# The explicit cyclic-line kernel polynomial

## 1. Purpose

The naive square evaluation determinant on the nonzero points of a cyclic
`ell`-subgroup is singular.  The determinant-of-cohomology route repairs that
singularity abstractly.  This note supplies the missing explicit algebraic
section and proves its good-reduction integrality.

Let `E/K` be an elliptic curve in Weierstrass form over a field of
characteristic different from two, let `ell` be odd, and let

\[
  C\subset E[\ell]
\]

be a cyclic subgroup of order `ell`.

## 2. The kernel polynomial

The involution `P -> -P` acts freely on `C\setminus{O}` because `ell` is odd.
Let

\[
  \overline C=(C\setminus\{O\})/\{\pm1\}.
\]

For an orbit `\{P,-P\}`, the two points have the same `x`-coordinate.  Define

\[
  \psi_C(X)=
  \prod_{\{P,-P\}\in\overline C}(X-x(P)).
\]

This is a monic polynomial of degree `(ell-1)/2`, independent of every choice
of orbit representatives.

### Theorem 2.1 (divisor of the kernel polynomial)

As a rational function on `E`,

\[
  \operatorname{div}(\psi_C(x))
  =\sum_{P\in C\setminus\{O\}}(P)-(\ell-1)(O).
\]

#### Proof

For every non-two-torsion point `P`, the degree-two function `x-x(P)` has
zeros at `P` and `-P`, each with multiplicity one, and its only pole is a
double pole at `O`.  Thus

\[
  \operatorname{div}(x-x(P))
  =(P)+(-P)-2(O).
\]

Summing this identity over the `(ell-1)/2` sign orbits gives the formula.

### Corollary 2.2

If

\[
  D_C=\sum_{P\in C\setminus\{O\}}(P),
\]

then

\[
  D_C\sim(\ell-1)(O).
\]

The section used in the exact sequence

\[
  0\to\mathcal O_E\to\mathcal O_E((\ell-1)O)
    \to\mathcal O_E((\ell-1)O)|_{D_C}\to0
\]

may therefore be taken to be the explicit monic kernel polynomial
`psi_C(x)`.

## 3. Descent to the field of definition of the line

### Theorem 3.1

If the subgroup `C` is stable under `Gal(\overline K/K)`, then

\[
  \psi_C(X)\in K[X].
\]

#### Proof

Galois permutes the sign orbits in `C\setminus\{O\}` and sends
`x(P)` to `x(\sigma P)`.  It therefore permutes the roots of the monic
polynomial `psi_C`.  Every coefficient is fixed by Galois.

The theorem uses only stability of the cyclic line, not a choice of a
nonzero generator.

## 4. Good-reduction integrality

Let `R` be a discrete valuation ring with fraction field `K` and residue
characteristic `p`.  Assume:

1. `E/R` is an elliptic scheme, equivalently `E/K` has good reduction;
2. `p` does not divide `ell`;
3. `C` is a finite etale cyclic subgroup scheme of `E[ell]` over `R`.

### Theorem 4.1 (integral kernel polynomial)

For a minimal integral Weierstrass equation of `E`,

\[
  \psi_C(X)\in R[X]
\]

and it is monic.

#### Proof

Because `ell` is invertible in `R`, the group scheme `E[ell]` is finite
etale.  Every geometric point of `C` extends uniquely to a section after an
unramified finite extension of `R`.

A nonzero prime-to-`p` torsion section cannot specialize to the zero section:
the kernel of reduction on prime-to-`p` torsion is trivial.  It therefore lies
in the affine part of the smooth integral Weierstrass model, so its
`x`-coordinate is integral over `R`.

All roots of `psi_C` are thus integral over `R`.  Since the polynomial is monic
and its coefficients belong to `K` by Theorem 3.1, its coefficients are
integral over `R`.  A DVR is integrally closed, hence the coefficients lie in
`R`.

### Corollary 4.2 (good-place unit boundary)

The canonical section `psi_C(x)` of `O_E((ell-1)O)` extends integrally at every
good finite place away from `ell`.  No denominator is introduced by the
cyclic-line algebraic section itself.

This closes the algebraic good-place part of the corrected cyclic-line
construction.  It does **not** yet prove that the metrized determinant-of-
cohomology torsion has norm one: one must still compare the integral bases in
the four-term exact sequence.  The only possible good-place discrepancy is
therefore an integral determinant/index, not an undefined inverse-evaluation
pole.

## 5. Relation with isogenies

The polynomial `psi_C` is the kernel polynomial of the cyclic isogeny with
kernel `C`.  Its degree `(ell-1)/2` is linear in `ell`, rather than quadratic.
Vélu's formulas express the target Weierstrass coefficients as integral
polynomials in the symmetric functions of its roots.  At good places away
from `ell`, Theorem 4.1 therefore also gives an integral isogeny model.

At multiplicative places, the valuation of the metrized section is expected
to recover the canonical/noncanonical Tate-line Bernoulli energies.  That is a
metric theorem, not a consequence of the divisor formula alone.

## 6. Remaining exact target

Let `tau_C` denote the determinant-of-cohomology trivialization attached to
`psi_C(x)`.  The next source theorem is:

\[
  -\log\|\tau_C\|_v
  =
  \begin{cases}
   \dfrac{\ell-1}{12}(-\log|q_v|)+J_v,
      &C\text{ canonical},\\[2mm]
   -\dfrac{\ell-1}{12\ell}(-\log|q_v|)+J_v,
      &C\text{ noncanonical},
  \end{cases}
\]

with an explicit integral/Hodge Jacobian `J_v` which vanishes at good places
away from `ell` and is globally bounded by different, conductor and
`O(log ell)` terms.

The algebraic section, its descent, and its good-place integrality are now
explicit.  The local metric comparison and the global nonlinear/projective
slope estimate remain open.
