# Final PDF validation

Status: **PASS**

The final artifact is `ChatGPT_ABC_Uniformity_2026.pdf`, with 270 pages,
1705875 bytes, and SHA-256
`9daf48428922e6a1216c8e191b93734cd4a496e4162684350df67a7c28b07e7e`.
Independent `pypdf` inspection confirms the title *Uniformity, Prime Support,
and Reachable Lattices in Approaches to the abc Conjecture*, author `ChatGPT`,
270 pages, and `encrypted=false`.

The final build used `build_paper_and_seal.py` with the bundled LaTeX compile
driver and Tectonic 0.17.0. In the same process, the wrapper hashed all 87
files in the recursive TeX input closure before compilation, ran the driver,
hashed the same closure afterward, required the maps to be identical, and
recorded the resulting PDF hash and byte count in
`paper_build_provenance.json`. Thus the current source closure is bound to the
current PDF rather than being checked as a separate stale artifact.

The final Tectonic engine log, the normalized engine transcript, and the
bundled compile-driver log contain no LaTeX/package warning, overfull or
underfull box, unresolved reference or citation, missing character, or engine
error. Their recorded exit codes are zero. `compile_multirun.log` is retained
as raw diagnostic evidence and includes transient first-pass reference
messages; the warning gate is applied to the clean final-pass engine and
driver logs.

Poppler 26.07.0 rendered every page at 110 dpi. The audit ran with CPython
3.13.5, pypdf 6.10.0, and Pillow 11.1.0. It found 270 contiguous
910-by-1287 page images, no blank raster, no ink within four pixels of an
outer border, no page below 100 extracted characters, all 14 required text
targets, and 36 fonts.

All 17 contact sheets, covering pages 1 through 270 without gaps, were
visually inspected. Pages 214, 227, 228, 230, 231, 232, 248, 264, and 267 were
also inspected at full resolution. No clipping, overlap, blank content,
malformed formula, or broken layout was observed. The contact sheets are
sealed individually; the raw page rasters are intentionally reproducible
temporary files.
