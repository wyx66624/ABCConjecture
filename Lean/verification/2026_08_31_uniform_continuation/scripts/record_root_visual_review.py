"""Record the root's already completed image inspection of pages 49--72.

This is an evidence-writing helper, not a substitute for actually viewing
the images. The root viewed all twelve pairs before writing these notes.
"""
from pathlib import Path
import hashlib
import json
from PIL import Image, ImageChops

ROOT = Path(__file__).resolve().parents[4]
RECORD = ROOT / "Lean/verification/2026_08_31_uniform_continuation"
PDF_SHA = "0dfc4b7be5f7b32c65d357bf43d1e0df91a4ec8c35eb68cec7f46c56898e4e9f"
PDF = ROOT / "output/pdf/ChatGPT_ABC_Uniformity_2026_08_31.pdf"

def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

if digest(PDF) != PDF_SHA:
    raise SystemExit("A different PDF requires a new actual visual inspection")
render = json.loads((RECORD / "render-manifest.json").read_text(encoding="utf-8"))
if render["pdf_sha256"] != PDF_SHA or render["pdf_pages"] != 93:
    raise SystemExit("The reviewed render manifest does not match")
notes = {
    49: "General square-label trace computation, inertia count in Lemma 14.3, and common-arrow Theorem 14.4. Equations and proof continuation are readable within the margins.",
    50: "Two endpoint hulls, trace-dual inclusion, and opening of the exact pre-transport corollary. Long span formulas, tensor exponents and equation numbers remain distinct.",
    51: "Completion of the scale and volume formulas and opening of global initial theta data. The section break, displayed family and mathematical/formal boundary are clean.",
    52: "Good reduction above two and the required-core proposition. Four exceptional j-invariants, superscripts and references are legible, with no clipped line.",
    53: "Decorated quotient transitivity and the full initial-data theorem. The arithmetic requirements and exact-sequence/global-cover formulas fit without overlap.",
    54: "Finite-cover commuting diagram and local cusp matching. Diagram arrows, the two isogenies and the Tate exact sequence are aligned and legible.",
    55: "Auxiliary theta-cover proof and uniform initial-data criterion. Torsion and subgroup notation, proposition hypotheses and the proof opening are complete.",
    56: "Initial data throughout the unbounded family. The three-case Tate-order display and the retained parameter assumptions are fully visible.",
    57: "Initial-data scope boundary and opening of the unbounded family. The finite-sieve lower bound, root-lifting formula and source qualifications are readable.",
    58: "Completion of the finite-sieve estimate and the existence theorem. Congruences, four parallel conditions and height-window formulas are aligned.",
    59: "Existence and arithmetic proof for the power-free family. The curve invariants, SL2 argument and good-reduction calculation fit, with a clean continuing proof.",
    60: "Global height window, exact local torsion field and fixed-domain definitions. The genuine uniformizer, ramification identities and local conditions are clear.",
    61: "Fixed local bounds with unbounded rational height, finite-set avoidance and ambient-compactness obstruction. Fractions and displayed bounds are unambiguous.",
    62: "Source-interface boundary and the sharp two-prime-support theorem. The equality cases, prime-power reduction and factorization proof are readable.",
    63: "Completion of the sharp two-prime proof and actual trace/rational-return lemma. Degree cancellation, scalar-line action and logarithm series fit correctly.",
    64: "Logarithmic endpoint table and exact arithmetic fibre theorem. Both three-row tables have clear column separation; parity conditions and quantified hypotheses are intact.",
    65: "Sharp two-point example, rational-return corollary and coefficient-unit sharpness. Formulas, references and the larger-category qualification are visible.",
    66: "Analytic formalization boundaries and opening of the entire rational isogeny-class argument. The cyclic-degree list and composite-isogeny proof fit within the text area.",
    67: "Prime-degree path proof, explicit curve family and mod-seven point count. The point table and quotient equation are clear, with no missing glyphs.",
    68: "Four genuine quotient equations, invariant table and entire-class theorem. Signs in the discriminants, table columns and intrinsic bound definitions are legible.",
    69: "Matching minimal-discriminant/j bounds, quantified obstruction and start of exact Weil heights. The distinction between complex magnitude and Weil height is visible.",
    70: "Signed reduced rational coordinates and coprimality residues. The negative zero-kernel numerator and both arithmetic tables are clear and properly aligned.",
    71: "Unique complex minimizer, exact height table and least Weil-height theorem. Three ratio formulas and the strict logarithmic bounds are readable without collisions.",
    72: "Finite-place contribution, asymptotic gap, bounded gain and quantified height obstruction. The revised formalization paragraph fits; no overflow, clipping or unresolved reference appears.",
}
if list(notes) != list(range(49, 73)):
    raise SystemExit("Unexpected inspection scope")
for number in notes:
    page = render["pages"][number - 1]
    if page["page"] != number or digest(Path(page["path"])) != page["sha256"]:
        raise SystemExit(f"Changed reviewed page {number}")
for pair in render["pairs"]:
    if pair["first"] not in notes:
        continue
    if digest(Path(pair["path"])) != pair["sha256"]:
        raise SystemExit("Changed pair image")
    with Image.open(pair["path"]) as raw_pair:
        paired = raw_pair.convert("RGB")
        offset = 0
        for number in range(pair["first"], pair["last"] + 1):
            with Image.open(render["pages"][number - 1]["path"]) as raw_page:
                single = raw_page.convert("RGB")
                crop = paired.crop((offset, 0, offset + single.width, single.height))
                if ImageChops.difference(crop, single).getbbox() is not None:
                    raise SystemExit(f"Pair image differs from page {number}")
                offset += single.width + 18
review = {"reviewer": "ChatGPT, root coordinating agent", "pdf_sha256": PDF_SHA,
          "status": "pass", "inspected_pages": list(notes), "page_notes": notes,
          "page_image_sha256": {number: render["pages"][number-1]["sha256"] for number in notes},
          "actual_image_inspection": True, "reviewed_pair_count": 12,
          "paired_pixels_checked": True, "required_corrections": []}
qa = RECORD / "qa"
qa.mkdir(exist_ok=True)
(qa / "root-review.json").write_text(json.dumps(review, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
rows = "\n".join(f"| {number} | {note} | Pass |" for number, note in notes.items())
text = f"""# Final PDF visual review: pages 49--72

Reviewer: ChatGPT, root coordinating agent. Date: 2026-08-31.

**PASS for every page 49--72. No required visual correction found.**

Exact artifact: output/pdf/ChatGPT_ABC_Uniformity_2026_08_31.pdf.
SHA256: {PDF_SHA}. 93 pages; 741229 bytes; author ChatGPT.

The root actually viewed the twelve full-resolution pair images
pair-49-50.png through pair-71-72.png. The images were inspected in
four groups of three pairs. This is a new inspection of the exact
93-page artifact, not a reuse of the earlier 66-page review. The PDF
hash, individual page hashes and pixel identity of each reviewed
pair half with its single page were then checked before recording
this evidence. The detailed machine-readable scope is root-review.json.

| Page | Material actually viewed and layout finding | Result |
|---|---|---|
{rows}

Headers and page numbers remain distinct from the text. No overlapping
formula, missing symbol, clipped table, unreadable superscript or
unresolved reference was seen. Continuing proofs at page boundaries
remain complete. Mathematical proof and source review are recorded
separately; visual acceptance is not a proof of abc or external
human peer review. No TeX or PDF was changed during this inspection.
"""
(qa / "root-review.md").write_text(text, encoding="utf-8")
print(json.dumps({"status": "pass", "pages": list(notes), "pdf_sha256": PDF_SHA}))
