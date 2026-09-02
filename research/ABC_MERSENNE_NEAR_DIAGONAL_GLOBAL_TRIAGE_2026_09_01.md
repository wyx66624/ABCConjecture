# Global Near-Diagonal Triage for the Mersenne Powerful Part

**Author:** ChatGPT  
**Date:** 2026-09-01  
**Status:** unconditional reduction and exact abstract counterexamples; this
does not prove or disprove the standard abc conjecture.

## 1. Purpose

Put

\[
 M_m=2^m-1,
 \qquad W_m=\frac{M_m}{\operatorname{rad}(M_m)}.
\]

The previous order-block and totient-concentration arguments proved

\[
 W_m=L_m\prod_{d\mid m}E_d,
 \qquad L_m\mid m,                                      \tag{1.1}
\]

and localized the unresolved divisor mass to

\[
 \mathcal N_m=
 \left\{d\mid m:
 d>m\exp\!\left(-\bigl(\log\log(3m)\bigr)^2\right)
 \right\}.                                               \tag{1.2}
\]

This note combines that global localization with the blockwise
Wieferich-prime decomposition.  A failure of `log W_m=o(m)` cannot be spread
arbitrarily over the divisor lattice: after passage to a subsequence it must
consume a positive linear logarithmic mass in one of exactly three explicit
near-diagonal mechanisms.  In the transition mechanism it forces
`Omega(m/log m)` distinct base-two Wieferich primes.

No density theorem currently excludes any of the three resulting weighted
alternatives.  The theorem is therefore a sharper obstruction ledger, not a
claim that the Mersenne route is closed.

## 2. Exact-order blocks and four exponent layers

For an odd prime `q`, write

\[
 d_q=\operatorname{ord}_q(2),
 \qquad w_q=v_q(2^{d_q}-1).
\]

For `d>=1`, define

\[
 \mathcal W_d=\{q:d_q=d,\ w_q\ge2\},
 \qquad
 D_d=\prod_{\substack{d_q=d\\w_q\ge3}}q^{w_q-2},       \tag{2.1}
\]

and

\[
 Y_d=\frac{\varphi(d)^2}{\log\log(3d)}.                 \tag{2.2}
\]

Fix `delta>0`.  Split the logarithm of the canonical excess block into

\[
\begin{aligned}
 S_d&=\sum_{\substack{q\in\mathcal W_d\\q\le Y_d}}\log q,\\
 T_{d,\delta}
   &=\sum_{\substack{q\in\mathcal W_d\\Y_d<q\le d^{2+\delta}}}\log q,\\
 X_{d,\delta}
   &=\sum_{\substack{q\in\mathcal W_d\\q>d^{2+\delta}}}\log q,\\
 G_d&=\log D_d
     =\sum_{\substack{d_q=d\\w_q\ge3}}(w_q-2)\log q.
                                                               \tag{2.3}
\end{aligned}
\]

The exponent identity `w_q-1=1+(w_q-2)` gives the exact decomposition

\[
                 \log E_d=S_d+T_{d,\delta}+X_{d,\delta}+G_d. \tag{2.4}
\]

Every term is nonnegative.  Moreover, `w_q>=2` is exactly the base-two
Wieferich condition, because LTE gives

\[
 v_q(2^{q-1}-1)=v_q(2^{d_q}-1)=w_q.                    \tag{2.5}
\]

## 3. Two unconditional negligible arms

Let

\[
 H(m)=\bigl(\log\log(3m)\bigr)^2.
\]

The cyclotomic cap `E_d<=3^phi(d)` and the exact logarithmic-deficit moment
for the probability `mu_m(d)=phi(d)/m` imply

\[
 \sum_{\substack{d\mid m\\d\notin\mathcal N_m}}\log E_d=o(m). \tag{3.1}
\]

Indeed, Markov's inequality gives

\[
 \frac1m\sum_{\substack{d\mid m\\d\notin\mathcal N_m}}\varphi(d)
 \ll \frac{\log\log(3m)}{H(m)}
 =\frac1{\log\log(3m)},                                \tag{3.2}
\]

and multiplication by `log 3` proves (3.1).

Brun--Titchmarsh gives the uniform blockwise estimate

\[
                         S_d=o(\varphi(d))\qquad(d\to\infty). \tag{3.3}
\]

This also sums uniformly on the moving near-diagonal set:

\[
                     \sum_{d\in\mathcal N_m}S_d=o(m).         \tag{3.4}
\]

### Proof

Write `r(d)=S_d/phi(d)`.  Equation (3.3) says `r(d)->0`.  Since

\[
 \log\bigl(m e^{-H(m)}\bigr)=\log m-H(m)\longrightarrow\infty,
\]

the least possible member of `N_m` tends to infinity.  Hence

\[
 \sum_{d\in\mathcal N_m}S_d
 \le
 \left(\sup_{d>m e^{-H(m)}}r(d)\right)
 \sum_{d\mid m}\varphi(d)
 =o(1)m,                                                \tag{3.5}
\]

using `sum_(d|m) phi(d)=m`.  This proves (3.4).  ∎

## 4. The global near-diagonal obstruction theorem

### Theorem 4.1 (global three-arm obstruction)

Fix `delta>0`.  Suppose there are `epsilon>0` and an unbounded sequence
`m_j` such that

\[
                  \sum_{d\mid m_j}\log E_d\ge\epsilon m_j.   \tag{4.1}
\]

After passage to a subsequence, at least one fixed alternative holds for
every sufficiently large `j`:

1. **aggregate deep lifts**
   \[
    \sum_{d\in\mathcal N_{m_j}}G_d\ge\frac{\epsilon m_j}{6}; \tag{4.2}
   \]
2. **aggregate transition clustering:** there are at least
   \[
    \frac{\epsilon m_j}
         {6(2+\delta)\log m_j}                              \tag{4.3}
   \]
   distinct base-two Wieferich primes `q`, each satisfying
   \[
    d_q\mid m_j,
    \quad d_q>m_j e^{-H(m_j)},
    \quad Y_{d_q}<q\le d_q^{2+\delta};                      \tag{4.4}
   \]
3. **aggregate extreme small order**
   \[
    \sum_{d\in\mathcal N_{m_j}}X_{d,\delta}
       \ge\frac{\epsilon m_j}{6}.                          \tag{4.5}
   \]

Every prime in (4.5) satisfies

\[
          \operatorname{ord}_q(2)<q^{1/(2+\delta)}.         \tag{4.6}
\]

### Proof

By (3.1) and (3.4), after deleting finitely many `j` the far-diagonal mass
and the near-diagonal small-support mass are each at most
`epsilon*m_j/4`.  Summing (2.4) over `d|m_j` and subtracting those two
nonnegative contributions gives

\[
 \sum_{d\in\mathcal N_{m_j}}
   \bigl(G_d+T_{d,\delta}+X_{d,\delta}\bigr)
 \ge \frac{\epsilon m_j}{2}.                              \tag{4.7}
\]

At least one of the three sums in (4.7) is at least
`epsilon*m_j/6`.  Infinite pigeonhole fixes the same arm on a subsequence.
This proves (4.2) or (4.5), or gives

\[
 \sum_{d\in\mathcal N_{m_j}}T_{d,\delta}
 \ge\frac{\epsilon m_j}{6}.                              \tag{4.8}
\]

In the last case every summand `log q` is at most
`(2+delta)log m_j`.  A prime has one multiplicative order, so the prime sets
belonging to distinct `d` are disjoint.  Dividing (4.8) by the common upper
bound proves (4.3), and (2.5) proves that all counted primes are Wieferich.
The defining inequalities give (4.4).  Finally `q>d^(2+delta)` implies
`d<q^(1/(2+delta))`, which is (4.6).  ∎

## 5. A sufficient three-gate closure

### Corollary 5.1 (three aggregate estimates suffice)

For one fixed `delta>0`, assume as `m->infinity` that

\[
 \sum_{d\in\mathcal N_m}G_d=o(m),                         \tag{5.1}
\]

that the number of transition primes in (4.4) is

\[
                            o\!\left(\frac m{\log m}\right), \tag{5.2}
\]

and that

\[
 \sum_{d\in\mathcal N_m}X_{d,\delta}=o(m).              \tag{5.3}
\]

Then

\[
                     \log W_m=o(m).                       \tag{5.4}
\]

### Proof

The transition contribution is at most `(2+delta)log m` times the number in
(5.2), hence is `o(m)`.  Equations (3.1), (3.4), and (5.1)--(5.3), summed in
(2.4), give `sum_(d|m) log E_d=o(m)`.  Equation (1.1) and `L_m|m` give
`log L_m<=log m=o(m)`, proving (5.4).  ∎

This corollary replaces a stronger pointwise demand by three divisor-averaged
targets on the exact moving range that survives the unconditional
concentration theorem.

## 6. Exact counterexamples to deleting a disjunct

The three alternatives in the finite mass argument cannot be reduced by
nonnegativity alone.  On a one-point near set, take total target mass `1`,
far mass and small mass `0`, and respectively

\[
 (G,T,X)=(1,0,0),\qquad(0,1,0),\qquad(0,0,1).             \tag{6.1}
\]

Each choice satisfies the exact decomposition and every numerical premise of
the finite triage, while either of the other two arms vanishes.  Thus a
two-disjunct algebraic strengthening has a full-premise counterexample.
These are abstract mass examples, not claimed realizations by Mersenne order
blocks, and they do not retire any of the three arithmetic routes.

## 7. Lean boundary

The companion Lean module should formalize, after the proofs above:

1. the finite near/far subtraction inequality;
2. the aggregate deep/transition/extreme trichotomy with the constant `1/6`;
3. the transition-cardinality lower bound under a uniform logarithmic cap;
4. the sufficient finite closure inequality; and
5. the three complete one-point counterexamples to deleting a disjunct.

The analytic statements (3.1), (3.3), and their application to actual
Mersenne blocks remain cited mathematical inputs.  They must not be inserted
as Lean axioms.  The Lean theorem is the exact finite ordered-ring core used
after those proved analytic estimates have been supplied.

## 8. Source boundary

- T. Browning and M. Verzobio, *Sums of three powerful numbers*,
  [arXiv:2608.24512](https://arxiv.org/abs/2608.24512).  This concerns a
  different Campana counting route and does not supply (5.1)--(5.3).
- N. Fellini and M. Ram Murty, *Wieferich primes in number fields and the
  conjectures of Ankeny--Artin--Chowla and Mordell*,
  [arXiv:2508.08472v2](https://arxiv.org/abs/2508.08472).  Its unconditional
  conclusion under finiteness of super-Wieferich primes counts
  non-Wieferich primes; it does not bound the weighted exact-order sets here.
- A. Falk, J. Harrington, and L. Jones, *Generalized Wieferich primes and
  monogenic trinomials*,
  [arXiv:2607.29329](https://arxiv.org/abs/2607.29329).  It supplies a recent
  structural appearance of the same Wieferich congruence, not an order-block
  density estimate.
- P. Erdos and M. Ram Murty, *On the order of a modulo p*, CRM Proceedings
  and Lecture Notes 19 (1999), 87--97.  Its almost-all theorem locates the
  extreme arm in an exceptional prime set but gives no weighted bound along
  divisors of a single Mersenne number.

The standard abc conjecture and its negation remain unproved here.  No broad
route is abandoned.
