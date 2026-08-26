# A finite Heisenberg--Fourier bridge for transverse theta structures

## 1. Motivation

The universally transverse subgroup route radicalizes every finite Tate
monodromy exponent, but an exact archimedean/boundary compensation theorem is
still missing.  The classical theta-group representation supplies a more
rigid comparison than a generic Faltings-height inequality.

For a principally polarized abelian variety with full level-`ell` theta
structure, two transverse maximal isotropic subgroups give two Schrödinger
bases of the same theta space.  Their change-of-basis matrix is a finite
Fourier transform.  After the canonical `ell^(-g/2)` normalization this matrix
is unitary at every complex embedding.  Hence the archimedean comparison cost
is exactly level-sized, not an uncontrolled multiple of the input height.

This note proves the finite linear-algebra theorem and isolates the remaining
integral theta-lattice theorem needed for the abc route.

Throughout, `ell` is an odd prime and `zeta` is a primitive `ell`-th root of
unity.

## 2. The one-dimensional Fourier matrix

Let

\[
 F_\ell=(\zeta^{ij})_{0\le i,j<\ell}.
\]

### Theorem 2.1 (orthogonality)

\[
 \boxed{F_\ell\,\overline{F_\ell}^{\,t}=\ell I_\ell.}
\tag{2.1}
\]

#### Proof

The `(i,k)` entry is

\[
 \sum_{j=0}^{\ell-1}\zeta^{(i-k)j}.
\]

If `i=k`, this is `ell`.  If `i!=k`, primitivity of `zeta` makes
`zeta^(i-k)` a nontrivial `ell`-th root of unity, and the geometric sum is
zero.

### Corollary 2.2 (determinant size)

For every complex embedding,

\[
 \boxed{|\det F_\ell|=\ell^{\ell/2}.}
\tag{2.2}
\]

Indeed, taking determinants in (2.1) gives

\[
 |\det F_\ell|^2=\ell^\ell.
\]

Thus

\[
 U_\ell=\ell^{-1/2}F_\ell
\]

is unitary.

## 3. The genus-two transform

For the abelian surface route the relevant matrix is the tensor Fourier
transform

\[
 F_\ell^{(2)}=F_\ell\otimes F_\ell,
\]

of size `ell^2`.

### Theorem 3.1

\[
 F_\ell^{(2)}\,
 \overline{F_\ell^{(2)}}^{\,t}
 =\ell^2 I_{\ell^2},
\tag{3.1}
\]

and

\[
 \boxed{
 |\det F_\ell^{(2)}|=\ell^{\ell^2}.}
\tag{3.2}
\]

#### Proof

Equation (3.1) follows from (2.1) and

\[
 (A\otimes B)(C\otimes D)=AC\otimes BD.
\]

For square matrices of sizes `m,n`,

\[
 \det(A\otimes B)=\det(A)^n\det(B)^m.
\]

Taking `A=B=F_ell` and `m=n=ell`, Corollary 2.2 gives (3.2).
The normalized matrix

\[
 U_\ell^{(2)}=\ell^{-1}F_\ell^{(2)}
\]

is unitary.

Per theta coordinate, the logarithmic determinant cost is exactly

\[
 \frac1{\ell^2}\log|\det F_\ell^{(2)}|=\log\ell.
\tag{3.3}
\]

This is absorbable for the quantifier-correct choices
`log ell=o(log c)` already present in the repository.

## 4. Theta-group interpretation

Let `(A,lambda)` be a principally polarized abelian variety of dimension `g`
over a field containing `mu_ell`, and let `L` represent the polarization.
The finite theta group of `L^ell` is a Heisenberg extension of `A[ell]`.
A maximal isotropic subgroup `M subset A[ell]` determines a Schrödinger basis
of

\[
 H^0(A,L^\ell),
\]

indexed by a complementary Lagrangian.  If `M` and `M'` are transverse, the
Stone--von Neumann theorem identifies the basis change with the finite Fourier
transform for the perfect Weil-pairing duality

\[
 M\times M'\longrightarrow\mu_\ell.
\]

For `A=E^2`, the symmetric universally transverse graph kernel constructed in
the repository is maximal isotropic for the product polarization and
complementary to `L_p^2` for every Tate inertia line `L_p`.  Hence at every
multiplicative localization, the canonical Tate theta basis and the
`H_T`-quotient theta basis are related by `F_ell^(2)`, up to diagonal root-of-
unity and theta-trivialization factors.

The root-of-unity factors are unitary at infinity and units away from `ell`.
The diagonal theta-trivialization factors are precisely the objects computed
by the cyclic kernel-polynomial and Tate theta-distribution branches.

## 5. Why this improves the compensation problem

A generic comparison of Faltings heights only says that an `ell^2`-isogeny
changes the height by `O(log ell)`, but it does not identify which local terms
compensate the tropical radicalization.  The Fourier theorem supplies an exact
comparison of the **theta bases themselves**:

1. at complex places, the normalized basis change is unitary;
2. its unnormalized determinant contributes exactly `ell^2 log ell`, or
   `log ell` per coordinate;
3. at good finite places away from `ell`, the kernel section and determinant
   complex are integral units;
4. at multiplicative places, ultrametric dominance and the exact theta
   distribution formulas compute the diagonal q-weights;
5. the full torsion-field root-discriminant estimate bounds descent and
   integral-lattice defects by conductor plus `O(log ell)`.

Thus the remaining problem is no longer an arbitrary archimedean theta bound.
It is an integral comparison between two explicit theta lattices whose complex
change matrix is already unitary.

## 6. The exact surviving theorem

### Target theorem 6.1 (integral Fourier theta-lattice comparison)

For the Frey--Legendre curve `E`, choose a quantifier-correct prime `ell` and a
symmetric universally transverse maximal isotropic subgroup

\[
 H_T\subset E[\ell]^2.
\]

Let

\[
 \phi:E^2\longrightarrow A_T=E^2/H_T
\]

be the induced principally polarized isogeny.  Construct integral theta
lattices

\[
 \mathscr H_E
 \subset H^0(E^2,L_E^\ell),
 \qquad
 \mathscr H_T
 \subset H^0(A_T,L_T)
\]

and a pullback identification with the following properties.

1. **Complex Fourier isometry.**  After the standard `ell^{-1}` normalization,
   the pullback matrix at every complex embedding is `U_ell^(2)` times diagonal
   unitary factors.
2. **Good-place integrality.**  Away from the conductor and `ell`, both
   lattices and the pullback matrix are unimodular.
3. **Multiplicative diagonal terms.**  At a multiplicative prime `p`, the
   elementary divisors of the diagonal factor are the explicit cyclic Tate
   theta weights; transversality replaces each toric exponent `N_p` by
   `N_p/ell<1` on the quotient side.
4. **Level and descent defect.**  After normalized degree, the determinant of
   all remaining lattice changes is

   \[
   O(\log\ell)+
   (1+o(1))\log\operatorname{rad}(N_E).
   \]
5. **Boundary-form compatibility.**  The determinant comparison is compatible
   with a Siegel/toroidal boundary section whose restriction to the product
   locus is the appropriate power of the elliptic discriminant.

These statements would turn the product formula for the determinant of the
pullback matrix into

\[
 \frac16Q
 \le
 (1+o(1))(D+N)+O(\log\ell),
\]

and hence prove `ABCConjecture` by the already verified downstream absorption.

## 7. New finite subproblems

Target theorem 6.1 is decomposed into concrete pieces.

1. Formalize the finite Fourier orthogonality theorem and tensor determinant.
2. Construct the finite Heisenberg representation and its two Lagrangian
   Schrödinger bases.
3. Identify the repository's symmetric graph kernel with one Lagrangian.
4. Prove the nonarchimedean theta-basis distribution using the exact product
   identities already established mathematically.
5. Compare the integral theta lattices at `ell` using finite-flat theta-group
   theory.
6. Choose and normalize the genus-two boundary modular form.

The first three are finite algebra/representation theory.  The fourth has an
explicit product proof.  The last two are the remaining arithmetic-geometric
source problems.

## 8. Relation to previous no-go theorems

This route is not a fixed linear packet and is not a generic Minkowski
selector.  Its kernel is transverse to every local inertia line, while its
archimedean comparison is a unitary Fourier transform.  It is also not the
invalid Hodge-line shortcut: the comparison uses a boundary theta determinant,
not only invariant differentials.

A future no-go theorem would need to show that the integral theta-lattice
comparison necessarily contains a non-absorbable boundary or level defect.
The finite Fourier theorem itself has no such defect beyond `log ell` per
coordinate.

## 9. Formalization plan

The first Lean module should prove, for a primitive `ell`-th root of unity,

\[
 \sum_{j<\ell}\zeta^{(i-k)j}
 =\begin{cases}\ell,&i=k,\\0,&i\ne k,\end{cases}
\]

then package the Fourier matrix identity.  Mathlib already contains primitive
roots, finite geometric sums, matrices and Kronecker products.  No unresolved
arithmetic estimate is needed for this finite layer.
