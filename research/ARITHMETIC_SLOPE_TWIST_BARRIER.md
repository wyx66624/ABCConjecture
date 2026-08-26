# Arithmetic slope of a Hodge twist: a necessary correction

## 1. Purpose

The geometric Steinberg packet is naturally

\[
 \mathcal W_\ell=\omega^{\ell-1}\otimes\mathcal{St}_\ell,
\]

and its parabolic geometric maximal slope on the level-two modular stack is
`(ell-1)/2`.  It is tempting to substitute this geometric slope directly into
an arithmetic specialization inequality.  This note proves that such a
substitution is invalid: after specialization at an elliptic curve, tensoring
by the Hodge line shifts the arithmetic maximal slope by the actual Faltings
height.  Bounding that shift by the conductor is precisely the missing
Szpiro/abc-strength theorem.

This is a no-go theorem for one shortcut, not for the nonlinear packet route
itself.

## 2. Hermitian slope under a line twist

Let `K` be a number field.  Let `Ebar` be a Hermitian vector bundle over
`Spec O_K`, and let `Lbar` be a Hermitian line bundle.  Normalize arithmetic
degrees by `[K:Q]` and write `mu_max` for the maximal normalized Arakelov
slope.

### Theorem 2.1 (exact line-twist formula)

For every integer `m`,

\[
 \boxed{
 \widehat\mu_{\max}
   (\overline E\otimes\overline L^{\otimes m})
 =\widehat\mu_{\max}(\overline E)
  +m\,\widehat{\deg}(\overline L).}
\tag{2.1}
\]

#### Proof

Tensoring by an invertible module gives an inclusion-preserving bijection
between saturated submodules

\[
 F\subset E
 \quad\longleftrightarrow\quad
 F\otimes L^{\otimes m}
 \subset E\otimes L^{\otimes m}.
\]

For a rank-`r` saturated submodule, determinant multiplicativity gives

\[
 \widehat{\deg}
  (F\otimes L^{\otimes m})
 =\widehat{\deg}(F)
  +rm\,\widehat{\deg}(L).
\]

After division by `r`, every subbundle slope is shifted by the same number
`m deg(L)`.  Taking the supremum proves (2.1).

The theorem is exact for the tensor-product metrics.  Replacing those metrics
by uniformly comparable metrics introduces only the corresponding explicit
operator-norm error.

## 3. Application to the Steinberg packet

Let `E/K` be an elliptic curve and let `omegabar_E` be its metrized Hodge line,
normalized so that

\[
 \widehat{\deg}(\overline\omega_E)=h_F(E)+c_K,
\]

where the conventional constant `c_K` depends only on the normalization of
Faltings height.  Let `Stbar_ell` be a descended integral Hermitian realization
of the finite projective-line augmentation representation.

### Corollary 3.1

For the straightforward tensor-product metric on

\[
 \overline W_{\ell,E}
 =\overline\omega_E^{\otimes(\ell-1)}
  \otimes\overline{St}_\ell,
\]

one has

\[
 \boxed{
 \widehat\mu_{\max}(\overline W_{\ell,E})
 = (\ell-1)h_F(E)
   +\widehat\mu_{\max}(\overline{St}_\ell)
   +O_K(\ell).}
\tag{3.1}
\]

The finite-monodromy factor has geometric parabolic degree zero, but its
arithmetic lattice and archimedean metric do not cancel the Hodge-height term.
The root-discriminant estimate for the torsion/descent field may bound its
additional arithmetic cost by conductor and `O(log ell)`; it does not remove
`(ell-1)h_F(E)`.

## 4. The shortcut is equivalent to a Szpiro-strength inequality

Suppose one tries to prove the desired packet estimate solely by an ambient
maximal-slope bound

\[
 \widehat\mu_{\max}(\overline W_{\ell,E})
 \le
 \left(\frac{\ell-1}{2}+o(\ell)\right)(D+N)
 +O(\ell\log\ell).
\tag{4.1}
\]

Insert (3.1) and divide by `ell-1`.  After the separately controlled finite
monodromy and level terms are removed, (4.1) yields

\[
 h_F(E)
 \le \left(\frac12+o(1)\right)(D+N)+O(\log\ell).
\tag{4.2}
\]

For the Frey--Legendre family, the standard comparison between Faltings height,
minimal discriminant and the abc height turns (4.2) into an arithmetic
Szpiro/abc-strength estimate.  Thus (4.1) is not a consequence of geometric
polystability alone; it contains the decisive global arithmetic difficulty.

### Theorem 4.1 (geometric-to-arithmetic substitution no-go)

The equality

\[
 \mu_{\max}^{\rm par}
  (\omega^{\ell-1}\otimes St_\ell)
 =\frac{\ell-1}{2}
\]

on the modular base does not imply the arithmetic specialized bound (4.1).
Any argument making this substitution without an additional arithmetic
specialization theorem is incomplete.

## 5. What remains viable

The theorem excludes only the use of the **ambient tensor-product maximal
slope** as a free upper bound.  The following successors are not excluded.

1. **Projective/oscillation packet.**  Pass to ratios or the augmentation
   projectivization so that the common Hodge twist cancels before the height is
   formed.
2. **Determinant-of-cohomology torsion.**  Bound the arithmetic degree of the
   specific packet section directly, rather than the maximal slope of the
   entire Hodge-twisted bundle.
3. **Boundary-modified metric.**  Introduce an explicit singular/toroidal
   metric whose divisor subtracts the common Hodge height and leaves a
   truncated boundary term.
4. **Universal transverse isogeny.**  Compare projective boundary sections on
   the radicalized quotient, not only invariant differentials.
5. **Verified normed theta comparison.**  Use an independently constructed
   metric transport whose Jacobian is explicitly charged to different and
   conductor.

Each surviving route must exhibit the mechanism that removes the common
Hodge-height term; finite monodromy and geometric degree alone cannot do so.

## 6. Revised nearest target

The nearest classical target is therefore not (4.1) for the ambient bundle.
It is a **projectivized determinant packet theorem**:

* construct weight-zero ratios of the corrected cyclic determinant sections;
* prove their local projective oscillation is
  `(A_ell-B_ell)(-log|q_v|)`;
* prove good-place integrality and level/different control;
* establish a global upper bound for the resulting projective height in terms
  of the truncated conductor, with no common Hodge twist.

This target remains deep, but the present theorem prevents a geometric slope
identity from being mistaken for its arithmetic proof.

## 7. Formalization plan

The abstract line-twist formula can be formalized once the repository chooses a
specific arithmetic-degree API.  Its finite-dimensional core is elementary:
for every subspace or lattice submodule, tensoring by a one-dimensional factor
adds the same scalar to the normalized log determinant.  No `ABCConjecture`
hypothesis is used.
