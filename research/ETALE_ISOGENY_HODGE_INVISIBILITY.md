# Prime-to-`p` transverse isogenies are invisible to the local Hodge lattice

## 1. Statement

Let `R` be a discrete valuation ring of residue characteristic `p`, and let

\[
  \phi:\mathcal A\longrightarrow\mathcal B
\]

be an isogeny of semiabelian schemes over `R`.  Assume that the kernel
`\mathcal H` is finite etale over `R`; this holds for the closure of an
`ell`-torsion subgroup when `ell != p`.

Let

\[
  \omega_{\mathcal A}=e^*\Omega^1_{\mathcal A/R},
  \qquad
  \omega_{\mathcal B}=e^*\Omega^1_{\mathcal B/R}
\]

be the invariant-differential lattices.

### Theorem 1.1

Pullback is an isomorphism

\[
  \phi^*:\omega_{\mathcal B}\xrightarrow{\sim}
  \omega_{\mathcal A}.
\]

Consequently the local Hodge determinant defect of the isogeny is zero.

### Proof

For a finite flat kernel there is an exact conormal sequence at the identity

\[
  0\longrightarrow\omega_{\mathcal B}
   \xrightarrow{\phi^*}\omega_{\mathcal A}
   \longrightarrow\omega_{\mathcal H}\longrightarrow0.
\]

A finite etale group scheme has zero relative differentials, hence

\[
  \omega_{\mathcal H}=0.
\]

The result follows.

## 2. Application to the universally transverse kernel

At a multiplicative prime `p != ell`, the full group scheme `E[ell]` is finite
etale.  The closure of the universally transverse subgroup

\[
  H_T\subset E[\ell]^2
\]

is therefore finite etale, independently of whether it is canonical or
noncanonical in Tate coordinates.  Thus the local pullback on invariant
Hodge lattices is an isomorphism.

On the analytic/tropical side, the same noncanonical kernel enlarges the Tate
period lattice and changes each toric weight from

\[
  N_p\log p
  \quad\text{to}\quad
  \frac{N_p}{\ell}\log p.
\]

The Hodge lattice does **not** record this reduction.

## 3. No-go consequence

A proof using only:

1. the Faltings/Hodge line;
2. the prime-to-`p` isogeny pullback on invariant differentials; and
3. the tropical q-root calculation

cannot convert multiplicity into radical.  At the bad primes the Hodge defect
is exactly zero, while the tropical period changes.  The missing information
is carried by a separate boundary/discriminant/theta section and by its
archimedean norm.

This excludes the naive claim that the transverse isogeny directly lowers the
finite Faltings-height contribution.  It does not exclude a route using:

- a Siegel or theta modular form whose divisor detects the toroidal boundary;
- determinant of cohomology with a boundary section;
- an arithmetic intersection formula including the tropical monodromy pairing;
- or a normed Hodge--Arakelov comparison with all archimedean Jacobians.

## 4. Corrected compensation theorem

The surviving target must introduce an explicit metrized boundary section
`Delta_A` on the principally polarized quotient and prove both:

\[
  v_p(\Delta_{A_T})
  \le \frac{1}{\ell}v_p(\Delta_{E^2})
\]

at multiplicative primes, and an archimedean/global estimate whose leading
coefficient is sharp enough to compare the original Frey height with the
radical.  The ordinary Hodge-isogeny formula alone cannot supply that estimate.
