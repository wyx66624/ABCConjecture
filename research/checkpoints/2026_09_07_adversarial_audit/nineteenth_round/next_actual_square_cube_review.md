# AC3.1--AC3.3: independent review of the actual square/cube exclusion

Reviewed source: `research/checkpoints/2026_09_07_independent_route/nineteenth_round/next_actual_square_cube_exclusion.md`.

SHA256: `0c54700c944cc8d10df08d3af03d9f3ccff4407154cca89eeb2ec4b01a738fe4`.

Verdict: full ordinary proof PASS, using the separately fully reviewed ZD2 rank-zero proof. No correction to the mathematical statements is needed. I reread the actual earlier DC1 extraction, RL projective maps and domain, HG1/HG3 function-field and positive inverse, CL1--CL3 identity-unit argument, and CB1--CB3 nontrivial-unit classification. The new connection does not rely on matching names or on conjugating away a different unit class.

The quartic F is exactly the norm of the primitive integer element ab+M*zeta. The coprimality of its coordinates follows prime by prime from gcd(a,b)=1. Its norm is one modulo three, including the case where both a and b are units modulo three. Thus no ramified prime occurs. Norm Euclidean division in the Eisenstein ring follows from rounding in the basis 1,zeta, with norm error at most 3/4. Primitivity excludes an inert norm prime and simultaneous conjugate split factors. Consequently every rational norm exponent is the exponent in exactly one actual split orientation.

When F=Q cubed, this gives a literal integral cube times a unit, with root norm Q, primitive root coordinates and no ramified factor. There is no denominator or discarded nonunit residual. The six unit choices reduce exactly to 1,zeta,zeta squared by absorbing the sign into the cube root. F>=13 ensures Q>1, independently of any extraction convention.

The first norm being a square forces its three-adic valuation to be zero: the only other primitive possibility is one, as seen directly from M=(a-b) squared+3ab. The equality a=b would give the primitive pair (1,1) and M=3, so it is excluded. Therefore r=ab/M is strictly between zero and one third, v=(a+b)/U is positive, and w=(a-b)/U is nonzero, with the exact two square equations at the same rational source [S:T] of the extracted cube. The conic inverse has denominator 2b/U and gives t=(a+U)/b>1. It lies on the smooth positive chart, while infinite source inputs remain allowed rather than removed by convention.

The three exclusions are applied in their precise domains. For the identity unit, the coefficient 3ST(S+T) already contradicts M being prime to three, and CL supplies the stronger complete local-locus theorem. The zeta unit has the twelve CB boundary points with r=0. The squared-zeta unit has the six ZD2 boundary points with r=-1. Neither nontrivial class is inferred from the other by conjugation. These exhaust the actual unit extraction and prove the primitive square/cube intersection empty.

For an odd g divisible by three, the composition L_(epsilon,g)=L_(epsilon,3) composed with L_(1,g/3) is the actual projective power identity. The coordinate forms have no common geometric zero, because the two conjugate linear-form powers cannot both vanish at a projective input. The induced map between the HG connected smooth projective curves is nonconstant and extends everywhere. It preserves t and hence preserves the exact positive rational domain. The forgetful Gaussian-cover statement uses only its map to the Eisenstein curve. This argument does not assume that an even-index BK cover is connected.

For numerical exponents, writing Q^g as (Q^(g/3)) cubed proves the asserted corollary for every positive multiple of three, including even g. Likewise an even first exponent makes its total first norm a square. This uses total integer equalities, not labels on a profile. The excluded ramified shape 3R^h with h even really has valuation one and is outside the theorem; noncube second residuals, nonsquare first residuals and remaining exponents are not removed.

No new finite search, rank computation or Lean declaration is asserted by this review. The result is a complete exclusion of the specified actual two-norm subfamily. It does not provide a uniform moving-family height bound or coverage of arbitrary ABC triples.
