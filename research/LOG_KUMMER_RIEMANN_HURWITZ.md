# Logarithmic Riemann--Hurwitz for adaptive Kummer globalization

## 1. The local identity

Let `L/K` be a finite separable extension of complete discretely valued
fields.  Above the base valuation, write

\[
 e_i=e(w_i/v),\qquad
 f_i=f(w_i/v),\qquad
 d_i=v_{w_i}(\mathfrak D_{L/K}),
\]

and let

\[
 n=[L:K]=\sum_i e_i f_i.
\]

The ordinary different contribution is `sum f_i d_i`.  The reduced inverse
image of the boundary has degree `sum f_i`, whereas the full pullback of the
base boundary has degree `n`.  Therefore

\[
 \sum_i f_i d_i+\sum_i f_i-n
 =\sum_i f_i(d_i+1-e_i).
\tag{1}
\]

This is the coefficient form of logarithmic Riemann--Hurwitz:

\[
 K_Y+D_Y=f^*(K_X+D_X)+R_{\log}.
\]

## 2. Tame cancellation

For tame ramification,

\[
 d_i=e_i-1.
\]

Every summand on the right of (1) is zero.  Hence

\[
 \boxed{\text{ordinary different}+
        \text{reduced conductor}=
        \text{pullback base conductor}}
\]

at a tame boundary prime.

This corrects a misleading bookkeeping step in naive Kummer-base-change
arguments.  One must not add a full tame different cost to a full conductor
cost: in the logarithmic pair they cancel exactly.

## 3. Wild defect

In general the logarithmic defect is

\[
 \delta_{\log,i}=d_i+1-e_i\ge0.
\]

The standard local different estimate

\[
 d_i\le e_i-1+e_i v_p(e_i)
\]

gives

\[
 0\le\delta_{\log,i}\le e_i v_p(e_i).
\]

After normalization by `n`, the contribution above `p` is at most

\[
 \max_i v_p(e_i)\log p
 \le \log\max_i e_i.
\tag{2}
\]

Thus a Kummer extension whose local ramification degree is controlled by the
actual multiplicity `m_p` has logarithmic wild cost `O(log m_p)`, not
`m_p log p`.

## 4. Global consequence under controlled ramification

Let `P` be the support of an integer or of the multiplicative places of a Frey
curve. Suppose a global extension realizes the required local Kummer roots and
is ramified only over:

1. the original boundary primes `p in P`;
2. primes dividing the local root indices `m_p`;
3. a fixed finite auxiliary set.

Assume moreover that the local ramification degrees above `p` divide a bounded
multiple of `m_p`. Applying (1) prime by prime gives

\[
 D_{\log}(K/\mathbb Q;P)
 +N_{\mathrm{red}}(K;P)
 \le
 \log\prod_{p\in P}p
 +C\sum_{p\in P}\log(m_p+1)
 +O(1).
\tag{3}
\]

The multiplicity-entropy theorem then implies that, for every `eta>0`,

\[
 D_{\log}+N_{\mathrm{red}}
 \le
 \log\operatorname{rad}(n)
 +\eta\sum_pm_p\log p
 +O_\eta(1).
\tag{4}
\]

This has exactly the quantifier shape required for abc absorption.

## 5. What is proved and what remains

Equation (1), tame cancellation, and the normalized wild bound are complete.
Their scalar cores are formalized in
`LogRamificationCancellation.lean`.

The surviving arithmetic theorem is a **controlled-ramification Kummer
localization theorem**:

> Simultaneously realize the local unit-root Kummer classes by a global
> extension whose ramification outside the original boundary is supported on
> the root indices and one fixed auxiliary set, with local ramification degree
> bounded by the prescribed indices.

Class field theory and Grunwald--Wang suggest this formulation, but the exact
uniform ramification statement must be proved rather than cited loosely.

Even after (4), a geometric source theorem is still required to compare the
Kummer-saturated logarithmic pair with the original Frey Hodge/Tate height
without restoring multiplicity through an ordinary tensor-power identity.
The log cancellation theorem removes the apparent factor-two
`different + conductor` obstruction; it does not by itself prove that final
comparison.
