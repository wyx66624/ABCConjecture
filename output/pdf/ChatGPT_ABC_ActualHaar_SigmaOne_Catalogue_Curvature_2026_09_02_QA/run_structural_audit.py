from __future__ import annotations

import hashlib
import json
import re
from pathlib import Path
from typing import Any

from pypdf import PdfReader


QA_DIR = Path(__file__).resolve().parent
PDF = QA_DIR.parent / "ChatGPT_ABC_Uniformity_2026.pdf"
OUT = QA_DIR / "STRUCTURAL_AUDIT.json"


def deref(value: Any) -> Any:
    return value.get_object() if hasattr(value, "get_object") else value


def object_key(value: Any) -> str:
    ref = getattr(value, "indirect_reference", None)
    if ref is None and hasattr(value, "idnum"):
        ref = value
    if ref is not None and hasattr(ref, "idnum"):
        return f"{ref.idnum}:{getattr(ref, 'generation', 0)}"
    return f"direct:{id(value)}"


def font_descriptor(font: Any) -> Any | None:
    font = deref(font)
    descriptor = font.get("/FontDescriptor")
    if descriptor is not None:
        return deref(descriptor)
    descendants = font.get("/DescendantFonts") or []
    for descendant in descendants:
        descendant = deref(descendant)
        descriptor = descendant.get("/FontDescriptor")
        if descriptor is not None:
            return deref(descriptor)
    return None


def font_name(font: Any) -> str:
    font = deref(font)
    descendants = font.get("/DescendantFonts") or []
    if descendants:
        descendant = deref(descendants[0])
        return str(descendant.get("/BaseFont") or font.get("/BaseFont") or "unknown")
    return str(font.get("/BaseFont") or "unknown")


def main() -> None:
    reader = PdfReader(PDF, strict=True)
    metadata = reader.metadata or {}
    root = deref(reader.trailer["/Root"])

    texts: list[str] = []
    text_lengths: list[int] = []
    annotation_count = 0
    uri_count = 0
    internal_link_count = 0
    other_annotation_count = 0
    fonts: dict[str, dict[str, Any]] = {}
    dimensions: set[tuple[float, float]] = set()

    for page in reader.pages:
        text = page.extract_text() or ""
        texts.append(text)
        text_lengths.append(len(text.strip()))
        box = page.mediabox
        dimensions.add((round(float(box.width), 3), round(float(box.height), 3)))

        annotations = page.get("/Annots") or []
        for annotation_ref in annotations:
            annotation = deref(annotation_ref)
            annotation_count += 1
            if annotation.get("/Subtype") == "/Link":
                action = deref(annotation.get("/A")) if annotation.get("/A") else None
                if action and action.get("/S") == "/URI":
                    uri_count += 1
                elif annotation.get("/Dest") is not None or action is not None:
                    internal_link_count += 1
                else:
                    other_annotation_count += 1
            else:
                other_annotation_count += 1

        resources = deref(page.get("/Resources") or {})
        font_dict = deref(resources.get("/Font") or {})
        for _, font_ref in font_dict.items():
            font = deref(font_ref)
            key = object_key(font_ref)
            if key in fonts:
                continue
            descriptor = font_descriptor(font)
            embedded = bool(
                descriptor
                and any(descriptor.get(k) is not None for k in ("/FontFile", "/FontFile2", "/FontFile3"))
            )
            fonts[key] = {
                "base_font": font_name(font),
                "subtype": str(font.get("/Subtype") or "unknown"),
                "embedded": embedded,
            }

    full_text = "\n".join(texts)
    normalized = re.sub(r"\s+", " ", full_text)
    bad_tokens = {
        token: len(re.findall(rf"\b{re.escape(token)}\b", full_text))
        for token in ("qquad", "quad", "pmod")
    }
    phrase_checks = {
        "actual_haar": bool(re.search(r"Actual Haar admissibility", normalized, re.I)),
        "mersenne_exact_order": bool(re.search(r"Exact-order coupling at the Mersenne endpoint", normalized, re.I)),
        "formal_job_count_9239": "9,239" in normalized or "9239" in normalized,
        "abc_open_disclaimer": bool(
            re.search(r"neither proved nor disproved", normalized, re.I)
            or re.search(r"unproved and undisproved", normalized, re.I)
        ),
        "author_chatgpt": str(metadata.get("/Author", "")).strip() == "ChatGPT",
    }

    names = deref(root.get("/Names") or {})
    javascript_name_tree = names.get("/JavaScript") is not None
    embedded_files = names.get("/EmbeddedFiles") is not None
    open_action = deref(root.get("/OpenAction")) if root.get("/OpenAction") is not None else None
    if isinstance(open_action, list):
        open_action_kind = "destination_array"
        open_action_javascript = False
    elif hasattr(open_action, "get"):
        open_action_kind = str(open_action.get("/S") or "action_dictionary")
        open_action_javascript = open_action.get("/S") == "/JavaScript"
    elif open_action is None:
        open_action_kind = "none"
        open_action_javascript = False
    else:
        open_action_kind = type(open_action).__name__
        open_action_javascript = False
    has_additional_actions = root.get("/AA") is not None
    has_acroform = root.get("/AcroForm") is not None

    font_rows = sorted(fonts.values(), key=lambda row: (row["base_font"], row["subtype"]))
    all_fonts_embedded = all(row["embedded"] for row in font_rows)
    structural_pass = all(
        (
            len(reader.pages) == 202,
            dimensions == {(595.28, 841.89)},
            not any(bad_tokens.values()),
            full_text.count("??") == 0,
            all(phrase_checks.values()),
            not has_acroform,
            not javascript_name_tree,
            not open_action_javascript,
            not has_additional_actions,
            not embedded_files,
            not reader.is_encrypted,
            all_fonts_embedded,
        )
    )
    result = {
        "verdict": "PASS" if structural_pass else "FAIL",
        "artifact": str(PDF),
        "sha256": hashlib.sha256(PDF.read_bytes()).hexdigest(),
        "pypdf_version": __import__("pypdf").__version__,
        "metadata": {
            "title": str(metadata.get("/Title", "")),
            "author": str(metadata.get("/Author", "")),
            "creator": str(metadata.get("/Creator", "")),
            "producer": str(metadata.get("/Producer", "")),
        },
        "page_count": len(reader.pages),
        "media_box_points": [list(pair) for pair in sorted(dimensions)],
        "text": {
            "total_extracted_characters": len(full_text),
            "minimum_page_characters": min(text_lengths),
            "minimum_page_number": text_lengths.index(min(text_lengths)) + 1,
            "pages_below_20_characters": [i + 1 for i, n in enumerate(text_lengths) if n < 20],
            "literal_unescaped_command_tokens": bad_tokens,
            "double_question_mark_count": full_text.count("??"),
            "phrase_checks": phrase_checks,
        },
        "interactive_features": {
            "annotation_count": annotation_count,
            "uri_link_count": uri_count,
            "internal_or_other_link_count": internal_link_count,
            "other_annotation_count": other_annotation_count,
            "acroform": has_acroform,
            "javascript_name_tree": javascript_name_tree,
            "open_action_kind": open_action_kind,
            "open_action_javascript": open_action_javascript,
            "additional_actions": has_additional_actions,
            "embedded_files": embedded_files,
            "encrypted": reader.is_encrypted,
        },
        "fonts": {
            "unique_resource_fonts": len(font_rows),
            "all_embedded": all_fonts_embedded,
            "unembedded": [row for row in font_rows if not row["embedded"]],
            "resources": font_rows,
        },
    }
    OUT.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
