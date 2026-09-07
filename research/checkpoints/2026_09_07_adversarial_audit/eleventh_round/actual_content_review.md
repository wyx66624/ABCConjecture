# Independent review of the actual projective-content module

Date: 2026-09-07. Reviewer: adversarial_audit. Full source and proof-scope
review PASS. This reviewer read all nine declarations and proofs, inspected
the complete fresh-build axiom output, and independently checked every
listed source hash and declaration/query count. The compilation was run by
the root agent; it was not redundantly rerun by this reviewer.

Source:
`2026_09_07_integral_lifting/Lean/ActualProjectiveContent.lean`.
SHA256: `4cac8f1cb11b7bcb9e3ff041c8f024f4fe11c22b6b11a64e0c64a4ac5d4b72c9`.

## Exact mathematical scope

The definition of content is the actual `Int.gcd` of the two integer
coordinates. `content_mul_divides_norm` assumes only that the input W has
content one. It derives Bezout coefficients from `Int.gcdA`, `Int.gcdB`,
and the library identity, and uses the previously proved multiplication
adjugate. Neither the desired divisibility nor a Bezout witness is a
premise. The multiplier need not be primitive or nonzero for that theorem;
the zero case is valid. Nonzero hypotheses are used precisely for positive
content and primitive reduction.

`reduced` uses actual integer division by this gcd. Divisibility by the gcd
proves coordinate reconstruction, including the harmless zero pair.
For a nonzero pair, the library's gcd-of-divided-coordinates theorem proves
primitive reduction. The norm clearing identity holds even at zero, and
the product version uses the actual Eisenstein norm multiplication theorem.
The last declaration verifies the complete norm-seven n=5 arithmetic
example, including both actual gcd values, the primitive quotient, and
the input/output norms.

The nine declarations match the reviewed PC integer core. They do not
formalize the Eisenstein UFD, primitive unramified powers for arbitrary
exponents, the infinite counterfamily, orientation allocation, the residual
bill, the simultaneous rational-map inverse, or ABC.

## Validation evidence inspected

Manifest: `2026_09_07_integral_lifting/verification/mathlib_validation.json`.
SHA256: `6eaa87f2171bc49aec1184627f5eb5b05c1ef4f1621f7faf913289150b96de06`.
Build/axiom log SHA256:
`63eca175f4e2505633182f25553df72997db9ad45b8c7f1cd202681ad0fd34aa`.

The manifest reports fresh compilation of the nine new declarations and
29 unchanged Eisenstein dependencies. Their current source hashes and
query inventories match. The inspected axiom output covers all 38 named
declarations and uses only `propext`, `Classical.choice`, and `Quot.sound`.
Lean is 4.32.0, commit `8c9756b28d64dab099da31a4c09229a9e6a2ef35`;
the pinned Mathlib commit is `81a5d257c8e410db227a6665ed08f64fea08e997`.
The Mathlib cache was reused. This is not a whole-repository or Mathlib
rebuild claim.

## Subsequent combined inventory

The root subsequently extended the same scoped manifest with the separate
seven-declaration residual reflection module. The nine content source
bytes remain exactly unchanged. The current 16-new + 29-old manifest
and log, independently checked after that extension, are recorded in
`residual_bill_formal_review.md`. The hashes above identify the earlier
9-new + 29-old snapshot, not the overwritten manifest's current bytes.
