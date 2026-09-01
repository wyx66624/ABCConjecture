# Determinant layers and canonical-kernel entropy in the affine route

**Author:** ChatGPT  
**Date:** 1 September 2026  
**Status:** unconditional fixed-template theorem, exact adaptive boundary,
and three narrowly scoped counterexamples; abc remains open

## 1. Scope and route policy

This note continues the minimal-radical affine shear from
`ABC_AFFINE_TEMPLATE_ENTROPY_2026_09_01.md`.  It strengthens the capacity
bound for one complete divisibility template from a two-dimensional cell
bound to a one-dimensional determinant-layer bound.  It then applies the
new bound to the unique canonical certificate that retains every repeated
prime-power exponent in each affine arm.

The argument does not prove abc.  It exposes a stronger necessary entropy
gate for any proof that covers an exceptional affine packet by exact
lossless divisibility certificates.  Adaptive and correlated certificates
remain active.  A route is not discarded because this gate is difficult;
only the three exact auxiliary claims contradicted in Section 8 are retired.

## 2. Fixed-template setting

Let `S` be a finite subset of the integer box `[1,M]^2`.  For a fixed
template, the difference `(x,y)` of any two points satisfies

\[
 d_U\mid x,\qquad
 d_V\mid x+Cy,\qquad
 d_W\mid x+By,                                             \tag{2.1}
\]

where `d_U,d_V,d_W` are pairwise coprime.  Put

\[
 D=d_Ud_Vd_W,
 \qquad N=M-1.                                             \tag{2.2}
\]

The coefficient-coprimality and size-cap hypotheses of the earlier
three-form separation theorem are retained whenever separation is invoked.

### Theorem 2.1 (determinant divisibility)

If `v=(x,y)` and `w=(x',y')` are two fixed-template difference vectors,
then

\[
 D\mid\det(v,w)=xy'-yx'.                                  \tag{2.3}
\]

#### Proof

The modulus `d_U` divides both `x` and `x'`, and hence divides the
determinant.  The identities

\[
\begin{aligned}
 \det(v,w)
  &=(x+Cy)y'-y(x'+Cy'),\\
 \det(v,w)
  &=(x+By)y'-y(x'+By')
\end{aligned}                                             \tag{2.4}
\]

show that `d_V` and `d_W` also divide it.  Pairwise coprimality lets one
multiply the three divisibilities.  ∎

This uses all three affine forms simultaneously.  It is absent from the
earlier argument, which used only the size of one difference vector.

## 3. Layer capacity

Assume `|S|>=2`.  Choose a shortest nonzero difference vector `v` between
two points of `S`, in sup norm, and write

\[
 \delta=\lVert v\rVert_\infty.
\]

Choose one endpoint `p_0` of `v`.  The map

\[
 p\longmapsto\det(v,p-p_0)                                \tag{3.1}
\]

takes values divisible by `D`, by Theorem 2.1.  Its range has length at
most

\[
 N(|v_1|+|v_2|)\le2N\delta.                               \tag{3.2}
\]

Every level set is contained in a line parallel to `v`.  Points in one
level remain pairwise at sup distance at least `delta`; projecting to a
dominant coordinate of `v` therefore puts at most

\[
 \left\lfloor\frac N\delta\right\rfloor+1                 \tag{3.3}
\]

points on the level.

### Theorem 3.1 (determinant-layer bound)

Under the preceding hypotheses,

\[
 |S|\le
 \left(\left\lfloor\frac N\delta\right\rfloor+1\right)
 \left(\left\lfloor
   \frac{N(|v_1|+|v_2|)}D\right\rfloor+1\right).           \tag{3.4}
\]

In particular,

\[
 |S|\le \frac{4N^2}{D}+\frac N\delta+1.                  \tag{3.5}
\]

#### Proof

An interval of length (3.2) contains at most the second factor of (3.4)
multiples of `D`.  Multiply that number of layers by (3.3).  For (3.5),
discard the floors, expand, and use `delta<=N`.  ∎

The empty and singleton cases obey every capacity bound below directly.

### Corollary 3.2 (forced collinearity)

If

\[
 D>2N^2,                                                   \tag{3.6}
\]

then all points of `S` are collinear.  If the complete three-form theorem
also gives `delta>L`, then

\[
 |S|\le
 \left\lfloor\frac{M-1}{L+1}\right\rfloor+1.              \tag{3.7}
\]

#### Proof

For each `p in S`, the integer `det(v,p-p_0)` is divisible by `D`, while

\[
 |\det(v,p-p_0)|\le N(|v_1|+|v_2|)\le2N^2<D.
\]

It must therefore vanish, proving collinearity.  On the common line, choose
a coordinate in which the direction is dominant.  Distinct points differ
by at least `L+1` in that coordinate, whose total range has length `N`; this
gives (3.7).  ∎

## 4. Canonical parameters force the collinear case

For a primitive positive seed `a+b=c`, orient `b>=c/2`, and put

\[
 R=\operatorname{rad}(abc),
 \qquad
 M=\left\lfloor\frac{c^6}{4R}\right\rfloor,
 \qquad
 T_0=\frac{Rc^{14}}{8192}.                                \tag{4.1}
\]

The route concerns the subcritical case `R<c`, with `c>=6`.

### Lemma 4.1 (the first possible subcritical endpoint)

Every such actual primitive seed has

\[
 c\ge9.                                                    \tag{4.2}
\]

#### Proof

The standard seed-radical argument gives `R>=6`.  For `c=6`, already
`R>=6` contradicts `R<c`.  For `c=7`, the prime `7` divides `abc`, so
`7|R`, again contradicting `R<c`.  For `c=8`, the primitive unordered pairs
are `(1,7)` and `(3,5)`; their radicals are respectively `14` and `30`.
Thus none of `c=6,7,8` is subcritical.  ∎

Now `R>=6` and `c>=9`, so

\[
 R^3c^2\ge6^3\cdot9^2>1024.                               \tag{4.3}
\]

Since `N<M<=c^6/(4R)`, this gives

\[
 T_0=\frac{Rc^{14}}{8192}
   >\frac{c^{12}}{8R^2}>2N^2.                              \tag{4.4}
\]

Every complete certificate has `D>=Delta>T_0`, where `Delta` is its product
of repeated-exponent losses.  Corollary 3.2 therefore makes every canonical
fixed-template class collinear.

## 5. Two separation scales

### Theorem 5.1 (fixed scale twelve)

Let

\[
 L_{12}=\left\lfloor\frac{c^4}{12}\right\rfloor.          \tag{5.1}
\]

The complete cubic and size-cap inequalities needed by the three-form
separation theorem hold at this scale, and every canonical template obeys

\[
 |S|\le
 \left\lfloor\frac{M-1}{L_{12}+1}\right\rfloor+1
 <\frac{31c^2}{10R}.                                      \tag{5.2}
\]

#### Proof

The cubic inequality follows from `9(c+1)<=10c`, `R>=6`, and

\[
 8192\cdot100=819200
 <839808=81\cdot12^3\cdot6.                               \tag{5.3}
\]

Indeed, after multiplying by `8192`, the desired inequality is
`8192(c+1)^2 L_12^3<Rc^14`.  The weakest individual size cap follows from

\[
 8192<12\cdot6\cdot9^3.                                   \tag{5.4}
\]

Thus distinct template points are more than `L_12` apart.  Collinearity and
(3.7) give the first part of (5.2).  Since `L_12+1>c^4/12`,

\[
 |S|<\frac{3c^2}{R}+1.
\]

Finally `10R<c^2` follows from `R<=c-1` and `c>=9`, yielding the displayed
constant.  ∎

### Theorem 5.2 (scale growing with the seed radical)

Let `s>=1` be an integer satisfying `s^3<=R`, and set

\[
 L_s=\left\lfloor\frac{s c^4}{22}\right\rfloor.           \tag{5.5}
\]

Then the complete separation hypotheses again hold, and

\[
 |S|<\frac{57c^2}{10Rs}.                                  \tag{5.6}
\]

#### Proof

Using `s^3<=R`, the cubic inequality reduces to

\[
 8192\cdot100=819200<81\cdot22^3=862488.                  \tag{5.7}
\]

The size caps use `s<=R` and

\[
 8192<22\cdot9^3.                                         \tag{5.8}
\]

Hence (3.7) gives

\[
 |S|<\frac{11c^2}{2Rs}+1.                                 \tag{5.9}
\]

It remains to verify `5Rs<c^2`.  If `s=1`, use `R<c`.  If `s=2`, then
`5Rs=10R<=10(c-1)<c^2` for `c>=9`.  If `s>=3`, then
`5s<s^3<=R<c`, so again `5Rs<c^2`.
This absorbs the final one in (5.9) and proves (5.6).  ∎

No independence between the three arms was used in either theorem.

## 6. The canonical repeated kernel

Define

\[
 K(n)=\prod_{\substack{p^e\parallel n\\e\ge2}}p^e.        \tag{6.1}
\]

### Proposition 6.1 (unique minimal exact-lossless certificate)

For every positive `n`,

\[
 K(n)\mid n,
 \qquad
 \frac{K(n)}{\operatorname{rad}K(n)}
  =\frac n{\operatorname{rad}n}.                          \tag{6.2}
\]

Moreover, if `d|n` and

\[
 d/\operatorname{rad}(d)=n/\operatorname{rad}(n),         \tag{6.3}
\]

then `K(n)|d`.

#### Proof

Compare prime exponents.  If `v_p(n)=0` or `1`, both powerful-loss
exponents are zero.  If `v_p(n)=e>=2`, the right side of (6.2) has exponent
`e-1`, and `K(n)` contains exactly `p^e`, whose quotient by its radical has
the same exponent.  This proves (6.2).  Under (6.3), the exponent of `p` in
`d/rad(d)` must be `e-1`; since `d|n`, this forces `v_p(d)=e`.  Thus every
prime power in `K(n)` divides `d`.  ∎

This certificate is canonical: among armwise divisors retaining the full
exponent loss, it is the unique minimal one.  It therefore gives the
coarsest exact-lossless partition, rather than an artificially inflated
template count.

Partition the exceptional parameters by

\[
 \bigl(K(U),K(V),K(W)\bigr).                               \tag{6.4}
\]

Each part is a fixed-template class and retains

\[
 \Delta=E(U)E(V)E(W)>T_0.                                 \tag{6.5}
\]

## 7. Forced canonical-kernel entropy

Let `kappa,eta>0`, and let `N_ker` be the number of realized triples (6.4).
Theorems 5.1--5.2
give

\[
 |\mathcal E|<N_{\rm ker}
 \min\left\{
  \frac{31c^2}{10R},\frac{57c^2}{10Rs}
 \right\}.                                                \tag{7.1}
\]

Consequently a matching lower bound

\[
 |\mathcal E|\ge\kappa R^{-2/3}c^{4+\eta}                 \tag{7.2}
\]

forces

\[
 N_{\rm ker}>
 \max\left\{
  \frac{10\kappa}{31}R^{1/3}c^{2+\eta},
  \frac{10\kappa}{57}sR^{1/3}c^{2+\eta}
 \right\}.                                                \tag{7.3}
\]

Taking `s=floor(R^(1/3))` and using `s>=R^(1/3)/2` gives the convenient
necessary scale

\[
 N_{\rm ker}>
 \frac{5\kappa}{57}R^{2/3}c^{2+\eta}.                    \tag{7.4}
\]

The earlier two-dimensional estimate required only
`(kappa/12)R^(4/3)c^eta` templates.  The determinant structure gains the
factor `c^2` in the height direction and now applies to the unique
nonoverlapping canonical-kernel partition.

The realized kernels also satisfy the support restriction

\[
 \operatorname{rad}\bigl(K(U)K(V)K(W)\bigr)
 <\frac{8192c^6}{R}.                                      \tag{7.5}
\]

Indeed, their product is below `c^20`, while its quotient by its radical is
greater than `Rc^14/8192`.

For a correlated fractional cover by templates `tau` with weights
`w_tau>=0`, assume both that every exceptional point receives total covering
weight at least one and that every template meets the exceptional set in at
most `K_s` points.  Tonelli's identity for this finite incidence matrix gives

\[
 |\mathcal E|\le K_s\sum_\tau w_\tau,
 \qquad
 K_s=\left\lfloor\frac{M-1}{L_s+1}\right\rfloor+1.         \tag{7.6}
\]

This handles overlap exactly.  The unresolved positive input is a lower
construction or an upper obstruction for the effective adaptive weight,
not a missing disjointness assumption.

## 8. Full-premise counterexamples to three stronger claims

### Proposition 8.1 (the area term alone is false)

#### Proof

Take

\[
 B=1,\ C=2,\ Q=2,\quad (h,k)=(24,60),
\]

so

\[
 (U,V,W)=(49,289,169).
\]

Use the template `(d_U,d_V,d_W)=(49,289,169)`, `L=5`, and `T=1500`.
Then

\[
 D=2393209,
 \qquad
 \Delta=7\cdot17\cdot13=1547>T,                           \tag{8.1}
\]

while

\[
 9L^3=1125<T,
 \qquad 5\max(d_U,d_V,d_W)=1445<T.                        \tag{8.2}
\]

All membership, pairwise coprimality, coefficient cancellation, size-cap,
and threshold premises hold.  In the box with `M=60`, the template is
nonempty, but

\[
 \frac{4M^2}{D}=\frac{14400}{2393209}<1.                  \tag{8.3}
\]

Thus a proposed bound retaining only an `M^2/D` area term is false, so some
boundary correction is necessary.  This example does not by itself isolate
which individual boundary summand is optimal, and it does not contradict the
determinant-layer theorem.

### Proposition 8.2 (point-adaptive separation does not unionize)

#### Proof

Use the actual primitive seed

\[
 (a,b,c)=(1,8,9),\qquad R=Q=6,
\]

and `L=1,T=2000`.  Let

\[
 p=(861219583918648,1),
 \qquad q=(861219583918649,1).
\]

At `p`, use `(121,169,289)=(11^2,13^2,17^2)`, with excess product `2431`;
at `q`, use `(361,529,841)=(19^2,23^2,29^2)`, with excess product `12673`.
The corresponding affine arm values are

\[
\begin{aligned}
 p:&\ (5167317503511889,5167317503511943,5167317503511937),\\
 q:&\ (5167317503511895,5167317503511949,5167317503511943).
\end{aligned}                                             \tag{8.4}
\]

Direct division verifies the six required template memberships.  Each
point's three arms and three moduli satisfy the complete coprimality,
cancellation, size-cap, threshold, and admissibility premises; in
particular

\[
 (c+1)^2L^3=100<T,
 \qquad \max d_i=841<T.                                   \tag{8.5}
\]

Nevertheless

\[
 \lVert p-q\rVert_\infty=1=L.                             \tag{8.6}
\]

This is a full-premise counterexample to the unrestricted assertion that
the union of pointwise chosen separated templates remains separated.  It
lies outside the canonical parameter box and does not contradict the
canonical correlated-template route.

### Proposition 8.3 (the zero-density entropy strengthening is false)

#### Proof

If the positivity premise on `kappa` is deleted from the entropy corollary,
take `kappa=0`, the empty exceptional packet, and `N_ker=0`.  The lower bound

\[
 |\mathcal E|\ge \kappa R^{-2/3}c^{4+\eta}
\]

then reads `0>=0`, while the claimed strict conclusion reads `0>0`.  Thus
these data satisfy every premise of the weakened statement and refute it.
They do not meet `kappa>0` and hence do not affect the corrected corollary or
the positive-density canonical-kernel route.

## 9. Formalization boundary and remaining target

The companion module
`AffineDeterminantLayerEntropy20260901.lean` now kernel-checks:

1. product-modulus divisibility of every determinant;
2. the coordinate-bound estimate and forced-zero determinant when
   `D>2N^2`;
3. one-dimensional separated cardinality and its dominant-coordinate
   interface;
4. exclusion of the actual primitive subcritical cases `c=6,7,8`;
5. the scale-12 and scale-22 cubic and long-cap integer inequalities;
6. the canonical implication from the full threshold to `D>2M^2`;
7. the three exact counterexamples of Section 8; and
8. the finite fractional-cover inequality used in (7.6).

The general nonzero-layer count (3.4), an automatic selection of the
dominant coordinate after collinearity, the repeated-kernel divisibility and
minimality of Proposition 6.1, and their final composed entropy corollaries
remain separate formalization tasks.  They are proved mathematically above
but are not counted as kernel-checked declarations in this checkpoint.

The remaining mathematical input for this branch is a theorem producing or
excluding roughly `R^(2/3)c^(2+eta)` realized canonical kernel triples with
the support restriction (7.5), while also enforcing the actual exception
inequality on their collinear classes.  Neither the current exceptional-set
bounds nor fixed-modulus squarefree-distribution theorems supply that
adaptive growing-kernel result.  No full-premise counterexample to it is
known, so the route remains active.
