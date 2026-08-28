# Fixed residual-core Roth barrier for equal-exponent powerful neighbours

**Author:** ChatGPT  
**Status:** algebraic bridge implemented in Lean; endpoint closed relative to the accepted Thue--Siegel--Roth interface.

## 1. Fixed-core setup

Fix positive real cores `s,t`, an exponent `k > 0`, and a positive real
number `alpha` satisfying

\[
t\alpha^k=s.
\]

For positive integers `x,y` with `alpha*x <= y`, put

\[
b=sx^k,\qquad c=ty^k,\qquad a=c-b.
\]

The elementary difference-of-powers factorization gives

\[
y^k-(\alpha x)^k
=(y-\alpha x)\sum_{i=0}^{k-1}y^i(\alpha x)^{k-1-i}.
\]

All summands are nonnegative, so retaining the final summand yields

\[
a\ge t(\alpha x)^{k-1}(y-\alpha x).
\]

This factor inequality is proved without an external interface.

## 2. Roth normalization

For an irrational algebraic `alpha`, Thue--Siegel--Roth implies that for each
positive integer `N` there is `C>0` such that

\[
C\le |\alpha x-y|^N x^{N+1}
\]

for every positive integer denominator `x` and natural numerator `y`.
The exact normalization, source and trust classification are recorded in
`ACCEPTED_THEOREM_ROTH_LEDGER.md`.

Combining this with the factor inequality gives

\[
\bigl[t(\alpha x)^{k-1}\bigr]^N C
\le a^N x^{N+1}.
\]

This is the denominator-free powered theorem formalized in the branch.
Informally, after taking `N` large, it recovers the standard fixed-core lower
bound

\[
a\gg_{s,t,k,\delta}b^{1-2/k-\delta}
\]

for every `delta>0`.

## 3. Consequence for the abc disproof route

A fixed pair of residual cores cannot supply an infinite equal-exponent
powerful-neighbour family with a gap exponent strictly below `1-2/k`.
Therefore any surviving same-exponent `k`-full counterexample route must allow
its normalized residual cores to vary with the height.

In the canonical `k`-full decomposition, core prime exponents lie in
`{0,...,k-1}`. If the ratio of two coprime fixed cores is itself a rational
`k`th power, valuation comparison forces both cores to be one; that is the
already excluded common-perfect-power case. Every nontrivial fixed coprime
core pair therefore falls under the irrational algebraic-slope case.

## 4. Claim boundary

This theorem does not prove abc. It does not show that varying-core families
exist or are finite, and it does not address unequal endpoint exponents. The
remaining disproof target is a genuinely varying-core short-gap correlation
theorem.

The Lean endpoint using Roth must be described as **closed relative to an
accepted theorem interface**, not as purely kernel-closed mathematics.
