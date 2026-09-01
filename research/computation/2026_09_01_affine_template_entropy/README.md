# Affine template-entropy replay

This bundle accompanies
`research/ABC_AFFINE_TEMPLATE_ENTROPY_2026_09_01.md`.

It checks, with exact integer arithmetic:

- the corrected determinant-only counterexample with
  `d_U=31` at `(h,k)=(30,1),(30,2)`, including every pairwise and
  coefficient-cancellation coprimality premise and the explicit choices
  `T=10`, `X_U=X_V=X_W=1`;
- a bounded exhaustive stress test of the abstract separation hypotheses;
- every cross-multiplied canonical constant inequality for
  `6 <= c <= 1000` and `6 <= R < c`;
- the sharpened scale `L=floor(c^4/13)` and
  `12 c^4/R^2` product-cell bound throughout that range.

The finite stress test is diagnostic only.  The general results rest on the
paper proof; the companion Lean module checks the separation, cell packing,
membership cancellation, and cross-multiplied constant-12 core.  No finite
no-hit is interpreted as a proof, and the full affine route remains open.
