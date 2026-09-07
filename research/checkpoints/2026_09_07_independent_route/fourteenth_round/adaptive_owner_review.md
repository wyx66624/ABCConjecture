# Independent full ordinary reviews of AP and OC

Reviewer: independent_route. Date: 2026-09-07. Status: PASS for both.
This new record does not alter the frozen CL/EQ sources or their
thirteenth-round publication inventory.

## AP1--AP4

Reviewed the complete candidate at
`critical_bottleneck/thirteenth_round/next_adaptive_precision.md`.
Reviewed SHA256:
7ef4bf9161b752825441e127492d46edf42f87defa853f7155678fa0d9719ee1.

The individual boundary-arm cap is valid: the three integer coordinates
are pairwise coprime, so a supported prime contributes its full depth
to one coordinate. Its logarithmic depth is bounded by t_k, not just
by log(T_k). The norm and coordinate bounds give t_k<n log(8B) with
the stated strict constants even at n=1.

The UM determinant bound is already strictly below (8B)^(2 nu),
uniformly for every positive tuple length. Consequently the separate
precision condition q^e >= (8B)^(2 nu) is sufficient. The norm-one
torsion lifting argument applies at every positive precision because
q does not divide 3n, and multiplicative independence gives the exact
multiset injection.

The adaptive threshold includes its max with four. When it exceeds
four, subtracting the four initial depths pays the ceiling without
an additional log(q) error. All lower positive layers and all high
layers are included, giving 13n log(8B), then 26/B after actual
whole-block normalization. The two-progression sum and the numerical
52n/(n-1)<55 are correct. The finite data-dependent far-prime set is
indeed finite, and its o(B) cardinality is only an unproved sufficient
condition. No count at a fixed prime is mistaken for that condition.

## OC1--OC3

Reviewed the complete candidate at
`critical_bottleneck/thirteenth_round/next_two_owner_concentration.md`.
Reviewed SHA256:
6d51ac87112b162830132da032d5be017dcdb4ec0c320fc32f84105aff9f9ca5.

The three thresholds use independent valid moment choices. The cubic
multiset count gives M_h0^3<=18n and the threshold ceil(sqrt(6n))
forces M_h1<=2 by the quadratic binomial count. The selected two
greatest depths contain every h1-hit, including all ties at that
threshold because there can be no more than two such hits.

Outside the selected pair, the complete positive layer sum has only
the two displayed ranges. Empty ranges and all ceiling effects are
handled correctly. Their constants 15 sqrt(n) and 24 n^(5/6) give
39 n^(5/6); the two removed roots cost at most 2n log(8B) by the
individual-arm cap. Division by the actual lower bound for t_k gives
78 n^(-1/6)/B.

At log(q)>=(r/2)log(8B), both thresholds equal four, so there are at
most two actual roots with positive excess. The labelled graph allows
one-vertex edges and repeated endpoint pairs; it does not impose a
uniform choice of owners or bound the number of prime labels. The
far summation, the roots outside the independent class and the signed
negative credits remain explicit open issues.

No mathematical correction is required. This is full ordinary proof
review using the previously reviewed UM/MC and prime-progression
inputs. No new software replay, Lean compilation or complete far-tail
estimate is claimed by this review.
