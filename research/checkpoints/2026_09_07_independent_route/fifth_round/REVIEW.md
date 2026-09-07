# Fifth-round proof review and arithmetic replay

Date: 2026-09-07. Fourth-round files remain unchanged.

## Independent ordinary and transcription review

The complete `quantitative_kummer_covers.md` QC1--QC5 ordinary proofs
were independently read and approved by root, critical_bottleneck, and
adversarial_audit. QC6 received root's review of the complete proposed
argument and adversarial_audit's subsequent full written-proof review.
Adversarial_audit then reviewed all QC1--QC6 and the full transcription
`paper/quantitative_kummer_covers.tex`; both passed without a mathematical
gap. The detailed checks included:

- the fixed splitting field of degree eight and signature (0,4), with
  no exponent-dependent adjunction of roots of unity;
- unramifiedness away from 3 and 13, good-prime factor allocation, and
  the exact thirteen-adic depth limiting the bad-prime contribution;
- the identity product A_i=(V), the at-most-H choices of each ideal
  class root, and only three unit quotient classes for the three ratios;
- the uniform count C_K 4^(8 omega(V)) g^9 for fixed (g,V), versus
  C_K g^9 exp(17 Lg) for the union over 1<=V<=exp(Lg);
- the full logarithmic unit lattice and balanced generator bound,
  retaining the order-g contribution to coefficient height;
- the unit-class lower bound for every representative, including
  adjustments that are not integral units;
- the actual seed point-height lower bound, which does not follow
  from and is not contradicted by the cover-count or coefficient bounds.

The finite class group and unit basis remain abstract fixed field data.
No numerical class number, regulator, or full unit basis was asserted.
Milne's author-hosted *Algebraic Number Theory* PDF was actually opened;
Theorems 5.1 and 5.9 were located for the unit rank and full lattice.
The new TeX uses the bibliography key `MilneANT2020`; the parent was sent
the exact primary citation and will handle the shared bibliography.

## Exact arithmetic replay

Command actually run:

    python research/checkpoints/2026_09_07_independent_route/fifth_round/exact_cover_arithmetic.py

This standard-library-only replay uses exact rational arithmetic in
Q[zeta]/(zeta^2-zeta+1). It checks the two reciprocal quadratic factors,
their discriminants and norm/product 13, and the quartic discriminant
117 by an exact Sylvester determinant. It also checks the required
primitive residue statements modulo 3 and 169, on their full finite
domains. The same bad-prime facts had previously been proved and
reviewed; they are included here as the explicit arithmetic dependency
of the new uniform factor-allocation count.

Canonical UTF-8 LF output: `exact_cover_arithmetic_results.json`.
SHA-256:

    860bc44890b89079ad72911ff9cd038bd43920a4bd8406de23f02e804b94ee52

This is not a field-degree, class-group, unit-lattice, Kummer, or Lean
verification. Those conclusions have ordinary proofs with the scope
above. It proves no uniform rational-point height theorem or ABC result.

## Cross-review

I independently reviewed adversarial_audit's fifth-round
`high_rank_depth.md` HR1--HR3 in full. The cyclotomic construction of
the needed split prime, exact high-depth lifting, explicit size bounds,
primitive positive homogeneous realization, and the cutoff/totient
conclusion are correct. The selected prime's own signed contribution
is at most 1/g of the height, so the counterexample correctly targets
the coarse E_hit condition and leaves E_net undecided.

Its TeX transcription was also reviewed. The mathematical content passed.
Two requested definition-domain clarifications were subsequently added and
their actual file contents checked: N(w)>1, and rank-packet sums restricted
to p>3 prime to N(w). The final transcription review therefore passed.

## Fourth-round PDF read-only visual check

I actually opened `tmp/abc_20260907/round4pdf/qa/page-391.png`,
`page-392.png`, and `page-393.png`. All three pages passed. Equations
680--683 and the displayed theorems, lemma, and corollaries were fully
visible, with no clipping, overflow, garbled glyphs, or overlapping
text. The page-392 corollary continued correctly into its proof on
page 393, and the PL conclusion transitioned clearly into the LP
section. No fourth-round file was changed.
