# Multi-label marginalization and inherited-label overcount

**Author:** ChatGPT  
**Status:** theorem-first Lean implementation; merge status determined by branch CI.

## 1. Product-weight marginalization

Let `L` and `V` be finite types, let `w : V -> R`, and assume

\[
\sum_{v\in V} w(v)=1.
\]

For a component `c : L -> V`, write

\[
W(c)=\prod_{j\in L}w(c(j)).
\]

For label-local observables `f_j : V -> R`, finite-sum interchange and the
existing one-coordinate marginal theorem give

\[
\sum_{c:L\to V}W(c)\sum_{j\in L}f_j(c(j))
 =\sum_{j\in L}\sum_{v\in V}w(v)f_j(v).
\]

Consequently, if `f_j(v)=a_j g(v)`, then

\[
\sum_c W(c)\sum_j a_jg(c(j))
 =\left(\sum_j a_j\right)\left(\sum_vw(v)g(v)\right).
\]

Thus every genuinely active label contributes additively. An inherited label
can disappear from the packet coefficient only because its local logarithmic
volume is zero or because a separately proved quotient/marginal construction
removes it.

## 2. Prime-power q-pilot specialization

For the public packet data, suppose the component order is

\[
E(c)=\sum_j e_j(c(j)).
\]

The prime-power region formula and the theorem above yield

\[
\log\operatorname{Vol}_{\rm packet}
 =\sum_j\sum_vw(v)[-e_j(v)\log p].
\]

If `e_j(v)=a_j e(v)`, the scalar packet coefficient is exactly
`sum_j a_j`.

## 3. Standard-procession coefficient audit

For procession length `n`, capsule `i` has labels

\[
\{0,1,\ldots,i+1\},\qquad 0\le i<n.
\]

Charging only the new label in each capsule gives

\[
D_n=\sum_{j=1}^{n}j^2
 =\frac{n(n+1)(2n+1)}6.
\]

Treating every inherited label occurrence as an independent q-scaled factor
gives

\[
T_n=\sum_{i=0}^{n-1}\sum_{j=0}^{i+1}j^2
 =\frac{n(n+1)^2(n+2)}{12}.
\]

After division by `n`, the exact excess is

\[
\frac{T_n-D_n}{n}
 =\frac{n(n-1)(n+1)}{12}.
\]

Initial theta data have `ell >= 5`, hence `n=(ell-1)/2 >= 2`; the excess is
therefore strictly positive.

If `L_Q` denotes the signed actual q-packet Haar logarithm, the naive
all-occurrence average and the verified distinguished-label average differ by

\[
\frac{n(n-1)(n+1)}{12}L_Q.
\]

They agree exactly when `L_Q=0`. When `L_Q<0`, the all-occurrence model is
strictly more negative.

## 4. Claim boundary

This eliminates only the model in which every inherited label occurrence is
independently q-scaled again. It does not refute IUT III. A source-faithful
construction may instead make inherited coordinates integral, quotient them
out with an exact marginal map, or provide a geometric correction with the
precise compensating coefficient.

No abc inequality, IUT IV height theorem, possible-image existence theorem, or
target-equivalent axiom is assumed.
