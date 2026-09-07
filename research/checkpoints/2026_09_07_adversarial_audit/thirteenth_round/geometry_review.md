# Thirteenth continuation: independent geometric ordinary reviews

Reviewer: adversarial_audit. Date: 2026-09-07.
This record concerns complete ordinary proof review, not new Lean verification
or a rerun of the author's PARI calculations. Published round twelve is frozen.

## CL1--CL3: complete local gate, PASS

Source: `research/checkpoints/2026_09_07_independent_route/thirteenth_round/cubic_unit_local_gate.md`
Reviewed SHA256: `3a7022bb4b66846953eaa8e6df47a323491ffeec8c01a0cc598be78137fb5326`.

I read the complete final candidate. The weighted homogeneous sextic model
covers every rational point of the smooth double cover: normalize its image
in P1(Q3) by min(v3(S),v3(T))=0, and scale the weight-three coordinate
accordingly. Thus a square criterion in each base fibre suffices and includes
(1,0), not merely finite affine s. The six branch points are simple by HG.

The values of E modulo 3 at the four projective residue points are all units.
If S is not T modulo 3, C is also a unit, so -3CE has odd valuation one.
If S=T+3K, the exact expansion
C=3(T^3+9KT^2+18K^2T+9K^3) gives v3(C)=1, and the unit part
(-3CE)/9 is -T^6=-1 modulo 3. Hence it is not a square. These alternatives
exhaust primitive Z3 coordinates, with no exceptional fibre omitted.

For odd g=3k, identity-unit projective power maps compose exactly. Keeping
t and replacing s by L_(1,k)(s) gives a nonconstant rational curve map
D_(g,1) to D_(3,1). Smooth-projective extension makes it a morphism over Q,
then over Q3, so it propagates the local obstruction over all points. The
Gaussian forgetful map propagates it once more. This relies on the reviewed
connected smooth curves, not a component-free assertion on an arbitrary
singular affine equation.

CL3 correctly separates the already elementary integral coefficient
obstruction from this complete local curve result. For the former,
primitive square M has v3(M)=0, whereas an identity-unit cube has second
coefficient 3ST(S+T). The two nonidentity unit classes are not excluded;
no bounded point scan is used to prove their emptiness.

## EQ1--EQ3: two elliptic quotients and the exact image gate, PASS

Source: `research/checkpoints/2026_09_07_independent_route/thirteenth_round/elliptic_quotient_gate.md`
Reviewed SHA256: `d74696665669762f596d25b2eecdcc7ed8fa8726d11a882ac521c5db4ce76cc4`.

I read the complete note and checked the two changes of variables, the even
sextic, and the quotient formulas. Substituting t=(s+1)/(s-1) gives the
stated short Weierstrass models, whose discriminants are 11664 and 944784.
The invariant subfields under (t,v)->(-t,v) and (t,v)->(-t,-v) are exactly
the displayed elliptic function fields, each of index two. Smooth projective
extension handles the apparent chart poles. Both quotient maps are defined
over Q. The divisor norm/pullback identities and the hyperelliptic involution
acting as -1 give Psi Phi=[2]; dimension two on both sides makes Psi a
Q-isogeny. No decomposition valid only over C is promoted to Q.

Clearing the first X formula gives the quadratic in s with discriminant
4X+9. The exact image includes O from s=-1, X=-2 with Y=+/-1 from s=0
(and also infinity), and no rational point at the double-discriminant value
X=-9/4 because the Weierstrass right side there is -9/64. For any other
finite elliptic point satisfying the square criterion, a rational quadratic
root cannot be -1, and y=Y(s+1)^3 reconstructs the hyperelliptic point.
Thus the image assertion is genuinely both directions, including all
projective exceptions. It is only one quotient gate: the remaining HG square
root and the positive common-source condition are still required for seeds.

The displayed doublings of (-2,1) and (6,9) are exact. With odd integral
short coefficients a,b and v2(x)=s<0, the unique lowest valuations in the
doubling numerator and denominator are 4s and 2+3s. Thus the new abscissa
has valuation s-2. Both doubled examples begin at -2 and generate infinitely
many distinct abscissas; both original points have infinite order. The
Q-isogeny and Mordell--Weil then give Jac(H)(Q) rank at least two. No claim
of a full set of generators or a certified upper rank uses PARI output.
The non-lifting example 2P has 4X+9=34 and refutes only automatic lifting
of all points on that elliptic curve. It does not resolve all common-source
points or either nonidentity unit branch.

Standard curve-extension and norm/pullback dependencies are the published
RL/HG inputs previously source-reviewed; no additional analytic or rank
black box is used by these local calculations.

## CL finite arithmetic source: six statements, PASS

I read the complete CubicUnitLocalArithmetic.lean, its ordinary scope and
its author fresh-build manifest. Source SHA256:
ec5f2f2d1783d4c8c6a1d698c5b2f6555a95ef0d0af8dc14489e01a82e90147a.
Manifest SHA256: 4737e107fcd8364047f5bcd9e5385633b4a0f6b11288ac8ffc324936ff990ae0.
The source imports only Std. The mod-27 table uses kernel decide, with
an empty axiom list in the author record. The remaining dependencies
recorded there are subsets of the standard three axioms.

The integer polynomial and the shifted cubic identity are the actual
ones used by CL. Remainder compatibility is proved for every integer
modulus. The finite-table transfer constructs the three actual mod-27
remainders in Fin 27, including for negative input integers, then proves
both mod-3 remainders vanish. An integer square therefore forces common
3-divisibility, which the actual Int.gcd=1 hypothesis rules out. There
is no formal Q3, weighted-projective model, or curve-morphism claim.

Separately, I actually ran a complete independent Python integer replay
of all 27^3=19683 coordinate/square triples. All 243 equalities occur
with both coordinates divisible by 3; none of the 648 coordinate pairs
primitive modulo 3 has a square value modulo 27. The canonical result
is verification/cubic_mod27_review.json. This finite replay is independent
of the Lean proof and does not replace the ordinary all-Q3 argument.
I did not rerun the Lean compiler.

## CL/EQ final full paper transcription: PASS

I actually read both entire TeX files after the complete ordinary reviews.

- `research/checkpoints/2026_09_07_independent_route/thirteenth_round/paper/cubic_unit_local_gate.tex`: `21db28a8bbff2dc6eccc4eef1d0f9feff3b8794853cf74a54e103b2aebdc7c4e`.

- `research/checkpoints/2026_09_07_independent_route/thirteenth_round/paper/elliptic_quotient_gate.tex`: `3e4618fdd412eaea27f024cc2a77d5a4dbf763df07991520f5a858e4222fd950`.

CL retains every projective Q3 fibre, the identity-unit composition and
extension to all odd exponents divisible by three. Its six-declaration
paragraph exactly matches the arithmetic-only source scope. EQ retains
both degree-two quotient maps and Q-defined isogeny, every exception in
the exact rational image, the two independent rank contributions and
the strict but partial common-source gate. Its bounded-search paragraph
is presented as author finite evidence; I have not independently rerun
those PARI searches. The independent mod-27 replay I did run is recorded
separately above. No finite scan is used as rational-point completeness.
