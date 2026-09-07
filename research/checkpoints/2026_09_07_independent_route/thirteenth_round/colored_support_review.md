# NC1--NC5 independent full ordinary review

Reviewer: independent_route. Date: 2026-09-07. Status: PASS.
Reviewed full source:
`research/checkpoints/2026_09_07_adversarial_audit/thirteenth_round/colored_norm_support.md`.
SHA256: bcc2e3ae8b012d4246630103f354d22edc866f3ef2005c988bf2cda63230420c.

The exact graph degree follows from the two simple norm-root classes,
subtracting the vertex itself, and summing at most m large norm primes.
Greedy coloring uses at most D colors. Within each color a chosen large
prime is private relative to that color, and its nonzero oriented ideal
valuation proves integer multiplicative independence. Depth one is not
assumed, and small-prime overlap is harmless.

The complete norm valuation sum keeps every level. Partial summation
of the stated fixed-modulus-three prime theorem gives the main
B log(x) term, while the explicit endpoint C x log(49B^2)/log(x) is
retained. Dividing by the complete per-root log norm upper bound gives
the domain estimate. The constants are uniform for theta in a fixed
compact interval [theta_0,1], including the floor in the color budget.
There is no uncontrolled theta-to-zero step.

The UM proof is applied separately to each previously fixed independent
color. It supplies the uniform-in-moment rigidity, injective multisets,
and every positive excess layer. Summing the colors incurs exactly the
factor D in the per-prime and mean budgets. The rank-one exclusion,
norm-one group order and the two reduced progressions are consistent;
the argument does not assert that alpha itself always has order 3n.

For kappa=4theta-3 the powers cancel as
4(1-theta)+kappa-1=0. The logarithmic asymptotic, Markov errors and
domain fraction (5-kappa)/8 are correct, including the example 17/32
at kappa=3/4. Full-block normalization permits removing the FM/EA
exceptional set without imposing a uniform estimate on a previously
discarded smooth subset. The signed far tail is kept explicitly.

No mathematical correction is required. The comparison with MC below
kappa=1/2 correctly declines to claim improved domain coverage there.
This review uses the same already reviewed primary analytic inputs as
PN/MC/UM; I did not reopen the newly linked primary pages during this
particular source review. No extra finite computation or Lean build
was performed, and no global tail or all-root independence result is
inferred.

## Final TeX transcription

The complete self-contained paper/colored_norm_support.tex was read in
full after the ordinary review: final mathematical transcription PASS.
Its explicit all-prime convention, graph budget, cutoff endpoint,
uniformity range, repeated multisets, complete depth ledger, exact
normalization and all remaining-scope statements agree with NC1--NC5.
The through-Z use of Brun--Titchmarsh is now explicitly related to its
interval form. No mathematical change or unsupported formal claim was
introduced. This is source review, not rendered PDF inspection.
Final reviewed TeX SHA256:
9eeeac82d4826301cf40cc68c604ebc921de1b15760bafa9332e1fb74a384ce2.
