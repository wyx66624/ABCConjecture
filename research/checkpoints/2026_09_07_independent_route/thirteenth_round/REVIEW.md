# Thirteenth-round independent review record

All reviews below concern the complete named source unless a smaller
scope is explicitly stated. Finite computation and compilation are
recorded separately from ordinary mathematics.

## CL1--CL3

Root, critical_bottleneck and adversarial_audit each read the complete
ordinary proof and returned PASS. The homogeneous local normalization,
four residue points, valuation-one and valuation-two cases, infinity,
and propagation by the complete projective power map were all checked.
The ordinary integral comparison is explicitly distinguished from
the stronger full local curve assertion.

Both peer agents read the complete final TeX and returned PASS,
SHA256 21db28a8bbff2dc6eccc4eef1d0f9feff3b8794853cf74a54e103b2aebdc7c4e.

## EQ1--EQ3

critical_bottleneck and adversarial_audit read the complete ordinary
proof and returned PASS. Both exact maps, discriminants, involutions,
the arithmetic isogeny identity, every rational-image exception,
and the explicit infinite-order proof were independently checked.
No rank upper bound from PARI is a proof dependency. Root's complete
EQ ordinary review has not yet been reported in this snapshot.

Both peer agents read the complete final TeX and returned PASS,
SHA256 3e4618fdd412eaea27f024cc2a77d5a4dbf763df07991520f5a858e4222fd950.

## Six local arithmetic declarations

The author actually compiled CubicUnitLocalArithmetic.lean with
Lean 4.32.0 and completed all six axiom queries. All passed; the
complete Fin 27 table has no axiom dependencies. The remaining
queries use only propext, Classical.choice and Quot.sound.

Both peers read all six signatures, proofs, scope and manifest and
returned PASS. They did not claim a second compilation. Source SHA256:
ec5f2f2d1783d4c8c6a1d698c5b2f6555a95ef0d0af8dc14489e01a82e90147a.
The actual integer congruence and gcd theorem are formal; Q_3,
weighted projective geometry and curve morphisms remain ordinary.

adversarial_audit also independently enumerated all 19,683 residue
triples modulo 27. All 648 primitive coordinate pairs had no square
hit; every one of the 243 hits had both coordinates divisible by
three. This was a separate finite replay, not a Lean build.

## Author's final finite replay

Both write and --check runs passed for replay_genus_two_probe.py.
The canonical result is
6f6150df50428609e6ffaf24f0251d870430e8b7cab951041d952e0d8cf7f82e.
Its exact scopes are specified in README.md and in the JSON. It
includes bounded point searches and polynomial identities; it is
not a complete rational-point computation or a certificate of any
elliptic rank upper bound. No visual PDF review of round thirteen
has yet been performed.
