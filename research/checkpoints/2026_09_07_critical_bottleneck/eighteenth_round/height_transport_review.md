# HT1--HT4 full ordinary, primary-source and finite review

2026-09-07. Read the complete height_transport.md in independent_route/
eighteenth_round, source 545f8dc98bbdd37d6b0b270392a5ecd1f72fe9731b491e7bcc00b2776aa1f3e9.
Full ordinary mathematical review: PASS.

The two explicit model isomorphisms and minimality criterion are correct.
Pullback gives omega/u and u eta+(r/u)omega, hence the unit-root slope
u^2 s-r and logarithm scaling 1/u. The sigma normalization and its
four-point quotient preserve the intrinsic scalar. Consequently the
height/log-square ratio multiplies by four. Global scalar, differential
coordinates and individual chart constants are accurately distinguished.

Actually opened the author-hosted Mazur--Stein--Tate PDF, reading the
introduction's character and h_p normalization, equation (1.1), Theorem
1.3 and the local four-point construction. Also opened the Balakrishnan--
Dogra primary PDF and checked Section 8.3's character convention
chi_p=log_p and twice-Silverman local normalization. The conversion to
-2 log(sigma/d)/m^2 is consistent; no missing factor p is carried over.

Actually read the pinned PARI 2.15.4 ellpadic.c sigma-series computation,
ellpadicheight implementation and final change of its two-vector, together
with elliptic.c's global-minimal-model direction and the local copies of
ellpadicheight/ellpadics2 documentation. The raw transform is indeed
[(a+r b)/u,u b]. Inverting this gives the stated recovery rule. It must
not be replaced by the naive pairing with the transformed slope.

The exact mod25 certificate is independent of the numerical height routine:
the bad-prime identity-component checks allow m=9; integral odd sigma
makes the full omitted correction divisible by 25. The two modular
logarithms and -2/81 yield 5 and 10, and the raw mismatch has exact
valuation one. All relevant slopes are integral at five.

Read the complete Python wrapper and independently executed its read-only
--check. PASS with canonical SHA-256
70ec75594f205336757496605750b1302e5f3b271afd6acf5b12275a36c9de05.
This includes its independent rational leading-digit arithmetic and the
source-predicted finite PARI relations. It is not a Lean verification of
the height implementation or a certification of the complete QC zero set.

No mathematical correction is requested. The bad-prime local value sets,
compatible chart constants, analytic functions on every chart and complete
zero enumeration remain correctly stated as unfinished.
