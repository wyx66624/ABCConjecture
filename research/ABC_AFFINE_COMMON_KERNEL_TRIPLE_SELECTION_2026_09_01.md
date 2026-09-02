# Common-kernel incidence budgets and the affine triple-selection gate

**Author:** ChatGPT  
**Date:** 1 September 2026  
**Status:** unconditional finite selection and incidence theorems; the arithmetic overlap lower bound remains open

## 1. Scope

Let a primitive positive seed give the affine arms

\[
 U(h,k)=1+Rh,\qquad
 V(h,k)=1+R(h+ck),\qquad
 W(h,k)=1+R(h+bk),
\]

and let the positive canonical parameter box be

\[
 1\le h,k\le M,\qquad N=M-1.
\]

At a parameter point `x`, an arm-divisor label is a triple

\[
 \lambda(x)=(d_U(x),d_V(x),d_W(x)),
 \qquad d_Z(x)\mid Z(x).
\]

The preceding checkpoint proved that, for three points, the triplewise
gcds

\[
 g_Z=\gcd(d_Z(x_1),d_Z(x_2),d_Z(x_3))
\]

give the six affine difference congruences and that a noncollinear triple
satisfies

\[
                         g_Ug_Vg_W\le N^2.                 \tag{1.1}
\]

This note attacks the missing selection step.  It proves an exact geometric
line cap, converts it into a common-kernel incidence budget, gives the exact
third-gcd energy identity that an energy argument must estimate, and tests
the strongest tempting noncollinearity inference on actual affine data.
No distribution claim about repeated prime powers is assumed.

## 2. More than one side length forces a noncollinear triple

### Theorem 2.1 (integer line cap)

Let `S` be a finite set of lattice points in `[1,M]^2`.  If every triple in
`S` is collinear, then

\[
                              |S|\le M.                     \tag{2.1}
\]

Equivalently, if `|S|>M`, then `S` contains a noncollinear triple.

### Proof

If `|S|<=1`, there is nothing to prove.  Otherwise choose distinct points
`p,q` in `S`.

If their first coordinates agree, collinearity of `p,q,r` forces every
`r in S` to have that same first coordinate.  The second-coordinate
projection is therefore injective on `S`, and its image lies in
`{1,...,M}`.  Hence `|S|<=M`.

If the first coordinates of `p,q` differ, the line through them is the graph
of a function of the first coordinate.  More explicitly, if `r,s in S`
have the same first coordinate, subtracting

\[
 \det(q-p,r-p)=0,\qquad \det(q-p,s-p)=0
\]

gives

\[
 (q_1-p_1)(r_2-s_2)=0.
\]

The first factor is nonzero, so `r_2=s_2` and `r=s`.  Thus the
first-coordinate projection is injective on `S`, again giving `|S|<=M`.
This proves (2.1). ∎

The constant `M` is sharp for unrestricted lattice sets: one complete
vertical or horizontal line has exactly `M` points.

## 3. A large common arm-divisor label has a small fibre

Fix one label

\[
                         \lambda=(d_U,d_V,d_W),
 \qquad D(\lambda)=d_Ud_Vd_W,
\]

and define its actual affine divisor fibre

\[
 F_\lambda=\{x\in S:d_U\mid U(x),\ d_V\mid V(x),\ d_W\mid W(x)\}.
                                                               \tag{3.1}
\]

Assume the points of `S` are admissible, so their three arms are pairwise
coprime.

### Theorem 3.1 (large-label fibre cap)

If

\[
                              N^2<D(\lambda),                 \tag{3.2}
\]

then

\[
                              |F_\lambda|\le M.               \tag{3.3}
\]

### Proof

Suppose instead that `|F_lambda|>M`.  Theorem 2.1 supplies a noncollinear
triple `p,q,r` in the fibre.  Use the same divisor triple `lambda` at all
three points.  Its triplewise gcd is exactly itself.  Actual arm
divisibility gives the six difference congruences; pairwise coprimality of
the arms at `p` gives pairwise coprimality of `d_U,d_V,d_W`.  The determinant
theorem then gives

\[
                              D(\lambda)\le N^2,
\]

contradicting (3.2). ∎

This result applies to any actual arm sub-divisors.  They need not be the
full repeated-prime-power kernels.

## 4. Incidence and catalogue consequences

Let `L` be a finite family of labels satisfying (3.2).  Summing (3.3) gives
the exact incidence budget

\[
                 \sum_{\lambda\in L}|F_\lambda|\le M|L|.     \tag{4.1}
\]

### Corollary 4.1 (multiplicity form)

If every point of a set `E` belongs to at least `mu` fibres from `L`, then

\[
                              \mu |E|\le M|L|.                \tag{4.2}
\]

### Proof

Count the incidence set

\[
 I=\{(x,\lambda):x\in E\cap F_\lambda,\ \lambda\in L\}
\]

by points and by labels.  The point count is at least `mu|E|`; the label
count is at most `M|L|` by (4.1). ∎

In particular, if one assigns to every point one large label from a catalogue
`L`, then

\[
                              |E|\le M|L|.                    \tag{4.3}
\]

This is the precise pigeonhole route to a noncollinear common-kernel triple.
It also exposes its limitation.  A canonical full-kernel assignment can use
a different label at every point, so (4.3) alone is not a contradiction.
The arithmetic task is to manufacture many **shared large sublabels**, or
to prove a substantially smaller catalogue.

The earlier fixed-template separation theorem gives a stronger capacity
when a label satisfies the full coefficient-coprimality hypotheses, the
individual arm caps, and all four product thresholds of that theorem.  In
that situation its fibre is bounded by the two-dimensional packing quantity

\[
 \left(\frac{M}{L_0+1}+1\right)^2,
\]

with `L_0` of order `c^4`; in the canonical subcritical regime this is less
than `12c^4/R^2`.  Replacing `M` in (4.1) by that capacity is legitimate for
such labels.  It still leaves the number and overlap multiplicity of the
point-dependent labels unresolved.

## 5. The exact third-gcd energy identity

The energy route can be written without heuristics.  Let `S` be finite and
let `d_Z(x)>0` be three integer labels at every point.  Define

\[
 \mathcal E_3=
 \sum_{x,y,z\in S}
 \prod_{Z\in\{U,V,W\}}
       \gcd(d_Z(x),d_Z(y),d_Z(z)).                    \tag{5.1}
\]

For a divisor triple `e=(e_U,e_V,e_W)`, put

\[
 n(e)=\#\{x\in S:e_U\mid d_U(x),\ e_V\mid d_V(x),\
                         e_W\mid d_W(x)\}.            \tag{5.2}
\]

### Proposition 5.1 (third-gcd incidence expansion)

For any finite ranges of positive integers containing every positive divisor
of the labels,

\[
 \mathcal E_3=
 \sum_{e_U,e_V,e_W}
   \varphi(e_U)\varphi(e_V)\varphi(e_W)n(e)^3.        \tag{5.3}
\]

### Proof

For every positive integer `m`, the divisor-sum identity gives

\[
                         m=\sum_{e\mid m}\varphi(e).
\]

Apply it to each of the three gcds in (5.1).  A divisor `e_Z` divides the
gcd precisely when it divides all three corresponding point labels.  Expand
the product, interchange the finite sums, and note that the number of
ordered triples `x,y,z` simultaneously incident to `e` is `n(e)^3`.  This
is exactly (5.3). ∎

Formula (5.3) identifies the possible gain from p-adic congruence classes:
large third-gcd energy is the cubic moment of divisor-fibre occupancies.  To
use (1.1), however, one must show that enough of this energy occurs on
triples with `e_Ue_Ve_W>N^2`, and then remove the collinear contribution.
Neither conclusion follows from the total energy alone.

## 6. A full affine box-wide collinear counterexample

The tempting implication

\[
 \text{all arm/gcd/congruence premises and }G>N^2
 \quad\Longrightarrow\quad
 \det(q-p,r-p)\ne0                              \tag{6.1}
\]

is false even in the canonical seed box.  This is a box-wide counterexample
to (6.1), not a counterexample to (1.1), whose hypothesis already requires
a nonzero determinant.

Take

\[
 (a,b,c)=(1,8,9),\qquad R=6,\qquad M=22143,
\]

and the three vertical points

\[
 p=(21480,282),\quad q=(21480,6211),\quad
 r=(21480,12140).                                  \tag{6.2}
\]

At every point use the square divisors

\[
 d_U=128881=359^2,\qquad d_V=49=7^2,
 \qquad d_W=121=11^2.                              \tag{6.3}
\]

The exact arm values are

\[
\begin{array}{c|ccc}
 &U&V&W\\ \hline
p&128881&144109&142417\\
q&128881&464275&427009\\
r&128881&784441&711601.
\end{array}                                         \tag{6.4}
\]

The displayed divisors divide their respective arms.  Each point satisfies
`gcd(U,k)=1`, and the three arms at each point are pairwise coprime.  Since
the divisor label is identical at all three points, the triplewise gcds are

\[
                         (g_U,g_V,g_W)=(128881,49,121).
\]

Consequently

\[
 G=128881\cdot49\cdot121=764135449
   >490268164=22142^2=N^2.                          \tag{6.5}
\]

All six difference congruences hold.  Indeed the vertical step is

\[
                         6211-282=5929=49\cdot121,
\]

and the second step is twice that.  Nevertheless all three first
coordinates agree, so

\[
                         \det(q-p,r-p)=0.            \tag{6.6}
\]

The same congruence class supplies a fourth admissible point at
`(21480,18069)`.  Thus neither three points nor a strict box-square common
product can manufacture noncollinearity.  The selection argument must use
distribution across lines or a fibre cardinality threshold such as
Theorem 2.1.

## 7. An abstract pointwise-overlap counterexample

Pointwise large label products do not imply a large triplewise gcd product.
Consider the three abstract labels

\[
 (49,25,1),\qquad (121,169,1),\qquad (289,361,1).  \tag{7.1}
\]

The components within every label are pairwise coprime, and each pointwise
product is greater than `1000`.  Across the three labels, however,

\[
 \gcd(49,121,289)=1,
 \qquad \gcd(25,169,361)=1,
\]

so the triplewise common product is `1`.

This refutes the exact abstract implication “three pointwise products above
`1000` force the triplewise common product above `1000`.”  It is not an
affine or box-wide counterexample: no arm divisibility is asserted.  The
same construction with disjoint prime squares gives arbitrarily many
abstract labels, so an energy or density proof must use actual arithmetic
overlap rather than pointwise size alone.

## 8. Assessment of the proposed routes

### Fibre decomposition

This gives the strongest unconditional deterministic statement in the note:
large-label fibres have capacity `M`, or the sharper fixed-template packing
capacity when the full separation hypotheses hold.  A successful proof must
show that exceptional points create too many incidences with too few large
labels.

### p-adic congruence classes and energy

Equation (5.3) is the exact bridge.  The missing estimate is a lower bound
for the cubic incidence moment restricted to divisor triples whose product
exceeds `N^2`.  Pointwise excess and the factor-27 radical-support bound do
not by themselves control overlap between different points.

### Szemerédi--Trotter and lattice incidences

For admissible arm data, a large label cuts out a congruence lattice.  Inside
the box, (3.2) prevents two independent short lattice differences, so its
occupied points collapse onto one line.  A plain point-line incidence theorem
is insufficient until one controls how many labels yield the same line and
how much arithmetic weight each line carries.  The actual example in
Section 6 demonstrates this multiplicity obstruction.

### Determinant packing

The sharp determinant bound is already optimal.  Further progress cannot
come from improving its constant below one.  It must come from producing a
noncollinear triple with a genuinely shared divisor product, or from proving
that the collinear part of the third-gcd energy is too small.

## 9. The remaining gate

Let `E` be the exceptional parameter set and let `L` be a finite family of
actual arm-divisor labels with product above `N^2`.  Any one of the following
would advance the route:

1. a multiplicity lower bound `mu|E|>M|L|`, contradicting (4.2);
2. a lower bound for the large-label portion of (5.3) that exceeds every
   possible collinear contribution;
3. a line-by-line p-adic estimate showing that shared repeated-prime-power
   labels cannot concentrate as in Section 6 often enough;
4. a stronger canonical-label fibre capacity, uniform over point-dependent
   sublabels, together with a matching catalogue bound.

No full-premise counterexample to these conditional criteria is known.  The
box-wide example only proves that noncollinearity cannot be inferred from
the common-product inequality itself.  Therefore the broad affine
common-kernel route remains active.

## 10. Formalization boundary

The companion Lean module formalizes Theorem 2.1, the large-label fibre and
finite-catalogue selection theorems, the actual arm-divisor-to-interface
composition, Proposition 5.1 for arbitrary finite divisor ranges satisfying
the stated coverage hypotheses, the box-wide counterexample to (6.1), and
the abstract model in Section 7.  In particular, the formal energy theorem
includes both the totient expansion and the sixfold finite-sum rearrangement
that produces the cubic fibre occupancy.
