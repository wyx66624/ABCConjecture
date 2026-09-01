# The printed global-omega hypothesis in Carella's proposed abc disproof

**Author:** ChatGPT  
**Date and literature cut-off:** 1 September 2026  
**Status:** a rigorous counterexample to one printed hypothesis and a retained,
strictly broader positive disproof target; neither a proof nor a disproof of abc.

## 1. Scope and route policy

This note audits one statement that was not isolated in the earlier repository
reports.  It does not reopen conclusions that have already been proved in
`ANALYTIC_ROUTE_SESSION_2026_08_30.md` and
`GLOBAL_ABC_PT_ALMOST_ALL_AMPLIFICATION_AUDIT.md`.

The current arXiv version of N. A. Carella,
[*Note on the Exceptional Set in the ABC Conjecture*, arXiv:2608.16764v2](https://arxiv.org/abs/2608.16764v2),
was last revised on 24 August 2026.  Its abstract claims an unconditional
infinite exceptional set.  Theorem 5.1, printed p. 12, assumes

\[
 \#\{n\le x:\omega(n)>w\}=o(x^{3/5}),                 \tag{1.1}
\]

where

\[
 w=A(\log\log y)^{1/2+\delta}
 \quad\hbox{and later}\quad w\le 2\log\log x.         \tag{1.2}
\]

The gloss after (1.1) instead discusses smooth integers in the short interval
`[x,x+h]`.  Thus the displayed formula and its prose describe different sets.
Section 2 below gives a counterexample to the displayed global formula with all
of its printed parameters.  This is a reason to reject that formula and the
claimed unconditional invocation of Theorem 5.1.  It is not a reason to reject
the broader prime-power-neighbour route.

The exact source PDFs, metadata, page counts, and SHA-256 hashes are already
pinned in
`research/sources/exceptional_claim_audit_2026_08_31/`.  A fresh check of the
official arXiv records on 1 September 2026 found no version later than v2 for
Carella and no version later than v1 for Khalid Younis,
[*Asymptotics for smooth numbers in short intervals*, arXiv:2409.05761](https://arxiv.org/abs/2409.05761).

## 2. An elementary counterexample to the printed hypothesis

Write `omega(n)` for the number of distinct prime divisors of `n`.  Let

\[
       p_1=2<p_2<p_3<\cdots,
       \qquad Q_r=\prod_{j=1}^{r}p_j.                  \tag{2.1}
\]

### Theorem 2.1 (primorial-multiple lower bound)

For every real `w>=0`, put `r=floor(w)+1`.  For every `x>=Q_r`,

\[
 \#\{n\le x:\omega(n)>w\}
       \ \ge\ \left\lfloor{x\over Q_r}\right\rfloor. \tag{2.2}
\]

#### Proof

For every integer `1<=m<=floor(x/Q_r)`, the integer `mQ_r` is at most `x`.
Every one of the distinct primes `p_1,...,p_r` divides `mQ_r`, so

\[
             \omega(mQ_r)\ge r=\lfloor w\rfloor+1>w.  \tag{2.3}
\]

The integers `mQ_r` are distinct because `Q_r>0`.  They therefore give the
claimed injection into the set on the left of (2.2).  This proves the theorem.
\(\square\)

### Theorem 2.2 (failure at Carella's moving threshold)

Suppose `w=w(x)>=0` and, for all sufficiently large `x`,

\[
                       w(x)\le2\log\log x.             \tag{2.4}
\]

Then

\[
 \#\{n\le x:\omega(n)>w(x)\}=x^{1-o(1)}.             \tag{2.5}
\]

In particular, this cardinality is not `o(x^(3/5))`.

#### Proof

Let `r=floor(w(x))+1`.  Bertrand's postulate gives `p_{j+1}<2p_j`; induction
from `p_1=2` gives `p_j<=2^j`.  Hence

\[
 \log Q_r=\sum_{j\le r}\log p_j
       \le {r(r+1)\over2}\log2.                       \tag{2.6}
\]

By (2.4), `r<=2 log log x+1`, and therefore

\[
                    \log Q_r=O((\log\log x)^2)=o(\log x).
                                                               \tag{2.7}
\]

Thus `Q_r=x^{o(1)}`.  Theorem 2.1 gives

\[
 \#\{n\le x:\omega(n)>w(x)\}
       \ge\lfloor x/Q_r\rfloor=x^{1-o(1)}.            \tag{2.8}
\]

The reverse bound by `x` is trivial, proving (2.5).  Dividing (2.8) by
`x^(3/5)` gives `x^(2/5-o(1))`, which tends to infinity.  Hence (1.1) is
false. \(\square\)

This proof is stronger than a finite computation: it supplies a full
asymptotic counterfamily satisfying the displayed threshold.  It uses only
Bertrand's postulate and divisibility.

## 3. What the counterexample does and does not reject

Theorem 2.2 rejects the displayed global condition (1.1).  The condition is
not proved before Theorem 5.1, and Theorem 1.1 later treats Theorem 5.1 as if
its hypotheses had been discharged.  Consequently the unconditional
conclusion does not follow.

If (1.1) is corrected to count only `B`-smooth integers in `[x,x+x^(3/5)]`,
Theorem 2.2 no longer applies literally.  The earlier repository theorem gives
a sharper audit of that intended statement: in the Younis regime almost every
smooth integer in the interval has much more than `2 log log x` distinct prime
factors.  That refutes the proposed majority and moment mechanism.  It still
does not rule out one exceptionally sparse low-radical integer in infinitely
many prime-power-centred intervals.

Accordingly, only the following exact mechanisms are rejected:

1. the global estimate (1.1) at the printed threshold;
2. the claim that Theorem 5.1 has been invoked unconditionally;
3. the previously refuted relative moment estimates asserting that most local
   smooth integers have small `omega`.

The following routes remain active:

1. an unbounded zero-density subsequence of low-radical neighbours;
2. a weighted or tilted short-interval theorem that directly extracts such a
   neighbour;
3. constructions based on perfect powers, Pell recurrences, polynomial
   identities, or congruence packets rather than ordinary smooth-number
   density;
4. any other way to control the radical itself without controlling `omega` and
   the largest prime factor separately.

## 4. A broader positive target than smooth plus low omega

The numerical heart of the proposed construction is valid and admits a wider
formulation.

### Theorem 4.1 (radical-neighbour disproof threshold)

Fix an integer `k>=1` and real numbers `theta,sigma,epsilon` with

\[
 \theta\ge0,\qquad\sigma\ge0,\qquad\epsilon>0,
 \qquad(\theta+1/k+\sigma)(1+\epsilon)<1.              \tag{4.1}
\]

Suppose there are infinitely many primes `p` and integers `c` such that, with
`X=p^k`,

\[
 X<c\le X+X^\theta,\qquad p\nmid c,
 \qquad \operatorname{rad}(c)\le X^{\sigma+o(1)},     \tag{4.2}
\]

and the corresponding values of `X` are unbounded.  Then the standard abc
conjecture is false.

#### Proof

Put

\[
                    a=c-p^k,\qquad b=p^k.              \tag{4.3}
\]

The assumption `p` does not divide `c` gives `gcd(b,c)=1`; subtracting `b`
from `c` also gives `gcd(a,b)=gcd(a,c)=1`.  Hence `(a,b,c)` is a primitive
positive abc triple.  Radical submultiplicativity and
`rad(p^k)=p=X^(1/k)` give

\[
 \operatorname{rad}(abc)
 \le a\,p\,\operatorname{rad}(c)
 \le X^{\theta+1/k+\sigma+o(1)}.                      \tag{4.4}
\]

Let

\[
             \eta=1-(1+\epsilon)(\theta+1/k+\sigma)>0. \tag{4.5}
\]

The `o(1)` term in (4.4) may be made smaller than
`eta/(2(1+epsilon))`.  Since `c>X`, this gives

\[
 {c\over\operatorname{rad}(abc)^{1+\epsilon}}
       \ge X^{\eta/2}\longrightarrow\infty.           \tag{4.6}
\]

No constant depending only on `epsilon` can bound this ratio, contradicting
abc. \(\square\)

For the short-interval exponent `theta=3/5`, the decisive target is simply

\[
                         \sigma<{2\over5}-{1\over k}.  \tag{4.7}
\]

This reveals that Carella's requirement `rad(c)=X^o(1)` is much stronger than
necessary.  For example, when `k=4`, every fixed `sigma<3/20` leaves a positive
gap; as `k` grows, the permitted radical exponent approaches `2/5`.  Future
positive work should therefore search directly below (4.7), even when the
candidate is not conventionally smooth or has more than `2 log log X` prime
factors.

### Proposition 4.2 (exact positive-density exponent window)

Suppose `k>=3` and the candidates in Theorem 4.1 are required for a fixed positive
proportion of prime centres `p^k` in each sufficiently large dyadic block.
Then the low-radical counting theorem already proved in
`LOW_RADICAL_DENSITY_BARRIER_2026.md` forces

\[
                              \sigma\ge {1\over k}.     \tag{4.8}
\]

There exists a `sigma` satisfying both (4.7) and (4.8) if and only if

\[
                              k>5.                     \tag{4.9}
\]

For every integer `k>=6`, the single choice `sigma=1/5` lies in the feasible
window.

#### Proof

The cited Rankin bound gives at most `X^(sigma+eta)` integers up to `X` with
radical at most `X^sigma`, for every fixed `eta>0`.  The prime number theorem
and disjointness of the `X^(3/5)` candidate intervals give
`X^(1/k+o(1))` distinct candidates for a positive proportion of the prime
centres.  Hence `sigma>=1/k`, proving (4.8).

Combining (4.7) and (4.8), a feasible `sigma` exists exactly when

\[
 {1\over k}<{2\over5}-{1\over k}
 \quad\Longleftrightarrow\quad {2\over k}<{2\over5}
 \quad\Longleftrightarrow\quad k>5.                   \tag{4.10}
\]

If `k>=6`, then `1/k<=1/6<1/5`, while

\[
 {3\over5}+{1\over k}+{1\over5}
 \le {3\over5}+{1\over6}+{1\over5}
 ={29\over30}<1.                                     \tag{4.11}
\]

Thus `sigma=1/5` satisfies both bounds. \(\square\)

For `k=1,2`, the target (4.7) is already empty because `sigma>=0`.  This
proposition rejects the positive-density versions for `3<=k<=5` by a full
counting contradiction.  It does not reject sparse subsequences for
`3<=k<=5`.  It also gives a concrete positive target for `k>=6`: neighbour
radical exponent `1/5` is enough, and density counting does not forbid it.

The deterministic arithmetic content of Theorem 4.1 is already represented
in `IUTThreeClosures/PrimePowerSmoothNeighbour.lean` and
`IUTThreeClosures/SubcriticalRadicalSlopeDisproofGate.lean`.  The new Lean
module accompanying this note will formalize the finite primorial-multiple
lower bound and connect the wider threshold (4.7) to that existing gate.  It
will not insert the missing infinite family as an axiom.

## 5. Exact remaining mathematical gate

For any fixed `k>=3`, define the one-sided radical-neighbour exponent

\[
 \lambda_k(X)=
 \inf_{\substack{p^k=X<c\le X+X^{3/5}\\p\nmid c}}
       {\log\operatorname{rad}(c)\over\log X},         \tag{5.1}
\]

with the infimum set to `+infinity` when the interval has no admissible
integer.  A sufficient disproof theorem is

\[
        \liminf_{\substack{p\to\infty\\p\ \mathrm{prime}}}
              \lambda_k(p^k)<{2\over5}-{1\over k}.     \tag{5.2}
\]

Ordinary smooth-number existence does not prove (5.2), because the radical of
a smooth number can still be large.  A majority theorem is unnecessary:
(5.2) needs only an infinite subsequence.  This is the live analytic and
Diophantine gate retained after the counterexample in Section 2.

No unconditional proof of (5.2), and no counterexample to (5.2), is presently
known in this repository.  The route therefore remains active under the stated
research policy.
