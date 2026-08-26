# Counting nonsquare companion discriminants without character sums

Let `F=F_q` be a finite field of odd cardinality.  For `t in F`, consider

\[
  \Delta_t=t^2+4.
\]

## Theorem 1 (the conic has `q-1` points)

The affine conic

\[
  Y^2-T^2=4
\]

has exactly `q-1` `F`-rational points.

### Proof

Factor the equation as

\[
  (Y-T)(Y+T)=4.
\]

For every `u in F^x`, put

\[
  Y-T=u,
  \qquad Y+T=4u^{-1}.
\]

Since `2` is invertible,

\[
  Y=\frac{u+4u^{-1}}2,
  \qquad
  T=\frac{4u^{-1}-u}2.
\]

This construction is inverse to `(T,Y) -> Y-T`.  Hence the conic is in
bijection with `F^x` and has `q-1` points.

## Theorem 2 (exact nonsquare count)

Let `Z` be the number of `t` satisfying `t^2+4=0`.  Then `Z` is either zero or
two, and the number of `t` for which `t^2+4` is a nonzero nonsquare is

\[
  \frac{q+Z-1}{2}.
\]

In particular it is positive for every odd finite field.

### Proof

Let `S` be the number of `t` for which `Delta_t` is a nonzero square, and let
`N` be the nonsquare count.  Every zero value contributes one point to the
conic, every nonzero square value contributes two, and every nonsquare value
contributes none.  Theorem 1 gives

\[
  Z+2S=q-1.
\]

Also

\[
  Z+S+N=q.
\]

Eliminating `S` gives

\[
  N=\frac{q+Z-1}{2}.
\]

The polynomial `T^2+4` is separable in odd characteristic, so `Z` is zero or
two.

## Corollary 3 (anti-symplectic kernels exist at every odd prime)

For every odd prime `ell`, there exists `t in F_ell` such that

\[
  t^2+4
\]

is a nonsquare.  Therefore

\[
  T_t=\begin{pmatrix}0&1\\1&t\end{pmatrix}
\]

has irreducible characteristic polynomial, determinant `-1`, no projective
eigenline, and a graph which is simultaneously universally transverse and
maximal isotropic for the product Weil pairing.

Thus the corrected polarized construction does not require
`ell=1 mod 12`; the congruence condition remains useful for the integral
Legendre modular-form route but is unnecessary for the finite-field
transverse-kernel existence theorem.
