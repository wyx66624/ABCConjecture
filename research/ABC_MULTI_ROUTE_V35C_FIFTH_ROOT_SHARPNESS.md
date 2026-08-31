# ABC multi-route research note v35c: sharpness of the fifth-root threshold

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Question

Can the endpoint height, radical, and canonical residue budgets alone force a
fifth-power divisor in every hypothetical ABC counterexample?

The answer is no in the small-\(\varepsilon\) range.  The obstruction is not
an artifact of a loose proof: an explicit scalar model saturates the endpoint
inequalities while having zero fifth-root weight on all three endpoints.

## 2. Explicit model

Fix

\[
0<\varepsilon<\frac25.
\]

Set

\[
h=2(1+\varepsilon),
\]

\[
T_m=2+\varepsilon,
\qquad
T_M=T_c=2(1+\varepsilon),
\]

and

\[
r_m=\frac{2+\varepsilon}{4},
\qquad
r_M=r_c=\frac{1+\varepsilon}{2}.
\]

Finally set all fifth-root weights to zero:

\[
q_m=q_M=q_c=0.
\]

Each endpoint saturates its fifth-power residue budget:

\[
T_i=4r_i+5q_i=4r_i.
\]

The non-short-gap lower bound is also an equality:

\[
(2+\varepsilon)h
=2(1+\varepsilon)T_m.
\]

The two large endpoints satisfy

\[
T_M=T_c=h.
\]

The total radical is

\[
R=r_m+r_M+r_c
=
\frac{6+5\varepsilon}{4}.
\]

Therefore

\[
(1+\varepsilon)R<h
\]

is equivalent, after cancelling the positive factor \(1+\varepsilon\), to

\[
\frac{6+5\varepsilon}{4}<2,
\]

or exactly

\[
5\varepsilon<2.
\]

Thus all scalar hypotheses of the fifth-root extraction problem hold, while
no endpoint has positive fifth-root weight.

## 3. Consequence

The quartic frontier is sharp for any method using only:

* endpoint logarithmic sizes;
* the total ABC radical budget;
* the non-short-gap lower bound;
* independent canonical `k`-th-power residue inequalities.

To force exponent five or higher, a proof must use genuinely arithmetic input
from

\[
m+M=c,
\]

such as:

* correlations between prime-exponent profiles on different endpoints;
* the moving-Pell norm equation;
* local/global residue reciprocity;
* level lowering tied to selected exponent classes;
* or a uniform height theorem.

Merely optimizing the scalar pigeonhole argument cannot cross the quartic
frontier.

## 4. Lean module

The formalization is

```text
Lean/IUTThreeClosures/FifthRootAggregateSharpness.lean
```

with declarations

```lean
exists_zero_fifthRoot_aggregate_model
not_every_aggregate_model_has_positive_fifthRoot
```

This is a counterexample to an overly weak proof strategy, not a counterexample
to the ABC conjecture.
