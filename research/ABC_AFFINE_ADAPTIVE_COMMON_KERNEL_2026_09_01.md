# Sharp triangle determinants and adaptive common kernels in the affine route

**Author:** ChatGPT  
**Date:** 1 September 2026  
**Status:** unconditional finite geometry and arithmetic; the positive common-kernel density input remains open

## 1. Purpose and notation

This note strengthens the determinant part of the minimal-radical affine
route without replacing its unresolved distribution input by an axiom.  It
also tests the two degenerate geometric branches on the smallest known
subcritical seed.  A branch is not discarded because its remaining input is
difficult.  The explicit examples below refute only statements obtained by
deleting a stated geometric alternative.

Let a primitive positive seed satisfy

\[
 a+b=c,
 \qquad R=\operatorname{rad}(abc),
\]

and use the minimal-radical shear

\[
 U(h,k)=1+Rh,
 \quad V(h,k)=1+R(h+ck),
 \quad W(h,k)=1+R(h+bk).                    \tag{1.1}
\]

For a positive integer `n`, write

\[
 E(n)=\frac{n}{\operatorname{rad}(n)}.
\]

The canonical box has side

\[
 M=\left\lfloor\frac{c^6}{4R}\right\rfloor,
 \qquad 1\le h,k\le M,
 \qquad N=M-1.                              \tag{1.2}
\]

## 2. A sharp determinant bound for three points in a square

### Theorem 2.1 (sharp square-triangle bound)

If `p,q,r` lie in a closed axis-parallel square of side `N`, then

\[
 |\det(q-p,r-p)|\le N^2.                    \tag{2.1}
\]

The constant one is sharp, as shown by any three vertices of the square.

#### Proof

Translate the square to `[0,N]^2` and reorder the points by their first
coordinate.  Write those coordinates as

\[
 x_1,\quad x_1+s,\quad x_1+s+t,
 \qquad s,t\ge0,\quad s+t\le N,
\]

and write the second coordinates as `Y_1,Y_2,Y_3 in [0,N]`.  Translation in
the first coordinate gives

\[
 D=\det(q-p,r-p)
   =tY_1-(s+t)Y_2+sY_3.                     \tag{2.2}
\]

The positive part is at most

\[
 tN+sN=(s+t)N\le N^2,
\]

and the absolute value of the negative part is at most
`(s+t)N<=N^2`.  Therefore `-N^2<=D<=N^2`, proving (2.1).  The determinant
changes only by sign under a permutation of the three points, so the chosen
ordering loses nothing.  ∎

This improves the coordinatewise estimate `|D|<=2N^2` used in the preceding
fixed-template checkpoint.

## 3. Three point-adaptive certificates still have a common determinant divisor

At each of three admissible parameters `p_i=(h_i,k_i)`, allow an independent
choice

\[
 d_U(i)\mid U_i,
 \qquad d_V(i)\mid V_i,
 \qquad d_W(i)\mid W_i.
\]

Define the triplewise common moduli

\[
 g_Z=\gcd(d_Z(1),d_Z(2),d_Z(3))\quad(Z=U,V,W),
 \qquad G=g_Ug_Vg_W.                        \tag{3.1}
\]

### Lemma 3.1 (common difference congruences)

For differences `(x,y)=(h_j-h_i,k_j-k_i)`, one has

\[
 g_U\mid x,
 \qquad g_V\mid x+cy,
 \qquad g_W\mid x+by.                       \tag{3.2}
\]

Moreover `g_U,g_V,g_W` are pairwise coprime.

#### Proof

Every arm in (1.1) is congruent to one modulo `R`.  Hence every divisor
`d_Z(i)`, and therefore every `g_Z`, is coprime to `R`.  Since `g_U` divides
both `U_i` and `U_j`, it divides

\[
 U_j-U_i=R(h_j-h_i).
\]

Cancellation of the coprime factor `R` proves the first congruence.  The
identities

\[
 V_j-V_i=R(x+cy),\qquad W_j-W_i=R(x+by)
\]

give the other two.  At any one of the three admissible parameters, `g_U`,
`g_V`, and `g_W` divide the pairwise-coprime arms `U_i,V_i,W_i`; hence the
three common moduli are pairwise coprime.  ∎

### Lemma 3.2 (adaptive determinant divisibility)

For the two differences from one of the three points,

\[
 G\mid\det(p_2-p_1,p_3-p_1).                \tag{3.3}
\]

#### Proof

Apply (3.2) to both difference vectors.  The modulus `g_U` divides both
first coordinates and thus the determinant.  The identities

\[
 \det((x,y),(x',y'))
  =(x+cy)y'-y(x'+cy')
  =(x+by)y'-y(x'+by')                       \tag{3.4}
\]

show divisibility by `g_V` and `g_W`.  Pairwise coprimality multiplies the
three divisibilities.  ∎

### Theorem 3.3 (`adaptive_commonModulusProduct_le_boxSq_of_noncollinear`)

If the three parameters lie in the canonical square and are noncollinear,
then

\[
                         G\le N^2.           \tag{3.5}
\]

#### Proof

By Lemma 3.2, the positive integer `G` divides the nonzero determinant.
Consequently `G` is at most its absolute value.  Theorem 2.1 bounds that
absolute value by `N^2`.  ∎

Under the subcritical seed hypotheses used by this route, in particular
`R>=6` and `c>=9`, the earlier canonical threshold satisfies

\[
 T_0=\frac{Rc^{14}}{8192}>2(M-1)^2,          \tag{3.6}
\]

because `M-1<c^6/(4R)` and `R^3c^2>1024`.  No such comparison is asserted
for a general primitive seed outside these hypotheses.  Hence, in the
subcritical setting, any noncollinear adaptive triple with `G>T_0` is
impossible.  The
new, unresolved arithmetic question is whether many exceptional parameters
force a triple with a sufficiently large **common** product `G`; large
pointwise products alone do not imply this.

## 4. Canonical arm bounds with the factor three retained

### Proposition 4.1 (three-arm canonical box bound)

Assume `c>=9`, `R>=1`, `b<=c`, and `1<=h,k<=M`.  Then

\[
 3U\le c^6,
 \qquad 3V\le c^7,
 \qquad 3W\le c^7.                          \tag{4.1}
\]

#### Proof

The definition of `M` gives

\[
                         4RM\le c^6.         \tag{4.2}
\]

For `U`, multiply the desired inequality by four.  From (4.2),

\[
 4(3U)=12+12Rh\le12+3c^6\le4c^6,
\]

where the last step uses `12<=c^6`.

For `V`, again using (4.2),

\[
 4(3V)
 \le12+12RM(1+c)
 \le12+3c^6(1+c)
 \le4c^7.                                   \tag{4.3}
\]

The last inequality is exactly

\[
                         12\le(c-3)c^6,
\]

which holds for `c>=9`.  Since `b<=c`, the same computation bounds `W`.  ∎

## 5. A long-arm square-excess alternative

### Theorem 5.1 (long-arm square dichotomy)

Suppose (4.1) holds and the affine point meets the exceptional excess
threshold

\[
 Rc^{14}<8192E(U)E(V)E(W).                  \tag{5.1}
\]

Then one of the two long arms `Z in {V,W}` satisfies

\[
 3Rc^8<8192E(Z)^2.                           \tag{5.2}
\]

#### Proof

Since `E(U)<=U`, Proposition 4.1 gives `3E(U)<=c^6`.  Substitute this in
(5.1) and cancel the positive `c^6`:

\[
 3Rc^8<8192E(V)E(W).                         \tag{5.3}
\]

Choose `Z` to be the arm with larger excess.  Then
`E(V)E(W)<=E(Z)^2`, and (5.2) follows.  ∎

### Corollary 5.2 (one long arm has small radical support)

For the arm selected in Theorem 5.1,

\[
 27R\operatorname{rad}(Z)^2<8192c^6.        \tag{5.4}
\]

#### Proof

The exact factorization `Z=rad(Z)E(Z)` and `3Z<=c^7` give

\[
 9\operatorname{rad}(Z)^2E(Z)^2\le c^{14}.  \tag{5.5}
\]

Multiply (5.2) by `9rad(Z)^2`, use (5.5), and cancel `c^8>0`.  ∎

This is a genuine disjunction: it selects at least one long arm, but it does
not assert the same bound simultaneously for both.

## 6. The factor-27 support bound for the full canonical repeated kernel

Define the repeated kernel

\[
 K(n)=\prod_{p^e\parallel n,\ e\ge2}p^e.     \tag{6.1}
\]

Then

\[
 K(n)=\operatorname{rad}(K(n))E(n).          \tag{6.2}
\]

For an admissible affine point, the arms `U,V,W` are pairwise coprime, so
their repeated kernels are pairwise coprime as well.  Consequently, with

\[
 K=K(U)K(V)K(W),
\]

one has the exact identity

\[
 K=\operatorname{rad}(K)E(U)E(V)E(W).        \tag{6.3}
\]

### Theorem 6.1 (canonical kernel radical support)

Under (4.1) and (5.1),

\[
 27R\operatorname{rad}(K)<8192c^6,           \tag{6.4}
\]

or equivalently

\[
 \operatorname{rad}(K)<\frac{8192}{27}\frac{c^6}{R}.
                                                        \tag{6.5}
\]

#### Proof

Because `K(Z)|Z` in each arm, Proposition 4.1 yields

\[
 27K\le27UVW\le c^{20}.                    \tag{6.6}
\]

Multiply (5.1) by `27rad(K)` and use (6.3)--(6.6):

\[
 27Rc^{14}\operatorname{rad}(K)
 <8192\cdot27K
 \le8192c^{20}.
\]

Cancel `c^{14}` to obtain (6.4).  ∎

The factor `R` occurs exactly once on the left of (6.4).  In particular,
the correct result is not a bound with `R^2`, and the single-arm conclusion
(5.4) has a squared radical whereas the full-kernel conclusion (6.4) does
not.

## 7. Full degenerate examples from the seed `(1,8,9)`

Take

\[
 (a,b,c)=(1,8,9),\qquad R=\operatorname{rad}(72)=6,
 \qquad M=\left\lfloor\frac{9^6}{24}\right\rfloor=22143.
                                                        \tag{7.1}
\]

All parameters below are positive, lie in the canonical box, and satisfy
the exact admissibility condition `gcd(U,k)=1`.  Hence the general affine
coprimality theorem supplies pairwise-coprime arms and primitive abc outputs.

### Proposition 7.1 (the zero first-direction branch cannot be deleted)

For

\[
 p=(20,1),\qquad q=(20,2),                 \tag{7.2}
\]

the arm triples are

\[
 (U,V,W)(p)=(121,175,169),
 \qquad (U,V,W)(q)=(121,229,217).           \tag{7.3}
\]

Both points share the full canonical `U`-kernel

\[
 K(U)=121=11^2,
\]

and one may take the actual pointwise divisor certificates

\[
 (d_U,d_V,d_W)(p)=(121,25,169),\qquad
 (d_U,d_V,d_W)(q)=(121,1,1).                \tag{7.4}
\]

Their two-point gcds are `(g_U,g_V,g_W)=(121,1,1)`, so `G=121`; all arm
divisibility, coprimality, and difference-congruence premises hold.  Moreover,

\[
 121>(b+1)(c+1)=90,\qquad 121>(c+1)^2=100. \tag{7.5}
\]

Nevertheless their sup distance is one and their difference direction is
`(0,1)`.  Hence the precise local implication asserting, from the displayed
full premises and `x=0`, that
`G<=(c+1)^2 ||p-q||_infinity^3` is false: its conclusion is `121<=100`.
This does not contradict the corrected theorem, whose zero-coordinate branch
uses the two *other* arm moduli.

#### Verification

The values in (7.3) follow directly from (1.1).  Admissibility is
`gcd(121,1)=gcd(121,2)=1`; the box and inequalities are immediate from
(7.1).  The two first coordinates agree, and the second differ by one.  ∎

### Proposition 7.2 (a local cubic threshold does not imply noncollinearity)

For

\[
 p_1=(160,1),\qquad p_2=(160,2),\qquad p_3=(160,3),       \tag{7.5}
\]

all three points share

\[
 U=961=31^2,\qquad K(U)=961.                \tag{7.6}
\]

At each point choose `(d_U,d_V,d_W)=(961,1,1)`.  The triplewise gcds are
`(g_U,g_V,g_W)=(961,1,1)`, so `G=961`, and all nine arm-divisor and six
difference-congruence premises hold.

They lie on the vertical line `h=160`, have diameter two, and

\[
 961>(c+1)^2\,2^3=100\cdot8=800.            \tag{7.7}
\]

They are admissible because `gcd(961,k)=1` for `k=1,2,3`.  Their determinant
is zero.  Hence the precise implication from all the displayed premises and
`G>(c+1)^2 diameter^3` to a nonzero determinant is false; a collinearity
alternative cannot be deleted from that local cubic branch.

This is not a counterexample to Theorem 3.3, nor even to the numerical
inequality obtained by deleting noncollinearity from its box-wide conclusion:
here `G=961` while `N=22142`, so `G<N^2`.  It refutes only the local
diameter-scale cubic strengthening and the inference from divisibility to a
size bound without first knowing that the determinant is nonzero.  The
broader adaptive common-kernel route remains active because no full-premise
counterexample to it is known.

## 8. Formalization boundary and next mathematical gate

The companion Lean module formalizes the sharp ordered-square determinant
bound, derives the six-congruence adaptive interface from nine actual
pointwise arm divisors and their three triplewise gcds, and proves the
common-modulus product theorem.  It also checks all three factor-three arm
bounds, the long-arm square dichotomy, the one-arm factor-27 support theorem,
and the arithmetic seam of the full-kernel factor-27 theorem from its two
explicit kernel identities.  The two local false implications are defined as
propositions and negated by the full-premise divisor/gcd examples above.  No
density or incidence lower bound is postulated.  The actual repeated-kernel
identity used in Section 6 remains a mathematical proof rather than an
additional Lean specialization in this module.

The next positive target is a triple-selection theorem: from a sufficiently
large exceptional packet, select three noncollinear parameters for which the
triplewise canonical-kernel gcd product exceeds `N^2`.  The determinant
theorem would then give a contradiction.  Collinear concentration and the
zero-direction examples must be handled explicitly rather than omitted.
