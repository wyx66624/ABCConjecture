# An integral form of the actual thirteen-square-class map

Status: ordinary proof passed complete independent reviews by both
independent_route and adversarial_audit, 2026-09-07.
This note simplifies the explicit rational map in independent_route's
seventh-round Q13 proof. It does not assume or prove the elliptic rational
point classification by itself.

For arbitrary integers a,b,s define

    F=a^4+3a^3*b+5a^2*b^2+3a*b^3+b^4,
    c=a-b, y=a+b, A=7a^2+12ab+7b^2,
    U=13(A-26s), V=13U y.

The following are unconditional polynomial identities:

    A^2+3c^4=52F,                         (IM1)
    c^2+13y^2=2A,                        (IM2)
    V^2-U^3+13U^2 c^2+507U c^4
        =8788U(F-13s^2).                 (IM3)

Indeed IM1 and IM2 follow by expansion. For IM3, factor its left side
as U[169U y^2-U^2+13U c^2+507c^4]. By IM2 the bracket is
26AU-U^2+507c^4. Substitution of U=13(A-26s) gives
169[A^2-676s^2+3c^4], which is 8788(F-13s^2) by IM1.

Consequently if F=13s^2 then

    V^2=U^3-13U^2 c^2-507U c^4.         (IM4)

If also c is nonzero, U is nonzero. Otherwise A=26s, and IM1 with
F=13s^2 would give 3c^4=0. Thus the explicitly defined rational pair

    X=U/c^2, Y=V/c^3

is a finite point with X nonzero on

    Y^2=X^3-13X^2-507X.                 (IM5)

No division by a,b,s,A or V occurs; c nonzero is the only denominator
condition. The formulas work for arbitrary signs and include zero seed
coordinates whenever the stated conditions are satisfiable. The diagonal
c=0 is treated separately in the actual positive primitive classification.

This map agrees, on its domain, with the earlier explicit map. With
t=(a-b)/b and u=(s-ab)/(a-b)^2, its first coordinate is
91-338u=U/c^2. Its second coordinate simplifies to V/c^3 after use
of the same quartic equation. Agreement is not required for IM1--IM5,
whose direct identities prove the map independently.

Given the independently proved external ordinary statement
E(Q)={O,(0,0)}, IM5 excludes all non-diagonal solutions F=13s^2.
For coprime positive a,b the diagonal then forces a=b=1 and s=+/-1.
Formal verification of IM1--IM4 and nonvanishing would verify precisely
this integral bridge, not the external elliptic group classification.
