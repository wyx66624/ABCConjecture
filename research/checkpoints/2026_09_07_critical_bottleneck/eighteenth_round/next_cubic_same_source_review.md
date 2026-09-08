# Independent full ordinary review of CB1--CB3

2026-09-07. Next-only review; no frozen source changed.

I read the complete peer `next_cubic_same_source_boundary.md`, SHA256
`e68c6dc1102248f1db9f3dcf772acc4bd79a679a122534efe6488e3986b90ff4`.
**Full ordinary PASS**, using the independently reviewed SM fixed-curve
classification and the exact projective maps in the stated older sources.

The two rational chart transformations are literal inverses. Their
homogeneous sextic identity and the inverse dense charts give a smooth
projective isomorphism. The listed limits at z=1 and C infinity give,
respectively, H infinity with sign W/8 and s=-1 with ordinate -epsilon.
Thus the six rational H points lie exactly over 0,-1,infinity; no
denominator exception is omitted.

Multiplying the actual cube A0+B0 zeta by zeta gives (-B0,A0+B0).
The first double quotient is y1^2=A0(A0+B0), exactly the H polynomial.
The second quotient retains the SAME source and is
y2^2=(A0+B0)(A0+4B0). At each of the three remaining source points,
B0=0 and B=+/-1, so both square roots v,w are independently +/-1.
The two defining equations are smooth there since both roots are
nonzero. The normalization therefore has exactly four rational points
over each source, rather than extra branches at a singular fiber.

The inverse conic parameter was checked at all four sign choices. Its
displayed fraction gives t=1 and -1 for the middle rows and infinity
for (1,1). The ambiguous 0/0 row (-1,-1) is resolved by the original
degree-two conic parametrization and has t=-1/2. Explicitly

    r(t)=(t-1)(t+1)(2t+1)/(t^2+t+1)^2,

so these three finite values and infinity are all four simple zeros.
This also confirms that none lies in the finite rational t>1 positive
domain. For the original first-root coordinates, their primitive
signed outputs are exactly (1,0),(0,1),(0,-1),(-1,0), including content
removal at t=1 and -1/2. Their two actual norms M,F are both 1.

The actual positive M-square/F-cube branch with oriented coefficient
zeta maps into this same-source curve by the audited RL/CI inverse;
it is therefore excluded, not just subjected to a new necessary square
test. The power-map composition L_(zeta,3k)=L_(zeta,3) composed with
L_(1,k) retains the actual seed parameter t. Its projective extension
thus excludes the same positive coefficient class for every odd
exponent divisible by 3. No larger-exponent boundary-preimage count
is inferred from that morphism.

The separate unit classes are handled honestly. Conjugation changes
r to -1-r and does not preserve the positive interval. In particular
CB does not identify the remaining zeta^2 class with zeta. Nonunit
residuals, a ramified first norm and varying-exponent uniform ABC
bounds remain outside this fixed-branch conclusion.

This is an ordinary proof/source review, not a new software computation
or a complete Lean verification of the analytic classification chain.
