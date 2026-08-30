# ABC multi-route research note v18: multiplicity excess forces large square parts

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Finite exponent profiles

Let a finite prime-exponent profile have nonnegative logarithmic weights
`w_i` and exponents `e_i`.  Define

\[
T=\sum_i e_iw_i,
\qquad
R=\sum_iw_i,
\qquad
S=\sum_i\left\lfloor\frac{e_i}{2}\right\rfloor w_i.
\]

Here `T` is total logarithmic size, `R` is the radical budget, and `S` is the
logarithmic size of the canonical extracted square root.

## 2. Exact square-part inequality

For every natural exponent,

\[
e=(e\bmod2)+2\left\lfloor\frac e2\right\rfloor,
\]

and `e mod 2 <= 1`.  Therefore

\[
e_iw_i\le w_i+2\left\lfloor\frac{e_i}{2}\right\rfloor w_i.
\]

Summing gives

\[
\boxed{T\le R+2S}.
\]

Equivalently,

\[
\boxed{T-R\le2S}.
\]

Thus the canonical square root carries at least half of the logarithmic
multiplicity excess:

\[
\boxed{\frac{T-R}{2}\le S}.
\]

## 3. Consequence for the endpoint localization route

The v17 theorem proves that every abc violation forces both `c` and
`max(a,b)` to have multiplicity excess at least a fixed positive proportion
of `log c`.  Applying the present finite-profile inequality to their prime
factorizations shows that both endpoints contain square divisors whose roots
have a fixed positive height exponent.

Schematically, if

\[
E(n)=\log n-\log\operatorname{rad}(n)>\delta\log c+O(1),
\]

then the canonical square root `x(n)` satisfies

\[
\log x(n)>\frac\delta2\log c+O(1),
\]

so

\[
x(n)>c^{\delta/2+o(1)}.
\]

Writing the two large endpoints as

\[
M=u x^2,
\qquad
c=v y^2,
\]

with squarefree residue coefficients, the abc equation becomes

\[
\boxed{v y^2-u x^2=\min(a,b)}.
\]

The remaining arithmetic theorem is therefore a uniform gap estimate for two
coprime nearby integers with simultaneously large canonical square parts.

## 4. Lean deliverable

```text
Lean/IUTThreeClosures/SquarePartExponentWeight.lean
```

Main declarations:

```lean
parityResidueWeight_le_radicalWeight
totalWeight_le_radical_add_two_mul_squareRootWeight
multiplicityExcessWeight_le_two_mul_squareRootWeight
half_excess_le_squareRootWeight
squareRootWeight_large_of_excess_large
```

The proof uses the already formalized exact exponent-residue decomposition and
contains no arithmetic-existence or abc hypothesis.
