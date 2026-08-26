# Steinberg packet interpolation by the `(ell-1)`-st symmetric power

## 1. Purpose

The fixed linear average of cyclic Tate-line energies vanishes, while the
nonlinear Steinberg/sup packet retains the canonical coordinate.  The remaining
global problem is to relate that packet to a conventional automorphic or Hodge
bundle whose arithmetic slope can be estimated.

This note supplies a canonical finite-field bridge.  For a prime `ell`, the
permutation module on the cyclic lines of a two-dimensional `F_ell`-space,
modulo its constant line, is explicitly isomorphic to

\[
  \operatorname{Sym}^{\ell-1}(V^\vee).
\]

The construction is elementary, `GL_2(F_ell)`-equivariant, and has an integral
lift whose archimedean operator cost is `O(ell log ell)`.  This identifies the
precise representation-theoretic object into which a descended theta packet
must map.

It does not by itself identify the packet metric with the Hodge metric.  That
remaining comparison is isolated in Section 8.

## 2. The canonical interpolation map

Let

\[
  k=\mathbf F_\ell,
  \qquad V=k^2,
  \qquad \mathbb P(V)=\mathbb P^1(k),
\]

where `ell` is an odd prime.  Fix the alternating form

\[
  [v,w]=\det(v,w).
\]

For a line `L in P(V)`, choose any nonzero `v in L` and define the homogeneous
polynomial

\[
  \phi_L(w)=[v,w]^{\ell-1}
  \in \operatorname{Sym}^{\ell-1}(V^\vee).
\]

### Lemma 2.1 (well-definedness)

The polynomial `phi_L` is independent of the chosen nonzero vector `v in L`.

### Proof

Another generator is `lambda v` with `lambda in k^x`.  Fermat gives

\[
  \lambda^{\ell-1}=1,
\]

hence

\[
  [\lambda v,w]^{\ell-1}
  =\lambda^{\ell-1}[v,w]^{\ell-1}
  =[v,w]^{\ell-1}.
\]

Thus there is a linear map

\[
 \Phi_\ell:
 k[\mathbb P(V)]
 \longrightarrow
 \operatorname{Sym}^{\ell-1}(V^\vee),
 \qquad e_L\longmapsto\phi_L.
 \tag{2.1}
\]

## 3. Equivariance

Let `g in GL(V)` act on homogeneous polynomials by

\[
  (g\cdot f)(w)=f(g^{-1}w).
\]

### Lemma 3.1

The map `Phi_ell` is `GL(V)`-equivariant.

### Proof

For a generator `v` of `L`,

\[
 \begin{aligned}
  \phi_{gL}(w)
   &=[gv,w]^{\ell-1}\\
   &=\det(g)^{\ell-1}[v,g^{-1}w]^{\ell-1}\\
   &=[v,g^{-1}w]^{\ell-1},
 \end{aligned}
\]

because `det(g) in k^x` and hence `det(g)^(ell-1)=1`.

## 4. The affine interpolation basis

Write the projective lines as

\[
 L_t=k(1,t)\quad(t\in k),
 \qquad L_\infty=k(0,1).
\]

Then

\[
 \phi_{L_t}(X,Y)=(Y-tX)^{\ell-1},
 \qquad
 \phi_{L_\infty}(X,Y)=X^{\ell-1}.
\]

### Theorem 4.1 (affine basis theorem)

The `ell` polynomials

\[
  \{(Y-tX)^{\ell-1}:t\in k\}
\]

form a basis of `Sym^(ell-1)(V^vee)`.

### Proof

The target has dimension `ell`.  It is therefore enough to prove linear
independence.  Suppose

\[
  \sum_{t\in k}c_t(Y-tX)^{\ell-1}=0.
  \tag{4.1}
\]

Evaluate at `(X,Y)=(1,s)` for an arbitrary `s in k`.  Fermat gives

\[
  (s-t)^{\ell-1}=
  \begin{cases}
   0,&t=s,\\
   1,&t\ne s.
  \end{cases}
\]

Thus

\[
  \sum_{t\ne s}c_t=0.
  \tag{4.2}
\]

Let `S=sum_t c_t`.  Equation (4.2) says `c_s=S` for every `s`.  Summing these
identities gives

\[
  S=\ell S=0
\]

in characteristic `ell`; hence every `c_s=0`.

## 5. The projective relation and the Steinberg quotient

### Theorem 5.1 (constant-vector kernel)

\[
  \sum_{L\in\mathbb P(V)}\phi_L=0.
  \tag{5.1}
\]

Consequently

\[
 \ker\Phi_\ell
 =k\cdot\sum_{L\in\mathbb P(V)}e_L,
\]

and `Phi_ell` induces a `GL_2(k)`-equivariant isomorphism

\[
 \boxed{
  k[\mathbb P^1(k)]/k\mathbf1
  \xrightarrow{\sim}
  \operatorname{Sym}^{\ell-1}(k^2)^\vee.}
 \tag{5.2}
\]

### Proof

Expand

\[
 \sum_{t\in k}(Y-tX)^{\ell-1}+X^{\ell-1}.
\]

For exponents `1<=j<=ell-2`, the power sum `sum_t t^j` vanishes.  The constant
coefficient also vanishes because `ell=0` in `k`.  The top coefficient is

\[
  \sum_{t\in k}t^{\ell-1}=-1,
\]

which is cancelled by the final `X^(ell-1)`.  This proves (5.1).  The affine
basis theorem shows that `Phi_ell` has rank `ell`; its source has dimension
`ell+1`, so the displayed constant line is the complete kernel.

The quotient in (5.2) is the Steinberg representation in its projective
permutation realization.  The theorem is an explicit realization, not merely
a character-theoretic dimension count.

## 6. The local Tate packet becomes a pure highest-weight vector

At a split Tate place let `C` be the canonical cyclic line and put

\[
 A_\ell=\frac{\ell-1}{12},
 \qquad
 B_\ell=-\frac{\ell-1}{12\ell},
 \qquad
 \Delta_\ell=A_\ell-B_\ell.
\]

The local energy vector is

\[
 s_C=\Delta_\ell L
 \left(e_C-\frac1{\ell+1}\mathbf1\right).
\]

Modulo the constant line, Theorem 5.1 sends its projective class to

\[
  \Delta_\ell L\,\phi_C.
  \tag{6.1}
\]

Thus the nonlinear packet signal is represented by a pure `(ell-1)`-st power
of the canonical vanishing-cycle linear form.  This is the finite-field
highest-weight vector expected in a symmetric-power Hodge realization.

## 7. An integral lift with controlled operator cost

Choose the affine representatives `t=0,1,...,ell-1` and define over `Z`

\[
  \widetilde\phi_t(X,Y)=(Y-tX)^{\ell-1}.
\]

In the monomial basis, the sum of the absolute values of its coefficients is

\[
  \sum_{j=0}^{\ell-1}
  {\ell-1\choose j}t^j
  =(1+t)^{\ell-1}
  \le \ell^{\ell-1}.
\]

### Theorem 7.1 (one-way integral metric comparison)

The resulting integral linear operator from the affine packet lattice to the
monomial symmetric-power lattice has archimedean `ell-infinity` operator norm
at most

\[
  \ell^\ell,
\]

and hence logarithmic cost at most

\[
  \ell\log\ell.
\]

At every nonarchimedean place its coefficients are integral, so its operator
norm is at most one for the standard lattice sup norms.

### Proof

Every target coefficient is a sum of at most `ell` source coordinates, each
multiplied by a coefficient of absolute value at most the corresponding row
sum.  The total row estimate is bounded by `ell * ell^(ell-1)=ell^ell`.
Nonarchimedean integrality is immediate.

Only this one-way bound is needed for an upper slope estimate: if `Phi(v)` is
the symmetric-power image of a packet vector, then

\[
  \|\Phi(v)\|_\infty\le\ell^\ell\|v\|_\infty
\]

implies

\[
  -\log\|v\|_\infty
  \le -\log\|\Phi(v)\|_\infty+\ell\log\ell.
\]

No inverse determinant estimate of size `O(ell^2 log ell)` is required.

## 8. The corrected global source theorem

The finite-field and integral interpolation theorems reduce the active
Steinberg route to a sharper geometric statement than the previous abstract
maximal-slope target.

### Target theorem 8.1 (theta--symmetric-power interpolation)

Construct, over the full level-`ell` modular cover or an equivalent descended
adelic object, a metrized morphism

\[
  \mathcal V_\ell^{\rm Steinberg}
  \longrightarrow
  \operatorname{Sym}^{\ell-1}\mathcal H_{\rm dR}^\vee
  \otimes\mathcal J_\ell
  \tag{8.1}
\]

with the following properties.

1. Its reduction at the level prime is the explicit map `Phi_ell` of (5.2).
2. Applied to the determinant-of-cohomology theta packet, its local leading
   term is the pure vector (6.1).
3. The auxiliary line `J_ell` has normalized arithmetic degree

   \[
     O(\ell\log\ell)
   \]

   plus the already isolated different and level-prime terms.
4. The morphism is integral at good finite places; this is compatible with the
   explicit kernel-polynomial and determinant-unit theorems.
5. Its archimedean operator norm has logarithm `O(ell log ell)`, as predicted
   by Theorem 7.1 and the complex theta multiplication formulas.

A maximal-Higgs or Arakelov slope estimate for the symmetric power would then
give

\[
 \widehat\mu_{\max}(\mathcal V_\ell^{\rm Steinberg})
 \le
 \left(\frac{\ell-1}{2}+o(\ell)\right)(D+N)
 +O(\ell\log\ell),
\]

which is exactly the remaining estimate needed for `abc`.

Theorem 8.1 is not assumed proved here.  The present result closes its finite
representation, projective-line selection, and allowable integral operator
cost.  What remains is the genuine theta/Hodge metric realization.

## 9. Formalization plan

The Lean development is split into source-independent layers.

1. Prove the abstract finite-field coefficient-vanishing lemma used in
   Theorem 4.1.
2. Instantiate Fermat's identity in `ZMod ell` and package the affine family as
   linearly independent.
3. Prove the projective constant-vector relation.
4. Formalize the integral binomial row-sum estimate.
5. Only after these kernels compile, introduce the geometric theta packet
   morphism of Target theorem 8.1.

No step in Sections 2--7 assumes `ABCConjecture`, IUT, or the unresolved global
slope theorem.
