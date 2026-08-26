# A universally transverse torsion subgroup in a power of a Frey curve

## 1. Motivation

For one elliptic curve, no cyclic `ell`-subgroup can be noncanonical at every
Galois conjugate of a multiplicative place: the possible canonical lines fill
`P^1(F_ell)`.  This is the mechanism behind the fixed-line averaging
cancellation theorem.

The obstruction disappears in a power `E^g`.  A single `g`-dimensional
subgroup of `E[ell]^g` can be complementary to `L^g` for **every** line
`L subset E[ell]`.  This gives a global isogeny which is locally of the
q-root, rather than q-power, type at every multiplicative place.

## 2. The finite-field transversality theorem

Let `F=F_ell`, let `V=F^2`, and identify

\[
 V^g\simeq F^g\oplus F^g.
\]

Choose a matrix `T in M_g(F)` with no eigenvalue in `F`, and define

\[
 H_T=\{(x,Tx):x\in F^g\}.
\]

For a line `L subset V`, write `L^g` for the direct sum of `g` copies of `L`
inside `V^g`.

### Theorem 2.1 (universal transversality)

For every line `L subset V`,

\[
 H_T\cap L^g=0,
 \qquad
 H_T\oplus L^g=V^g.
\]

### Proof

If `L=F(0,1)`, then `L^g=0\oplus F^g`, and a vector `(x,Tx)` in the
intersection has `x=0`.

Every other line has the form

\[
 L_\lambda=F(1,\lambda)
\]

for some `lambda in F`; hence

\[
 L_\lambda^g=\{(x,\lambda x):x\in F^g\}.
\]

An element `(x,Tx)` lies in this subspace exactly when

\[
 Tx=\lambda x.
\]

The hypothesis that `T` has no eigenvalue in `F` forces `x=0`.  Both
subspaces have dimension `g`, so trivial intersection implies that their sum
is all of `V^g`.

### Corollary 2.2

One may take `g=2` for every prime `ell`: choose the companion matrix of any
irreducible quadratic polynomial over `F_ell`.

## 3. Global subgroup of a power of an elliptic curve

Let `E/K` be an elliptic curve over a number field containing all
`ell`-torsion points.  Fix a basis

\[
 E[\ell]\simeq F_\ell^2.
\]

The subgroup

\[
 H_T\subset E[\ell]^g=E^g[\ell]
\]

is defined over `K` and has order `ell^g`.  Therefore the quotient

\[
 \phi_T:E^g\longrightarrow A_T:=E^g/H_T
\]

is a global isogeny of degree `ell^g`.

At a multiplicative place `w`, the connected or canonical Tate subgroup is a
line

\[
 L_w\subset E[\ell].
\]

Theorem 2.1 gives

\[
 H_T\cap L_w^g=0
\]

for every place, independently of which projective Galois conjugate occurs as
`L_w`.  Thus the same global kernel is noncanonical in every multiplicative
localization.

## 4. Local Tate quotient

Assume locally that `E=E_q` is split Tate, that `mu_ell` and `q^(1/ell)` are
present, and use the Tate exact sequence

\[
 0\longrightarrow\mu_\ell
 \longrightarrow E_q[\ell]
 \longrightarrow\mathbb Z/\ell\mathbb Z
 \longrightarrow0.
\]

For `E_q^g`, the canonical subgroup is `mu_ell^g`.  Any complement `H` to it
projects isomorphically to `(Z/ell Z)^g`.  Choosing lifts, the quotient period
lattice is obtained from `q^{Z^g}` by adjoining `g` vectors of the form

\[
 \zeta^{T e_i}q^{e_i/\ell}.
\]

The root-of-unity factors have norm one.  Hence, on the tropical skeleton, the
period lattice changes from

\[
 v(q)\mathbb Z^g
 \quad\text{to}\quad
 \frac{v(q)}\ell\mathbb Z^g.
\]

### Theorem 4.1 (uniform local q-root quotient)

At every split multiplicative place of `K`, the isogeny `phi_T` is of q-root
type in all `g` toric directions.  Its tropical covolume is `ell^(-g)` times
that of `E^g`.

For nonsplit multiplicative reduction, the same statement holds after the
standard unramified splitting extension.  For potentially multiplicative
reduction, it holds after the standard quadratic twist/splitting extension;
the central sign does not alter the projective canonical line.

## 5. Why this avoids the fixed-line no-go theorem

For `g=1`, a global line is canonical at some projective conjugate, and the
canonical/noncanonical contributions cancel after averaging.  For `g>=2`, the
subspace `H_T` is complementary to **every** diagonal canonical subspace
`L^g`.  Thus no conjugate place turns the kernel into the q-power direction.

The construction uses higher-dimensional linear algebra rather than selecting
one preferred projective line.  It is therefore not covered by the previously
proved fixed-packet or `1/(ell+1)` selector no-go theorems.

## 6. The unavoidable compensation problem

The existence of `phi_T` does not yet prove `abc`.  Stable Faltings height is
nearly invariant under an isogeny of fixed degree:

\[
 |h_F(A_T)-g h_F(E)|\le \frac g2\log\ell.
\]

Since the finite tropical discriminant contribution of `A_T` is smaller at
every multiplicative place, an opposite contribution must appear in one or
more of the following:

1. the integral closure of `H_T` in semistable models;
2. places above `ell`;
3. the different of the full torsion field;
4. archimedean theta determinants;
5. the failure of the quotient polarization to remain principal.

This is not a defect of the transversality theorem; it identifies the exact
compensation term that a global proof must estimate.

## 7. Exact surviving theorem

A proof of `abc` through this route is reduced to the following classical
statement.

### Target theorem 7.1 (transverse-isogeny compensation)

For the Frey--Legendre curve and a quantifier-correct prime `ell`, choose
`g=2` and a universally transverse `H_T`.  Prove that the normalized total
compensation outside the multiplicative tropical term is bounded by

\[
 (1+o_{\ell\to\infty}(1))
 \log\operatorname{rad}(abc)+O(\log\ell),
\]

with the coefficient normalized so that the tropical improvement yields

\[
 \frac16Q
 \le(1+o(1))\log\operatorname{rad}(abc)+O(\log\ell).
\]

The actual Picard--Lefschetz package and cyclotomic selector provide an `ell`
with full image and `log ell=o(log c)`.  Thus Target theorem 7.1 would imply
`abc` by the already verified final absorption chain.

Theorem 2.1 and the local lattice computation are unconditional.  Target
7.1 remains open and is now the principal global estimate on this route.
