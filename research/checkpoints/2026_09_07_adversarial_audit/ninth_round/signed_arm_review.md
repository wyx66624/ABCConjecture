# Independent review of actual signed-arm compensation

Date: 2026-09-07. Status: SA1--SA4 complete ordinary review PASS,
after making the positive-sector bridge to LR2 explicit. Earlier
round-eight proof and paper sources were not changed.

Reviewed the complete
`2026_09_07_critical_bottleneck/ninth_round/signed_arm_compensation.md`
and its full `replay.py`. This is a sufficient criterion for the
large-index homogeneous branch, with an open actual membership
problem. It is not a proof of the general signed-tail gate.

## Actual quotient structure and necessary domain

For n=1 modulo six, the power map fixes each boundary line; for
n=5 modulo six, conjugating the root before powering does so. At
a=0, b=0, and a=-b the three claimed specializations follow directly
from zeta^6=1. They prove polynomial divisibility by a, b, a+b,
respectively, before evaluating any integers. The resulting quotient
polynomials have integral coefficients and degree n-1.

Primitive and unramified are both necessary here. Primitive w with
3 not dividing its norm has only one orientation of each split
prime, so its powers remain primitive and have no zero boundary arm.
Consequently their three nonzero coordinate arms are pairwise
coprime; the three respective integer quotient divisors are also
pairwise coprime. The additive identity and the product identity are
then exact. For prime n the product is the single top cyclotomic
factor up to sign; for composite n it is the complete nontrivial
divisor product, as the manuscript explicitly states.

The excluded example w=1+zeta, n=5 gives quotient values -9,-9,-9.
This confirms that merely calling the root primitive would not
suffice. The actual manuscript already retains 3 not dividing Q,
Q>=7, and the nonzero-boundary hypotheses.

## The finite signed inequality

Each output arm lies between exp(t-Delta) and exp(t) in absolute
value: the other two logarithms are at most 2t. Dividing by its
nonzero input arm gives exactly

    t-Delta-log c1 <= log|D_i| <= t.

For the selected arms i,j, the pointwise inequality
e<=2+max(e-2,0) gives R_i>=(S_i-E_i)/2. Pairwise coprimality
makes the signed weights add on the quotient product. Substitution
of the individual height intervals and low-prime masses yields
the displayed SA5, including its constants 1/2 and 3/2.

The original boundary factor T1 may share primes with the quotient
product. The manuscript correctly avoids a false coprime radical
factorization: at a previously supported prime the added weight is
exactly its added multiplicity; at a new prime the extra -3 credit
only decreases it. Therefore log W(UV)-log W(V)<=log|U|, which
justifies the log T1 term without dropping an overlapping credit.
The third arm retains the full -3R_k term and is not assumed to have
small multiplicity excess.

## Precise use of the reviewed LR2 theorem

LR2 is stated for positive coordinates. The reviewer requested an
explicit bridge from the signed-coordinate power, and the author
inserted it in SA3. A unit rotates the nonboundary output into the
open positive sector. Units and conjugation permute the absolute
values of its three arms, preserving c, T, Delta, and every prime
valuation. The representation has ramified exponent zero, unit
residual, exponent n, and root w or its conjugate of norm Q. Hence
lambda=1/n, exactly within LR2's domain.

The earlier LR2 was reread at its statement, unit-residual branch,
and local identity (L8). That identity explicitly includes p=3 when
the ramified exponent is zero, with the additional normalized
valuation 3/2. The p=2 case is also retained; primes dividing the
norm cannot divide the primitive boundary. Thus SA7 includes the
entire small-prime mass, not only primes greater than three.

The norm bounds give t>=n log Q/2 and
log c1+log T1<=2log Q+log(2/sqrt(3)). Their ratio is less than
5/n for Q>=7. The elementary prime sum is at most Y^3 log Y,
so at Y=n^(1/6) the remaining error is
O(log n/n+1/n+log^3 n/sqrt n), uniformly in every moving root.
These estimates are ordinary consequences of the previously
reviewed logarithmic-form theorem; no new Lean proof of it is used.

## Sufficient subclass and exact scope

If two selected quotient arms have every large-prime valuation at
most two, their E terms vanish. The third arm can have arbitrary
private depth, while its radical contributes negative signed credit.
More generally the positive part of E_i+E_j-2R_k being o(t)
suffices. In either case the conclusion concerns the positive part
of log W divided by t, not two-sided convergence of the signed sum.

The resulting restricted ABC estimate is uniform for sufficiently
large n, for each fixed epsilon, as in the stated n-to-infinity
hypothesis. Bounded n with unbounded Q are not a finite set of seeds
and are not disposed of by this asymptotic proof. The reviewer
requested that this range also be explicit in the short prose
description of the restricted estimate.

No general occurrence of two suitable arms, no generic cubefreeness,
and no unrestricted private-depth bound has been proved. The finite
deep-arm example supplies an actual illustration, not an unbounded
family in the asymptotic subclass.

## Independent exact replay execution

The reviewer actually ran

    python research/checkpoints/2026_09_07_critical_bottleneck/ninth_round/replay.py --check

The result was PASS: 113 actual rows, 678 exact rational inequalities,
and six polynomial quotient identities including indices 25 and 35.
The proof-to-code conversion of SA5 is exp(2*SA5), so the program
uses integers and Fraction rather than approximate logarithms. Its
listed large factors are verified prime by complete trial division,
including the example with a private depth-four prime and two
squarefree quotient arms.

Canonical payload SHA256:
`4292da9eb4d642cf99c5e7530e8d462f12da945887d96086d325c56a04d02e8f`.
Complete JSON byte SHA256:
`8e6a5da3fdc84d316ea2ef3cd98c74e6c111de04584e7e20a5706657f72f4132`.
The finite replay corroborates the exact algebra and finite inequality;
it does not validate an infinite membership claim or replace LR2.
