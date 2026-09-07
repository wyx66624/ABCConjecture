# CL1--CL3. A complete 3-adic obstruction for the untwisted cubic quotient

Status: complete ordinary proof, reviewed by root and both peer agents.
This is new
thirteenth-round research, outside the frozen twelfth-round publication.
The symbol u=1 below means the identity unit, not the unit zeta.

## CL1. The complete projective genus-two quotient has no Q_3 point

Put

    C(S,T)=S^3+3S^2T-T^3,
    E(S,T)=S^3-S^2T-4ST^2-T^3,
    D(S,T)=-3E(S,T).

Let H be the smooth projective double cover of P^1 defined by the binary
sextic equation Y^2=C(S,T)D(S,T), with Y of weight 3. This is the third
hyperelliptic quotient in HG at g=3 and u=1. Then H(Q_3) is empty.

Proof. The six branch points are simple by the already proved HG
branch calculation. A Q_3 point on H maps to a Q_3 point of P^1. Choose
coordinates S,T in Z_3, with at least one a unit. In the fibre over these
coordinates a rational point would give a Y in Q_3 with

    Y^2=-3C(S,T)E(S,T).                            (CL1)

This also treats infinity: the coordinates (1,0) are allowed. Changing
the coordinates by a scalar changes the right side by its sixth power
and does not change this square criterion.

Reduction of E on the four points of P^1(F_3), represented by
(1,0),(0,1),(1,1),(-1,1), gives respectively 1,-1,1,1 modulo 3.
Thus E(S,T) is always a 3-adic unit.

If S is not congruent to T modulo 3, then
C(S,T) is congruent to (S-T)^3 and is also a unit. The right side of
(CL1) has valuation 1, contradicting its being a square.

Otherwise T is a unit and S=T+3K for some K in Z_3. Direct expansion gives

    C(S,T)=3(T^3+9KT^2+18K^2T+9K^3).

Consequently v_3(C)=1 and C/3 is congruent to T^3 modulo 3. Also E is
congruent to T^3 modulo 3. The right side of (CL1) has valuation 2,
but its quotient by 9 is congruent to -T^6=-1 modulo 3. A 3-adic unit
square is congruent to 1 modulo 3, another contradiction. All fibres,
including the projective fibre at infinity, have been covered. QED.

## CL2. The identity-unit Eisenstein locus is empty whenever 3 divides g

Use the projective power maps and smooth projective curves of RL/HG.
For an odd positive integer g divisible by 3, let D_(g,1) be the identity-
unit Eisenstein curve

    r(t)=L_(1,g)(s),
    r(t)=a_0(t)b_0(t)/U_0(t)^2.

Then D_(g,1)(Q_3) is empty. In particular its entire Q-rational locus is
empty, and so is the Q-rational locus of the higher Gaussian cover
C_(g,1). This is stronger than emptiness only on the positive chart.

Proof. For g=3, HG constructs a quotient morphism D_(3,1) to H. Thus
CL1 rules out a Q_3 point on D_(3,1). For g=3k, the identity

    L_(1,g)=L_(1,3) composed with L_(1,k)

holds as an identity of projective maps; it follows directly from
raising the Eisenstein element to successive powers. On the generic
fibre, (t,s) maps to (t,L_(1,k)(s)) and defines a nonconstant rational
map from D_(g,1) to D_(3,1). It extends over every point of the smooth
projective source to the smooth projective target, by the curve
extension theorem already used in RL/RD. It is defined over Q, so also
over Q_3. Any Q_3 point would therefore map to a Q_3 point of D_(3,1),
which is impossible. The forgetful map from C_(g,1) to D_(g,1) proves
the last assertion. No affine-chart exclusion or assumption that the
source parameter is finite is used. QED.

## CL3. Comparison with the elementary integral obstruction and scope

For an actual primitive positive seed with M=a^2+ab+b^2=U^2, one has
3 not dividing M: the standard primitive Eisenstein norm calculation
gives v_3(M) in {0,1}, and its valuation must be even. If its second
Eisenstein element ab+M*zeta were an identity-unit cube of an integral
element S+T*zeta, its zeta coefficient would be

    3ST(S+T).

That would force 3 to divide M. Thus the integral identity-unit cubic
obstruction is already elementary. CL1--CL2 additionally give the
complete local obstruction for the smooth projective quotient, including
all nonpositive and infinite rational-chart cases, and propagate it by
a genuine curve morphism to every odd g divisible by 3.

The two nontrivial unit classes u=zeta and u=zeta^2 have not been
excluded. No conclusion about their complete rational points follows
from the bounded searches that motivated CL1. Nor does this result
address moving residuals, odd exponents not divisible by 3, or the
global ABC conjecture. The genus-two calculation is an independent
geometric route; none of these exclusions is a claimed height bound.

Dependencies: the reviewed RL/HG projective power maps and quotient
morphisms; the smooth-projective-curve extension theorem in Stacks
Project, Section 53.2 (tag 0BXX). The local argument CL1 is explicit.
