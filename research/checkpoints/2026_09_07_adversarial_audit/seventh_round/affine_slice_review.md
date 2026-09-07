# Independent review of effective affine-slice escape

Date: 2026-09-07. Reviewed all AS1--AS4 in
`2026_09_07_critical_bottleneck/seventh_round/affine_slice_escape.md`.
Result: ordinary proof PASS, with the external theorems stated below.

Independently opened the primary Berczes--Evertse--Gyory paper
https://arxiv.org/pdf/1301.7175, Theorems2.2 and2.3, equations
(2.4)--(2.7), printed pages5--6. The exponent bound permits degree
four with nonzero discriminant and positive integer base Q>1;
the latter excludes its zero and root-of-unity exceptions. The
specialization A=Z[0]=Z[U]/(U) has presentation r=d=1, so its
logarithmic exponent bound is an effective constant times h+1.
There is no hidden dependence on the integer solution or on Q.

The two polynomial expansions are correct. The root transformations
c alpha_i and c/(alpha_i-1) are defined and injective for c!=0,
because the original quartic has four simple roots and F(1,1)=13.
The binary discriminant transformation has determinant c or minus c
and exponent12, giving exactly117 c^12 in both cases. Coefficient
height is bounded by log26+4log(1+|c|), uniformly in all charts.

The actual equation admits c=a, c=b and c=a-b. The last is nonzero:
positive primitivity with a=b forces(1,1), and its norm13 has no
integer divisor Q^g with Q>1 and g>=2. All three uses of the external
bound share one effective constant C. Thus choosing the smallest
absolute parameter gives log g<=C(1+log V+log(1+M)), where
M=min(a,b,|a-b|). Rearrangement gives1+M>=exp(-1)g^(1/C)/V.
No g-free or coprimality condition on V,Q is needed.

For fixed c,V, the exponent bound leaves finitely many g. Theorem2.2
then gives an effective finite list for each exponent; degree four
also meets its hyperelliptic g=2 hypothesis. This proves finite
integer solutions across all g, not just a finite search. With fixed
V and bounded M, the finite set of charts and nonzero c reduces
the actual seed assertion to those lists.

The pure-power consequence applies to the complete consecutive slice,
including a=Lk,b=Lk+1 as L varies: at most finitely many actual pure
power seeds occur, despite the exact simultaneous local shadows.
It leaves moving affine slices and small compression lambda with
log V much larger than log g open. In particular V=exp(sqrt(g))
is not excluded by this estimate. The claimed rate for V=g^o(1)
correctly absorbs the fixed multiplicative constant and the minus1
into g^(delta-o(1)). No boundary eigenform identification or global
modular-route impossibility is asserted. No new Lean theorem.
