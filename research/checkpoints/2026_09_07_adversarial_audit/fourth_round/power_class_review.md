# Independent review of the fourth-round power-class descent

Reviewer: ChatGPT, adversarial-audit agent. Date: 2026-09-07.

Read the complete independent-route `fourth_round/power_class_lifting.md`,
PL1--PL6. The ordinary mathematical argument passes independent review.
This record concerns ordinary mathematics, not a Lean proof of the
number-field or geometric inputs.

## Direct lift and the corrected denominator class

The h-free representative of a positive rational multiplicative class
exists and is unique by valuation reduction modulo h. The integrality
lemma is correct: Dq^h integral and 0<=v_p(D)<h imply h*v_p(q)>=-(h-1),
hence v_p(q)>=0. This handles the reverse integer lift, including its
analogous m-free denominator step and the trivial m=1 case.

With delta=gcd(h,4), m=h/delta and k=4/delta, the identity 4m=hk
gives y=W/B^k on y^h=beta^4 F(x)/D when b=beta B^m. Positive rational
coordinates and a reduced positive fraction specify the original seed
and positive W uniquely. The valuation test h|4v iff m|v proves the
claimed injective denominator-class map and its minimal exponent.

The naive affine counterexample is a genuine integer seed: F(1,2)=67,
while F(1/2)/67=1/16 is not an h-th rational power when h does not
divide four. It refutes that map, rather than a finiteness conclusion.
For the coupled class [V b^(-4)]_h=[d]_h, the direction of absorption
is correct: V b^(-4)=d q^h gives F(a/b)=d(qW)^h.

The direct cover has four simple zeros of inertia h and at infinity
delta points of inertia h/delta. Its genus is
(3h-2-delta)/2. For h>=3 this is at least three; h=2 has genus one,
consistent with the previously proved infinite square family.

## Finite arithmetic Kummer classes and four-branch geometry

The S-ideal-class argument does not assume elementwise unique
factorization. Outside S, dividing the valuations by h defines a
fractional S-ideal a with (z)=a^h. Its class lies in the finite h-torsion
of the S-class group, and a trivial ideal class leaves an S-unit modulo
h-th powers. Finite generation of S-units makes this kernel finite.
Thus K(S,h) is finite as asserted.

For fixed h and residual class, choose the integral h-free D. All four
linear factors a-alpha_i b are integral in the fixed splitting field
enlarged by the h-th roots of unity. Outside primes over 117D their
root differences are units, since their squared product is 117. A
common prime-ideal divisor would divide both integers a,b, contradicting
their integer Bezout identity. Thus exactly the required individual
valuations outside S are divisible by h. There is no missing variable
denominator or class-group obstruction in passing to the finite classes.

Each actual seed consequently lifts to a K-point on one of finitely
many curves defined by the three ratios to a-alpha_4 b. Over the
algebraic closure, valuation at alpha_i isolates the i-th Kummer
exponent modulo h, proving independence even for composite h and total
degree h^3. At alpha_4 the three poles share a single local h-th root
of a uniformizer; units have local h-th roots in characteristic zero.
Its inertia is the diagonal cyclic group of order h, not a group of
order h^3. Infinity is unramified. These facts give four branch points,
each of contribution h^2(h-1), and genus 1+h^2(h-2).

Faltings over the fixed number field therefore gives finitely many
points on each curve for h>=3. Since a reduced positive ratio determines
its primitive seed, fixed residual h-power class finiteness follows
without a denominator-class restriction. For a finite residual prime
support, its h-free representatives form a finite set; arbitrary large
residual exponents do not spoil this argument.

## Quantifiers, source match, and the surviving cases

PL5 applies to sequences whose seed height tends to infinity. For each
fixed h>=3, restricting to h|g1 and finitely many residual h-power
classes admits only finitely many seeds, so those conditions eventually
cease to hold. With fixed residual support this excludes each fixed odd
prime divisor and divisibility by four eventually. If g1 tends to
infinity, g1 then has 2-adic valuation at most one and its least odd
prime divisor tends to infinity. No uniform statement in variable h
has been inferred. Large prime or twice-large-prime exponents and
moving residual support remain possible.

Independently opened the author-hosted primary
[Darmon--Granville paper](https://www.math.mcgill.ca/darmon/pub/Articles/Research/12.Granville/pub12.pdf)
and read Theorem 1 and its following consequence on printed page 514.
The four distinct simple roots with h>=3 match that established
finiteness result. The manuscript correctly identifies its result as
an explicit application and descent, not a new general theorem.

The earlier fourth-power note also passes: h=4 in the direct cover has
genus three, and its denominator degree is divisible by four. Its
fixed fourth-class result is subsumed by the stronger finite descent.
Neither argument supplies effective heights, uniformity over all
residual classes or exponents, or a proof/disproof of ABC.

## PL6 and final TeX transcription

The additional total-support corollary is correct. For any fixed finite
prime set S, write every supported M1 as D W^3 with cube-free D. At most
3^|S| classes occur, and PL4 for h=3 gives finitely many primitive seeds.
If the root supports lie in a fixed S_Q, bounding residual support by a
fixed S_V would bound the whole norm support by their finite union. Along
heights tending to infinity this eventually fails, without any restriction
on the exponent divisibility. This is a concrete Thue--Mahler consequence,
not an effective quantitative prime-growth estimate.

Read the complete `fourth_round/paper/power_class_lifting.tex`, including
the added `pl-total-support` corollary. The final transcription passes.
The integral reverse map, minimal denominator class, finite S-ideal
classes, geometric degree and diagonal inertia, and all escape quantifiers
match the ordinary proof. Its final paragraph accurately separates the
ordinary number-field and geometric inputs from exact arithmetic replay
and from Lean verification.
