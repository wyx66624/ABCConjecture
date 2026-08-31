# An exact theta average over irreducible symmetric graph kernels

## 1. Purpose

The universally transverse genus-two route constructs, for a symmetric
matrix `T` over `F_ell` with no ground-field eigenline, a maximal-isotropic
graph subgroup of `E[ell]^2`.  Its quotient has the exact complex period matrix
computed in the transverse-period branch.  The remaining archimedean question
was whether one can choose a transverse kernel whose theta value is not
exponentially small.

For primes

\[
  \ell\equiv3\pmod4,
\]

this note proves an exact average identity over **all irreducible symmetric
kernels**.  The average is a positive theta series at the dilated period
`ell*tau`.  Consequently, for a rectangular elliptic period `tau=iy`, at least
one universally transverse kernel has a second-order genus-two theta constant
of real part at least one.

This is a classical finite-Fourier theorem.  It does not use IUT and it does
not yet provide the required integral boundary modular form or global
height--conductor estimate.

## 2. Symmetric matrices and irreducibility

Let

\[
  F=\mathbb F_\ell,
  \qquad \ell\equiv3\pmod4.
\]

Then `-1` is not a square in `F`.  Parametrize every symmetric matrix by

\[
 T(u,v,w)=
 \begin{pmatrix}
  u+v&w\\
  w&u-v
 \end{pmatrix},
 \qquad u,v,w\in F.
\tag{2.1}
\]

Its characteristic polynomial is

\[
 X^2-2uX+(u^2-v^2-w^2),
\]

whose discriminant is

\[
 \boxed{4(v^2+w^2).}
\tag{2.2}
\]

Because `4` is a square, the characteristic polynomial is irreducible exactly
when

\[
  v^2+w^2
\]

is a nonsquare.  Let

\[
 \mathcal I_\ell=
 \{T(u,v,w):v^2+w^2\text{ is a nonsquare}\}.
\tag{2.3}
\]

Every `T in I_ell` has no eigenline over `F`.  Since it is symmetric, its graph
in the regrouped symplectic coordinates of `E[ell]^2` is maximal isotropic and
is transverse to `L^2` for every cyclic line `L subset E[ell]`.  Thus every
member of `I_ell` is a universally transverse graph kernel.

## 3. Counting the kernel packet

Let `i` satisfy `i^2=-1` in `F_(ell^2)`.  The norm map is

\[
 N(v+iw)=v^2+w^2.
\]

For every nonzero `t in F`, the norm fibre has cardinality `ell+1`, because the
kernel of

\[
 F_{\ell^2}^{\times}\longrightarrow F_\ell^{\times}
\]

has cardinality

\[
 \frac{\ell^2-1}{\ell-1}=\ell+1.
\]

Exactly `(ell-1)/2` nonzero elements of `F` are nonsquares.  Hence

\[
 \#\{(v,w):v^2+w^2\text{ is a nonsquare}\}
 =\frac{\ell^2-1}{2}.
\tag{3.1}
\]

The parameter `u` is free, so

\[
 \boxed{
  |\mathcal I_\ell|
  =\frac{\ell(\ell^2-1)}2.}
\tag{3.2}
\]

## 4. Exact finite Fourier orthogonality

Fix the standard nontrivial additive character

\[
 \mathbf e_\ell(t)=
 \exp\left(\frac{2\pi i}{\ell}\widetilde t\right),
\]

where `tilde t` is any integer representative of `t in F`.

For `z=(x,y) in F^2`, define

\[
 q_T(z)=z^tTz.
\]

In the parametrization (2.1),

\[
 q_{T(u,v,w)}(x,y)
 =u(x^2+y^2)+v(x^2-y^2)+2wxy.
\tag{4.1}
\]

### Lemma 4.1 (anisotropy)

If `(x,y) != (0,0)`, then

\[
 x^2+y^2\ne0.
\tag{4.2}
\]

#### Proof

If `y=0`, then `x^2+y^2=0` implies `x=0`.  If `y!=0`, the same equality would
imply

\[
 (x/y)^2=-1,
\]

contrary to the fact that `-1` is a nonsquare.

### Theorem 4.2 (irreducible-symmetric orthogonality)

For every `z in F^2`,

\[
 \boxed{
 \sum_{T\in\mathcal I_\ell}
  \mathbf e_\ell(q_T(z))
 =
 \begin{cases}
  |\mathcal I_\ell|,&z=0,\\
  0,&z\ne0.
 \end{cases}}
\tag{4.3}
\]

#### Proof

The zero case is immediate.  Suppose `z=(x,y)` is nonzero.  For every fixed
pair `(v,w)` with nonsquare norm, sum first over `u`.  Equation (4.1) gives

\[
 \begin{aligned}
 &\sum_{u\in F}
 \mathbf e_\ell\bigl(
  u(x^2+y^2)+v(x^2-y^2)+2wxy
 \bigr)\\
 &\qquad=
 \mathbf e_\ell\bigl(v(x^2-y^2)+2wxy\bigr)
 \sum_{u\in F}\mathbf e_\ell(u(x^2+y^2)).
 \end{aligned}
\]

By Lemma 4.1, the coefficient of `u` is nonzero.  The last character sum is
therefore zero.  Summing over `(v,w)` proves (4.3).

The important point is that no cancellation estimate is used: the identity is
exact and holds after restricting to the irreducible symmetric kernels.

## 5. Exact analytic theta average

For `tau` in the upper half-plane and `T in I_ell`, define the second-order
rank-two theta series

\[
 \Theta_T^{(2)}(\tau)
 =\sum_{n\in\mathbb Z^2}
  \exp\left(
   \frac{2\pi i}{\ell}
   \bigl(\tau(n_1^2+n_2^2)+n^tTn\bigr)
  \right).
\tag{5.1}
\]

The phase `n^tTn` is interpreted modulo `ell`, so the definition is independent
of the chosen integer lift of `T`.  Absolute convergence follows from
`Im(tau)>0`.

Let

\[
 \vartheta_2(\tau)
 =\sum_{m\in\mathbb Z^2}
   \exp\bigl(2\pi i\tau(m_1^2+m_2^2)\bigr).
\tag{5.2}
\]

### Theorem 5.1 (exact transverse theta average)

\[
 \boxed{
 \sum_{T\in\mathcal I_\ell}
  \Theta_T^{(2)}(\tau)
 =|\mathcal I_\ell|\,\vartheta_2(\ell\tau).}
\tag{5.3}
\]

#### Proof

Absolute convergence permits interchange of the finite `T`-sum and the
integer-lattice sum.  For fixed `n`, reduce `n` modulo `ell`.  The inner sum is
given by Theorem 4.2.  It vanishes unless

\[
 n\equiv(0,0)\pmod\ell.
\]

Writing `n=ell*m` in the surviving terms gives

\[
 \frac1\ell\tau(n_1^2+n_2^2)
 =\ell\tau(m_1^2+m_2^2),
\]

which is exactly (5.3).

## 6. A universally transverse kernel with a non-small theta value

For a positive real number `y`, set `tau=iy`.  Then

\[
 \vartheta_2(i\ell y)
 =\sum_{m\in\mathbb Z^2}
  e^{-2\pi\ell y(m_1^2+m_2^2)}
 >1.
\tag{6.1}
\]

### Corollary 6.1

For every `y>0`, there exists `T in I_ell` such that

\[
 \boxed{
  \operatorname{Re}\Theta_T^{(2)}(iy)
  \ge\vartheta_2(i\ell y)>1.}
\tag{6.2}
\]

In particular,

\[
 |\Theta_T^{(2)}(iy)|>1.
\]

#### Proof

Divide (5.3) by `|I_ell|`.  Its right side is the positive real number in
(6.1).  At least one summand must have real part at least the average.

For a positive Frey--Legendre parameter `0<lambda<1`, the real elliptic curve
has three real branch points and admits a rectangular period basis
`tau=iy`.  Thus Corollary 6.1 applies directly to the archimedean period of the
positive abc specialization.

## 7. Relation to the transverse quotient period matrix

The transverse-period branch computes a quotient period matrix of the form

\[
 \Omega_T=\frac{T+\tau I_2}{\ell}.
\]

With the convention

\[
 \theta(0,\Omega)
 =\sum_n e^{\pi i n^t\Omega n},
\]

our series is

\[
 \Theta_T^{(2)}(\tau)=\theta(0,2\Omega_T).
\]

It is therefore a second-order theta constant of the transverse graph
quotient.  The theorem proves exact average nonvanishing in the doubled theta
linear system.  A complete abc source still has to connect this second-order
section to an integral boundary modular form or determinant packet with the
required `Q/6` normalization.

## 8. What this closes and what remains

This theorem closes a genuine part of the archimedean problem:

1. the average is taken only over universally transverse maximal-isotropic
   graph kernels;
2. it is exact, not asymptotic equidistribution;
3. it gives an individual kernel with a uniform lower bound;
4. it works for every rectangular period, including the positive
   Frey--Legendre specialization;
5. it has no field-degree or orbit-size loss after normalization.

It does **not** yet prove abc.  The remaining source theorem is now:

### Target theorem 8.1 (integral boundary comparison)

Construct a Galois-invariant integral section from the second-order transverse
theta packet such that:

1. its nonarchimedean tropical divisor records the full multiplicative
   `q`-weight with coefficient compatible with `1/6`;
2. it is a unit at good finite places away from `ell`;
3. the level-prime and descent defect is `O(log ell)` after normalized degree;
4. its archimedean norm is controlled from below by Corollary 6.1;
5. its arithmetic degree is bounded above by conductor and different with
   leading coefficient `1+o(1)`.

The exact Fourier average removes the need for an unproved Hecke
archimedean-equidistribution theorem on this subroute.  The decisive remaining
work is the algebraic/integral identification of the second-order theta section
with a boundary form.

## 9. Formalization order

The Lean development is split into layers.

1. the scalar identity for the discriminant of `T(u,v,w)`;
2. anisotropy of `x^2+y^2` from nonsquareness of `-1`;
3. abstract finite-character cancellation after summing over `u`;
4. counting `I_ell` through the norm map;
5. finite Fourier orthogonality;
6. absolutely convergent theta-series interchange;
7. the positive-real averaging corollary.

The first three layers are implemented together with this note.  No analytic
or arithmetic source theorem is inserted as an axiom.
