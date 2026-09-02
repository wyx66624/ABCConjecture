# PDF quality-assurance record

## Artifact

- File: `../ChatGPT_ABC_Uniformity_2026.pdf`
- SHA-256: `cbe3693431fd9f969531fa8c7a0669e3afe1c8cd29aa36a2c1af497f1024451f`
- Title: *Uniformity, Prime Support, and Reachable Lattices in Approaches to the abc Conjecture*
- Author: ChatGPT
- Format: PDF 1.5, 202 A4 pages, 1,350,347 bytes

## Compilation audit

The bundled Tectonic 0.17.0 compiler rebuilt the complete TeX project with
exit code zero.  The retained machine log is `compile_audit.json`.  Tectonic
performed the required rerun, produced 202 pages, and reported no overfull
box.  Its only box diagnostics were underfull vertical boxes at line 273 of
the main source and line 694 of the inherited
`balanced_persistence_2026.tex`; visual inspection confirmed that neither
site causes clipping, overlap, or an anomalous blank page.

The audit rebuild was written temporarily outside the publication location.
`RECOMPILE_COMPARISON.json` records an exact equality check of extracted text
on every one of the 202 pages and equality of every media box against the
published PDF.  Its verdict is `PASS`.  Byte hashes differ because PDF
creation metadata is time dependent.

## Structural and textual audit

`run_structural_audit.py`, executed with pypdf 6.10.0 in strict mode, records
its full result in `STRUCTURAL_AUDIT.json`; the verdict is `PASS`.

- All 202 pages have the single A4 media box `595.28 x 841.89` points.
- Text extraction yields 599,032 characters.  Every page contains text; the
  shortest is the final bibliography continuation on page 202, with 165
  characters.
- The title, author, actual-Haar section, exact-order Mersenne section,
  9,239-job formal count, and explicit statement that abc remains open are
  all present in extracted text.
- The repaired bare TeX-command tokens `qquad`, `quad`, and `pmod` occur zero
  times in extracted text, and no unresolved `??` marker occurs.
- All 33 distinct font resources are embedded.
- The document contains 1,193 link annotations: 82 URI links and 1,111
  internal or other document links.  It contains no form, JavaScript action,
  additional action, embedded file, or encryption.  The sole open action is
  a harmless initial-view destination array.
- Independent Poppler metadata is retained in `pdfinfo.txt` and agrees on
  the title, author, page count, A4 dimensions, absence of forms and
  JavaScript, and absence of encryption.

## Visual audit

All 202 pages were rendered at 105 dpi as `page-001.png` through
`page-202.png`.  Seventeen contact sheets cover the full page sequence.
Sixteen pages were additionally rendered and inspected at 180 dpi in
`selected/`: 1, 2, 127, 128, 144, 145, 146, 155, 156, 182, 183, 184, 185,
186, 199, and 202.

`run_raster_audit.py` verifies that every raster can be decoded, that the
low-resolution filenames form the complete sequence 1--202, and that the
selected set is exact.  Its retained `RASTER_AUDIT.json` verdict is `PASS`.

The full contact-sheet pass and the high-resolution pass found no clipping,
overlap, garbled glyph, missing equation, missing page, accidental blank
page, or broken section boundary.  Page 202 contains the final bibliography
entry at its top and is intentionally sparse.  The title page, abstract,
four new mathematical sections, formalization table, disclosure, and final
bibliography were all included in the selected-page inspection.

## Source lint

The four new TeX fragments were scanned with a negative-lookbehind rule for
unescaped `qquad`, `quad`, and `pmod`; the result is retained in
`SOURCE_LINT.txt` and is `PASS`.  `git diff --check` also passed.

Overall QA verdict: **PASS**.
