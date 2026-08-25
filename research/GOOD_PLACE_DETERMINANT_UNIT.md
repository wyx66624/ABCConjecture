# Good-place unitness for the cyclic-line determinant complex

## 1. Set-up

Let `R` be a discrete valuation ring with fraction field `K`.  Let

\[
  \pi:E\longrightarrow\operatorname{Spec}R
\]

be an elliptic curve with zero section `e`.  Let `ell>=3` be odd and invertible
in `R`, and let

\[
  C\subset E[\ell]
\]

be a finite etale cyclic subgroup scheme of order `ell`.  Put

\[
  D=C-e,
\]

viewed as the effective Cartier divisor formed by the nonzero points of `C`.
It is finite etale of degree `ell-1` over `R`.

The determinant object relevant to a cyclic-line evaluation construction is
best defined from the exact sequence

\[
  0\longrightarrow
  \mathcal O_E((\ell-1)e-D)
  \longrightarrow
  \mathcal O_E((\ell-1)e)
  \longrightarrow
  \mathcal O_D((\ell-1)e)
  \longrightarrow0.
  \tag{1}
\]

This formulation is invariant under changes of bases and automatically records
the integral Jacobian.

## 2. The degree-zero term is trivial over the DVR

### Lemma 2.1

The line bundle

\[
  \mathcal M_C=\mathcal O_E(D-(\ell-1)e)
\]

is trivial.

### Proof

For a divisor of relative degree zero on an elliptic curve, its class in the
relative Picard scheme is the group-law sum of its points.  Since `ell` is odd,
the nonzero elements of the cyclic group pair as `P,-P`; hence

\[
  \sum_{P\in C\setminus\{e\}}P=e.
\]

Thus `M_C` represents the zero section of `Pic^0_{E/R}`.  It is therefore the
pullback of a line bundle on `Spec R`.  Every line bundle over a DVR is free of
rank one, so `M_C` is trivial.  Equivalently,

\[
  \mathcal O_E((\ell-1)e-D)\simeq\mathcal O_E.
\]

## 3. Integral determinant trivialization

Apply the derived pushforward `R pi_*` to (1).  All three terms are perfect
complexes over `R`:

- `E/R` is proper and smooth;
- `O_E((ell-1)e)` is a line bundle;
- `D/R` is finite etale, so `R Gamma(D,O_D)` is a finite free `R`-module.

The determinant functor for a distinguished triangle gives a canonical
isomorphism of rank-one `R`-modules

\[
 \det R\Gamma(E,\mathcal O_E((\ell-1)e))
 \simeq
 \det R\Gamma(E,\mathcal O_E)
 \otimes
 \det R\Gamma(D,\mathcal O_D((\ell-1)e)).
 \tag{2}
\]

Here Lemma 2.1 was used for the left term of (1).

### Theorem 3.1 (good-place unit theorem)

Endow every determinant line in (2) with its integral lattice norm: a generator
of a free rank-one `R`-module has norm one.  Then the canonical determinant
isomorphism (2) has norm one.  Consequently the logarithmic local defect of the
cyclic-line determinant complex is zero.

### Proof

The determinant isomorphism is constructed in the category of perfect
`R`-complexes from the integral short exact sequence (1).  It is therefore an
isomorphism of invertible `R`-modules, not merely an isomorphism after tensoring
with `K`.  An isomorphism of free rank-one `R`-modules sends a primitive
integral generator to a unit times a primitive integral generator.  Its
valuation is zero, hence its norm is one.

## 4. Arithmetic consequence

Let `E/Q` be semistable and let `L_C` be a field over which a cyclic
order-`ell` subgroup is defined.  At every finite place `w` of `L_C` such that

1. `E` has good reduction at `w`, and
2. the residue characteristic is different from `ell`,

the cyclic subgroup extends to a finite etale subgroup scheme and Theorem 3.1
applies.  Therefore these places contribute exactly zero to the determinant
error.

All nonzero finite-place contributions are confined to:

- multiplicative/bad-reduction places, which carry the desired Tate boundary
  term;
- places above `ell`;
- the different or integral-model transition used to descend the determinant
  line.

This closes the good-place integral-unit subproblem for the determinant-of-
cohomology realization of the classical parabolic route.  It does not prove
the archimedean/maximal-slope estimate or the final abc inequality.
