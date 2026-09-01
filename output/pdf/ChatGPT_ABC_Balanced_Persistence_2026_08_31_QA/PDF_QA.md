# PDF QA — corrected balanced-persistence release

Candidate: `ChatGPT_ABC_Uniformity_2026.pdf`

## Structural checks

- SHA256: `ccbc4d77d112aec78a869caba53104b133467f6cd4a60ee528e09437f79d2e3e`.
- Size: 830,854 bytes; 109 A4 pages; zero rotation; unencrypted; no forms or JavaScript.
- Metadata title is *Uniformity, Prime Support, and Reachable Lattices in Approaches to the abc Conjecture* and author is `ChatGPT`.
- Extracted text has 340,732 characters. Every page has extractable text; the minimum is 1,926 characters on page 87.
- All 29 distinct PDF font resources contain embedded font programs, including descendant fonts of Type 0 resources.
- The final Tectonic log contains no unresolved citation or reference, multiply defined label, missing character, overfull box, or LaTeX error. The only TeX layout warning is one pre-existing underfull output box.
- Extracted text contains no leaked `qquad`, `\\qquad`, `\\quad`, `pmod`, `\\leq`, or `\\cdot` control words.

## Render and visual checks

- Poppler rendered all 109 pages at 110 dpi to 910 by 1287 PNG files without an error.
- All 109 page renders have distinct SHA256 hashes. Their mean grayscale values range from 239.6733 to 248.7992; no blank, all-black, clipped, or truncated page was detected.
- Ten contact sheets cover pages 1–109. Relative to the immediately preceding fully inspected candidate, the final render differs on physical pages 102–109 only; the other 101 raster hashes are identical.
- Pages 97–98 were inspected at original rendered resolution. The admissible-count prime subscript is rendered correctly, and the primary-source clarification states that the exponent `1/2` comes from BBLT Proposition 1.1 while Theorem 1.3's `3/5` estimate is weaker at `mu=3/4`. The equations, margins, and footers are legible and unclipped.
- Page 101 retains the inspected Danilov normalization `K ~ (54 sqrt(5)/125) sqrt(X)` with coefficient below one. Pages 102–109 were reinspected at original rendered resolution after adding the certified finite-search paragraph. Page 102 displays all nine unresolved balancing indices, the 999/1990/81 certificate counts, and the explicit finite-scope guard without overflow. The shifted route ledger, formalization tables, build statistics, and references remain inside the margins and legible; the total page count is unchanged.
- The page 97–108 and page 109 contact sheets were inspected after the final recompilation.

Result: **PASS**. No material layout or rendering defect remains.

Reproducible structural, per-page, and contact-sheet hashes are stored in `structural-qa.json` and `render-manifest.json`; the final Tectonic, Poppler, and `pdfinfo` outputs are stored beside this report.
