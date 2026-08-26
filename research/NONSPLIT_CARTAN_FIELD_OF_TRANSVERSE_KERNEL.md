# The nonsplit-Cartan field of the universally transverse kernel

## 1. Stabilizer of the graph subgroup

Let `F=F_ell`, let `T in M_2(F)` have irreducible characteristic polynomial

\[
  X^2-sX+t,
\]

so that

\[
  T^2=sT-tI.
\]

Inside `V^2 = F^2 \oplus F^2`, put

\[
  H_T=\{(x,Tx):x\in F^2\}.
\]

The group `GL_2(F)` acts diagonally on the two copies of `V`; in the
`F^2 \oplus F^2` coordinates this sends

\[
 (X,Y)\longmapsto(aX+bY,cX+dY)
\]

for `g=[[a,b],[c,d]]`.

### Theorem 1.1

The stabilizer of `H_T` is

\[
 C_T=
 \left\{
 \begin{pmatrix}
 a&b\\
 -bt&a+bs
 \end{pmatrix}:
 a+bT\ne0
 \right\},
\]

and the map

\[
 F[T]^\times\longrightarrow C_T
\]

is an isomorphism.  In particular,

\[
 C_T\simeq\mathbb F_{\ell^2}^\times,
 \qquad |C_T|=\ell^2-1.
\]

### Proof

The equality `g(H_T)=H_T` is equivalent to

\[
 cI+dT=T(aI+bT)=aT+bT^2.
\]

Using `T^2=sT-tI`, this is equivalent to

\[
 c=-bt,
 \qquad d=a+bs.
\]

These are precisely the matrices of multiplication by the nonzero elements
`a+bT` of the quadratic field `F[T]`.

### Corollary 1.2

The orbit of `H_T` under `GL_2(F)` has size

\[
 \frac{|GL_2(F)|}{\ell^2-1}=\ell(\ell-1).
\]

Thus the subgroup and the quotient abelian surface are defined over the
nonsplit-Cartan orbit field of degree at most `ell(ell-1)`, rather than only
over the full `ell`-torsion field of degree about `ell^4`.

## 2. Tame inertia in the orbit field

Let `p != ell` be a multiplicative prime of a semistable elliptic curve, and
assume the inertia image contains a nontrivial transvection.  Such an element
has order `ell`.

The nonsplit Cartan `C_T` has order `ell^2-1`, which is prime to `ell`.
Therefore no nontrivial transvection fixes `H_T`.  On the orbit
`GL_2(F)/C_T`, inertia acts freely in orbits of length `ell`.

The orbit degree is `n=ell(ell-1)`, so the number of inertia orbits is
`n/ell=ell-1`.  For a tame permutation extension, the discriminant exponent is

\[
 n-\#\{\text{inertia orbits}\}
 =\ell(\ell-1)-(\ell-1)
 =(\ell-1)^2.
\]

After normalization by the field degree, the contribution is exactly

\[
 \boxed{
 \frac{(\ell-1)^2}{\ell(\ell-1)}\log p
 =\left(1-\frac1\ell\right)\log p.}
\]

## 3. Global root-discriminant estimate

Let `L_T` be the field of definition of `H_T`.  At every good prime distinct
from `ell`, the torsion representation is unramified.  At every multiplicative
prime, Section 2 gives the normalized tame contribution.  If `ell` is chosen
outside the conductor, the standard finite-flat ramification theorem at the
level prime contributes `O(log ell)`.

Hence the expected sharp global estimate is

\[
 \boxed{
 \log\operatorname{rd}(L_T)
 \le
 \left(1-\frac1\ell\right)
 \log\operatorname{rad}(N_E)
 +O(\log\ell).}
\]

The tame part and the orbit degree are completely explicit.  A final proof
must state the precise finite-flat constant at `ell` rather than hiding it in
an unrestricted local-field discriminant estimate.

## 4. Research consequence

The universally transverse isogeny can be formed over a degree
`ell(ell-1)` orbit field with the correct conductor-plus-log-level
root-discriminant shape.  Therefore the field-of-definition cost is not the
remaining conceptual obstruction.

The decisive term is the arithmetic compensation between:

- the factor-`ell` reduction of every multiplicative tropical period; and
- the archimedean, integral-kernel, polarization, and level-prime terms in the
  global height of the quotient abelian surface.

This makes the transverse-isogeny compensation theorem a concrete
nonsplit-Cartan Arakelov problem.
