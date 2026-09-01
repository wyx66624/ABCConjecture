# Totient-weighted divisor concentration for the Mersenne endpoint

**Author:** ChatGPT  
**Date:** 1 September 2026  
**Status:** proved reduction; the remaining arithmetic tail is open

## 1. Scope and logical status

Write

\[
  E_d=\prod_{\substack{p\mid 2^d-1\\ \operatorname{ord}_p(2)=d}}
       p^{v_p(2^d-1)-1},
  \qquad a_d=\log E_d,
\]

and let `W_m` denote the powerful part of `2^m-1`.  The preceding exact
order-block analysis proved

\[
 \log W_m=\sum_{d\mid m}a_d+\log\gcd(m,2^m-1).             \tag{1.1}
\]

Since the last term is `o(m)`, the Mersenne route has the exact endpoint

\[
 \log W_m=o(m)
 \quad\Longleftrightarrow\quad
 A(m):=\sum_{d\mid m}a_d=o(m).                            \tag{1.2}
\]

This note proves two new facts about that endpoint.  First, a bounded block
mass satisfies (1.2) exactly when its large normalized values occupy
`o(m)` **totient weight** among the divisors.  Second, totient weight is
unconditionally concentrated on divisors that are logarithmically close to
`m`.  Consequently every fixed power-small range `d <= m^(1-delta)` is
already negligible, and the unresolved Mersenne input can be localized to
near-diagonal divisors.

These statements are reductions, not a proof of abc.  No conjecture about
Wieferich primes, multiplicative orders, or primitive divisors is assumed.
The route remains active after this note.

## 2. The natural divisor probability

For `m >= 1`, define a probability measure on the positive divisors of `m`
by

\[
  \mu_m(d)=\frac{\varphi(d)}m\qquad(d\mid m).              \tag{2.1}
\]

It is a probability measure because the elementary divisor identity gives

\[
  \sum_{d\mid m}\varphi(d)=m.                             \tag{2.2}
\]

For any nonnegative mass `a_d`, put

\[
  X(d)=\frac{a_d}{\varphi(d)}.
\]

Euler's totient is positive on every positive divisor, and hence

\[
  \frac{A(m)}m
   =\sum_{d\mid m}\mu_m(d)X(d)
   =\mathbb E_{\mu_m}X(D).                                \tag{2.3}
\]

Thus the divisor-average endpoint is an expectation, rather than an
unweighted assertion about the number of divisors.

## 3. Exact threshold criterion

Let `a : N -> R` satisfy, for one fixed `C >= 0`,

\[
  0\le a_d\le C\varphi(d)\qquad(d\ge1).                   \tag{3.1}
\]

For `epsilon > 0`, define the totient weight of the exceptional divisors by

\[
 B_\epsilon(m)=
 \sum_{\substack{d\mid m\\a_d>\epsilon\varphi(d)}}
       \varphi(d).                                        \tag{3.2}
\]

### Proposition 3.1 (finite threshold inequalities)

For every `m >= 1` and `epsilon >= 0`,

\[
 \epsilon B_\epsilon(m)\le A(m)                          \tag{3.3}
\]

and

\[
 A(m)\le \epsilon m+C B_\epsilon(m).                     \tag{3.4}
\]

#### Proof

On the exceptional set, each summand is strictly greater than
`epsilon*phi(d)`.  Summing and weakening strict inequality proves (3.3).
On its complement, `a_d <= epsilon*phi(d)`; on the exceptional set, (3.1)
gives `a_d <= C*phi(d)`.  Split the divisor sum into these two sets, bound
the first totient subsum by (2.2), and retain the second as
`B_epsilon(m)`.  This proves (3.4).  The argument also covers `epsilon=0`.
∎

### Theorem 3.2 (bounded convergence criterion)

Under (3.1),

\[
 A(m)=o(m)
 \quad\Longleftrightarrow\quad
 \text{for every fixed }\epsilon>0,
 \ B_\epsilon(m)=o(m).                                   \tag{3.5}
\]

#### Proof

If `A(m)=o(m)`, fix `epsilon>0`.  Inequality (3.3) gives
`B_epsilon(m) <= A(m)/epsilon`, so `B_epsilon(m)=o(m)`.

Conversely, let `eta>0` be the requested final error and apply the assumed
exceptional-weight estimate with threshold `epsilon=eta/2`.  For all
sufficiently large `m`,

\[
 B_{\eta/2}(m)\le \frac{\eta}{2(C+1)}m.
\]

Using (3.4), nonnegativity of `C`, and `C/(C+1)<=1`, we obtain

\[
 A(m)\le \frac\eta2m+
 C\frac{\eta}{2(C+1)}m\le\eta m.
\]

This is exactly `A(m)=o(m)`.  ∎

In probabilistic language, (3.5) says that the uniformly bounded random
variables `X(D)` converge to zero in `mu_m`-probability if and only if their
expectations converge to zero.  The finite inequalities above are the full
proof; no measure-theoretic convergence theorem is needed.

## 4. Exact logarithmic-deficit moment

Factor

\[
 m=\prod_{p^a\parallel m}p^a.
\]

Under `mu_m`, write a random divisor as `D=prod p^{J_p}`.  Multiplicativity
of the totient makes the coordinates independent, with

\[
 \Pr(J_p=j)=\frac{\varphi(p^j)}{p^a},
 \qquad 0\le j\le a.                                    \tag{4.1}
\]

### Proposition 4.1 (exact deficit expectation)

For every `m >= 1`,

\[
 \mathbb E_{\mu_m}\log\frac mD
 =\sum_{p^a\parallel m}
    \frac{1-p^{-a}}{p-1}\log p.                          \tag{4.2}
\]

#### Proof

For one prime-power coordinate, the tail-sum formula and (2.2) at
prime powers give

\[
\begin{aligned}
 \mathbb E(a-J_p)
 &=\sum_{r=1}^a\Pr(a-J_p\ge r)\\
 &=\sum_{r=1}^a\frac1{p^a}
       \sum_{j=0}^{a-r}\varphi(p^j)\\
 &=\sum_{r=1}^a p^{-r}
  =\frac{1-p^{-a}}{p-1}.                                 \tag{4.3}
\end{aligned}
\]

Now
`log(m/D)=sum_p (a-J_p) log p`.  Linearity of expectation, or direct
factorization of the finite divisor sum, yields (4.2).  For `m=1` both
sides are empty and equal to zero.  ∎

### Proposition 4.2 (the deficit is sublogarithmic)

As `m` tends to infinity,

\[
 \sum_{p^a\parallel m}
    \frac{1-p^{-a}}{p-1}\log p=o(\log m).                 \tag{4.4}
\]

#### Proof

It suffices to bound the left side by

\[
 S(m)=\sum_{p\mid m}\frac{\log p}{p-1}.                  \tag{4.5}
\]

Fix an integer `Y >= 2` and split at `Y`.  The contribution of primes
`p <= Y` is a fixed constant `K_Y`, independent of `m`.  For `p>Y`,
`1/(p-1)<=1/Y`, and therefore

\[
 \sum_{\substack{p\mid m\\p>Y}}\frac{\log p}{p-1}
 \le \frac1Y\sum_{p\mid m}\log p
 =\frac1Y\log\operatorname{rad}(m)
 \le\frac1Y\log m.                                      \tag{4.6}
\]

After division by `log m`, the small-prime term tends to zero and the
limsup is at most `1/Y`.  Letting `Y` tend to infinity proves (4.4).
This proof uses no prime number theorem.  ∎

## 5. Concentration near the top divisor

### Theorem 5.1 (totient-weighted divisor concentration)

For every fixed `delta>0`,

\[
 \frac1m
 \sum_{\substack{d\mid m\\d\le m^{1-\delta}}}
      \varphi(d)\longrightarrow0.                        \tag{5.1}
\]

#### Proof

If `d <= m^(1-delta)`, then

\[
 \log(m/d)\ge\delta\log m.                               \tag{5.2}
\]

Markov's inequality for the nonnegative variable `log(m/D)`, followed by
Propositions 4.1 and 4.2, gives

\[
\begin{aligned}
 \frac1m\sum_{\substack{d\mid m\\d\le m^{1-\delta}}}
       \varphi(d)
 &=\mu_m\{D\le m^{1-\delta}\}\\
 &\le\frac{\mathbb E_{\mu_m}\log(m/D)}
            {\delta\log m}
 \longrightarrow0.
\end{aligned}                                             \tag{5.3}
\]

The finitely many cases `m<=1` are irrelevant to the limit.  ∎

The theorem is stronger than a square-root truncation: the exponent
`1-delta` may be arbitrarily close to one, while `delta` remains fixed.

### Corollary 5.2 (bounded masses on power-small divisors)

If (3.1) holds, then for every fixed `delta>0`,

\[
 \sum_{\substack{d\mid m\\d\le m^{1-\delta}}}a_d=o(m).
                                                               \tag{5.4}
\]

#### Proof

Termwise comparison with `C*phi(d)` reduces (5.4) to Theorem 5.1.  ∎

### Theorem 5.3 (moving near-diagonal concentration)

There is an absolute constant `C_0` such that

\[
 \Delta(m):=\mathbb E_{\mu_m}\log\frac mD
 \le C_0\log\log(3m)\qquad(m\ge1).                        \tag{5.5}
\]

Consequently, if `H : N -> R` is eventually positive and

\[
 \frac{H(m)}{\log\log(3m)}\longrightarrow\infty,          \tag{5.6}
\]

then

\[
 \frac1m\sum_{\substack{d\mid m\\
       d\le m\exp(-H(m))}}\varphi(d)\longrightarrow0.     \tag{5.7}
\]

#### Proof

The exact formula (4.2) bounds `Delta(m)` by

\[
 \sum_{p\mid m}\frac{\log p}{p-1}.                        \tag{5.8}
\]

Set `z=log m` for large `m`.  The primes `p<=z` contribute

\[
 \sum_{p\le z}\frac{\log p}{p-1}=O(\log z).               \tag{5.9}
\]

One may prove (5.9) without the prime number theorem.  Split into dyadic
shells `2^j<p<=2^(j+1)`.  Chebyshev's elementary estimate
`theta(x)=O(x)` bounds each shell by an absolute constant because

\[
 \sum_{2^j<p\le2^{j+1}}\frac{\log p}{p-1}
 \ll 2^{-j}\theta(2^{j+1})\ll1.                            \tag{5.10}
\]

There are `O(log z)` shells.  For `p>z`,

\[
 \sum_{\substack{p\mid m\\p>z}}\frac{\log p}{p-1}
 \le\frac{\log\operatorname{rad}(m)}{z-1}=O(1).           \tag{5.11}
\]

This proves (5.5).  If `d<=m exp(-H(m))`, then
`log(m/d)>=H(m)`.  Markov's inequality now gives

\[
 \frac1m\sum_{\substack{d\mid m\\d\le m e^{-H(m)}}}
       \varphi(d)
 \le\frac{\Delta(m)}{H(m)}
 \le\frac{C_0\log\log(3m)}{H(m)}\longrightarrow0.         \tag{5.12}
\]

All limits run through positive integers.  The value at `m=0` is not part
of the probability statement, and `m=1` gives an empty deficit sum.  ∎

For example, one may take

\[
 H(m)=(\log\log(3m))^2.                                   \tag{5.13}
\]

Thus the unresolved range can be confined to

\[
 d>m\exp\!\left(-\bigl(\log\log(3m)\bigr)^2\right)
   =m^{1-o(1)},                                            \tag{5.14}
\]

which is strictly narrower than every fixed range `d>m^(1-delta)`.

### Proposition 5.4 (sharpness against a fixed logarithmic deficit)

For every fixed `C>0`, it is false in general that

\[
 \frac1m\sum_{\substack{d\mid m\\
       d\le m/(\log m)^C}}\varphi(d)\longrightarrow0.      \tag{5.15}
\]

Hence the hypothesis `H/log log m -> infinity` in Theorem 5.3 cannot be
replaced, uniformly for all bounded masses, by `H=C log log m`.

#### Proof

Let

\[
 m_y=\prod_{p\le y}p.
\]

Under `mu_(m_y)`, write `K=m_y/D`.  Since `m_y` is squarefree, the events
`p|K` are independent and have probability `1/p`.

Choose an integer `r>C+1` and disjoint exponent intervals

\[
 0<u_1<v_1<\cdots<u_r<v_r<1,
 \qquad\sum_{i=1}^r u_i>C+1.                              \tag{5.16}
\]

Such intervals exist by placing all of them in a sufficiently short
interval below one.  Let `A_i(y)` be the event that at least one prime in
`(y^(u_i),y^(v_i)]` divides `K`.  Mertens's prime-product theorem yields

\[
 \Pr(A_i(y)^c)=
 \prod_{y^{u_i}<p\le y^{v_i}}(1-1/p)
 \longrightarrow\frac{u_i}{v_i}.                          \tag{5.17}
\]

The intervals are disjoint, so these events are independent.  Therefore

\[
 \liminf_{y\to\infty}\Pr\!\left(\bigcap_iA_i(y)\right)
 =\prod_i(1-u_i/v_i)>0.                                   \tag{5.18}
\]

On their intersection, `K>y^(C+1)`.  Chebyshev's two-sided estimates give
`log m_y=theta(y)` asymptotic to `y` up to positive constant factors, and
so eventually

\[
 y^{C+1}>(\log m_y)^C.
\]

This proves

\[
 \liminf_{y\to\infty}\mu_{m_y}
 \left\{D\le\frac{m_y}{(\log m_y)^C}\right\}>0,           \tag{5.19}
\]

which contradicts (5.15).  Taking the abstract mass `a_d=phi(d)` gives a
full-premise counterexample under `0<=a_d<=phi(d)`.  It is not a model of
the actual Mersenne masses and therefore does not retire the arithmetic
Mersenne route.  ∎

## 6. The uniform cap for actual Mersenne blocks

### Proposition 6.1 (cyclotomic cap)

The actual canonical Mersenne block satisfies

\[
 0\le a_d=\log E_d\le\varphi(d)\log3                    \tag{6.1}
\]

for every positive integer `d`.

#### Proof

The lower bound follows from `E_d>=1`.  Suppose a prime `p` occurs in
`E_d`.  Then `ord_p(2)=d`, so `p` is odd and `p` does not divide `d`.
The standard cyclotomic valuation identity in this coprime exact-order
case is

\[
 v_p(\Phi_d(2))=v_p(2^d-1).                              \tag{6.2}
\]

The exponent of `p` in `E_d` is one less than the right side.  Hence
`E_d` divides `Phi_d(2)`.  Finally, using the primitive complex roots of
unity,

\[
 0<\Phi_d(2)=\prod_{\substack{1\le k\le d\\(k,d)=1}}
       |2-e^{2\pi i k/d}|
 \le3^{\varphi(d)}.                                      \tag{6.3}
\]

Taking logarithms proves (6.1).  When `d=1`, `E_1=1` and the same bound is
immediate.  ∎

The upper cyclotomic evaluation bound in (6.3) is available in Mathlib as
`Polynomial.cyclotomic_eval_le_add_one_pow_totient`.  The Lean companion now
also proves the exact-order prime-power divisibility, combines the pairwise
coprime fibres, and obtains the unconditional canonical-block cap, including
the definitional edge case `d=0`.

## 7. The localized exact Mersenne gate

For fixed `epsilon,delta>0`, put

\[
 B_{\epsilon,\delta}^{\rm top}(m)=
 \sum_{\substack{d\mid m\\d>m^{1-\delta}\\
                  a_d>\epsilon\varphi(d)}}\varphi(d).     \tag{7.1}
\]

### Theorem 7.1 (near-diagonal exceptional-weight endpoint)

For the actual Mersenne blocks, and for any one fixed `delta>0`,

\[
 \log W_m=o(m)
 \quad\Longleftrightarrow\quad
 \text{for every fixed }\epsilon>0,
 \ B_{\epsilon,\delta}^{\rm top}(m)=o(m).                 \tag{7.2}
\]

#### Proof

Proposition 6.1 permits Theorem 3.2 with `C=log 3`.  The part of
`B_epsilon(m)` with `d<=m^(1-delta)` is at most the full totient weight of
that range, which is `o(m)` by Theorem 5.1.  Therefore `B_epsilon=o(m)` if
and only if its near-diagonal part (7.1) is `o(m)`.  Combine this with the
exact endpoint (1.2).  ∎

This changes the remaining positive target.  A pointwise estimate
`a_d=o(phi(d))` for every large `d` is sufficient but no longer necessary.
It is enough to show that, among divisors logarithmically close to each
index `m`, the orders with a fixed positive normalized excess carry
negligible totient weight.

Theorem 5.3 permits the stronger moving version: in (7.1), one may replace
`d>m^(1-delta)` by the range (5.14).  Proposition 5.4 shows why a proof based
only on the uniform cyclotomic cap cannot replace (5.14) by
`d>m/(log m)^C` for fixed `C`.

### Proposition 7.2 (prime and fixed-prime-power necessity)

The divisor-average endpoint always implies

\[
 a_m=o(m).                                                 \tag{7.3}
\]

Thus on every sequence on which `phi(m)/m` is bounded below, it still
forces `a_m/phi(m)->0`.  In particular, divisor averaging gives no escape
from pointwise control at prime indices or at powers of one fixed prime.

#### Proof

Every mass is nonnegative and the divisor sum defining `A(m)` contains the
term `a_m`, so `0<=a_m<=A(m)`.  This proves (7.3).  If
`phi(m)/m>=c>0`, then

\[
 \frac{a_m}{\varphi(m)}
 \le c^{-1}\frac{a_m}{m}\longrightarrow0.
\]

For a prime `ell`, the ratio is `1-1/ell`; for `m=p^a` it is the fixed
positive number `1-1/p`.  ∎

Large normalized blocks can therefore be tolerated only on orders with
small `phi(d)/d`, together with sufficient sparsity in the relevant
near-top divisor lattices.

### Proposition 7.3 (a weaker near-top multiplicity criterion)

Fix `0<delta<1`, and let

\[
 \mathcal N_{\epsilon,\delta}(m)=
 \{d\mid m:d>m^{1-\delta},\ a_d>\epsilon\varphi(d)\}.
\]

Suppose that, for each `epsilon>0`, there is `R_epsilon` such that eventually

\[
 \#\mathcal N_{\epsilon,\delta}(m)\le R_\epsilon           \tag{7.4}
\]

and, with the maximum over the empty set defined as zero,

\[
 \max_{d\in\mathcal N_{\epsilon,\delta}(m)}
       \frac{\varphi(d)}d\longrightarrow0.                 \tag{7.5}
\]

Then the near-diagonal gate in Theorem 7.1 holds.

#### Proof

Since every co-divisor `m/d` is at least one,

\[
\begin{aligned}
 \frac1m\sum_{d\in\mathcal N_{\epsilon,\delta}(m)}
       \varphi(d)
 &=\sum_{d\in\mathcal N_{\epsilon,\delta}(m)}
       \frac{\varphi(d)}d\frac1{m/d}\\
 &\le R_\epsilon
   \max_{d\in\mathcal N_{\epsilon,\delta}(m)}
       \frac{\varphi(d)}d=o(1).
\end{aligned}                                             \tag{7.6}
\]

Theorem 7.1 now applies.  ∎

This criterion is genuinely weaker than pointwise `a_d=o(phi(d))` in the
abstract setting.  Choose a rapidly growing chain of squarefree primorials
`n_1|n_2|...` with

\[
 n_{k-1}\le n_k^{1-\delta},
 \qquad \varphi(n_k)/n_k\longrightarrow0,                  \tag{7.7}
\]

and put `a_(n_k)=phi(n_k)`, with all other masses zero.  Pointwise little-oh
fails.  At most one `n_k` can lie in the near-top set for any `m`, and the
index of that possible member tends to infinity.  Hence (7.4)--(7.5) hold.
This is a strictness witness for the abstract implication, not an assertion
about actual cyclotomic valuations.

## 8. Counterexample audit

### Proposition 8.1 (unweighted divisor counts cannot replace totient weight)

There is a sequence of divisor sets whose unweighted relative cardinality
tends to zero while their totient weight stays bounded away from zero.

#### Proof

Take `m_a=2^a` and the singleton divisor set `S_a={m_a}`.  Since
`tau(2^a)=a+1`,

\[
 \frac{|S_a|}{\tau(m_a)}=\frac1{a+1}\longrightarrow0.
\]

But

\[
 \frac1{m_a}\sum_{d\in S_a}\varphi(d)
 =\frac{\varphi(2^a)}{2^a}=\frac12                    \tag{8.1}
\]

for every `a>=1`.  ∎

This is a full-premise counterexample only to a **sequence-indexed or
triangular** inference that replaces totient weight by cardinality.  It is
not an arithmetic counterexample to (7.2), and it does not refute the
Mersenne route.  A fixed exceptional set obeys additional compatibility
across multiples, so no stronger conclusion is attributed to this witness.

### Proposition 8.2 (finite computation cannot retire the tail)

A search through finitely many exact-order blocks cannot disprove an
eventual statement in (7.2) unless it produces a symbolic infinite family
or a single object contradicting a genuinely universal finite premise.

#### Proof

Every assertion in (7.2) has an eventual quantifier: for each error there
may be a larger threshold.  Finitely many computed values can always be
absorbed into that threshold.  Thus a finite no-hit is evidence only, while
a finite hit refutes only a universal claim that included that exact value.
∎

This quantifier audit implements the route policy used throughout the
project: difficulty and missing estimates keep a route open; only a
full-premise counterexample retires the exact claim it contradicts.

### Proposition 8.3 (finite exact-order obstructions to naive linear caps)

The universal shortcut `E_d<=2d` is false.

#### Proof

The already verified exact-order witnesses give

\[
 3511\mid E_{1755},\qquad 3511>2\cdot1755,
\]

and

\[
 1093\mid E_{364},\qquad 1093>2\cdot364.
\]

The first is particularly instructive: `phi(1755)=864`, so for every
`epsilon<log(3511)/864`, the normalized exceptional set contains an odd
order with `phi(d)/d` approximately `0.4923`.  These are full-premise
counterexamples to the stated universal finite shortcuts.  They do not
contradict any eventual exceptional-weight estimate.  ∎

## 9. Formalization plan and remaining theorem

The companion Lean module formalizes, in this order:

1. the exceptional totient mass (3.2);
2. both finite inequalities in Proposition 3.1;
3. both directions of Theorem 3.2;
4. moving-region and exceptional-mass decompositions, including both
   directions of the localized exact criterion;
5. the small-divisor conclusion from an explicit concentration hypothesis;
6. the resulting conditional bridge to the already formalized exact
   Mersenne endpoint;
7. nonnegativity of the finite logarithmic-deficit moment and the exact
   finite Markov inequality for every moving divisor region;
8. the asymptotic Markov passage from a stated moment little-oh estimate to
   totient concentration;
9. the prime-power moment identity, the global von-Mangoldt convolution,
   the exact prime-factor formula (4.2), and the elementary fixed-cutoff
   proof of (4.4);
10. the dyadic Chebyshev estimate giving the explicit `O(log log(3m))`
    moment bound (5.5);
11. fixed-`delta` concentration, the general moving-window theorem under
    `log log(3m)/H(m)=o(1)`, and the unconditional squared-loglog instance
    (5.13)--(5.14);
12. positivity and product factorization of `Phi_d(2)`, the exact-order
    prime-power divisibility, the canonical-block divisibility, and the
    unconditional cap of Proposition 6.1;
13. the actual moving localized Mersenne equivalence with no cap or
    concentration premise left; and
14. the power-of-two divisor count and top-singleton totient ratio behind
    Proposition 8.1.

Consequently the exact moment, its `O(log log(3m))` form, the logarithmic-tail
formulation underlying (5.14), and Proposition 6.1 are kernel checked.  The
near-diagonal exceptional-weight estimate displayed below is still open and
is not installed as an axiom.

After Theorem 7.1, the remaining Mersenne problem is the near-diagonal
exceptional-weight estimate

\[
 \forall\epsilon>0:\quad
 \sum_{\substack{d\mid m\\
       d>m\exp(-\{\log\log(3m)\}^2)\\
       \log E_d>\epsilon\varphi(d)}}\varphi(d)=o(m)       \tag{9.1}
\]

No unconditional theorem presently in the repository proves (9.1), and no
full-premise counterexample is known.
Accordingly this route is narrowed but not abandoned.

## 10. Primary-source boundary checked on 1 September 2026

1. F. Mertens, *Ein Beitrag zur analytischen Zahlentheorie*, J. Reine
   Angew. Math. 78 (1874), 46--62,
   DOI `10.1515/crll.1874.78.46`, supplies the classical prime-product
   asymptotic used only for the sharpness construction in Proposition 5.4.
   The positive estimate in Theorem 5.3 needs only Chebyshev's elementary
   upper bound for `theta(x)`; Mathlib contains a suitable explicit form as
   `Chebyshev.theta_le_log4_mul_x`.
2. A. Granville, *Primitive prime factors in second order linear recurrence
   sequences*, arXiv:1212.6306, proves an odd-valuation primitive prime in
   the relevant Lucas setting outside the stated small indices.  For a
   Mersenne level this produces a valuation-one versus valuation-at-least-
   three dichotomy for one primitive prime.  It removes only one logarithmic
   contribution and gives no weighted estimate for all exact-order primes.
3. M. Ram Murty and F. Séguin, *Prime divisors of sparse values of
   cyclotomic polynomials and Wieferich primes*, J. Number Theory 201
   (2019), 1--22, DOI `10.1016/j.jnt.2019.02.016`, supplies exact valuation
   and order reindexing and conditional consequences of finiteness of a
   super-Wieferich set.  It does not estimate the near-top exceptional
   totient weight.
4. C. Pomerance, *Cyclotomic primes*, J. Number Theory 276 (2025), 198--208,
   DOI `10.1016/j.jnt.2025.02.013`, proves unconditional compositeness
   results for many primitive parts; stronger distinct-factor conclusions
   use abc.  It gives no upper bound for the powerful part in one prescribed
   exact-order fibre.
5. N. Fellini and M. Ram Murty, *Wieferich primes in number fields and the
   conjectures of Ankeny--Artin--Chowla and Mordell*, J. Number Theory
   (2026), DOI `10.1016/j.jnt.2026.01.002`, proves non-Wieferich lower bounds
   under number-field abc or finiteness of super-Wieferich primes.  Its
   results are not weighted by exact-order fibres.
6. A. Falk, J. Harrington, and L. Jones, *Generalized Wieferich primes and
   monogenic trinomials*, arXiv:2607.29329v1 (31 July 2026), gives
   monogenicity congruence equivalences.  It provides no counting, depth, or
   exceptional-totient estimate.
7. T. Browning and M. Verzobio, *Sums of three powerful numbers*,
   arXiv:2608.24512 (25 August 2026), gives new power-saving counts for
   primitive Campana points in broad exponent ranges.  Its uniform
   generalized-Fermat estimates do not currently imply the exact-order
   Mersenne gate (9.1).

No checked source proves (9.1), its moving version with (5.14), or the
bounded near-top bad-order multiplicity in Proposition 7.3.  Conversely, no
checked source supplies a full-premise counterexample to those statements.
