# PDF release QA

**Artifact:** `ChatGPT_ABC_Holonomy_Depth_Continuation_2026_09_01.pdf`  
**Author metadata:** ChatGPT  
**Verdict:** PASS

## Mechanical checks

- Bundled Tectonic 0.17.0 compiled the final source and exited `0`; a retained
  final-pass log contains no overfull box, undefined control sequence, LaTeX
  error, undefined citation, or undefined reference.
- The final log contains four nonblocking underfull-vbox locations: two in the
  title/front matter at main-source lines 130 and 131 (badness 10000), one at
  main-source line 224 (badness 2726), and one near
  `balanced_persistence_2026.tex` line 694 (badness 1281). Visual inspection
  shows no clipping or collision at these locations.
- The bundled runtime emits a nonblocking Fontconfig configuration warning
  before TeX starts.
- The PDF is unencrypted A4, version 1.5, has no forms or JavaScript, and has
  nonempty extractable text on all 124 pages.
- It is 919,453 bytes. SHA-256:
  `02c415a2f49575117dc5ae86f43c810a63c3cc6e201b1e82def151d93d934df9`.

`verify_pdf.py` checks these properties, the ChatGPT author metadata, and
extracted-text markers for the valuation-ball theorem, the positive normalized
scalar collision, the strict affine boundary counterexample, the Pell finite
search and nonintersection boundaries, the corrected identity
`u_ell=A_ell*B_ell` on page 114 (with the erroneous factor-two form absent),
the exact Danilov endpoint, the
`65 + 18 + 4 + 5 = 92` Lean inventory, all 58 `#print axioms` queries, and the
explicit absence of an unconditional `ABCConjecture` term. Its
machine-readable result is `pdf-verification.json`; the captured run is
`verify-pdf-stdout.txt`.

## Visual checks

Poppler rendered all 124 pages at 60 dpi. Seven contact sheets cover pages
1--20, 21--40, 41--60, 61--80, 81--100, 101--120, and 121--124. Page 1 and
pages 111--124 were also rendered at 120 dpi. The contact sheets were checked
as a complete-page survey; high-resolution review covered the title page, all
five pages of the new four-route section, its formal boundary, the new-module
table and metrics, the terminal open-status paragraph, and the final
bibliography page.

No clipped equations, text collisions, margin overflow, missing glyphs,
malformed table rules, unexpected blank pages, or header/footer defects were
found. In particular, the normalized-weight formulas on page 112, the affine
count on pages 113--114, the Pell ledger and finite-search boundary on page
114, both Danilov amplification bounds on page 115, and the declaration counts
on pages 116 and 121 render inside the text block.

## Claim audit

The four routes are stated with their actual logical scope. The scalar and
derivative counterexamples close only the named auxiliary mechanisms. The
affine squarefree theorem does not supply the thin exceptional lower bound;
the two Pell simple-index sets are not claimed to intersect; the search below
`10^9` is a finite lower bound; and both Danilov prime-population conclusions
are conditional on a squarefull survivor. Literature theorems, analytic
estimates, and large computation certificates remain outside the Lean kernel.
The paper states that neither an unconditional Lean proof nor a rigorous
unconditional disproof of standard abc has been obtained.
