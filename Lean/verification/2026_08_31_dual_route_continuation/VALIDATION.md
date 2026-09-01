# Dual-route Lean validation

Validated on 2026-08-31. The standard `ABCConjecture` remains open.

- Six modules compiled directly with exit code zero.
- The declaration audit covers 109 declarations: 94 theorems and 15 definitions/structures.
- The audit has no warnings, no `sorryAx`, and no unexpected axioms.
- Kernel dependencies are exactly: Classical.choice, Quot.sound, propext.
- Full `lake build` passed with 9142 jobs.
- The 265 warning lines exactly match the frozen baseline multiset; the new modules add zero warnings.
- Protected statement/toolchain files and package pins match the frozen baseline.
- The positive route proves an exact uniformity equivalence and conditional amplification lemmas.
- The counterexample route proves a conditional Pell/Campana disproof gate, without assuming its open squarefull-subsequence premise.
- The accepted ChatGPT manuscript is a 102-page A4 PDF. Its final TeX pass
  has zero diagnostics in the audited categories, every page was rendered and
  visually inspected, and its SHA256 is
  `cbbd600376a9c27754e6969612efa9ed2833060f60cb1a48d4b64ed03c25bfc4`.
- Presentation QA is recorded in `PDF_QA.md`; it is not external peer review.
