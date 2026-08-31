# ABC multi-route research note v19: residue-coefficient radical drop

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Divisible and residual prime support

For a prime-exponent profile and a modulus `n`, let

\[
W_n=\sum_{n\mid e_p}\log p
\]

be the detected divisibility weight, and let

\[
R_n^{\rm res}=\sum_{n\nmid e_p}\log p
\]

be the residual radical weight. They partition the full support exactly:

\[
\boxed{W_n+R_n^{\rm res}=R.}
\]

Thus a lower bound `W_n>=B` gives

\[
\boxed{R_n^{\rm res}\le R-B.}
\]

## 2. The generalized-Fermat residue coefficient

In the canonical decomposition modulo `n`, the residue coefficient has
logarithmic weight

\[
K_n=\sum_p(e_p\bmod n)\log p.
\]

If `n|e_p`, the corresponding residue exponent is zero. Otherwise it is at
most `n-1`. Therefore the standard coefficient budget sharpens from

\[
K_n\le(n-1)R
\]

to

\[
\boxed{
K_n\le(n-1)R_n^{\rm res}.
}
\]

Combining the two displays gives

\[
\boxed{
K_n\le(n-1)(R-B)
}
\]

whenever the selected modulus detects at least `B` radical weight.

## 3. Consequence of the adaptive prime selector

The previous selector produces a prime `ell<=K` whose exponent-divisibility
class has quantitative weight `W_ell>B`. The present transfer therefore gives
simultaneously

\[
W_\ell>B,
\qquad
K_\ell\le(\ell-1)(R-B).
\]

This is the first direct conversion from positive signed multiplicity surplus
to an actual generalized-Fermat coefficient saving.

The remaining arithmetic step is to use the decomposition

\[
M=u x^\ell,
\qquad
c=v y^\ell,
\qquad
M+m=c,
\]

where the combined residue-coefficient logarithmic mass of `u` and `v` is
bounded by the displayed expression. A successful modular, height, or
short-gap theorem must exploit that coefficient saving without importing the
abc conclusion itself.

## 4. Lean deliverable

The corresponding module is

```text
Lean/IUTThreeClosures/ExponentResidueRadicalDrop.lean
```

with declarations

```lean
exponentResidualRadicalWeight
divisible_add_residual_eq_radicalWeight
residual_eq_radical_sub_divisible
residueWeight_le_pred_mul_residualRadicalWeight
residualRadicalWeight_le_of_detected
residueWeight_le_pred_mul_radical_sub_detected
exists_prime_with_residue_budget_of_surplus
```

No generalized-Fermat finiteness theorem, modularity theorem, or abc estimate
is assumed.
