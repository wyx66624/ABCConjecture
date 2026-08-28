# Actual bad-place procession geometry

**Author:** ChatGPT  
**Status:** mathematical proof implemented in Lean; kernel status determined by branch CI.

## 1. Setup

Let `D` be actual initial theta data, let `Q` be its source-derived q-pilot
packet, and put

\[
n=\frac{\ell-1}{2}>0.
\]

For each distinguished procession label `m+1`, `0 <= m < n`, and each actual
bad place `w`, the existing construction supplies the genuine finite-positive
local Tate region

\[
U_{m,w}=q_w^{(m+1)^2}\mathcal O_w.
\]

The bad-place packet rectangle is

\[
U_m=\prod_w U_{m,w}.
\]

The preceding product-region theorem proves

\[
\log\mu(U_m)=L_m=(m+1)^2 L_q,
\]

where `L_q` is the signed actual q-packet Haar logarithm.

## 2. Same-ambient union collapses

For `m <= r`, one has

\[
(m+1)^2\le (r+1)^2.
\]

Since powers of the maximal ideal form a decreasing filtration,

\[
U_{r,w}\subseteq U_{m,w}
\]

at every bad place. Taking products gives

\[
U_r\subseteq U_m.
\]

Consequently

\[
\boxed{\bigcup_{0\le m<n}U_m=U_0.}
\]

Thus a union formed after identifying all labels in one fixed packet ambient
space has logarithmic volume only

\[
\log\mu(U_0)=L_q.
\]

It does not retain the square-sum coefficient

\[
\sum_{j=1}^{n}j^2.
\]

This is a strict geometric no-go theorem for the naive same-ambient union
interpretation. It does not exclude a genuine multiradial construction in
which labels remain distinct arithmetic-holomorphic coordinates.

## 3. Independent-label product realizes the procession sum

Retain one copy of the complete bad-place packet for every label and form

\[
\mathcal U=\prod_{m=0}^{n-1}U_m.
\]

This is a genuine finite-positive region for the iterated finite product Haar
measure. Product-measure multiplicativity gives

\[
\log\mu(\mathcal U)
 =\sum_{m=0}^{n-1}\log\mu(U_m)
 =\sum_{m=0}^{n-1}L_m
 =L_{\mathrm{proc}}.
\]

After dividing by the procession length and by the number-field degree,

\[
-\frac{1}{n[F:\mathbf Q]}\log\mu(\mathcal U)
 =\operatorname{normalizedProcessionMass}(Q).
\]

The already proved square-sum calculation therefore yields

\[
\boxed{
-\frac{1}{n[F:\mathbf Q]}\log\mu(\mathcal U)
 =\frac{(2n+1)(n+1)}{6}\,\operatorname{arithmeticLogQ}(Q).
}
\]

For the canonical residue-degree reweighting this becomes the identical
formula in the public q-pilot scalar.

## 4. Consequence for the IUT route

The finite bad-place scalar procession is now represented by an honest
finite-positive product-measure region. The remaining issue is not the
square-sum algebra or the local Haar normalization. It is the source theorem
that makes the label coordinates genuinely independent and identifies their
product, or a controlled image of it, with an actual IUT III possible-image
object and its mono-analytic hull.

A proof which instead places every label in one common local field and takes a
set-theoretic union collapses to the first label and loses the amplification.
Therefore any successful source-faithful construction must supply nontrivial
cross-label AHS/untilt data, tensor coordinates, or another geometric
mechanism preventing this diagonal collapse.

## 5. Boundary

This result does not construct the complete IUT III possible-image union, the
cross-label multiradial comparison, the archimedean term, or the
different/conductor estimate of IUT IV. It does not prove an unparameterized
`ABCConjecture`. No target-equivalent assumption, component-volume field, or
abc inequality is used in the construction.
