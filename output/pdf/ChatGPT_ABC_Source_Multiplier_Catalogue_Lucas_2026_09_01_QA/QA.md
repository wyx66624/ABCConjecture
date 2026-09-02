# PDF quality-assurance record

This directory records delivery-level QA for
`../ChatGPT_ABC_Uniformity_2026.pdf` after the source-realization,
balanced-multiplier, catalogue-overlap, and all-order Lucas checkpoint was
integrated.  The inspected PDF is 1,238,630 bytes with SHA-256
`94168cdd83388ff58cf03008c120204debb21755b4be4f72c8914656456a1d15`.

## Result

**PASS.**  Poppler, pypdf, and pdfplumber agree on 182 A4 pages.  The PDF is
unencrypted, has no form fields, JavaScript, signatures, or embedded files,
and identifies ChatGPT as author.  Strict parsing produced no warning.  All
33 used font objects are embedded.  All 1,106 links have valid destinations
or nonempty URIs.  Page boxes and rotation are uniform, no extracted text or
line object crosses a page boundary, and every page contains text.

The full document rendered successfully at 72 DPI.  The 182 renders have one
uniform page size, no blank or nearly blank page, and no ink on the page-edge
guard band.  Ten contact sheets retain visual coverage of every page.
High-resolution renders of pages 1, 2, 125, 126, 137, 138, 141, 142, 143,
164, 165, 166, 167, 174, and 179--182 were inspected at original detail.
They show no clipping, overlap, missing glyph, black block, broken table, or
malformed formula.  In particular, the corrected rational-source formula on
page 125 has the intended mathematical spacing, the four new route sections
are legible, and the terminal bibliography on page 182 is unclipped.

The final Tectonic log contains no overfull box, undefined reference,
undefined citation, multiply-defined label, missing character, LaTeX error,
or emergency stop.  It contains one pre-existing cosmetic underfull-vbox
page-break warning.

## Reproducible artifacts

- `pdf-verification.json` is the complete machine-readable structural,
  geometry, font, link, text, object-bound, render, metadata, marker, and log
  audit.
- `verify-pdf-stdout.txt` is the exact verifier output, and `verify_pdf.py` is
  the verifier source.
- `pdfinfo.txt` records Poppler metadata.
- `page-*.png` are the retained high-resolution inspection pages.
- `contact-sheet-*.png` cover all 182 low-resolution page renders.
- `ChatGPT_ABC_Uniformity_2026.log` is the final compiler log.
- `SHA256SUMS` seals every retained QA file except itself.

Some mathematical glyphs are represented as control codes or CID tokens by
text extractors.  This is an extraction limitation: the embedded-font check,
Poppler renders, and visual inspection show the glyphs correctly.  These QA
checks certify compilation, internal structure, text presence, and visual
layout.  They do not certify any still-open mathematical gate and do not
prove or disprove the standard abc conjecture.
