# Journal-paper seal

Status: **PASS**

The final paper was built by `build_paper_and_seal.py` with bundled Tectonic
0.17.0. The wrapper hashed the complete recursive TeX input closure both
before and after the build. The two maps were identical and contain exactly
87 source files. `paper_build_provenance.json` binds that map, the compile
driver JSON, and the resulting PDF in one build record.

The sealed PDF has the following identity:

- file: `output/pdf/ChatGPT_ABC_Uniformity_2026.pdf`;
- length: 270 pages and 1705875 bytes;
- SHA-256: `9daf48428922e6a1216c8e191b93734cd4a496e4162684350df67a7c28b07e7e`;
- title: *Uniformity, Prime Support, and Reachable Lattices in Approaches to
  the abc Conjecture*;
- author: `ChatGPT`;
- encryption: false.

The final Tectonic engine transcript and the bundled-driver transcript both
pass the zero-warning gate: no unresolved reference or citation, bad box,
missing character, package warning, or engine error was found. The retained
raw multi-pass transcript records transient first-pass cross-reference
messages; it is not the final-pass warning gate.

Every page was rasterized at 110 dpi. The structural audit reports 270
contiguous 910-by-1287 rasters, no blank page, no ink within four pixels of a
page border, no page below 100 extracted characters, all 14 required text
targets, and 36 fonts. All 17 contact sheets were visually inspected, and
pages 214, 227, 228, 230, 231, 232, 248, 264, and 267 were additionally
inspected at full resolution. No clipping, overlap, blank content, or broken
layout was observed. The 17 contact sheets are individually included in the
exact-set manifest; the 270 raw page rasters are reproducible temporary data.

This seal certifies the paper artifact and its stated conditional reductions,
local obstructions, and finite computations. It does not certify an
unconditional proof or disproof of the standard abc conjecture, which remains
open in this repository.
