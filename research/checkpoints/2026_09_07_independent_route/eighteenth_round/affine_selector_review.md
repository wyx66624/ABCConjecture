# Independent ordinary review of LM1--LM5

Reviewer: independent_route. Date: 2026-09-07.

Actually read the complete final ordinary source
`research/checkpoints/2026_09_07_critical_bottleneck/eighteenth_round/affine_owner_selectors.md`.
Reviewed SHA256:
`76ca4bd2770971523fc917f83f3f54228fa0202ed7e7ef6030e3c7448bc03a51`.

Result: **PASS for the full ordinary proof**. No new compiler or author
finite-replay execution is claimed in this review.

The finite difference in LM1 is a true nonzero coefficient vector with
zero actual Eisenstein output, and its stated restricted obstruction is
accurate. In LM2 both determinant identities imply that the full content
divides the fixed determinant; preserving the owner modulo one more than
the boundary valuation fixes the complete depth and its norm-unit
condition excludes content loss at that prime. LM3 uses the actual Gram
determinant inequality, and its modulus lower bound survives cancellation.

In LM4 the exceptional primes include every possible content prime and
every zero slope or coincident-root prime. The progression freezes both
the cubic valuation and the common coordinate valuation, since the former
is at least three times the latter. Dividing by that fixed content gives
three affine integral arms with unit slopes and distinct simple roots at
every remaining prime. This also excludes cross-arm square factors.
For each fixed progression the complete large-prime square tail is at
most `3X sum_(p>Y) p^-2 + 3 sqrt(C0 X)`, so the passage from finite CRT
densities to the infinite product is justified without a prime-distribution
input. The lower bound 1/4, exact fixed K, full signed identity, limiting
value -6 and radical inequality follow. None is claimed uniformly in the
moving input data.

LM5's angular cone and its derivative give nonparallel positive powers
and positive coordinate differences. Both explicit different-owner
packets satisfy the asserted boundary congruences, including the depths
4 and 5 in the positive-cost example. Their n=2 and small-prime scope is
expressly separated from the original US moving prime block. The output
is a new affine family, with no asserted preservation of the original
power compression or proof of general ABC.
