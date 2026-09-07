# Independent review of the complete thirteen-square class

Reviewer: adversarial_audit. Date: 2026-09-07.

Status: complete ordinary mathematical review PASS. The reviewed sources are
`2026_09_07_independent_route/seventh_round/quartic_13_square_class.md`
(Q13) and `2026_09_07_boundary_descent/integral_thirteen_map.md`
(IM1--IM5). No source owned by another agent was edited.

## Descent and completeness

For E: Y²=X³−13X²−507X the eight possible signed square classes are
1,−1,3,−3,13,−13,39,−39. The actual torsion class −3 pairs them;
representatives −1,13,−13 exhaust the six classes outside {1,−3}.
The primitive mod-16 parity exclusions for −1 and the two mod-13
exclusions for ±13 are complete. In the latter, division after 13|N
forces (U/V)² to equal respectively 7 and 6; V=0 mod13 would first
force U=0 mod13, and both 7 and 6 are nonsquares.

For the dual E', X²+26X+2197 is positive on the real line. Its
possible positive classes are exactly 1,13, both realized. Since the
dual kernel point has class 13, either P' or P'+T' lies in phi(E).
Applying psi gives psi(E')=2E, with no omitted torsion coset.
Thus ker(alpha)=2E and |E/2E|=2. There is exactly one nonzero rational
2-torsion point because 2197 is nonsquare. Mordell--Weil finite
generation now gives rank zero. This logical order does not infer rank
from finite point counts.

At the good primes 5 and 7, complete point counts are 6 and 4. The
prime-to-residue-characteristic torsion injections remove 5-primary
torsion at 7 and 7-primary torsion at 5; every other primary part
divides both counts. Consequently E(Q)={O,(0,0)}. The explicit
descent and its exceptional points agree with the previously reviewed
third-round QG proof, which this review also reread.

## The actual-point map

The t=x−1, u=(y−1−t)/t² substitution exactly gives
(u²−1/13)t²+(2u−7/13)t+(2u−7/13)=0. Completing this quadratic
and scaling gives the particular stated twist, not merely a matching
j-invariant. The map has finite coordinates. X=0 gives u=7/26,
B=0, A=−3/676 and hence t=0, a contradiction. No division by A or B
is used, so neither creates a missing branch. The two x=1 points
are explicitly retained. Homogeneity with x=a/b, y=s/b² is valid
for every positive integer b; primitive positivity then gives exactly
(a,b,s)=(1,1,±1).

Root's IM1--IM5 supply a simpler integral bridge and independently
pass review. With c=a−b, A=7a²+12ab+7b², U=13(A−26s),
V=13U(a+b), the defect polynomial factors as

    U[169U(a+b)²−U²+13Uc²+507c⁴]
      =U[26AU−U²+507c⁴]
      =169U[A²−676s²+3c⁴]
      =8788U[F−13s²].

If F=13s² and c≠0, U=0 would imply 3c⁴=0 via A²+3c⁴=52F.
Thus (U/c²,V/c³) is a finite point with nonzero X. This argument
allows arbitrary integer signs and has only the denominator condition
c≠0. On the older map's domain, X=−169B and
2At+B=−B(t+2)/t show equality of both coordinates without division
by A or B. Formal verification of this bridge does not formalize
the elliptic rational-point classification.

## Independent finite supplement and scope

`replay_q13_review.py` was actually executed with Python and returned
PASS. Its implementation uses only exact integer/Fraction polynomial
arithmetic, independently checking two polynomial identities, all 192
primitive pairs mod16, all 168 nonzero pairs mod13 for each of the two
covers, and every affine point at both good primes. The completeness
proof above uses no PARI rank output, no BSD assumption, and no bounded
rational-point search.

The established external inputs are the elliptic group law, rational
2-isogeny descent with the explicit exceptional cases, Mordell--Weil
finite generation, and good-reduction prime-to-p torsion injection.
This is an ordinary proved classification of one actual residual
square class. It neither proves ABC nor excludes the remaining odd
exponents or moving residual classes, and is not a complete Lean
formalization of Q13.
