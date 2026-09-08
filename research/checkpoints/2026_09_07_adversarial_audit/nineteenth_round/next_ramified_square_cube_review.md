# RS1--RS4: independent complete ordinary review

Reviewed source: `research/checkpoints/2026_09_07_independent_route/nineteenth_round/next_ramified_square_cube.md`.

Final SHA256: `8c840dd90e2193b974a647b29133b9b8ce04d655b55e7cdbbb70c8088c685341`.

Verdict: full ordinary proof PASS. All four sections, including the enlarged even-index geometric domain, were actually read. The initial integral-coordinate chain was also worked out independently before the complete source arrived. No reviewed file was modified and no new finite replay, rank calculation, Lean compilation or external peer review is asserted here.

## Exact projective model

The three coordinate pairs are respectively (A0,B0), (-B0,A0+B0), and (-(A0+B0),A0). The ratio conjugacy uses epsilon/bar(epsilon)=epsilon squared, so it is a projective power map of degree three with its two nonrational branch values unchanged by the indicated unit. The three rational targets infinity, minus one and one third consequently have disjoint simple three-point fibers.

The conic 3V squared+W squared=12L squared has the stated everywhere-defined map to r. On its affine chart the two square equations are v squared=3(1+r) and w squared=3(1-3r). Their pullbacks have independent geometric square classes: each has simple zeros not belonging to the other. At a common pole the two quadratic local extensions have the same ramified square class, so inertia is two rather than four. Thus there are nine branch points in the degree-four cover and Riemann--Hurwitz gives genus six. The three quotient equations have exactly the stated twists; the product quotient loses the factor nine as a square. Every quotient uses the same source.

The actual parameters c/U and (a-b)/U satisfy both square equations with r=ab/M. Positivity gives the stated range, and the endpoint a=b reduces by primitivity to (1,1), whose quartic is thirteen rather than a cube. The resulting actual point is in the smooth chart. No reverse integral reconstruction from arbitrary rational points is assumed.

## Complete Q3 exclusion

A conic point at L=0 would give a square of valuation one, which is impossible. In the affine equation, the finite valuations of 3v squared and w squared have opposite parity, so their minimum cannot cancel. Their sum has valuation one. This forces v to be a unit and w to lie in 3Z3, also allowing w=0. The case v=0 is impossible. Thus every conic point has r of valuation minus one, with no omitted negative-valuation or zero-coordinate case.

Normalize every projective source S,T over Z3 with at least one unit. If S and T differ modulo three, A0 and C0 are units and B0 is divisible by nine. This includes T=0 and the cases B0=0. The three ratios have valuations at most minus two or infinity; at least two or zero ratio; and exactly zero, respectively. None has valuation minus one. If S and T agree modulo three, both are units. Direct expansion at S=T+3K gives A0/3, B0/3 and C0/3 congruent to -T cubed, 2T cubed and T cubed, respectively. All three coordinates have valuation exactly one, and every ratio is a unit.

The contradiction uses the two projective morphisms from the normalization and their identical r image. It therefore excludes all Q3 points of each complete common-source curve, including points above branch fibers and infinity; it is not merely a check on its affine presentation.

## Stronger actual integer obstruction

The norm identity and gcd(ab,M)=1 make z=ab+M*zeta an actual primitive Eisenstein integer. Its norm F is one modulo three for every primitive pair. The norm-Euclidean argument supplies unique factorization; inert factors and simultaneous split orientations are excluded by coordinate primitivity, and the ramified factor is excluded by F being a unit at three. Consequently a positive integer norm cube gives a literal integral cube times one of the six units, with each norm exponent in its single actual orientation. Absorbing the sign gives the three stated units. The extracted root is primitive and unramified, hence S differs from T modulo three. No content division, fractional root or residual is introduced.

For every primitive original pair, the first norm has three-adic valuation zero or one. This follows directly from M=(a-b) squared+3ab, with valuation one in the equal-residue case. For the extracted unramified source, the identity unit gives a second coordinate divisible by nine (possibly zero), whereas the two other units give a unit second coordinate. Equality with the positive integer M excludes the identity unit in all cases and excludes valuation one in the other two. The actual conclusion is therefore the stronger F=Q cubed implies 3 does not divide M, without assuming M=3U squared.

The supplementary parity and mod-five values are consistent with the literal quartic. They are not used as an exhaustive local-solubility classification. The numerical exclusion of M=3U squared follows both from the stronger integer obstruction and from the projective local exclusion after actual extraction.

## Propagation and the distinction from local numerical equations

For every positive integer g divisible by three, the numerical conclusion follows by rewriting the actual integer power as a cube. This includes even g. Geometrically, the exact projective power composition preserves the conic coordinates. For every such g the three rational branch targets have g simple preimages, and the two square classes stay independent. Thus these explicitly defined ramified fiber products are geometrically connected even when g is even. Their nonconstant map to the cubic normalization extends everywhere. This is an independent geometric argument for these curves; it does not import a connectedness claim about a different even-index BK model or identify arbitrary g-th unit classes with only three choices.

The concrete pair (1,4) has M=21 and F=541. The equation U squared=7 has a simple Hensel root at one modulo three. Writing Q=1+3t turns Q cubed=541 into t+3t squared+3t cubed=60, whose derivative is a unit at the solution t=0 modulo three. Thus the two numerical norm equations do have simultaneous Q3 values at that fixed primitive integer pair. This correctly demonstrates why the global integral cube extraction cannot be replaced by a blanket local numerical insolubility assertion.

## Primary source and scope

I reopened [Stacks, Curves and function fields, Section 53.2](https://stacks.math.columbia.edu/tag/0BXX). Lemma 53.2.2 extends rational maps from a normal curve to a proper variety; Theorem 53.2.6 identifies the function-field maps with nonconstant maps of the proper normal curve models. The source uses this domain correctly, and characteristic zero gives smooth normalizations. No source claim is needed to replace the explicit valuation arguments above.

The result closes the specified ramified cubic profiles and the entire indicated local common-source curves. It supplies no uniform height estimate for moving residuals, all-ABC coverage, or conclusion for exponents not divisible by three. The original unramified square/cube theorem remains a separate result.

## Complete ordinary-to-TeX review

I subsequently read the entire canonical `research/checkpoints/2026_09_08_descent_and_shift/paper/ramified_cubic_exclusion.tex`, SHA256 `3eb6c1b95c557d19790fade596a77049138dafc7af12ed81aa6f1a1c412cf4cf`. Verdict: full final mathematical transcription PASS, with no requested correction.

The projective conic, all three actual coordinate pairs and all three quotient equations are present with complete proofs. The genus calculation retains inertia two at the common poles. The entire local exclusion keeps the zero-coordinate, infinite-source, equal-residue and unequal-residue cases. The integer extraction is repeated fully and separately proves the stronger unramified-first-norm conclusion before giving the ramified square corollary.

The actual positive reconstruction and its endpoint (1,1) are explicitly checked; there is no assumed inverse to integer seeds. Numerical propagation permits every positive multiple of three, and geometric propagation proves its own connectedness for even indices using the simple disjoint fibers. The distinction between the three specified coefficients and all possible g-th unit classes is retained. Both Hensel equations at (1,4) appear, so the text does not misstate the result as local numerical insolubility. The final ordinary/formal and varying-family boundaries agree with the reviewed source. No new finite run, build or visual inspection is claimed by this transcription review.
