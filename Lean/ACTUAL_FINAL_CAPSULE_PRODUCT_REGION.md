# Actual final-capsule product-region theorem

**Author:** ChatGPT  
**Status:** mathematical proof implemented in Lean; kernel status is determined by branch CI.

## 1. Source combinatorics

Put

\[
n=\frac{\ell-1}{2}.
\]

The standard IUT procession has nested label sets

\[
S_2\subset S_3\subset\cdots\subset S_{n+1},
\qquad
S_{j+1}=\{0,1,\ldots,j\}.
\]

Thus the last capsule has label set

\[
S_{n+1}=\{0,1,\ldots,n\}.
\]

The distinguished label newly introduced by capsule `m` is `m+1`, so the
complete sequence of distinguished new labels is exactly `1,...,n`.

## 2. Actual regions

For every actual bad place `w` and arbitrary label `j`, define

\[
U_{j,w}=q_w^{j^2}\mathcal O_w.
\]

The source-faithful local Tate/Haar theorem gives

\[
\log\mu_w(U_{j,w})=j^2\log\chi_w(q_w).
\]

First take the genuine product over all actual bad places,

\[
U_j=\prod_{w\in S_Q}U_{j,w}.
\]

Then take the genuine product over the labels of the final capsule,

\[
U_{\mathrm{final}}
 =\prod_{j=0}^{n}U_j.
\]

Every factor is a finite-positive region and every measure is sigma-finite, so
both dependent product regions exist as honest measured regions.

## 3. Final-capsule/procession identity

The label-zero factor is the normalized integer ball and has logarithmic volume
zero. Therefore

\[
\begin{aligned}
\log\mu(U_{\mathrm{final}})
 &=\sum_{j=0}^{n}j^2
   \sum_{w\in S_Q}\log\chi_w(q_w)\\
 &=\sum_{m=0}^{n-1}(m+1)^2
   \sum_{w\in S_Q}\log\chi_w(q_w)\\
 &=\operatorname{processionLogSum}(Q).
\end{aligned}
\]

The preceding distinguished-procession product theorem proves that the last
quantity is also the logarithmic volume of

\[
\prod_{m=0}^{n-1}\prod_{w\in S_Q}
 q_w^{(m+1)^2}\mathcal O_w.
\]

Hence the two actual product regions have equal logarithmic Haar volume.
After the established normalization,

\[
\operatorname{normalizedFinalCapsuleMass}(Q)
 =\operatorname{squareAverage}(D)\,
  \operatorname{arithmeticLogQ}(Q).
\]

For the canonical residue-degree reweighting, this becomes the corresponding
unconditional formula in the public q-pilot `logQ` scalar.

## 4. Meaning of the theorem

The result shows that the correct finite product interpretation of the nested
standard procession counts every final label once, equivalently counts only
the new distinguished label at every procession step. Multiplying all labels
again in every nested capsule would introduce artificial multiplicities and is
not the scalar used by the source-faithful procession theorem.

The Lean file also supplies a canonical equivalence

\[
\operatorname{Fin}(n+1)\simeq S_{n+1}
\]

between the convenient finite coordinate type and the actual source label type
`Iut.procLabels n`.

## 5. Boundary

This closes only the finite nested-label bookkeeping and its realization by
actual product Haar regions. It does not identify the arithmetic holomorphic
structures or untilts attached to different labels, prove the Ind1--Ind3
possible-image completeness statement, construct the mono-analytic hull, or
prove the archimedean/different/conductor estimate required by IUT IV Theorem
1.10. No abc inequality or target-equivalent source inhabitant is assumed.
