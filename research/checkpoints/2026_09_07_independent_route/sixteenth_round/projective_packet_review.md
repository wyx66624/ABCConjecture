# JP1--JP3 full ordinary independent review

Reviewer: independent_route. Status: FULL PASS after actual complete reading.
Source: `research/checkpoints/2026_09_07_critical_bottleneck/sixteenth_round/projective_packets.md`.
SHA-256: `9a614c79b25c92c3c4cd56a6877ddcfcfcdb7734b56075d25db602c842a094f7`.

The prime-independent quotient is the actual norm-one group modulo global
mu3. Cubing recovers true integral-exponent independence. Each reduction is
correctly restricted to marked q-unit ratios. Embedded mu3 stays distinct,
and the q-primary higher-precision kernel has no n-torsion, so the finite
quotient contributes at most n elements at each individual prime.

For two signed vectors the three possible global phases are all paid for:
each marked prime power divides the determinant of its own phase, and the
product over distinct primes divides the product of the three integer
determinants. The Gram bound applies to unit rotations, conjugates, unequal
lengths and the empty product. Strict product height below m implies a zero
determinant, hence equality in the actual global quotient and then equality
of the signed vectors. Empty phase packets do not introduce a gap.

The count is n^s, not n; the signed-ball count and the singleton case are
correct. The same-phase improvement has its additional hypothesis stated
explicitly. No global prime-label bound, all-root independent subset or
far-tail membership is claimed. This review is of the ordinary proof only,
with no finite replay, Lean compilation or publication change.
