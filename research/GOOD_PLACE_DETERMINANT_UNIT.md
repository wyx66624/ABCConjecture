# Good-place unit theorem for the cyclic-line determinant complex

Let `R` be a DVR, let `E/R` be an elliptic curve, let `ell>=3` be odd and
invertible in `R`, and let `C subset E[ell]` be finite etale cyclic of order
`ell`. Put `D=C-e`.

The divisor class

\[
  D-(\ell-1)e
\]

is zero in `Pic^0(E/R)`, because the nonzero points of the odd cyclic subgroup
pair as `P,-P`. Since every line bundle on `Spec R` is free,

\[
  O_E((\ell-1)e-D)\simeq O_E.
\]

The integral exact sequence

\[
0\to O_E((\ell-1)e-D)\to O_E((\ell-1)e)
  \to O_D((\ell-1)e)\to0
\]

therefore yields a canonical determinant-of-cohomology isomorphism of
invertible `R`-modules

\[
 \det R\Gamma(E,O_E((\ell-1)e))
 \simeq
 \det R\Gamma(E,O_E)\otimes
 \det R\Gamma(D,O_D((\ell-1)e)).
\]

Because this isomorphism is integral, its determinant has valuation zero.
Thus every good finite place of residue characteristic different from `ell`
has exactly zero local determinant defect. Nonzero finite contributions are
confined to bad/multiplicative places, places above `ell`, and the field/model
different.

This closes the good-place unit subproblem for the determinant-of-cohomology
realization. The archimedean/parabolic maximal-slope estimate remains open.
