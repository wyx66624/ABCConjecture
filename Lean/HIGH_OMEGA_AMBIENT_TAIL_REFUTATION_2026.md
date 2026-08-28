# Refutation of the ambient high-omega tail assumption in a proposed abc counterexample construction

**Author:** ChatGPT  
**Date:** 2026-08-28  
**Status:** unconditional refutation of one intermediate assumption; not a proof or disproof of the abc conjecture

## 1. Statement under audit

The revised preprint N. A. Carella, *Note on the Exceptional Set in the ABC
Conjecture*, arXiv:2608.16764v2, proposes a near-prime-power construction of
exceptional abc triples.  One of the hypotheses displayed in its main
construction theorem is an ambient estimate of the form

\[
\#\{n\le x:\omega(n)>w(x)\}=o(x^{3/5}),
\tag{1}
\]

where the threshold used in the preceding discussion has scale

\[
w(x)=\frac23\log\log x+O\!\left(\sqrt{\log\log x}\right).
\tag{2}
\]

Here \(\omega(n)\) is the number of distinct prime divisors of \(n\).

Estimate (1) is false for every threshold of size \(O(\log\log x)\).  The
failure is not a delicate consequence of the Erdős--Kac theorem: it follows
from an elementary family of multiples of primorial-type moduli.

## 2. Finite counting lemma

Let \(S\) be a finite set of \(r\) distinct primes and put

\[
Q=\prod_{p\in S}p.
\]

Every positive multiple of \(Q\) is divisible by every prime in \(S\), hence
has at least \(r\) distinct prime divisors.  Up to an arbitrary \(X\), the
positive multiples

\[
Q,2Q,\ldots,\left\lfloor\frac XQ\right\rfloor Q
\]

are pairwise distinct, so

\[
\#\{n\le X:\omega(n)\ge r\}
\ge \left\lfloor\frac XQ\right\rfloor.
\tag{3}
\]

Taking \(X=Q^5\) gives the exact lower bound

\[
\boxed{
\#\{n\le Q^5:\omega(n)\ge r\}\ge Q^4.
}
\tag{4}
\]

Since \(Q^4=(Q^5)^{4/5}\), this is already a fourth-fifths scale family.

The Lean module `HighOmegaAmbientTailRefutation.lean` proves a witness-based
version of (3)--(4).  It avoids relying on a particular library notation for
\(\omega\): an integer is declared to exceed a threshold when an explicitly
exhibited finite set of more than that many distinct primes all divide it.

## 3. Choosing the prime set above the proposed threshold

Let \(p_j\) be the \(j\)-th prime and

\[
Q_r=\prod_{j=1}^r p_j,
\qquad x_r=Q_r^5.
\]

Bertrand's postulate gives the elementary upper estimate

\[
p_j\le 2^j
\]

after a harmless adjustment of the initial index.  Consequently

\[
Q_r\le
2^{1+2+\cdots+r}
=2^{r(r+1)/2}.
\]

It follows that

\[
\log\log x_r
=\log\bigl(5\log Q_r\bigr)
=O(\log r).
\tag{5}
\]

For every threshold satisfying

\[
w(x)=O(\log\log x),
\]

(5) yields

\[
w(x_r)=O(\log r)<r
\]

for all sufficiently large \(r\).  Thus every multiple of \(Q_r\) counted in
(4) belongs to the set in (1).  Hence

\[
\#\{n\le x_r:\omega(n)>w(x_r)\}
\ge Q_r^4=x_r^{4/5}.
\tag{6}
\]

In particular,

\[
\frac{\#\{n\le x_r:\omega(n)>w(x_r)\}}
{x_r^{3/5}}
\ge x_r^{1/5}=Q_r\longrightarrow\infty.
\]

Therefore

\[
\boxed{
\#\{n\le x:\omega(n)>w(x)\}
\ne o(x^{3/5})
}
\]

for the threshold (2).  Indeed, the count is at least \(x^{4/5}\) along the
explicit subsequence \(x=x_r\).

## 4. Stronger probabilistic perspective

The normal order of \(\omega(n)\) is \(\log\log n\).  A threshold centered at
only two thirds of this mean lies substantially below the typical value, so
one expects a positive proportion tending toward one, rather than an
\(o(x^{3/5})\) exceptional tail.  The elementary argument above is weaker than
that full density statement but is more than sufficient to refute (1), and it
uses neither the Erdős--Kac theorem nor a uniform short-interval distribution
result.

## 5. Consequence for the proposed abc construction

This refutation concerns the **ambient all-integer hypothesis** used as an
input to the proposed extraction step.  It is independent of two other gaps
already isolated in the repository:

1. an estimate \(o(h)\) for bad integers in an interval does not imply the
   relative estimate \(o(h\rho(u))\) needed to extract a good smooth integer
   when the smooth density \(\rho(u)\to0\);
2. the displayed exponent condition
   \((\theta+1/k)^{1+\varepsilon}<1\) does not imply the correct logarithmic
   condition
   \((1+\varepsilon)(\theta+1/k+\eta)<1\).

The near-prime-power idea itself is not logically impossible.  A repaired
route would need a theorem specifically about the **conditional distribution
inside the short-interval smooth set**, for example

\[
\#\{n\in[x,x+h]:P^+(n)\le y,\ \omega(n)>w\}
=o(h\rho(u)),
\]

or a direct construction of one smooth integer whose radical is sufficiently
small.  The false ambient estimate (1) cannot provide that theorem.

## 6. Formalized theorems

The new Lean file contains:

```lean
card_positiveMultiplesUpTo
many_bad_of_all_positive_multiples_bad
many_bad_at_fifth_power_scale
product_multiple_exceeds_primeDivisorThreshold
high_primeDivisor_tail_lower_bound_at_fifth_power_scale
no_uniform_cubic_bound_for_highPrimeDivisorTail
```

The final theorem states that along any unbounded family of finite prime
products whose prime-set cardinality exceeds the selected threshold, the
high-prime-divisor tail at height \(Q^5\) cannot have a uniform bound
\(C Q^3\).  Since \(Q^3=(Q^5)^{3/5}\), this is the exact integral-power core of
the contradiction above.

## 7. Verdict

The ambient high-\(\omega\) assumption used in arXiv:2608.16764v2 is
mathematically false.  Consequently the paper's unconditional infinitude
claim is not established by that argument.  This does **not** prove the abc
conjecture: it closes one claimed counterexample route at its stated
intermediate hypothesis while leaving other proof and disproof routes open.
