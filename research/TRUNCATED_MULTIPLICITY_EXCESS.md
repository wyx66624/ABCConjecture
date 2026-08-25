# Truncated multiplicity excess and the cubeful support of an abc exception

## 1. Definition

For a positive integer

\[
  n=\prod_p p^{e_p}
\]

and an integer `k>=2`, define the `k`-truncated multiplicity excess

\[
  T_k(n)=\prod_{e_p\ge k}p^{e_p-k+1}.
\]

Thus `T_k(n)` is a divisor of `n` supported only at primes whose exponent is
at least `k`.  In particular, `T_3(n)` is supported on the cubeful part of
`n`.

## 2. General lower bound

### Theorem 2.1

For every positive integer `n` and every `k>=2`,

\[
  T_k(n)\geq \frac{n}{\operatorname{rad}(n)^{k-1}}.
\]

### Proof

At a prime of exponent `e`, the exponent of the right-hand side is

\[
  e-(k-1).
\]

If `e>=k`, this is exactly the exponent `e-k+1` occurring in `T_k(n)`.  If
`1<=e<k`, the exponent on the right is nonpositive, whereas `T_k(n)` has
exponent zero.  The inequality follows prime by prime.

Equivalently,

\[
  \log T_k(n)
  \geq
  \log n-(k-1)\log\operatorname{rad}(n).
\]

## 3. Cubeful excess forced by an abc violation

Let `a,b,c` be positive pairwise coprime integers with `a+b=c`, and put

\[
  R=\operatorname{rad}(abc).
\]

### Theorem 3.1

If

\[
  c>R^{1+\epsilon},
\]

then

\[
  T_3(abc)
  >c^{2\epsilon/(1+\epsilon)}\left(1-\frac1c\right).
\]

### Proof

Since `a,b` are positive and sum to `c`,

\[
  ab\geq c-1.
\]

Theorem 2.1 gives

\[
  T_3(abc)\geq\frac{abc}{R^2}
  \geq\frac{c(c-1)}{R^2}.
\]

The assumed violation implies `R^2<c^{2/(1+epsilon)}`, hence

\[
  T_3(abc)
  >c^{2-2/(1+\epsilon)}\left(1-\frac1c\right)
  =c^{2\epsilon/(1+\epsilon)}\left(1-\frac1c\right).
\]

## 4. One term carries a large cubeful divisor

Pairwise coprimality implies

\[
  T_3(abc)=T_3(a)T_3(b)T_3(c).
\]

Consequently one of `a,b,c` satisfies

\[
  T_3(n)
  >c^{2\epsilon/(3(1+\epsilon))}
    \left(1-\frac1c\right)^{1/3}.
\]

This is stronger in support information than merely finding a large square or
cube divisor: the entire displayed divisor is supported only on primes whose
valuation in that one term is at least three.

## 5. Relation with exponent moments

Writing `e_p=v_p(abc)`, Theorem 3.1 is the logarithmic inequality

\[
  \sum_p\max\{e_p-2,0\}\log p
  >\frac{2\epsilon}{1+\epsilon}\log c
   +\log\left(1-\frac1c\right).
\]

Thus every prospective counterexample has a quantitatively large positive
third multiplicity moment.  This provides a direct interface to:

1. determinant-method stratification by valuation multiplicities;
2. counting powerful and cubeful integers in short additive configurations;
3. diagonal-cubic descent and Selmer methods;
4. exceptional-set amplification mechanisms that vary only the cubeful
   support while preserving the squarefree radical.

## 6. Remaining target

A proof of abc along this route would follow from a uniform theorem that the
additive equation `a+b=c` cannot contain a divisor of the size in Theorem 3.1
supported entirely at exponent-at-least-three primes, except for finitely many
triples at each fixed `epsilon`.

The present theorem is an unconditional reduction.  The required uniform
additive-cubeful estimate is not assumed here and remains an active target.
