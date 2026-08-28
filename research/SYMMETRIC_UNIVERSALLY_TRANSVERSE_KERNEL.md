# A symmetric maximal-isotropic kernel transverse to every Tate line

## 1. Purpose

The first universally transverse graph used an operator with irreducible
quadratic polynomial.  For the quotient of `E^2` to inherit a principal
polarization, the graph must also be maximal isotropic for the product Weil
pairing.  This note gives an explicit symmetric operator satisfying both
requirements at every auxiliary prime

\[
  \ell\equiv1\pmod{12}.
\]

## 2. Explicit symmetric operator

Let `F=F_ell`, assume `ell` is odd and `-1` is a square in `F`, and choose

\[
  i\in F,\qquad i^2=-1.
\]

Choose a nonsquare `nu in F^x`.  Put

\[
  a=\frac{1+\nu}{2},
  \qquad
  b=\frac{1-\nu}{2i},
\]

and define

\[
 T=
 \begin{pmatrix}
  a&b\\
  b&-a
 \end{pmatrix}.
\]

### Lemma 2.1

\[
  a^2+b^2=\nu,
  \qquad
  T^2=\nu I_2.
\]

### Proof

Since `i^2=-1`,

\[
 b^2=-\frac{(1-\nu)^2}{4}.
\]

Therefore

\[
 a^2+b^2
 =\frac{(1+\nu)^2-(1-\nu)^2}{4}
 =\nu.
\]

The off-diagonal entries of `T^2` are `ab-ab=0`, while both diagonal entries
are `a^2+b^2`.

### Corollary 2.2

`T` has no eigenvalue in `F`.

Indeed, if `Tx=lambda x` for nonzero `x`, then

\[
 \nu x=T^2x=\lambda^2x,
\]

so `nu=lambda^2`, contradicting that `nu` is a nonsquare.

## 3. Universal transversality

Identify

\[
 E[\ell]^2\simeq F^2\oplus F^2
\]

relative to a symplectic basis of `E[ell]`, and define

\[
 H_T=\{(x,Tx):x\in F^2\}.
\]

For a line `L subset F^2`, let `L^2` denote its diagonal two-copy subspace.
Exactly as in the general graph theorem, an intersection with a finite-slope
line gives `Tx=lambda x`, while the vertical line forces `x=0`. Hence

\[
 H_T\cap L^2=0
\]

for every line `L`, and dimension counting gives

\[
 H_T\oplus L^2=F^4.
\]

## 4. Maximal isotropy

On `F^2\oplus F^2`, write the product symplectic form as

\[
 \Omega((x,y),(x',y'))
 =x^ty'-y^tx'.
\]

### Theorem 4.1

`H_T` is maximal isotropic.

### Proof

For graph vectors,

\[
 \Omega((x,Tx),(x',Tx'))
 =x^tTx'-(Tx)^tx'
 =x^t(T-T^t)x'=0,
\]

because `T` is symmetric.  The graph has dimension two, half the dimension of
the ambient symplectic space.

## 5. Polarized quotient

Let `(E^2,lambda_prod)` carry the product principal polarization.  If the full
`ell`-torsion is rational over a field `K`, the subgroup scheme corresponding
to `H_T` is defined over `K`, is maximal isotropic for the `ell`-Weil pairing,
and therefore the quotient

\[
 \phi_T:E^2\longrightarrow A_T=E^2/H_T
\]

admits a principal polarization `lambda_T` satisfying

\[
 \phi_T^*\lambda_T=\ell\lambda_{\rm prod}.
\]

Thus the universal-transversality construction does not leave an uncontrolled
polarization defect.  The remaining compensation is confined to the integral
kernel closure, level-prime ramification, archimedean theta norm, and the
isogeny/Faltings-height formula.

## 6. Compatibility with the cyclotomic selector

The repository's auxiliary-prime theorem produces

\[
 \ell\equiv1\pmod{12}.
\]

Hence `ell` is odd and `-1` is a square in `F_ell`.  Every finite field of odd
order has nonsquares, so the construction applies to exactly the primes
selected for the actual two-inertia route.

The finite-group, local-Tate, field-of-definition and principal-polarization
parts of the transverse-isogeny route are therefore mutually compatible.
The decisive open problem remains the sharp global arithmetic compensation
estimate.
