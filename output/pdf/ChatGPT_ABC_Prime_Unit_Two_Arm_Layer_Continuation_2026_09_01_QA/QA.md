# PDF release QA

**Artifact:** `ChatGPT_ABC_Prime_Unit_Two_Arm_Layer_Continuation_2026_09_01.pdf`

**Author metadata:** ChatGPT

**Verdict:** PASS

## Mechanical checks

- Bundled Tectonic 0.17.0 compiled the final source and exited `0`.  The retained
  final-pass log contains no overfull box, undefined control sequence, LaTeX
  error, undefined citation, or undefined reference.
- The final log contains one historical, nonblocking underfull-vbox location in
  `balanced_persistence_2026.tex` near line 694 (badness 1281).  Visual review
  of that page found no clipping, collision, or malformed spacing.
- The bundled runtime emits a nonblocking Fontconfig configuration warning
  before TeX starts.
- The PDF is unencrypted A4, version 1.5, has no forms or JavaScript, and has
  nonempty extractable text on all 134 pages.
- It is 978,374 bytes. SHA-256:
  `594ef475fd66d43f4e2fc8bae355bde9af1fde21f66a64a3e67e8a370846ddad`.

`verify_pdf.py` checks these properties, the ChatGPT author metadata, and
extracted-text markers for the honest open status of standard abc, the
prime-unit vector bridge, the exact 318,322,715-point affine packet, the
near-quadratic Mersenne tail reduction, the exact ambient square-budget ratio,
the `97 theorem / 10 definition` Mersenne inventory, and the full
`176 theorem / 220 declaration / 177 #print axioms` continuation inventory.
It also checks that the paper explicitly records the absence of an
unconditional closed term of type `ABCConjecture`.  The machine-readable result
is `pdf-verification.json`; the captured run is `verify-pdf-stdout.txt`.

## Visual checks

Poppler rendered all 134 pages at 45 dpi.  Seven contact sheets cover pages
1--20, 21--40, 41--60, 61--80, 81--100, 101--120, and 121--134.  Page 1,
pages 115--124, pages 129--130, and page 134 were also rendered at 120 dpi.
The contact sheets were inspected as a complete-page survey.  High-resolution
review covered the title and abstract, all four new route sections, the new
Mersenne proofs and square-budget corollary, the formal module ledger and
counts, and the last bibliography page.

No clipped equations, text collisions, margin overflow, missing glyphs,
malformed table rules, unexpected blank pages, or header/footer defects were
found.  In particular, the fixed-theta hypothesis and weighted
Brun--Titchmarsh sum on page 122, the square-budget ratio and conditional
Murty--Seguin comparison on page 123, and the declaration counts on page 130
render inside the text block.

## Claim audit

The paper states its actual logical scope.  The exact counterexamples close
only the named auxiliary claims whose full hypotheses they satisfy.  No broad
route is closed for difficulty or for a bounded no-hit.  The Carella repair,
faithful IUT label vector, affine coupled three-arm inequality, and Mersenne
canonical-block mass estimate remain open at their stated interfaces.
Cyclotomic classification, analytic estimates, order-distribution theorems,
and the surviving global hypotheses remain outside the Lean kernel.  The paper
does not claim an unconditional proof or rigorous unconditional disproof of
the standard abc conjecture.
