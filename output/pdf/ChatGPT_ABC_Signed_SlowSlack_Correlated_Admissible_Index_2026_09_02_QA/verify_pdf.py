from __future__ import annotations

import argparse
import hashlib
import io
import json
import logging
import re
import sys
import unicodedata
import warnings
from collections import Counter, defaultdict
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

import pdfplumber
import pypdf
from PIL import Image
from pypdf import PdfReader
from pypdf.generic import ArrayObject, DictionaryObject, IndirectObject


EXPECTED_SHA256 = "16a9f976d65f76539e633b842899c688e1082a6d7561a6d412b4629463415dfa"
EXPECTED_BYTES = 1_297_178
EXPECTED_PAGES = 193
EXPECTED_SELECTED_PAGES = [
    1,
    2,
    125,
    126,
    127,
    128,
    140,
    141,
    142,
    143,
    148,
    149,
    150,
    151,
    174,
    175,
    176,
    177,
    178,
    189,
    190,
    191,
    192,
    193,
]


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Independent structural and render QA")
    parser.add_argument("pdf", type=Path)
    parser.add_argument("qa_dir", type=Path)
    parser.add_argument("low_dpi_render_dir", type=Path)
    parser.add_argument("final_log", type=Path)
    return parser.parse_args()


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def resolve(value: Any) -> Any:
    seen: set[int] = set()
    while hasattr(value, "get_object"):
        marker = id(value)
        if marker in seen:
            break
        seen.add(marker)
        resolved = value.get_object()
        if resolved is value:
            break
        value = resolved
    return value


def normalize(text: str) -> str:
    return re.sub(r"[^a-z0-9]+", "", text.casefold())


def box_values(box: Any) -> list[float]:
    return [float(box.left), float(box.bottom), float(box.right), float(box.top)]


def count_outline(items: Any) -> int:
    if not isinstance(items, list):
        return 0
    total = 0
    for item in items:
        if isinstance(item, list):
            total += count_outline(item)
        else:
            total += 1
    return total


def font_embedded(font: DictionaryObject) -> tuple[bool, list[str]]:
    subtype = str(font.get("/Subtype", ""))
    if subtype == "/Type3":
        return bool(font.get("/CharProcs")), ["/CharProcs"] if font.get("/CharProcs") else []
    target = font
    if subtype == "/Type0":
        descendants = resolve(font.get("/DescendantFonts", []))
        if descendants:
            target = resolve(descendants[0])
    descriptor = resolve(target.get("/FontDescriptor", {}))
    streams = [name for name in ("/FontFile", "/FontFile2", "/FontFile3") if descriptor.get(name)]
    return bool(streams), streams


def ref_key(value: Any) -> tuple[int, int] | None:
    if isinstance(value, IndirectObject):
        return value.idnum, value.generation
    indirect = getattr(value, "indirect_reference", None)
    if isinstance(indirect, IndirectObject):
        return indirect.idnum, indirect.generation
    return None


def main() -> int:
    args = parse_args()
    pdf_path = args.pdf.resolve()
    qa_dir = args.qa_dir.resolve()
    low_dpi_dir = args.low_dpi_render_dir.resolve()
    final_log = args.final_log.resolve()
    qa_dir.mkdir(parents=True, exist_ok=True)

    fatal: list[str] = []
    advisories: list[str] = []

    input_hash = sha256(pdf_path)
    input_bytes = pdf_path.stat().st_size
    if input_hash != EXPECTED_SHA256:
        fatal.append(f"unexpected PDF SHA256: {input_hash}")
    if input_bytes != EXPECTED_BYTES:
        fatal.append(f"unexpected PDF byte count: {input_bytes}")

    pypdf_log = io.StringIO()
    handler = logging.StreamHandler(pypdf_log)
    pypdf_logger = logging.getLogger("pypdf")
    old_level = pypdf_logger.level
    pypdf_logger.addHandler(handler)
    pypdf_logger.setLevel(logging.WARNING)
    with warnings.catch_warnings(record=True) as caught:
        warnings.simplefilter("always")
        reader = PdfReader(str(pdf_path), strict=True)
        pypdf_page_count = len(reader.pages)
    pypdf_logger.removeHandler(handler)
    pypdf_logger.setLevel(old_level)
    strict_messages = [str(item.message) for item in caught]
    strict_log_messages = [line for line in pypdf_log.getvalue().splitlines() if line.strip()]
    if strict_messages or strict_log_messages:
        fatal.append("pypdf strict parse emitted warnings")

    if pypdf_page_count != EXPECTED_PAGES:
        fatal.append(f"pypdf page count is {pypdf_page_count}")

    metadata = {str(key): str(value) for key, value in (reader.metadata or {}).items()}
    root = resolve(reader.trailer["/Root"])
    names = resolve(root.get("/Names", {}))
    has_javascript = bool(names.get("/JavaScript")) or bool(root.get("/AA"))
    has_embedded_files = bool(names.get("/EmbeddedFiles"))
    has_open_action = bool(root.get("/OpenAction"))
    form_fields = reader.get_fields() or {}
    named_destinations = reader.named_destinations
    outline_count = count_outline(reader.outline)

    page_ref_keys = {
        key for page in reader.pages if (key := ref_key(page)) is not None
    }
    page_geometry: list[dict[str, Any]] = []
    a4_pages = True
    crop_within_media = True
    zero_rotation = True
    for number, page in enumerate(reader.pages, start=1):
        media = box_values(page.mediabox)
        crop = box_values(page.cropbox)
        width = float(page.mediabox.width)
        height = float(page.mediabox.height)
        rotation = int(page.get("/Rotate", 0) or 0) % 360
        if abs(width - 595.28) >= 0.2 or abs(height - 841.89) >= 0.2:
            a4_pages = False
        if (
            crop[0] < media[0] - 0.01
            or crop[1] < media[1] - 0.01
            or crop[2] > media[2] + 0.01
            or crop[3] > media[3] + 0.01
        ):
            crop_within_media = False
        if rotation != 0:
            zero_rotation = False
        page_geometry.append(
            {
                "page": number,
                "mediaBox": media,
                "cropBox": crop,
                "rotation": rotation,
            }
        )
    if not a4_pages:
        fatal.append("one or more pages are not A4")
    if not crop_within_media:
        fatal.append("one or more crop boxes extend outside the media box")
    if not zero_rotation:
        fatal.append("one or more pages have nonzero rotation")

    fonts: dict[str, dict[str, Any]] = {}
    for page_number, page in enumerate(reader.pages, start=1):
        resources = resolve(page.get("/Resources", {}))
        page_fonts = resolve(resources.get("/Font", {}))
        for resource_name, font_ref in page_fonts.items():
            font = resolve(font_ref)
            key = ref_key(font_ref)
            identifier = f"{key[0]} {key[1]} R" if key else f"direct:{resource_name}:{id(font)}"
            if identifier not in fonts:
                embedded, streams = font_embedded(font)
                fonts[identifier] = {
                    "resourceNames": set(),
                    "baseFont": str(font.get("/BaseFont", "")),
                    "subtype": str(font.get("/Subtype", "")),
                    "encoding": str(font.get("/Encoding", "")),
                    "toUnicode": bool(font.get("/ToUnicode")),
                    "embedded": embedded,
                    "embeddingStreams": streams,
                    "pages": [],
                }
            fonts[identifier]["resourceNames"].add(str(resource_name))
            fonts[identifier]["pages"].append(page_number)
    font_inventory = []
    for identifier, record in sorted(fonts.items()):
        record["resourceNames"] = sorted(record["resourceNames"])
        record["pages"] = sorted(set(record["pages"]))
        font_inventory.append({"object": identifier, **record})
    unembedded_fonts = [
        {"object": item["object"], "baseFont": item["baseFont"], "subtype": item["subtype"]}
        for item in font_inventory
        if not item["embedded"]
    ]
    if unembedded_fonts:
        fatal.append(f"{len(unembedded_fonts)} used fonts are not embedded")

    annotation_counts: Counter[str] = Counter()
    link_action_counts: Counter[str] = Counter()
    invalid_internal_links: list[dict[str, Any]] = []
    empty_uris: list[dict[str, Any]] = []
    signature_widgets = 0

    def destination_is_valid(destination: Any) -> bool:
        if destination is None:
            return False
        if isinstance(destination, (str, bytes)):
            name = str(destination)
            return name in named_destinations or name.lstrip("/") in named_destinations
        resolved = resolve(destination)
        if isinstance(resolved, ArrayObject) and resolved:
            target = resolved[0]
            key = ref_key(target)
            return key in page_ref_keys if key else False
        key = ref_key(destination)
        return key in page_ref_keys if key else False

    for page_number, page in enumerate(reader.pages, start=1):
        annots = resolve(page.get("/Annots", []))
        for annotation_ref in annots:
            annotation = resolve(annotation_ref)
            subtype = str(annotation.get("/Subtype", "unknown"))
            annotation_counts[subtype] += 1
            if subtype == "/Widget" and str(annotation.get("/FT", "")) == "/Sig":
                signature_widgets += 1
            if subtype != "/Link":
                continue
            destination = annotation.get("/Dest")
            action = resolve(annotation.get("/A", {}))
            if destination is not None:
                link_action_counts["/Dest"] += 1
                if not destination_is_valid(destination):
                    invalid_internal_links.append({"page": page_number, "kind": "/Dest"})
                continue
            action_type = str(action.get("/S", "missing"))
            link_action_counts[action_type] += 1
            if action_type == "/URI":
                if not str(action.get("/URI", "")).strip():
                    empty_uris.append({"page": page_number})
            elif action_type == "/GoTo":
                if not destination_is_valid(action.get("/D")):
                    invalid_internal_links.append({"page": page_number, "kind": "/GoTo"})
    if invalid_internal_links:
        fatal.append(f"{len(invalid_internal_links)} internal links have invalid destinations")
    if empty_uris:
        fatal.append(f"{len(empty_uris)} URI links are empty")

    pypdf_page_text = [(page.extract_text() or "") for page in reader.pages]
    pypdf_text_lengths = [len(text) for text in pypdf_page_text]
    joined_text = "\n".join(pypdf_page_text)
    if not pypdf_text_lengths or min(pypdf_text_lengths) == 0:
        fatal.append("one or more pages have no pypdf-extractable text")

    marker_text = {
        "title": "Uniformity, Prime Support, and Reachable Lattices",
        "honestOpenStatus": "standard abc conjecture, which is neither proved nor disproved here",
        "iutCurrent": "Admissible scaling at the current IUT interface and an exact order index",
        "affineSigned": "Signed ray capture and exact canonical arm ceilings",
        "pellCorrelated": "Correlated Pell-Lucas staircases and opposite-channel incidence",
        "mersenneSlowSlack": "Critical slow-slack compression in the Mersenne route",
        "formalVerification": "Formal verification and remaining obligations",
        "terminalStatus": "No unconditional closed term of type ABCConjecture",
        "references": "References",
    }
    marker_presence = {
        name: normalize(value) in normalize(joined_text) for name, value in marker_text.items()
    }
    marker_pages = {
        name: [
            number
            for number, page_text in enumerate(pypdf_page_text, start=1)
            if normalize(value) in normalize(page_text)
        ]
        for name, value in marker_text.items()
    }
    missing_markers = [name for name, present in marker_presence.items() if not present]
    if missing_markers:
        fatal.append(f"expected text markers missing: {missing_markers}")

    forbidden_token_patterns = {
        "literalQuadCommand": r"(?i)(?<![A-Za-z])q?quad(?![A-Za-z])",
        "codexFileCitation": r"(?i)codex-file-citation",
        "webToolToken": r"(?i)turn\d+(?:search|view|fetch|open)\d+",
        "openAIToolCitation": r"(?i)(?:oaicite|contentreference|\ue200cite)",
        "todoToken": r"(?i)\b(?:TODO|FIXME|TBD)\b",
    }
    forbidden_tokens: dict[str, list[dict[str, Any]]] = {}
    for name, pattern in forbidden_token_patterns.items():
        hits = []
        for page_number, text in enumerate(pypdf_page_text, start=1):
            count = len(re.findall(pattern, text))
            if count:
                hits.append({"page": page_number, "count": count})
        forbidden_tokens[name] = hits
    if any(forbidden_tokens.values()):
        fatal.append("forbidden placeholder/tool/literal-spacing tokens remain in extracted text")

    unicode_dash_counts = Counter(
        character
        for character in joined_text
        if character in "\u2010\u2011\u2012\u2013\u2014\u2212"
    )
    replacement_character_count = joined_text.count("\ufffd")
    control_character_counts = Counter(
        f"U+{ord(character):04X}"
        for character in joined_text
        if unicodedata.category(character) == "Cc" and character not in "\n\r\t"
    )
    if replacement_character_count:
        advisories.append("pypdf extraction contains replacement characters")
    if control_character_counts:
        advisories.append(
            "some mathematical glyphs extract as control codes; visual rendering and body text remain readable"
        )

    plumber_text_lengths: list[int] = []
    plumber_word_counts: list[int] = []
    plumber_cid_counts: list[int] = []
    outside_objects: list[dict[str, Any]] = []
    object_type_counts: Counter[str] = Counter()
    with pdfplumber.open(pdf_path) as plumber_pdf:
        plumber_page_count = len(plumber_pdf.pages)
        for page_number, page in enumerate(plumber_pdf.pages, start=1):
            text = page.extract_text() or ""
            plumber_text_lengths.append(len(text))
            plumber_word_counts.append(len(page.extract_words()))
            plumber_cid_counts.append(len(re.findall(r"\(cid:\d+\)", text)))
            for object_type, objects in page.objects.items():
                object_type_counts[object_type] += len(objects)
                for object_index, obj in enumerate(objects):
                    if not all(key in obj for key in ("x0", "x1", "top", "bottom")):
                        continue
                    x0 = float(obj["x0"])
                    x1 = float(obj["x1"])
                    top = float(obj["top"])
                    bottom = float(obj["bottom"])
                    overshoot = max(0.0, -x0, x1 - page.width, -top, bottom - page.height)
                    if overshoot > 0.5:
                        outside_objects.append(
                            {
                                "page": page_number,
                                "type": object_type,
                                "index": object_index,
                                "bbox": [x0, top, x1, bottom],
                                "overshootPoints": overshoot,
                            }
                        )
    if plumber_page_count != EXPECTED_PAGES:
        fatal.append(f"pdfplumber page count is {plumber_page_count}")
    if not plumber_text_lengths or min(plumber_text_lengths) == 0:
        fatal.append("one or more pages have no pdfplumber-extractable text")
    if outside_objects:
        fatal.append(f"{len(outside_objects)} extracted page objects extend outside the page")
    if sum(plumber_cid_counts):
        advisories.append(
            "pdfplumber represents some math glyphs as cid tokens; this is an extraction limitation"
        )

    low_dpi_files = sorted(low_dpi_dir.glob("page-*.png"))
    low_dpi_page_numbers = [int(path.stem.rsplit("-", 1)[1]) for path in low_dpi_files]
    render_dimensions: Counter[str] = Counter()
    blank_render_pages: list[int] = []
    edge_ink_pages: list[int] = []
    render_stats: list[dict[str, Any]] = []
    for path, page_number in zip(low_dpi_files, low_dpi_page_numbers):
        with Image.open(path) as image:
            image.load()
            width, height = image.size
            render_dimensions[f"{width}x{height}"] += 1
            gray = image.convert("L")
            histogram = gray.histogram()
            dark_pixels = sum(histogram[:250])
            pixel_count = width * height
            dark_fraction = dark_pixels / pixel_count
            mask = gray.point(lambda value: 255 if value < 250 else 0)
            bbox = mask.getbbox()
            edge_width = min(3, width // 2, height // 2)
            edge_pixels = 0
            for crop in (
                mask.crop((0, 0, width, edge_width)),
                mask.crop((0, height - edge_width, width, height)),
                mask.crop((0, 0, edge_width, height)),
                mask.crop((width - edge_width, 0, width, height)),
            ):
                edge_pixels += sum(crop.histogram()[1:]) // 255
            if bbox is None or dark_fraction < 0.0005:
                blank_render_pages.append(page_number)
            if edge_pixels:
                edge_ink_pages.append(page_number)
            render_stats.append(
                {
                    "page": page_number,
                    "pixels": [width, height],
                    "contentBBox": list(bbox) if bbox else None,
                    "darkPixelFraction": dark_fraction,
                    "edgeInkPixels": edge_pixels,
                }
            )
    if low_dpi_page_numbers != list(range(1, EXPECTED_PAGES + 1)):
        fatal.append("72 DPI render coverage is incomplete or out of order")
    if blank_render_pages:
        fatal.append(f"rendered blank or nearly blank pages: {blank_render_pages}")
    if edge_ink_pages:
        fatal.append(f"rendered content touches a page edge: {edge_ink_pages}")

    selected_files = sorted(qa_dir.glob("page-*.png"))
    selected_page_numbers = [int(path.stem.rsplit("-", 1)[1]) for path in selected_files]
    selected_pngs = []
    for path, page_number in zip(selected_files, selected_page_numbers):
        with Image.open(path) as image:
            image.verify()
        with Image.open(path) as image:
            dimensions = list(image.size)
        selected_pngs.append(
            {
                "page": page_number,
                "file": path.name,
                "bytes": path.stat().st_size,
                "sha256": sha256(path),
                "pixels": dimensions,
            }
        )
    if selected_page_numbers != EXPECTED_SELECTED_PAGES:
        fatal.append(f"selected rendered pages are {selected_page_numbers}")

    expected_contact_sheets = [
        f"contact-sheet-{first:03d}-{min(first + 19, EXPECTED_PAGES):03d}.png"
        for first in range(1, EXPECTED_PAGES + 1, 20)
    ]
    contact_sheet_files = sorted(qa_dir.glob("contact-sheet-*.png"))
    contact_sheets = []
    for path in contact_sheet_files:
        with Image.open(path) as image:
            image.verify()
        with Image.open(path) as image:
            dimensions = list(image.size)
        contact_sheets.append(
            {
                "file": path.name,
                "bytes": path.stat().st_size,
                "sha256": sha256(path),
                "pixels": dimensions,
            }
        )
    if [item["file"] for item in contact_sheets] != expected_contact_sheets:
        fatal.append("contact-sheet coverage is incomplete")

    log_text = final_log.read_text(encoding="utf-8", errors="replace")
    log_patterns = {
        "overfull": r"Overfull",
        "underfull": r"Underfull",
        "undefinedControlSequence": r"Undefined control sequence",
        "latexError": r"! LaTeX Error",
        "undefinedReference": r"undefined references?|Reference .* undefined",
        "undefinedCitation": r"undefined citations?|Citation .* undefined",
        "multiplyDefined": r"multiply defined",
        "missingCharacter": r"Missing character",
        "emergencyStop": r"Emergency stop|Fatal error",
    }
    log_pattern_counts = {
        name: len(re.findall(pattern, log_text, flags=re.IGNORECASE))
        for name, pattern in log_patterns.items()
    }
    for name in (
        "overfull",
        "undefinedControlSequence",
        "latexError",
        "undefinedReference",
        "undefinedCitation",
        "multiplyDefined",
        "missingCharacter",
        "emergencyStop",
    ):
        if log_pattern_counts[name]:
            fatal.append(f"final log contains {name}")
    if log_pattern_counts["underfull"] != 4:
        fatal.append(f"expected four underfull vbox diagnostics, found {log_pattern_counts['underfull']}")
    if "Output written on ChatGPT_ABC_Uniformity_2026.xdv (193 pages" not in log_text:
        fatal.append("final log does not record a 193-page XDV output")

    pdfinfo_text = (qa_dir / "pdfinfo.txt").read_text(encoding="utf-8", errors="replace")
    pdfinfo_checks = {
        "pages193": bool(re.search(r"(?m)^Pages:\s+193\s*$", pdfinfo_text)),
        "a4": "Page size:       595.28 x 841.89 pts (A4)" in pdfinfo_text,
        "unencrypted": bool(re.search(r"(?m)^Encrypted:\s+no\s*$", pdfinfo_text)),
        "noJavaScript": bool(re.search(r"(?m)^JavaScript:\s+no\s*$", pdfinfo_text)),
        "noForms": bool(re.search(r"(?m)^Form:\s+none\s*$", pdfinfo_text)),
        "bytes": bool(re.search(r"(?m)^File size:\s+1297178 bytes\s*$", pdfinfo_text)),
        "pdf15": bool(re.search(r"(?m)^PDF version:\s+1\.5\s*$", pdfinfo_text)),
    }
    if not all(pdfinfo_checks.values()):
        fatal.append("one or more pdfinfo checks failed")

    if reader.is_encrypted:
        fatal.append("PDF is encrypted")
    if form_fields:
        fatal.append("PDF has AcroForm fields")
    if has_javascript:
        fatal.append("PDF has JavaScript")
    if has_embedded_files:
        fatal.append("PDF has embedded files")
    if signature_widgets:
        fatal.append("PDF has signature widgets")
    if metadata.get("/Title") != "Uniformity, Prime Support, and Reachable Lattices in Approaches to the abc Conjecture":
        fatal.append("title metadata does not match")
    if metadata.get("/Author") != "ChatGPT":
        fatal.append("author metadata does not match")

    result = {
        "status": "PASS" if not fatal else "FAIL",
        "qaTimestampUtc": datetime.now(timezone.utc).isoformat(),
        "scope": "Independent delivery-level QA of the frozen PDF; no PDF or paper source was modified.",
        "pdf": {
            "path": str(pdf_path),
            "bytes": input_bytes,
            "sha256": input_hash,
            "pypdfPages": pypdf_page_count,
            "pdfplumberPages": plumber_page_count,
            "encrypted": reader.is_encrypted,
            "metadata": metadata,
            "pdfVersionHeader": pdf_path.read_bytes()[:8].decode("ascii", errors="replace"),
        },
        "libraries": {
            "python": sys.version,
            "pypdf": pypdf.__version__,
            "pdfplumber": pdfplumber.__version__,
            "Pillow": Image.__version__,
        },
        "strictParse": {
            "warnings": strict_messages,
            "logWarnings": strict_log_messages,
        },
        "documentFeatures": {
            "formFieldCount": len(form_fields),
            "javascript": has_javascript,
            "embeddedFiles": has_embedded_files,
            "openAction": has_open_action,
            "signatureWidgets": signature_widgets,
            "outlineItems": outline_count,
            "namedDestinations": len(named_destinations),
            "annotations": dict(sorted(annotation_counts.items())),
            "linkActions": dict(sorted(link_action_counts.items())),
            "invalidInternalLinks": invalid_internal_links,
            "emptyUris": empty_uris,
        },
        "geometry": {
            "a4Pages": a4_pages,
            "cropWithinMedia": crop_within_media,
            "zeroRotation": zero_rotation,
            "uniqueMediaBoxes": sorted({tuple(item["mediaBox"]) for item in page_geometry}),
            "uniqueCropBoxes": sorted({tuple(item["cropBox"]) for item in page_geometry}),
        },
        "fonts": {
            "usedFontObjects": len(font_inventory),
            "allEmbedded": not unembedded_fonts,
            "unembedded": unembedded_fonts,
            "inventory": font_inventory,
        },
        "text": {
            "pypdfLengths": pypdf_text_lengths,
            "pdfplumberLengths": plumber_text_lengths,
            "pdfplumberWordCounts": plumber_word_counts,
            "pdfplumberCidTokenCounts": plumber_cid_counts,
            "markers": marker_presence,
            "markerPages": marker_pages,
            "forbiddenTokens": forbidden_tokens,
            "replacementCharacterCount": replacement_character_count,
            "controlCharacterCounts": dict(sorted(control_character_counts.items())),
            "unicodeDashCounts": {
                f"U+{ord(character):04X}": count
                for character, count in sorted(unicode_dash_counts.items())
            },
        },
        "objectBounds": {
            "objectTypeCounts": dict(sorted(object_type_counts.items())),
            "outsidePageCount": len(outside_objects),
            "outsidePageObjects": outside_objects[:50],
        },
        "render": {
            "lowDpi": 72,
            "lowDpiCoverage": low_dpi_page_numbers,
            "lowDpiDimensions": dict(sorted(render_dimensions.items())),
            "blankOrNearlyBlankPages": blank_render_pages,
            "edgeInkPages": edge_ink_pages,
            "pageStats": render_stats,
            "selectedDpi": 180,
            "selectedPages": selected_pngs,
            "contactSheets": contact_sheets,
        },
        "pdfinfoChecks": pdfinfo_checks,
        "finalLog": {
            "path": str(final_log),
            "bytes": final_log.stat().st_size,
            "sha256": sha256(final_log),
            "patternCounts": log_pattern_counts,
        },
        "fatalFindings": fatal,
        "advisories": advisories,
    }

    output = json.dumps(result, indent=2, ensure_ascii=False) + "\n"
    (qa_dir / "pdf-verification.json").write_text(output, encoding="utf-8")
    print(output, end="")
    return 0 if not fatal else 1


if __name__ == "__main__":
    raise SystemExit(main())
