# Counting integers with small radical

## 1. Purpose

The smooth-neighbour disproof route requires integers `c` near prime powers
whose radical is much smaller than `c`. Smoothness alone does not provide this:
a smooth integer may be squarefree. This note proves an unconditional counting
theorem for the genuinely relevant set

\[
  \mathcal R(X,Y)=\{n\le X:\operatorname{rad}(n)\le Y\}.
\]

The result supplies a density barrier for every proposed proof that produces
radical-small neighbours for a positive-density family of prime powers.

## 2. Residue--power decomposition

Fix an integer `m>=2`. Every positive integer

\[
 n=\prod_p p^{e_p}
\]

has a unique decomposition

\[
 n=a b^m,
 \qquad
 a=\prod_p p^{e_p\bmod m},
 \qquad
 b=\prod_p p^{\lfloor e_p/m\rfloor}.
\tag{2.1}
\]

The integer `a` is `m`-free: every prime exponent in `a` belongs to
`{0,1,...,m-1}`. Moreover

\[
  \operatorname{rad}(a)\mid\operatorname{rad}(n).
\tag{2.2}
\]

For a fixed squarefree integer `r`, the number of `m`-free integers `a` with
`rad(a)=r` is exactly

\[
  (m-1)^{\omega(r)}.
\tag{2.3}
\]

Indeed, each prime dividing `r` independently receives one exponent in
`{1,...,m-1}`.

For squarefree `r`, the ordered `m`-fold divisor function satisfies

\[
  \tau_m(r)=m^{\omega(r)},
\]

so the number in (2.3) is at most `tau_m(r)`.

## 3. A summatory divisor bound

Let

\[
 T_m(Y)=\sum_{r\le Y}\tau_m(r).
\]

### Lemma 3.1

For every real `Y>=1`,

\[
  T_m(Y)\le Y(1+\log Y)^{m-1}.
\tag{3.1}
\]

### Proof

The sum counts ordered positive integer tuples

\[
 (d_1,\ldots,d_m),\qquad d_1\cdots d_m\le Y.
\]

For `m=1`, the count is `floor(Y)<=Y`. Inductively,

\[
 \begin{aligned}
 T_m(Y)
 &=\sum_{d\le Y}T_{m-1}(Y/d)\\
 &\le\sum_{d\le Y}\frac{Y}{d}
       (1+\log(Y/d))^{m-2}\\
 &\le Y(1+\log Y)^{m-2}
       \sum_{d\le Y}\frac1d\\
 &\le Y(1+\log Y)^{m-1}.
 \end{aligned}
\]

The last step uses the elementary harmonic bound
`sum_{d<=Y} 1/d <= 1+log Y`.

## 4. Radical-small counting theorem

### Theorem 4.1

For integers `m>=2` and real numbers `X>=1`, `Y>=1`,

\[
 \boxed{
  \#\mathcal R(X,Y)
  \le
  X^{1/m}Y(1+\log Y)^{m-1}.}
\tag{4.1}
\]

### Proof

Use the unique decomposition (2.1). If `rad(n)<=Y`, then
`rad(a)<=Y`. For each possible `a`, the inequality `a b^m<=X` gives at
most `X^(1/m)` choices for `b`. By (2.3), the number of possible `a` is at
most

\[
 \sum_{r\le Y}\tau_m(r)=T_m(Y).
\]

Apply Lemma 3.1.

### Corollary 4.2

Fix `0<=delta<=1`. For every integer `m>=2`,

\[
 \#\{n\le X:\operatorname{rad}(n)\le X^\delta\}
 \le
 X^{\delta+1/m}(1+\delta\log X)^{m-1}.
\tag{4.2}
\]

### Corollary 4.3 (near-optimal exponent)

For every `eta>0`,

\[
 \boxed{
 \#\{n\le X:\operatorname{rad}(n)\le X^\delta\}
 \ll_\eta X^{\delta+\eta}}
\tag{4.3}
\]

uniformly for `0<=delta<=1`.

Choose a fixed integer `m>2/eta`. The polylogarithmic factor in (4.2) is at
most `X^(eta/2)` for all sufficiently large `X`; the remaining bounded range
is absorbed into the implied constant.

The exponent `delta` is essentially sharp: squarefree integers up to
`X^delta` already provide `X^{delta-o(1)}` examples.

## 5. Density barrier for prime-power neighbours

Fix `k>=2`. The number of primes `p` with

\[
 X\le p^k\le2X
\]

is `X^(1/k+o(1))` by the prime number theorem.

Suppose a proposed construction assigns to `X^(beta+o(1))` distinct such
centres distinct integers `c_p<=3X` satisfying

\[
  \operatorname{rad}(c_p)\le X^\delta.
\]

Corollary 4.3 forces

\[
  \boxed{\beta\le\delta.}
\tag{5.1}
\]

In particular, a construction working for all prime `k`-th-power centres must
have

\[
  \delta\ge\frac1k.
\tag{5.2}
\]

If every `c_p` is required to lie in

\[
 p^k<c_p\le p^k+X^\theta
\]

with `theta<1-1/k`, the intervals are disjoint for large `X`, because

\[
 q^k-p^k\ge k p^{k-1}
\]

for distinct integer bases `q>p` in the same dyadic range. Hence the
distinctness hypothesis above is automatic.

Combining (5.2) with the exact disproof budget

\[
  \theta+\frac1k+\delta<1
\]

shows that every dense/all-centres construction must satisfy

\[
  \boxed{\theta+\frac2k<1.}
\tag{5.3}
\]

For `k<=4`, this is incompatible with the currently available unconditional
short-interval smooth-number exponent `theta>17/30`. Thus those theorems cannot
be upgraded into an abc disproof merely by adding a radical estimate valid for
every prime-power centre of exponent at most four.

## 6. What the theorem does and does not exclude

The theorem strictly excludes:

1. any claim that radical-small integers of exponent `delta` have density
   larger than `X^(delta+o(1))`;
2. dense prime-power-neighbour constructions violating (5.1);
3. all-centres constructions with parameters violating (5.3).

It does not exclude an extremely sparse infinite sequence of radical-small
neighbours. Such a sequence is exactly what is still needed to disprove abc.
The broad smooth-neighbour route is therefore retained, while its required
rarity is now quantified.

## 7. Formalization plan

The Lean development will proceed in this order:

1. exponent residue/quotient decomposition
   `e = e % m + m * (e / m)`;
2. the induced unique prime-factorization decomposition `n=a*b^m`;
3. the finite encoding of `m`-free `a` by a squarefree radical and exponent
   choices;
4. the ordered-divisor-tuple interpretation of `tau_m`;
5. finite cardinal form of (4.1);
6. the asymptotic real-power corollary and the prime-power density barrier.

No unproved abc assertion is used in Theorem 4.1.
