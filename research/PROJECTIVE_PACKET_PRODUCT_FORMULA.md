# The projective packet product formula

## 1. Purpose

The cyclic-line and Hecke-discriminant routes produce a Galois-stable family
of nonzero algebraic coordinates

\[
  z_C\in K^\times,
  \qquad C\in\mathbb P^1(\mathbb F_\ell).
\]

The fixed linear average of the local Tate energies is zero, while the
projective maximum retains the canonical line.  This note proves the exact
global identity which separates the desired Tate contribution from the
remaining archimedean, level-prime, and descent defects.

The identity is elementary but important: it prevents a common Hodge factor
or a common algebraic factor from being counted as projective height.

## 2. Local centered projective height

Let `I` be a finite nonempty set of cardinality `N`, and let

\[
  x=(x_i)_{i\in I}\in\mathbb R^I.
\]

Define

\[
  \operatorname{avg}(x)=\frac1N\sum_{i\in I}x_i,
\]

and

\[
  h_{\rm proj}(x)
  =\max_{i\in I}x_i-\operatorname{avg}(x).
\tag{2.1}
\]

Then `h_proj(x)>=0`, and for every real `c`,

\[
  h_{\rm proj}(x+c\mathbf1)=h_{\rm proj}(x).
\tag{2.2}
\]

Thus (2.1) depends only on the projective class of the norm vector.

## 3. Product-formula identity

Let `K` be a number field.  Normalize the local weights `n_v` so that every
`z in K^x` satisfies

\[
  \sum_v n_v\log|z|_v=0.
\tag{3.1}
\]

For a nonzero packet `(z_i)_{i in I}`, put

\[
  x_{v,i}=\log|z_i|_v.
\]

Only finitely many finite places contribute.  Define the global projective
packet height

\[
  H_{\rm proj}(z)
  =\sum_v n_v h_{\rm proj}(x_v).
\tag{3.2}
\]

### Theorem 3.1 (average removal)

\[
  \boxed{
  H_{\rm proj}(z)
  =\sum_v n_v\max_i\log|z_i|_v.}
\tag{3.3}
\]

### Proof

By (3.1), for every coordinate `i`,

\[
  \sum_v n_vx_{v,i}=0.
\]

Therefore

\[
 \begin{aligned}
 \sum_vn_v\operatorname{avg}(x_v)
 &=\frac1N\sum_i\sum_vn_vx_{v,i}\\
 &=0.
 \end{aligned}
\]

Subtracting this zero term from (3.2) gives (3.3).

### Corollary 3.2

Multiplying every coordinate by one common algebraic scalar does not change
`H_proj`.  More generally, every common metrized line factor disappears after
the local centering in (2.1).

This is the global form of the Hodge-twist no-go theorem.

## 4. Exact Tate-place contribution

At a split multiplicative place let

\[
  L_v=-\log|q_v|\ge0.
\]

For the `ell+1` cyclic lines, assume the exact local logarithmic coordinates,
after removing the common determinant factor, are

\[
  A_\ell L_v
\]

at the canonical line and

\[
  B_\ell L_v
\]

at each of the other `ell` lines, where

\[
  A_\ell=\frac{\ell-1}{12},
  \qquad
  B_\ell=-\frac{\ell-1}{12\ell}.
\]

Since

\[
  A_\ell+\ell B_\ell=0,
\tag{4.1}
\]

the vector is already centered.  Since `A_ell>=0>=B_ell`, its maximum is the
canonical coordinate.

### Theorem 4.1

The local projective packet contribution at a split multiplicative place is
exactly

\[
  \boxed{
  h_{\rm proj}(x_v)
  =\frac{\ell-1}{12}L_v.}
\tag{4.2}
\]

This selects the canonical line without making a global choice of that line.

## 5. Good finite places

If every packet coordinate is a unit in the chosen integral lattice at a good
finite place away from `ell`, then

\[
  x_{v,i}=0
\]

for every `i`, and hence

\[
  h_{\rm proj}(x_v)=0.
\tag{5.1}
\]

The kernel-polynomial and determinant-of-cohomology arguments establish this
unitness for the active cyclic packet.

## 6. Exact global decomposition

Let `M` be the set of split multiplicative places, and let `E` contain the
archimedean places, the places above `ell`, and every remaining model/descent
place.  Put

\[
  Q=\sum_{v\in M}n_vL_v,
\]

and

\[
  H_{\rm exc}
  =\sum_{v\in E}n_vh_{\rm proj}(x_v).
\]

### Theorem 6.1 (projective packet decomposition)

Under the local hypotheses above,

\[
  \boxed{
  H_{\rm proj}(z)
  =\frac{\ell-1}{12}Q+H_{\rm exc}.}
\tag{6.1}
\]

Since every local centered maximum is nonnegative,

\[
  \frac{\ell-1}{12}Q\le H_{\rm proj}(z).
\tag{6.2}
\]

Thus the lower/source side of the proposed classical packet proof is now an
identity.  The remaining theorem is an upper bound for one explicit algebraic
projective packet.

## 7. Interaction with the division-polynomial product

For the Frey curve, the product over all cyclic lines of the three
kernel-polynomial evaluations at the rational two-torsion points has the form

\[
  \prod_C z_C
  =\pm\ell^{-3}(abc)^{(\ell^2-1)/2}.
\tag{7.1}
\]

Because

\[
  \frac1{\ell+1}\cdot\frac{\ell^2-1}{2}
  =\frac{\ell-1}{2},
\]

the coordinate average contains the common algebraic term

\[
  \frac{\ell-1}{2}\log(abc)
  -\frac{3}{\ell+1}\log\ell.
\tag{7.2}
\]

The centering in (2.1) subtracts this term exactly.  Consequently the common
Hodge weight and the common division-polynomial factor cannot supply the
upper bound; only the **relative Steinberg coordinates** remain.

## 8. The exact surviving target

A proof of abc along this route is reduced to an upper bound

\[
  \boxed{
  H_{\rm proj}(z)
  \le
  \left(\frac{\ell-1}{2}+o(\ell)\right)
  (D+N)
  +O(\ell\log\ell),}
\tag{8.1}
\]

for the explicit kernel/Hecke/theta packet, with every local norm and descent
Jacobian specified.

Combining (6.2) and (8.1), then dividing by `(ell-1)/2`, gives

\[
  \frac16Q
  \le(1+o(1))(D+N)+O(\log\ell).
\]

A quantifier-correct auxiliary prime with `log ell=o(log c)` would then imply
the logarithmic abc conjecture.

Theorem (8.1) remains open.  The present note proves that it is the precise
remaining projective-height statement and removes all common-factor and
product-formula ambiguities.
