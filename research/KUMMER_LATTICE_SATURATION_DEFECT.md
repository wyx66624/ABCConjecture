# The local Kummer lattice saturation defect

## 1. Set-up

Let `R` be a discrete valuation ring with uniformizer `pi`, fraction field `F`,
and valuation `v(pi)=1`.  Let `N>=1`, and let `alpha` be integral over `R`
such that

\[
  1,\alpha,\ldots,\alpha^{N-1}
\]

are `F`-linearly independent.  Define two rank-`N` `R`-lattices in the same
`F`-vector space:

\[
 B=\bigoplus_{j=0}^{N-1}R\alpha^j,
 \qquad
 A=\bigoplus_{j=0}^{N-1}R(\pi\alpha)^j.
\]

The second lattice is the power-basis lattice of the scaled Kummer generator
`beta=pi*alpha`; the first is its integral saturation obtained by removing the
uniformizer from the generator.

## 2. Exact quotient theorem

### Theorem 2.1

There is a canonical `R`-module isomorphism

\[
  B/A\simeq
  \bigoplus_{j=0}^{N-1}R/(\pi^j).
\]

Consequently

\[
  \operatorname{length}_R(B/A)
  =\sum_{j=0}^{N-1}j
  =\frac{N(N-1)}2,
\]

and the determinant ideal of the inclusion `A -> B` is

\[
  (\pi)^{N(N-1)/2}.
\]

### Proof

In the basis `1,alpha,...,alpha^(N-1)` of `B`, the basis of `A` is

\[
  1,\pi\alpha,\pi^2\alpha^2,\ldots,
  \pi^{N-1}\alpha^{N-1}.
\]

Thus the inclusion is represented by the diagonal matrix

\[
  \operatorname{diag}(1,\pi,\pi^2,\ldots,\pi^{N-1}).
\]

Its cokernel is the displayed direct sum and its determinant is the product of
its diagonal entries.

## 3. Exact multiplicity decomposition

Assume in addition that

\[
  \alpha^N=u\in R^\times.
\]

Then `beta=pi*alpha` satisfies

\[
  \beta^N=\pi^Nu,
  \qquad v(\beta^N)=N.
\]

Theorem 2.1 gives the exact identity

\[
 \boxed{
 N
 =1+\frac2N\operatorname{length}_R(B/A).}
\]

After multiplication by `log Norm(p)` at a nonarchimedean place, this becomes

\[
 \boxed{
 N\log p
 =\log p+
   \frac2N\operatorname{length}_R(B/A)\log p.}
\]

Thus the full valuation multiplicity decomposes into one radical contribution
plus one explicit saturation defect.

## 4. Discriminant interpretation

For any two full lattices in one separable algebra,

\[
  \operatorname{disc}(A)
  =\operatorname{disc}(B)\,[B:A]^2.
\]

In the present situation,

\[
 v(\operatorname{disc}(A))
 -v(\operatorname{disc}(B))
 =N(N-1).
\]

Equivalently, the saturation defect is half of the discriminant drop from the
scaled Kummer order to the unscaled integral Kummer order.

## 5. Global identity

For local Tate parameters of orders `N_p`, apply the construction at every
multiplicative prime.  If `A_p subset B_p` denotes the resulting local lattice
pair, then

\[
 \sum_pN_p\log p
 =\log\operatorname{rad}\!\left(\prod_pp^{N_p}\right)
 +\sum_p\frac2{N_p}
   \operatorname{length}(B_p/A_p)\log p.
\]

This identity does not prove `abc`; rather, it identifies the exact quantity
that every multiplicity-lowering proof must control.

## 6. Surviving global target

The actual-root globalization theorem bounds the root discriminant of the
saturated Kummer fields by radical plus sublinear multiplicity.  The new local
identity suggests a concrete global object:

1. assemble the saturated lattices `B_p` into an adelic or stacky lattice;
2. realize the original Frey/Tate object through the nonsaturated lattices
   `A_p`;
3. interpret `B_p/A_p` as the finite length of one global saturation map;
4. use an arithmetic determinant or maximal-slope theorem to bound this length
   by the normalized different, conductor, and archimedean determinant;
5. retain the exact coefficient `2/N_p` rather than replacing it by an
   uncontrolled metric rescaling.

A theorem carrying out Step 4 with coefficient `1+epsilon` would give the
missing multiplicity-to-radical inequality.  Unlike the excluded naive tensor
root, this target has an explicit nonmaximal-order quotient whose length is
exactly the lost multiplicity.
