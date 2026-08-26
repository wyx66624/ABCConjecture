# Perfect-power gap barrier in the smooth-neighbour disproof route

## 1. Statement

The corrected smooth-neighbour criterion seeks integers

\[
  p^k<c\le p^k+p^{k\theta}
\]

with

\[
  \theta+\frac1k+\delta<1
\]

and a radical bound `rad(c)<=p^(k delta)`.

A natural first attempt is to choose `c` itself as another `k`-th power.  The
following elementary theorem excludes that entire subroute.

### Theorem 1.1 (same-exponent derivative barrier)

Let `k>=1` and let `q>p>=1` be integers. Then

\[
  q^k-p^k\ge p^{k-1}.
\]

For `k>=2`, the stronger inequality

\[
  q^k-p^k\ge k p^{k-1}
\]

holds.

#### Proof

Since `q>=p+1`, the binomial theorem gives

\[
 q^k\ge(p+1)^k
 =p^k+k p^{k-1}+\sum_{j=0}^{k-2}\binom{k}{j}p^j.
\]

All omitted terms are nonnegative, so the stronger inequality follows.  The
weaker statement is immediate.

### Corollary 1.2

If

\[
  p^k<q^k\le p^k+p^{k\theta}
\]

for arbitrarily large `p`, then

\[
  \theta\ge1-\frac1k.
\]

Indeed, Theorem 1.1 gives

\[
  p^{k-1}\le p^{k\theta}.
\]

### Corollary 1.3 (no abc disproof from neighbouring equal powers)

For every `delta>=0`, a same-exponent perfect-power construction cannot satisfy

\[
  \theta+\frac1k+\delta<1.
\]

The gap lower bound forces `theta+1/k>=1` before any radical cost is included.

## 2. Interpretation

This explains why the trivial neighbouring-power family

\[
  (p+r)^k-p^k
\]

always lies exactly on or above the exponent horizon of the smooth-neighbour
criterion.  A genuine disproof route must use one of the following genuinely
different mechanisms:

1. an integer `c` with high multiplicities but not another `k`-th power;
2. perfect powers of different exponents, together with a nontrivial
   Diophantine approximation theorem;
3. a sparse polynomial or recurrence value whose radical is much smaller than
   its size;
4. a short-interval smooth number with an independent, quantitatively strong
   radical bound.

The theorem eliminates only the same-exponent perfect-power subroute.  It does
not rule out the corrected smooth-neighbour target as a whole.
