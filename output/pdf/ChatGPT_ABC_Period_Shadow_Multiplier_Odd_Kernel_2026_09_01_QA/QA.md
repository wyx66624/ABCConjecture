# PDF quality-assurance record

This directory records delivery-level QA for
`../ChatGPT_ABC_Uniformity_2026.pdf` after the visible `quad`/`qquad` source
defect was corrected and the paper was recompiled.  The inspected PDF is
1,186,652 bytes with SHA-256
`5d8f7ddc94b9b096b78df4a6d0d18a7f26c19cb3f62dbf698d6f7341433f58db`.

## Result

**PASS.**  Poppler, pypdf, and pdfplumber agree on 172 A4 pages.  The PDF is
unencrypted, has no form fields, JavaScript, signatures, or embedded files,
and identifies ChatGPT as author.  Strict parsing produced no warning.  All
33 used font objects are embedded.  All 1,066 links have valid destinations
or nonempty URIs.  No extracted text or line object crosses a page boundary,
and every page contains text.

The full document rendered successfully at 72 DPI.  The 172 renders have one
uniform page size, no blank or nearly blank page, and no ink on the page-edge
guard band.  Nine contact sheets retain visual coverage of every page.
High-resolution renders of pages 1, 2, 122, 133, 134, 136, 156, 157, 158,
166, 169, 170, 171, and 172 were inspected independently.  They show no
clipping, overlap, missing glyph, black block, broken table, or malformed
formula.  In particular, pages 133-134 contain the intended spacing and no
literal `quad` or `qquad` text after recompilation.  Reference numbering on
the terminal pages is continuous.

The final Tectonic log contains no overfull box, undefined reference,
undefined citation, missing character, LaTeX error, or emergency stop.  It
contains one cosmetic underfull-vbox page-break warning near page 2.

## Reproducible artifacts

- `pdf-verification.json` is the complete machine-readable structural,
  geometry, font, link, text, object-bound, render, metadata, and log audit.
- `verify-pdf-stdout.txt` is the exact verifier output, and `verify_pdf.py` is
  the verifier source.
- `pdfinfo.txt` records Poppler metadata.
- `page-*.png` are the retained high-resolution inspection pages.
- `contact-sheet-*.png` cover all 172 low-resolution page renders.
- `ChatGPT_ABC_Uniformity_2026.log` is the final compiler log.
- `SHA256SUMS` seals every retained QA file except itself.

Some mathematical glyphs are represented as control codes or CID tokens by
text extractors.  This is an extraction limitation: the embedded-font check,
Poppler renders, and independent visual inspection show the glyphs correctly.
