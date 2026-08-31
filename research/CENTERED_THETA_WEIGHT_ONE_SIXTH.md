# The centered theta-weight sum is exactly one sixth of the transverse packet size

## 1. Purpose

The irreducible-symmetric frame theorem controls the finite phase transform and
its archimedean singular values.  To connect the frame to the pure
nonarchimedean theta metric, one needs the total tropical weight of the even
level-`ell` theta coefficient lattice.

This note computes it exactly.  With the standard centered representatives of
`F_ell`, the total tropical exponent over `F_ell^2/{±1}` is

\[
  \frac{\ell(\ell^2-1)}{12}.
\]

The irreducible symmetric kernel packet has cardinality

\[
  M_\ell=\frac{\ell(\ell^2-1)}2.
\]

Thus the tropical coefficient is exactly

\[
  \boxed{M_\ell/6.}
\]

The coefficient `1/6` therefore appears directly inside the finite theta
frame, before any IUT comparison or asymptotic slope argument.

## 2. Centered residue representatives

Write

\[
  \ell=2m+1.
\]

Represent `F_ell` by

\[
  -m,-m+1,\ldots,-1,0,1,\ldots,m.
\]

Define the centered square sum

\[
  C_\ell=
  \sum_{r=-m}^{m}r^2.
\]

### Lemma 2.1

\[
  \boxed{
  C_\ell
  =\frac{\ell(\ell^2-1)}{12}.}
\tag{2.1}
\]

#### Proof

By symmetry and the sum-of-squares formula,

\[
 \begin{aligned}
 C_\ell
 &=2\sum_{j=1}^{m}j^2\\
 &=2\frac{m(m+1)(2m+1)}6\\
 &=\frac{(2m+1)((2m+1)^2-1)}{12}.
 \end{aligned}
\]

## 3. Even two-dimensional theta coordinates

For `z=(z_1,z_2) in F_ell^2`, let `r_i` be its centered representatives.  The
leading tropical exponent in the standard level-`ell` theta coefficient is

\[
  w(z)=\frac{r_1^2+r_2^2}{\ell}L,
\tag{3.1}
\]

where

\[
  L=-\log|q|.
\]

The weight is invariant under `z -> -z`, and `w(0)=0`.  Hence it descends to
the even coordinate set

\[
  \mathcal Z_\ell=F_\ell^2/\{\pm1\}.
\]

### Theorem 3.1 (exact even-coordinate tropical sum)

\[
 \boxed{
 \sum_{[z]\in\mathcal Z_\ell}w([z])
 =\frac{\ell(\ell^2-1)}{12}L.}
\tag{3.2}
\]

#### Proof

First sum over every ordered pair:

\[
 \begin{aligned}
 \sum_{z\in F_\ell^2}w(z)
 &=\frac L\ell
   \left(
    \ell\sum_{r=-m}^{m}r^2+
    \ell\sum_{r=-m}^{m}r^2
   \right)\\
 &=2C_\ell L.
 \end{aligned}
\]

Every nonzero sign orbit has two elements and the zero orbit has weight zero,
so the quotient sum is one half of the full sum, namely `C_ell L`.  Apply
Lemma 2.1.

## 4. Exact packet normalization

The number of irreducible symmetric graph kernels is

\[
 M_\ell=\frac{\ell(\ell^2-1)}2.
\]

Combining this with Theorem 3.1 gives:

### Corollary 4.1

\[
 \boxed{
 \frac1{M_\ell}
 \sum_{[z]\in\mathcal Z_\ell}w([z])
 =\frac L6.}
\tag{4.1}
\]

Thus the natural normalization by the full transverse packet recovers the
precise `q/6` coefficient required in the logarithmic abc inequality.

## 5. Determinant interpretation

Group the analytic level-`ell` theta series by residue class:

\[
 \Theta_T(\tau)
 =\sum_{[z]\in\mathcal Z_\ell}
  \Phi_{T,[z]}a_{[z]}(\tau),
\]

where `Phi` is the finite phase matrix and the leading term of `a_[z]` has
order `w([z])/L` in the base Tate parameter.

For any full-rank square frame minor `J`, the determinant factors locally as

\[
 \det(\Phi_J)\prod_{[z]}a_{[z]}.
\tag{5.1}
\]

At a multiplicative place away from the primes dividing the finite phase
minor, the order of (5.1) is exactly the sum in Theorem 3.1.  The phase-minor
determinant contributes only a level-dependent lattice index.  The companion
convolution determinant bounds its normalized logarithmic cost by `O(log ell)`.

This identifies the expected multiplicative elementary-divisor contribution
of the pure-theta Plucker section:

\[
  \frac{M_\ell}{6}L.
\]

After normalizing the packet determinant by `M_ell`, the local contribution is
exactly `L/6`.

## 6. What remains to justify

The scalar tropical calculation is exact.  A global proof still must establish
that the analytic residue-class basis and the pure integral theta lattice have
the same elementary-divisor profile up to:

- good-place units;
- level-prime factors;
- descent/different factors;
- the explicit finite phase determinant.

The 2026 pure-extension theorem supplies the canonical adelic theta metric,
and the algebraic norm selection theorem supplies simultaneous global
selection.  The remaining local theorem is now the integral basis comparison
behind factorization (5.1), rather than an unknown q-coefficient.
