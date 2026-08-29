# Low-radical counting and the prime-power density barrier

**Author:** ChatGPT  
**Date:** 28 August 2026  
**Status:** unconditional counting theorem and route reduction; not a proof or
disproof of the abc conjecture.

## 1. Main correction to the smooth-neighbour program

The square-root short-interval theorem for smooth numbers suggests studying
triples

\[
 a+p^k=c,
 \qquad
 0<a\le (p^k)^{1/2+o(1)}.
\]

A counterexample family would additionally need

\[
 \operatorname{rad}(c)\le (p^k)^{\beta+o(1)},
 \qquad
 \frac12+\frac1k+\beta<1.
\]

It is tempting to seek such a low-radical integer after every large centre.
That target is impossible.  Low-radical integers are too sparse.  The correct
analytic target must be formulated directly on the thin set of prime-power
centres, or on an even sparser unbounded subsequence.

## 2. Rankin bound for integers with small radical

### Theorem 2.1

For every fixed real `eta>0`, there exists a finite constant `C_eta` such that
for all `X,R>=1`,

\[
 \#\{n\le X:\operatorname{rad}(n)\le R\}
 \le C_\eta R X^\eta.
\]

### Proof

For every integer `n<=X` with `rad(n)<=R`,

\[
 1\le
 \frac{R}{\operatorname{rad}(n)}
 \left(\frac{X}{n}\right)^\eta.
\]

Therefore

\[
 \#\{n\le X:\operatorname{rad}(n)\le R\}
 \le
 RX^\eta
 \sum_{n=1}^{\infty}
 \frac{1}{\operatorname{rad}(n)n^\eta}.
\]

The series has the Euler product

\[
 \sum_{n=1}^{\infty}
 \frac{1}{\operatorname{rad}(n)n^\eta}
 =
 \prod_p
 \left(
 1+\sum_{e\ge1}\frac{1}{p\,p^{e\eta}}
 \right)
 =
 \prod_p
 \left(
 1+\frac{p^{-1-\eta}}{1-p^{-\eta}}
 \right).
\]

For all sufficiently large primes `p`, the denominator is at least `1/2`, so
its nontrivial local term is at most `2p^{-1-eta}`.  Since

\[
 \sum_p p^{-1-\eta}<\infty,
\]

the Euler product converges to a finite constant.  Taking this value as
`C_eta` proves the theorem.  No abc-type statement is used.  ∎

### Corollary 2.2

For every fixed `beta>=0` and every `eta>0`,

\[
 \#\{n\le X:\operatorname{rad}(n)\le X^\beta\}
 \ll_\eta X^{\beta+\eta}.
\]

Thus the set of integers whose radical has exponent at most `beta` has upper
counting exponent at most `beta`.

## 3. No subcritical low-radical theorem after every centre

Assume that for every integer centre `x in [X,2X]` there exists

\[
 c\in(x,x+X^\theta]
 \quad\text{with}\quad
 \operatorname{rad}(c)\le X^\beta.
\]

Each candidate `c` can serve at most `X^theta+1` integer centres.  Hence there
must be at least

\[
 \gg X^{1-\theta}
\]

distinct candidates in `[X,3X]`.  Theorem 2.1 supplies at most

\[
 O_\eta(X^{\beta+\eta})
\]

such candidates.  If `theta+beta<1`, choose
`eta<1-theta-beta`; the two estimates contradict one another for large `X`.
Consequently,

\[
 \boxed{\text{an all-centres theorem requires }\theta+\beta\ge1.}
\]

But a near-prime-power abc counterexample requires

\[
 \theta+\beta+\frac1k<1.
\]

Therefore the desired low-radical statement can never hold after every
integer centre.  An all-interval smooth-number theorem is useful only as a
geometric gap input; its low-radical strengthening must be restricted to a
thin arithmetic set.

## 4. Prime-power centres

Fix `k>=2`.  Let

\[
 \mathcal P_k(X)=\{p^k:X<p^k\le2X,\ p\text{ prime}\}.
\]

Suppose that every centre in this set has a candidate

\[
 p^k<c_p\le p^k+X^\theta,
 \qquad
 \operatorname{rad}(c_p)\le X^\beta.
\]

If

\[
 \theta<1-\frac1k,
\]

then the candidate intervals are disjoint for all sufficiently large `X`.
Indeed, for primes `q>p` with `p^k>=X`,

\[
 q^k-p^k
 \ge (q-p)p^{k-1}
 \ge X^{1-1/k},
\]

whereas `X^theta=o(X^{1-1/k})`.  Hence the candidates `c_p` are distinct.

The prime number theorem gives

\[
 |\mathcal P_k(X)|\asymp_k\frac{X^{1/k}}{\log X}.
\]

Combining this lower bound with Theorem 2.1 shows that a theorem valid for all
prime centres, or for a fixed positive proportion of them, necessarily has

\[
 \boxed{\beta\ge\frac1k.}
\]

More precisely, if `beta<1/k`, choose
`0<eta<1/k-beta`; then
`X^{1/k}/log X` eventually exceeds `O(X^{beta+eta})`, a contradiction.

This argument does not exclude a zero-density or extremely sparse unbounded
sequence of prime powers.  Such a sequence remains a legitimate route to
strictly disproving abc.

## 5. Consequence at the square-root gap

At the gap exponent `theta=1/2`, the abc counterexample budget is

\[
 \frac12+\frac1k+\beta<1.
\]

For a family covering all prime centres, the density theorem also imposes
`beta>=1/k`.  Therefore

\[
 \frac12+\frac{2}{k}<1,
\]

which is equivalent to

\[
 \boxed{k>4.}
\]

Consequently:

- `k=2` is already impossible by the slope budget alone;
- `k=3` and `k=4` are impossible for a positive-density/all-primes theorem,
  although a sparse subsequence is not ruled out;
- `k>=5` leaves a nonempty exponent window

\[
 \frac1k\le\beta<\frac12-\frac1k.
\]

A convenient universal point in this window is

\[
 \beta=\frac14
\]

for every `k>=5`.  For example, at `k=5` the total slope is

\[
 \frac12+\frac15+\frac14=\frac{19}{20}<1.
\]

This arithmetic feasibility does not construct the candidates.

## 6. Revised analytic target

The earlier formulation “prove an all-centres tilted friable lower bound” is
too strong and, in the subcritical radical range, impossible by Theorem 2.1.
The surviving targets are instead:

1. **positive-density prime-power route, necessarily with `k>=5`:** prove a
   low-radical or tilted low-omega theorem directly for `p^k` centres, with
   `1/k<=beta<1/2-1/k`;
2. **sparse-sequence route:** construct infinitely many prime powers, possibly
   of exponent `k=3` or `4`, having a square-root-scale neighbour with
   `beta<1/2-1/k`;
3. **non-square-root route:** improve the gap exponent and re-optimize
   `theta+1/k+beta<1`, while respecting the radical counting density bound.

For `y=(p^k)^{1/u}` and a `y`-smooth candidate with at most `w` distinct prime
factors, the prime-power-specific target becomes

\[
 \frac{w}{u}<\frac12-\frac1k.
\]

For an all-primes theorem, radical density additionally forces asymptotically
`w/u>=1/k`; thus `k>=5` is again necessary.

## 7. Lean formalization

`LowRadicalDensityBarrier.lean` formalizes:

- the finite injective-selection cardinality inequality;
- the implication

\[
 \beta\ge1/k,
 \quad
 1/2+1/k+\beta<1
 \Longrightarrow k>4;
\]

- the no-go theorem for `k<=4` under the density lower bound;
- the feasible universal choice `beta=1/4` for every `k>=5`;
- existence of a positive abc epsilon margin for that numerical budget.

The analytic Rankin estimate above is proved in this note but is not inserted
into Lean as an axiom.  Its future full formalization requires the Euler
product convergence layer for

\[
 \sum_n(\operatorname{rad}(n)n^\eta)^{-1}.
\]

No theorem in the Lean module claims that the required prime-power neighbours
currently exist.
