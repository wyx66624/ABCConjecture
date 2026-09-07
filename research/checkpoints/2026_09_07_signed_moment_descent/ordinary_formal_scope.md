# Actual Gram rigidity and signed products: ordinary proof before Lean

This is a fifteenth-continuation proposal. The fourteenth continuation is
published at main commit 2606de0f5787da1bb3a6d903564c1ef67e613e27, with
the 527-page designated manuscript, 35 new declarations and 15 unchanged
dependencies. These subsequent sources are not part of that sealed batch.

## G1. An exact integer determinant criterion

Use the already defined actual Eisenstein coordinate pair z=(R,S), with
N(z)=R^2+RS+S^2. For z'=(R',S'), put

    D=RS'-R'S,
    K=2RR'+RS'+SR'+2SS'.

Direct expansion proves

    4N(z)N(z')-K^2=3D^2.

In particular 3D^2<=4N(z)N(z'). If an integer modulus m divides D and

    4N(z)N(z')<3m^2,

then D=0. Indeed D^2<m^2 and m^2 divides the nonnegative integer D^2.
The only nonnegative multiple of m^2 strictly below m^2 is zero.
The strict premise already excludes m=0; no sign convention for m is
required. This is an actual integer divisibility statement, not a
postulated injectivity conclusion. Norm preservation under units and
conjugation is already established in the earlier coordinate library.

The reviewed US argument supplies the norm and divisibility premises for
actual products. Uniform exponential estimates and construction of the
finite residue algebra are not silently added to this finite criterion.

## S1. Actual signed products and private integer homomorphisms

Let I be a finite index type, G a commutative group, a_i in G, and
v_i:G -> Multiplicative(Z) group homomorphisms satisfying

    v_i(a_j)=1 for j!=i,       toAdd(v_i(a_i))!=0.

For an actual integer exponent vector x:I->Z, define

    P_a(x)=product_i a_i^(x_i).

Mapping this finite product through v_i leaves exactly
v_i(a_i)^(x_i). Applying toAdd gives x_i toAdd(v_i(a_i)). Consequently
P_a(x)=P_a(y) implies x_i=y_i for every i, by cancellation of the
nonzero diagonal integer. Thus the actual signed product is injective.
Negative diagonal values and negative exponents are permitted.

Suppose u_i in G satisfy v_i(u_j)=1 for every i,j. The actual products
b_i=u_i a_i satisfy the same private hypotheses, since each v_i is a
homomorphism. Hence their signed products are also injective. This is
the exact finite normalization statement; constructing the particular
arithmetic units and their prime-dependent selection remains ordinary.

For any finite set A of exponent vectors, any finite commutative target
group H with phi_i in H, assume the precise rigidity premise

    x,y in A and P_phi(x)=P_phi(y) => P_b(x)=P_b(y).

The actual product map on the membership subtype of A is injective.
It follows that |A|<=|H|, and hence |A|<=n if |H|<=n. There is no
homogeneity or fixed total exponent condition. The finite set and both
actual product maps are explicit; rigidity is not declared already
proved by this counting bridge.

## S2. A concrete two-coordinate signed diamond

For an integer radius r>=0, define a finite source type as the disjoint
union of two squares of indices:

    D_r = (Fin(r+1) x Fin(r+1)) disjoint_union (Fin r x Fin r).

Its first square has actual integer coordinates

    (x,y)=(-r+i+j, i-j),

and its second square has

    (x,y)=(-r+1+i+j, i-j).

Within either square the sums and differences recover i and j, so the
coordinate map is injective. The two images are disjoint: x+y has
parity -r on the first and parity -r+1 on the second. For each point,

    |x|+|y| = max(|x+y|,|x-y|) <= r.

The last inequality follows from the displayed coordinates and the
actual Fin bounds, in both squares including r=0. The source cardinality
is exactly (r+1)^2+r^2 = 2r^2+2r+1. Surjectivity onto every lattice point
of the diamond is not needed or claimed by this proposed finite core.

Given two actual group elements a,b with private homomorphisms that
separate their integer powers, the map (x,y) -> a^x b^y is injective.
Under a supplied actual-product rigidity premise into a finite target H,
the displayed D_r product map is injective into H. Therefore

    2r^2+2r+1 <= |H| <= n.

This realizes the two-coordinate signed-ball lower bound needed for
the single-owner contradiction. It is stronger than treating that
polynomial count as an unexplained numerical interface. The general
M-dimensional exact signed-ball formula retains its ordinary proof.

## Proposed formal boundary

The intended modules reuse the actual integer norm from
ABCEisenstein20260905, prove the Gram identity and modulus criterion,
and formalize the signed product, unit-kernel normalization and the
concrete finite diamond injection/count. Critical's separate module
handles numerical thresholds, actual maximum-depth selection and all
finite layers. Independent's curve module handles the actual equations
in the quadratic cube descent.

No formal result is claimed yet in this file. The arithmetic construction
of private valuations, norm-one residue torsion and the prime-dependent
unit twist, as well as the full signed far tail and all-rational-point
problem, are separate obligations. Review of this ordinary scope must
precede its implementation.
