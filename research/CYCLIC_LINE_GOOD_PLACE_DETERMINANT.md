# Good-place unitness of the cyclic-line determinant complex

## 1. Set-up

Let `R` be a discrete valuation ring with fraction field `K`.  Let

\[
  \pi:\mathcal E\longrightarrow\operatorname{Spec}R
\]

be an elliptic scheme, let `ell` be odd and invertible in `R`, and let

\[
  \mathcal C\subset\mathcal E[\ell]
\]

be a finite etale cyclic subgroup scheme of order `ell`.  Let

\[
  \mathcal D_\mathcal C
  =\mathcal C-\{O\}
\]

be the finite etale divisor of degree `ell-1`, and put

\[
  \mathcal L=\mathcal O_\mathcal E((\ell-1)O).
\]

The explicit kernel polynomial `psi_C(x)` gives a section of `L` whose zero
divisor is `D_C`.  Therefore there is an exact sequence of sheaves

\[
  0\longrightarrow\mathcal O_\mathcal E
  \xrightarrow{\,\psi_C\,}
  \mathcal L
  \longrightarrow
  \mathcal L|_{\mathcal D_\mathcal C}
  \longrightarrow0.
  \tag{1.1}
\]

## 2. Cohomological exactness over the DVR

Since `deg L=ell-1>0` on every geometric fibre,

\[
  R^1\pi_*\mathcal L=0.
\]

Cohomology and base change show that the following modules are finite free over
`R`:

\[
 \pi_*\mathcal O_\mathcal E\simeq R,
 \qquad
 \pi_*\mathcal L,
 \qquad
 \pi_*(\mathcal L|_{\mathcal D_\mathcal C}),
 \qquad
 R^1\pi_*\mathcal O_\mathcal E.
\]

The last module is an invertible `R`-module, dual to the Hodge line.  Applying
`R\pi_*` to (1.1) gives an exact four-term sequence

\[
 0\longrightarrow R
 \longrightarrow H^0(\mathcal E,\mathcal L)
 \longrightarrow H^0(\mathcal D_\mathcal C,
                       \mathcal L|_{\mathcal D_\mathcal C})
 \longrightarrow H^1(\mathcal E,\mathcal O_\mathcal E)
 \longrightarrow0.
 \tag{2.1}
\]

No torsion cokernel occurs: exactness is over `R`, not merely after tensoring
with `K`.

## 3. Determinant-line theorem

For a finite free `R`-module `M`, write `det_R M` for its top exterior power.
The exact sequence (2.1) induces the canonical isomorphism

\[
 \det_R H^0(\mathcal E,\mathcal L)
 \otimes
 \det_R H^1(\mathcal E,\mathcal O_\mathcal E)
 \simeq
 \det_R R
 \otimes
 \det_R H^0(\mathcal D_\mathcal C,
             \mathcal L|_{\mathcal D_\mathcal C}).
 \tag{3.1}
\]

Equivalently, the determinant-of-cohomology torsion element `tau_C` is a
generator of an invertible `R`-module.

### Theorem 3.1 (good-place unit norm)

Equip every determinant line in (3.1) with the lattice norm coming from its
finite free `R`-model.  Then

\[
  \|\tau_C\|_v=1.
  \tag{3.2}
\]

#### Proof

A finite exact sequence of finite free modules is locally split over a DVR.
Choose bases successively adapted to the image and quotient modules in (2.1).
In adapted bases the determinant isomorphism (3.1) has matrix determinant one.
Changing any adapted integral basis multiplies both sides by units of `R`.
Thus the canonical torsion element generates the determinant lattice and has
valuation zero.

### Corollary 3.2

At every good finite place whose residue characteristic does not divide
`ell`, the cyclic-line determinant packet has no finite-place error:

\[
  -\log\|\tau_C\|_v=0.
\]

The same holds for the dual coordinate `sigma_C=tau_C^{-1}`.

## 4. Why this theorem survives Galois descent

Suppose the cyclic line is defined only over a finite unramified extension
`R'/R`.  The construction above is equivariant under `Gal(R'/R)` and the
canonical determinant lattice descends.  The norm of a unit is a unit, so the
normalized descended contribution remains zero.

If the extension is ramified, the failure of unitness is measured by the
relative different and the comparison of determinant lattices.  This is
precisely the already isolated different/Jacobian term; it is not a hidden
good-reduction contribution.

## 5. Consequences for active routes

1. **Determinant of cohomology.**  The singular square evaluation determinant
   is replaced by an exact integral complex whose torsion is a good-place unit.
2. **Steinberg dual packet.**  Taking `sigma_C=tau_C^{-1}` creates no poles at
   good places away from `ell`; the inversion objection is removed there.
3. **Theta distribution.**  The exact Tate theta distribution supplies the
   analytic trivialization at multiplicative places, while Theorem 3.1 fixes
   the integral normalization at good places.
4. **Global slope target.**  The unresolved finite places are now restricted
   to multiplicative/bad reduction, primes above `ell`, and ramification in
   the descent field.

## 6. Remaining theorem

The nearest source-facing theorem is no longer good-place unitness.  It is the
metrized global comparison:

- identify the determinant torsion norm at a Tate place with the canonical or
  noncanonical Bernoulli energy, including the explicit automorphy monomial;
- bound the normalized level-prime and descent-field Jacobian by `O(log ell)`
  plus conductor/different;
- prove the maximal-slope bound for the descended Steinberg dual packet.

Theorem 3.1 is a standard determinant-functor result but must still be
formalized in the exact Lean category of finite free modules and determinant
lines before it is merged as code.
