# PDF quality-assurance record

**Artifact:** `../ChatGPT_ABC_Uniformity_2026.pdf`

**Title:** *Uniformity, Prime Support, and Reachable Lattices in Approaches to the abc Conjecture*

**Author:** ChatGPT

**Checkpoint date:** 2026-09-03

## Frozen artifact

- SHA-256: `02d7e2d53bd77490e6ba0c6352750ec0779f430b6537a5b7ff54c77c4963f335`
- Size: 1,534,968 bytes
- Pages: 237
- Media box on every page: 595.28 by 841.89 points (A4)
- PDF author metadata: `ChatGPT`
- Encryption: none

## Compilation audit

`final-tectonic.log` is the log from the last converged TeX pass. It contains
no LaTeX or package warnings, undefined references or citations, overfull or
underfull boxes, or rerun requests. `tectonic-console.txt` preserves the full
iterative compiler console, including diagnostics from early passes before
the cross-reference files converged; those early-pass diagnostics are absent
from the final log.

## Text and render audit

`render_audit.py` checked the final PDF and wrote `qa_metrics.json`. All 237
pages were rasterized at 910 by 1,287 pixels. The audit found no blank page,
no ink within four pixels of a page edge, and no page with fewer than 100
extracted characters. The final extracted text contains no literal bare
`qquad`, `??`, or Unicode replacement character.

The 237 renders were assembled into 15 contact sheets covering pages 1--237.
Every contact sheet was inspected manually. The original-resolution renders
for pages 1, 199--202, 205, 209, 214, 218, 228, 232, and 237 were also
inspected individually. These pages cover the new route statements, proof and
counterexample boundaries, formal inventory, checkpoint totals, and final
bibliography. No clipping, overlap, anomalous blank area, corrupt glyph,
unreadable formula or table, or header/footer defect was found. Modest blank
space at a few section endings reflects normal pagination.

This audit certifies artifact integrity and visible layout only. Mathematical
scope, proof dependencies, counterexample premises, and open obligations are
audited separately by the checkpoint verification package.
