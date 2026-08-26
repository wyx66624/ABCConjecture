# Anti-symplectic universally transverse kernels

## 1. Polarization audit

Let `V=F^2` over a field of odd characteristic, with the standard alternating
form

\[
  \omega(x,y)=x_1y_2-x_2y_1.
\]

The product principal polarization on `E^2[ell]=V\oplus V` induces

\[
  \Omega((x_1,x_2),(y_1,y_2))
  =\omega(x_1,y_1)+\omega(x_2,y_2).
\]

For a linear map `T:V->V`, put

\[
  H_T=\{(x,Tx):x\in V\}.
\]

### Proposition 1.1

The graph `H_T` is isotropic for the product polarization if and only if

\[
  \omega(Tx,Ty)=-\omega(x,y)
\]

for all `x,y`; in dimension two this is equivalent to

\[
  \det T=-1.
\]

### Proof

For graph vectors,

\[
  \Omega((x,Tx),(y,Ty))
  =\omega(x,y)+\omega(Tx,Ty).
\]

For every `2 x 2` matrix,

\[
  \omega(Tx,Ty)=\det(T)\omega(x,y).
\]

Since `omega` is nonzero, the displayed sum vanishes identically exactly when
`1+det(T)=0`.

## 2. Counterexample to the symmetric-cross-pairing shortcut

A symmetric matrix is isotropic for the **cross** form

\[
  x^Ty'-y^Tx',
\]

but this is not the product Weil pairing on `E^2[ell]`.

Over `F_5`, take `i=2`, `nu=2`, and

\[
  a=(1+\nu)/2=4,
  \qquad
  b=(1-\nu)/(2i)=1,
\]

so

\[
  T=\begin{pmatrix}4&1\\1&1\end{pmatrix},
  \qquad T^2=2I.
\]

Since `2` is a nonsquare in `F_5`, this `T` has no eigenline and its graph is
universally transverse.  But

\[
  \det T=3\ne-1=4\pmod5.
\]

Taking `x=(1,0)`, `y=(0,1)`, one gets

\[
  \Omega((x,Tx),(y,Ty))
  =(1+\det T)\omega(x,y)=4\ne0.
\]

Thus the symmetric construction does **not** provide a maximal-isotropic
kernel for the product polarization.  This is a strict counterexample to that
specific polarization claim.  Universal transversality itself remains valid.

## 3. Corrected anti-symplectic companion

For `t in F`, define

\[
  T_t=\begin{pmatrix}0&1\\1&t\end{pmatrix}.
\]

Then

\[
  \det T_t=-1,
\]

so `T_t` is anti-symplectic and `H_{T_t}` is isotropic for the product
polarization.

Its characteristic polynomial is

\[
  X^2-tX-1,
\]

with discriminant

\[
  \Delta_t=t^2+4.
\]

### Theorem 3.1

If `t^2+4` is not a square in `F`, then:

1. `T_t` has no eigenline over `F`;
2. `H_{T_t}` is complementary to `L^2` for every line `L subset V`;
3. `H_{T_t}` is maximal isotropic for the product symplectic form.

### Proof

The first assertion follows from irreducibility of the characteristic
polynomial.  For a finite-slope line

\[
  L_\lambda=F(1,\lambda),
\]

a vector in `H_{T_t} intersect L_lambda^2` gives an eigenvector of `T_t` with
eigenvalue `lambda`.  The vertical line is handled directly.  Thus every
intersection is zero; both spaces have dimension two, hence they are
complementary.  Finally `det T_t=-1` gives isotropy by Proposition 1.1, and a
two-dimensional isotropic subspace of a four-dimensional symplectic space is
maximal isotropic.

## 4. Existence over the selected finite fields

Let `F=F_q` with `q` odd.  For the quadratic character `chi`, the classical
quadratic character sum is

\[
  \sum_{t\in F}\chi(t^2-a)=-1
  \qquad(a\ne0).
\]

Apply this with `a=-4`.  If `q=1 mod 4`, then `t^2+4` vanishes for exactly two
values of `t`.  If `N_+` and `N_-` count nonzero square and nonsquare values of
`t^2+4`, then

\[
  N_++N_-=q-2,
  \qquad N_+-N_-=-1.
\]

Hence

\[
  N_-=(q-1)/2>0.
\]

In particular, every auxiliary prime

\[
  \ell\equiv1\pmod{12}
\]

admits many parameters `t` for which `T_t` satisfies Theorem 3.1.

## 5. Polarized quotient

Let `E/K` be an elliptic curve with rational `ell`-torsion.  Choose a
symplectic basis of `E[ell]` and a parameter `t` as above.  The graph subgroup

\[
  H_{T_t}\subset E[\ell]^2
\]

is a maximal-isotropic finite subgroup scheme for the product Weil pairing.
Therefore the quotient

\[
  \phi_t:E^2\longrightarrow A_t=E^2/H_{T_t}
\]

carries a principal polarization `lambda_t` satisfying

\[
  \phi_t^*\lambda_t=\ell\lambda_{\rm prod}.
\]

At every multiplicative place, `H_{T_t}` is complementary to the diagonal
canonical subgroup `L_w^2`; hence the local Tate period lattice is of q-root
type in both toric directions.

## 6. Updated research boundary

The corrected construction closes simultaneously:

- universal transversality to every Tate inertia line;
- maximal isotropy for the **actual product polarization**;
- compatibility with auxiliary primes `ell=1 mod 12`.

The remaining theorem is global and arithmetic: quantify the compensation in
the principally polarized quotient between the reduced tropical boundary and
its integral, level-prime and archimedean theta contributions.  No Faltings-
height-only argument can do this, because a prime-to-p etale isogeny induces
an isomorphism on invariant differential lattices at the multiplicative
places.
