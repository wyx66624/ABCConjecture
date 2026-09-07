# Thirteenth continuation: a local cubic class and an elliptic lifting gate

No proof or disproof of the general ABC conjecture is claimed.
The preceding 502-page twelfth-round publication is frozen.

## Reliable ordinary results

- CL1--CL3 prove that the entire identity-unit cubic hyperelliptic
  quotient has no Q_3 point, and propagate this by a projective curve
  morphism to every odd exponent divisible by three in the identity-
  unit Eisenstein and higher Gaussian curves. The two nonidentity
  unit classes remain open. The comparison with the already elementary
  integral cubic-coefficient obstruction is explicit.
- EQ1--EQ3 give two explicit degree-two elliptic quotients of the
  nonidentity-unit cubic genus-two curve, a Q-isogeny of its Jacobian
  with their product, and the exact rational lifting condition
  4X+9 being a rational square on the first elliptic curve. All chart
  exceptions are handled. Explicit doubling proves both elliptic
  curves have infinite-order points, hence the Jacobian has rank at
  least two, without using software rank bounds.

The ordinary proofs are in cubic_unit_local_gate.md and
elliptic_quotient_gate.md. Complete self-contained TeX transcriptions
are in paper/. The exact review status is recorded in REVIEW.md.

## Actual formal scope and finite evidence

Lean/CubicUnitLocalArithmetic.lean has six proved statements using
only Std. It proves the actual sextic's complete mod-27 table and
transfers it to all primitive integer coordinates. The table uses
kernel decide and has no axiom dependencies. The other declarations
use only the standard axioms. Fresh Lean 4.32.0 compilation and all
six axiom queries passed; see verification/local_arithmetic_build.json
and local_arithmetic_scope.md. No Q_3 or curve geometry is claimed
as formalized by these arithmetic declarations.

Run the finite exact probe with:

    python research/checkpoints/2026_09_07_independent_route/thirteenth_round/replay_genus_two_probe.py --check

It uses installed PARI/GP 2.15.4 and independently checks its bounded
point output with exact Python arithmetic. It verifies nine quotient
models, both elliptic maps, the even-sextic and inverse-discriminant
identities, two exact doublings and discriminants, 70,767 independent
curve-abscissa cases at bound 80, and all 648 primitive coordinate
pairs modulo 27. The nine GP point searches at bound 1000 return
24 affine points, all at s=0 or -1, with no positive common-source
point in the searched box. This is not a computation of all rational
points. Diagnostic GP rank outputs are not proof dependencies.

Canonical finite result SHA256:
6f6150df50428609e6ffaf24f0251d870430e8b7cab951041d952e0d8cf7f82e.
Both write and --check runs passed on the final script.

Official APIs consulted:
[PARI hyperelliptic curves](https://pari.math.u-bordeaux.fr/dochtml/ref/Hyperelliptic_curves.html)
and [PARI elliptic curves](https://pari.math.u-bordeaux.fr/dochtml/ref/Elliptic_curves.html).
The installed 2.15.4 hyperellratpoints help was checked as well.
The curve-extension and norm/pullback inputs are the already reviewed
Stacks and Milne inputs from RL/HG.

## Separate cross-reviews

uniform_moments_review.md contains complete ordinary UM1--UM4 review,
the final TeX review, and full signature/proof/scope review of its
fifteen arithmetic declarations. colored_support_review.md contains
the complete ordinary NC1--NC5 review. Neither record asserts an
extra independent compilation of the peers' Lean modules.

The nonidentity-unit positive rational loci, their simultaneous
same-source square conditions, moving residuals and the global
uniformity problem remain open. The rank lower bound does not
eliminate more refined descents or elliptic methods.
