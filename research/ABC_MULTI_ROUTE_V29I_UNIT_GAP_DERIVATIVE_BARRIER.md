# ABC multi-route research note v29i: the integral arithmetic-derivative barrier at unit gap

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Compatible derivatives on `1+M=C`

Let

\[
1+M=C,
\]

with `M` and `C` coprime.  Write

\[
M=Q_M A,\qquad C=Q_C B,
\]

where

\[
A=\operatorname{rad}(M),\qquad
B=\operatorname{rad}(C),
\]

and `Q_M,Q_C` are the powerful parts.

For an integral prime-weight arithmetic derivative `D`, additive
compatibility is

\[
D(1)+D(M)=D(C).
\]

Since `D(1)=0`, this becomes

\[
\boxed{D(M)=D(C)=T.}
\]

Every such derivative satisfies

\[
Q_M\mid D(M),
\qquad
Q_C\mid D(C).
\]

The supports of `M` and `C` are disjoint, so `Q_M` and `Q_C` are coprime.
Consequently every nonzero common derivative value satisfies

\[
\boxed{Q_MQ_C\mid T}
\]

and hence

\[
|T|\ge Q_MQ_C.
\]

## 2. Exact normalization barrier

Normalize by the left endpoint:

\[
\frac{|T|}{M}
\ge
\frac{Q_MQ_C}{Q_MA}
=
\frac{Q_C}{A}
=
\frac{C}{AB}.
\]

For a unit-gap triple,

\[
AB=\operatorname{rad}(MC)=\operatorname{rad}(1\cdot M\cdot C).
\]

Therefore

\[
\boxed{
\frac{|T|}{M}
\ge
\frac{C}{\operatorname{rad}(MC)}.
}
\]

The arithmetic Wronskian inequality has the form

\[
C
\le
\operatorname{rad}(MC)
\frac{|D(M)|}{M}.
\]

Substituting the universal lower bound shows that the smallest theoretically
possible integral compatible derivative merely gives

\[
C\le C.
\]

It does not produce an abc saving.

## 3. Consequence for the derivative route

The remaining derivative input cannot be stated only as

> there exists an integral compatible nonzero derivative.

That statement is far too weak.  To recover abc one would need

\[
\frac{|T|}{M}
\le
\operatorname{rad}(MC)^\varepsilon,
\]

but the unavoidable lower bound gives

\[
\frac{C}{\operatorname{rad}(MC)}
\le
\operatorname{rad}(MC)^\varepsilon,
\]

which is already the desired abc inequality.

Thus, on the unit-gap locus, a short-compatible-integral-derivative theorem at
the required scale is not a simpler missing lemma: it contains the original
height saving.

This closes another apparently independent route and prevents the repository
from treating an unrestricted short-derivative interface as progress toward
ABC.

## 4. Remaining possible derivative refinements

The barrier applies to the present integer-valued Leibniz derivative whose
values retain the full powerful parts.  A genuinely new derivative route
would need at least one of the following:

1. cancellation of powerful-part divisibility after passing to a non-integral
   or adelic object;
2. a product-formula construction in which local denominators are globally
   balanced rather than cleared into one integer `T`;
3. a source of extra archimedean smallness not equivalent to the abc bound;
4. a derivative evaluated in several places with a determinant whose content
   is smaller than `Q_MQ_C`.

Each refinement requires a separate non-circular proof of integrality,
nondegeneracy, and the final coefficient ledger.

## 5. Lean deliverable

The divisibility and scalar normalization barrier are formalized in

```text
Lean/IUTThreeClosures/UnitGapArithmeticDerivativeBarrier.lean
```

through

```lean
powerfulParts_mul_dvd_commonDerivative
powerfulParts_mul_le_commonDerivative_natAbs
normalized_common_value_lower_bound
```

No abc estimate or short derivative is assumed.
