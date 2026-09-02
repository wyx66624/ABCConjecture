# The fixed-polylogarithmic co-divisor gate for the Mersenne endpoint

**Author:** ChatGPT  
**Date:** 1 September 2026

## 1. Scope and status

This note sharpens the divisor-average formulation of the Mersenne route.
It proves that the unresolved exceptional mass may be tested in every
**fixed polylogarithmic co-divisor window**.  The result is an exact
equivalence, not a new hypothesis:

\[
 \log W_m=o(m)
 \quad\Longleftrightarrow\quad
 \forall\epsilon>0\ \forall k\in\mathbb Z_{>0},\qquad
 B^{\mathrm{poly}}_{\epsilon,k}(m)=o(m).                 \tag{1.1}
\]

The order of the quantifiers is essential.  Given a requested error, one
first chooses a sufficiently large but fixed `k`; only then does one let
`m` tend to infinity.  No single fixed polylogarithmic tail is asserted to
have totient weight `o(m)`.

The argument is unconditional relative to the Mersenne definitions already
proved in the repository.  It uses the exact divisor identity, the
cyclotomic cap, and the elementary Chebyshev bound already formalized in
`MersenneTotientDivisorConcentration20260901.lean`.  It does **not** prove
the localized exceptional estimate on the right of (1.1), and hence it does
not close the abc conjecture.  No route is discarded: the theorem replaces
one global target by a quantitatively equivalent family of local targets.

## 2. Definitions

For a positive integer `d`, let

\[
 E_d=\prod_{\substack{p\mid 2^d-1\\
                 \operatorname{ord}_p(2)=d}}
       p^{v_p(2^d-1)-1},
 \qquad a_d=\log E_d.                                    \tag{2.1}
\]

The already proved exact Mersenne decomposition reduces the endpoint to

\[
 \log W_m=o(m)
 \quad\Longleftrightarrow\quad
 A(m):=\sum_{d\mid m}a_d=o(m).                            \tag{2.2}
\]

The canonical block has the unconditional cyclotomic cap

\[
 0\le a_d\le (\log 3)\varphi(d).                          \tag{2.3}
\]

For `epsilon>0`, define the full normalized-excess mass

\[
 B_\epsilon(m)=
 \sum_{\substack{d\mid m\\a_d>\epsilon\varphi(d)}}
       \varphi(d).                                        \tag{2.4}
\]

Put

\[
 L_m=\log\log(3m).                                       \tag{2.5}
\]

For `m>=1`, this number is positive.  For a fixed real `A>0`, define

\[
 B^{\mathrm{poly}}_{\epsilon,A}(m)=
 \sum_{\substack{d\mid m\\
       \log(m/d)<A L_m\\
       a_d>\epsilon\varphi(d)}}\varphi(d).                \tag{2.6}
\]

Writing the co-divisor as `q=m/d`, the window is equivalently

\[
 q<\exp(A L_m)=\{\log(3m)\}^{A}.                         \tag{2.7}
\]

The strict inequality in (2.6) is paired with the closed far tail

\[
 T_A(m)=
 \sum_{\substack{d\mid m\\
       A L_m\le\log(m/d)}}\varphi(d).                     \tag{2.8}
\]

Thus every divisor lies in exactly one of the two regions, including the
boundary case.

## 3. The finite Markov approximation

Give the divisors of `m` the totient probability

\[
 \mu_m(d)=\frac{\varphi(d)}m,
 \qquad \sum_{d\mid m}\varphi(d)=m.                      \tag{3.1}
\]

Let

\[
 \Delta(m)=\frac1m\sum_{d\mid m}
       \varphi(d)\log\frac md.                            \tag{3.2}
\]

The exact moment calculation already proved in the repository is

\[
 \Delta(m)=
 \sum_{p^r\parallel m}
   \frac{1-p^{-r}}{p-1}\log p.                            \tag{3.3}
\]

Chebyshev's elementary estimate for the first prime Chebyshev function,
followed by a dyadic split, gives constants `C_0>0` and `m_0` such that

\[
 \Delta(m)\le C_0L_m\qquad(m\ge m_0).                    \tag{3.4}
\]

### Proposition 3.1 (finite far-tail bound)

For every `m>=m_0` and every fixed `A>0`,

\[
 T_A(m)\le\frac{C_0}{A}m.                                \tag{3.5}
\]

#### Proof

Every divisor counted by `T_A(m)` satisfies
`log(m/d)>=A L_m`.  All weights and all logarithmic deficits are
nonnegative.  Therefore finite weighted Markov gives

\[
 A L_m T_A(m)
 \le\sum_{d\mid m}\varphi(d)\log\frac md
 =m\Delta(m)
 \le C_0mL_m.                                            \tag{3.6}
\]

Because `A L_m>0`, division by it proves (3.5).  This is a finite
inequality for each `m`; no limiting probability theorem is used.  ∎

### Proposition 3.2 (finite polylogarithmic approximation)

For every `epsilon>0`, `A>0`, and `m>=m_0`,

\[
 0\le B_\epsilon(m)-B^{\mathrm{poly}}_{\epsilon,A}(m)
 \le T_A(m)\le\frac{C_0}{A}m.                            \tag{3.7}
\]

#### Proof

The localized exceptional set is a subset of the full exceptional set, so
the first difference is nonnegative.  Its complement inside the full set
has `log(m/d)>=A L_m`; after forgetting the exceptional condition its
totient weight is at most `T_A(m)`.  Proposition 3.1 gives the last
inequality.  ∎

Equation (3.7) is the required **uniform-in-`m`, fixed-`A` approximation**.
The error is `C_0/A`, not a quantity tending to zero with `m`.  Its utility
comes from being able to choose arbitrarily large fixed `A`.

## 4. The exact endpoint theorem

We first recall the finite bounded-convergence criterion behind the global
exceptional mass.

### Lemma 4.1 (global exceptional criterion)

If `0<=a_d<=C phi(d)` for a fixed `C`, then

\[
 \sum_{d\mid m}a_d=o(m)
 \quad\Longleftrightarrow\quad
 \forall\epsilon>0,\quad B_\epsilon(m)=o(m).              \tag{4.1}
\]

#### Proof

On the exceptional set,
`epsilon phi(d)<a_d`; hence

\[
 \epsilon B_\epsilon(m)\le\sum_{d\mid m}a_d.             \tag{4.2}
\]

Conversely split into `a_d<=epsilon phi(d)` and its complement.  The
totient identity gives

\[
 \sum_{d\mid m}a_d
 \le \epsilon\sum_{d\mid m}\varphi(d)+CB_\epsilon(m)
 =\epsilon m+CB_\epsilon(m).                              \tag{4.3}
\]

Equations (4.2)--(4.3), with `epsilon` chosen after the requested error in
the reverse direction, prove the equivalence.  ∎

### Theorem 4.2 (fixed-polylogarithmic co-divisor gate)

For the actual Mersenne canonical blocks, the following are equivalent:

1. `log W_m=o(m)`;
2. for every fixed `epsilon>0` and every fixed real `A>0`,
   `B^{poly}_{epsilon,A}(m)=o(m)`;
3. for every fixed `epsilon>0` and every fixed positive integer `k`,
   `B^{poly}_{epsilon,k}(m)=o(m)`.

#### Proof

By (2.2), (2.3), and Lemma 4.1, statement 1 is equivalent to

\[
 \forall\epsilon>0,\qquad B_\epsilon(m)=o(m).             \tag{4.4}
\]

If (4.4) holds, then every localized mass is `o(m)` because it is
nonnegative and bounded above by `B_epsilon(m)`.  Thus 1 implies 2, and 2
implies 3 by specialization.

Assume 3 and fix `epsilon>0`.  To prove `B_epsilon=o(m)`, let `eta>0`.
Choose a positive integer `k` so large that

\[
 \frac{C_0}{k}<\frac\eta2.                               \tag{4.5}
\]

This `k` is now fixed.  Statement 3 gives, for all sufficiently large `m`,

\[
 B^{\mathrm{poly}}_{\epsilon,k}(m)<\frac\eta2m.          \tag{4.6}
\]

Proposition 3.2 gives, after increasing the same lower cutoff for `m`,

\[
 B_\epsilon(m)
 \le B^{\mathrm{poly}}_{\epsilon,k}(m)+\frac{C_0}{k}m
 <\eta m.                                                 \tag{4.7}
\]

Since `eta` was arbitrary, `B_epsilon=o(m)`.  Since `epsilon` was
arbitrary, (4.4) holds and hence so does statement 1.  ∎

The proof exposes the quantifier order:

\[
 \forall\eta>0\quad
 \underbrace{\exists k=k(\eta)\in\mathbb Z_{>0}}_
             {\text{chosen before the limit}}\quad
 \exists M=M(\epsilon,\eta,k)\quad
 \forall m\ge M.                                         \tag{4.8}
\]

One may also recover statement 2 from statement 3 directly.  For a fixed
real `A>0`, choose an integer `k>A`; its window contains the `A`-window, so
`B^{poly}_{epsilon,A}<=B^{poly}_{epsilon,k}=o(m)`.

## 5. What failure of a localized gate must look like

The theorem gives a useful contradiction target without pretending that
the contradiction has already been found.  Suppose a fixed localized gate
fails.  Then, after passing to an unbounded sequence, there are fixed
numbers `epsilon,eta,A>0` and integers `m_j` such that

\[
 B^{\mathrm{poly}}_{\epsilon,A}(m_j)\ge\eta m_j.          \tag{5.1}
\]

Reindex by co-divisors.  Put

\[
 \mathcal Q_j=\left\{q:q\mid m_j,\quad
   \log q<A L_{m_j},\quad
   a_{m_j/q}>\epsilon\varphi(m_j/q)\right\},              \tag{5.2}
\]

and define the atom weights

\[
 w_j(q)=\frac{\varphi(m_j/q)}{m_j}.                        \tag{5.3}
\]

Then

\[
 \sum_{q\in\mathcal Q_j}w_j(q)\ge\eta,
 \qquad 0<w_j(q)\le\frac1q.                              \tag{5.4}
\]

Let `M_j=max_{q in Q_j} w_j(q)`.  After passage to a subsequence, exactly
one of the following two useful alternatives occurs.

### Proposition 5.1 (atomic branch)

There are `tau>0`, a fixed positive integer `q_0`, and a subsequence such
that, with `d_j=m_j/q_0`,

\[
 \frac{\varphi(d_j)}{d_j}\ge q_0\tau,
 \qquad
 \frac{a_{d_j}}{d_j}>\epsilon q_0\tau.                   \tag{5.5}
\]

#### Proof

This branch means `M_j>=tau` on an infinite subsequence.  Choose a
maximizing `q_j`.  By (5.4), `tau<=1/q_j`, so
`q_j<=1/tau`.  Only finitely many positive integers satisfy this bound;
pass to a further subsequence on which `q_j=q_0`.  Now

\[
 \tau\le\frac{\varphi(d_j)}{m_j}
 =\frac1{q_0}\frac{\varphi(d_j)}{d_j},                    \tag{5.6}
\]

which gives the first inequality in (5.5).  Exceptionalness gives
`a_{d_j}>epsilon phi(d_j)`, and the second follows.  Since `m_j` is
unbounded and `q_0` is fixed, `d_j` is unbounded.  ∎

Thus an atomic failure forces a positive linear block mass along one fixed
co-divisor fibre.  This is a sharp arithmetic target, not a contradiction
currently available from known Wieferich results.

### Proposition 5.2 (diffuse branch)

Along a subsequence, `M_j` tends to zero.  Then

\[
 \#\mathcal Q_j\ge\frac\eta{M_j}\longrightarrow\infty,   \tag{5.7}
\]

and

\[
 \sum_{q\in\mathcal Q_j}a_{m_j/q}
 >\epsilon\eta m_j.                                      \tag{5.8}
\]

#### Proof

Every atom is at most `M_j`; hence (5.4) gives
`eta<=#Q_j M_j`, proving (5.7).  Summing the defining strict exceptional
inequality in (5.2) and using (5.1) gives

\[
 \sum_{q\in\mathcal Q_j}a_{m_j/q}
 >\epsilon\sum_{q\in\mathcal Q_j}\varphi(m_j/q)
 \ge\epsilon\eta m_j,                                    \tag{5.9}
\]

which is (5.8).  ∎

For completeness, the subsequence dichotomy follows from boundedness
`0<=M_j<=1`: if its limsup is positive, choose a positive `tau` below that
limsup and obtain the atomic branch; if the limsup is zero, nonnegativity
forces `M_j->0` and gives the diffuse branch.  Neither branch is abandoned
for being difficult.  A branch would be retired only by a proof that its
full premises are inconsistent.

## 6. Pressure tests

### 6.1 Prime indices

Let `m=ell` be prime.  The divisor `d=ell` has co-divisor `q=1`, so

\[
 \log q=0<kL_\ell                                      \tag{6.1}
\]

for every fixed positive `k`.  Its totient weight is

\[
 \frac{\varphi(\ell)}\ell=1-\frac1\ell\longrightarrow1. \tag{6.2}
\]

Consequently every fixed-polylog gate still forces

\[
 a_\ell=o(\ell)                                          \tag{6.3}
\]

along the primes.  Localization does not hide the hardest top atom.

### 6.2 The exact `1093` and `3511` witnesses

The repository contains kernel-checked arithmetic certificates

\[
 1093\mid E_{364},\qquad 3511\mid E_{1755}.               \tag{6.4}
\]

Since

\[
 \varphi(364)=144,
 \qquad \varphi(1755)=864,                               \tag{6.5}
\]

they give the finite lower ratios

\[
 \frac{\log1093}{144}\approx0.0485881,
 \qquad
 \frac{\log3511}{864}\approx0.00944868.                  \tag{6.6}
\]

They also give

\[
 1093>2\cdot364,
 \qquad 3511>2\cdot1755.                                 \tag{6.7}
\]

Thus these are full-premise counterexamples to universal shortcuts such as
`E_d<=2d`, and to any universal bound
`log E_d<=c phi(d)` with `c` below the corresponding displayed ratio.
They are not counterexamples to an eventual little-oh statement: each is
one finite order and is absorbed by the eventual cutoff.  They therefore
do not retire the Mersenne route or either branch of Section 5.

### 6.3 The maximal abstract mass

Set `a_d=phi(d)` for every `d`.  Then

\[
 A(m)=\sum_{d\mid m}\varphi(d)=m,                         \tag{6.8}
\]

so the endpoint fails.  If `0<epsilon<1`, every divisor is exceptional.
Along prime `m=ell`, the top divisor lies in every fixed polylog window and
contributes `ell-1`.  Hence every sufficiently large fixed-`A` localized
gate fails as well.  This checks that the new equivalence does not gain
strength from a hidden normalization assumption.

### 6.4 A sparse primorial chain

Choose a nested squarefree primorial chain

\[
 n_1\mid n_2\mid\cdots                                    \tag{6.9}
\]

so rapidly that

\[
 \sum_{i<j}n_i\le\sqrt{n_j},
 \qquad \frac{\varphi(n_j)}{n_j}\longrightarrow0.         \tag{6.10}
\]

Such a subsequence exists because primorials are unbounded and Mertens's
prime-product theorem gives `phi(n)/n->0` along them.  Define

\[
 a_{n_j}=\varphi(n_j),\qquad a_d=0\quad(d\notin\{n_j\}).  \tag{6.11}
\]

For an integer `m`, let `n_r` be the largest supported element dividing
`m`, if one exists.  Nestedness and (6.10) give

\[
 \frac1m\sum_{d\mid m}a_d
 \le\frac{\varphi(n_r)+\sum_{i<r}n_i}{n_r}
 \le\frac{\varphi(n_r)}{n_r}+\frac1{\sqrt{n_r}}.          \tag{6.12}
\]

If `r` tends to infinity, the right side tends to zero.  If `r` remains
bounded while `m` tends to infinity, the numerator is bounded and division
by `m` gives zero.  Thus the divisor-average endpoint holds.  Every
localized exceptional mass is bounded by the full divisor mass and is
therefore `o(m)`, for every fixed `A`.  Nevertheless

\[
 \frac{a_{n_j}}{\varphi(n_j)}=1                           \tag{6.13}
\]

for every `j`.  The fixed-polylog gate is strictly weaker than pointwise
`a_d=o(phi(d))`, even for one fixed mass sequence rather than a triangular
array.

### 6.5 Why one must not discard one fixed polylog tail

For any fixed `A>0`, it is false for general totient-bounded masses that

\[
 T_A(m)=o(m).                                             \tag{6.14}
\]

The primorial divisor model from the preceding concentration report gives
an unbounded sequence on which the co-divisor exceeds
`(log(3m))^A` with probability bounded away from zero.  Equivalently, its
totient far-tail weight has a positive liminf after normalization by `m`.
This is consistent with (3.5), whose right side is the fixed constant
`C_0/A` times `m`.

Therefore the present proof cannot replace `for every fixed A` by
`for one fixed A` without a new arithmetic estimate on the exceptional
part of that tail.  This statement is a boundary of the Markov argument;
it does not assert that a stronger Mersenne-specific one-window theorem has
been disproved.

## 7. Quantifier and counterexample audit

The following distinctions prevent false route closures.

1. **Fixed versus moving window.**  In (1.1), `k` is fixed while `m` tends
   to infinity.  The proof may choose a different fixed `k` for a different
   requested error.  It does not assume one moving function `k(m)->infinity`
   in the localized hypothesis.
2. **All integers versus all reals.**  Positive integers are cofinal among
   positive real window parameters, and the localized masses increase with
   the parameter.  Hence the two formulations are equivalent.
3. **Finite hits versus eventual failure.**  The `1093` and `3511`
   certificates refute universal finite inequalities.  They cannot refute
   an `o(m)` assertion without an infinite family retaining positive
   normalized mass.
4. **Abstract versus arithmetic counterexamples.**  The maximal mass and
   sparse primorial chain test the finite mass logic.  Neither is asserted
   to equal the actual sequence `log E_d`.
5. **No-hit searches.**  A finite computation containing no further
   Wieferich orders cannot refute either the atomic or diffuse alternative,
   because both alternatives are eventual statements.

## 8. Formalization boundary

The Lean companion formalizes:

1. the strict fixed-polylog localized exceptional mass;
2. its exact decomposition from the global exceptional mass;
3. the finite Markov far-tail inequality and the `C/k` estimate;
4. a general uniform-in-positive-integer transfer theorem;
5. the exact equivalence between one full exceptional mass being `o(m)`
   and all of its fixed-integer polylog localizations being `o(m)`; and
6. the actual Mersenne endpoint equivalence (1.1).

No axiom or `sorry` is introduced.  The remaining arithmetic target is the
right side of (1.1).  Current literature checked in the parent concentration
report does not prove it and supplies no full-premise counterexample to it.

## 9. Source boundary

The analytic input is deliberately no stronger than the sources already
audited for the parent module:

1. Chebyshev's elementary bound `theta(x)=O(x)` supplies the dyadic
   `O(log log(3m))` estimate.  Mathlib exposes the explicit inequality as
   `Chebyshev.theta_le_log4_mul_x`.
2. F. Mertens, *Ein Beitrag zur analytischen Zahlentheorie*, J. Reine
   Angew. Math. 78 (1874), 46--62, DOI
   `10.1515/crll.1874.78.46`, is used only for the primorial sharpness and
   sparse-chain pressure tests, not for the positive Markov transfer.
3. The exact `1093` and `3511` statements are backed by explicit primality,
   modular-order, and valuation certificates in
   `MersenneCanonicalBlockWitness20260901.lean` and
   `MersenneSuperWieferichDepth20260901.lean`.

No cited source proves the localized actual Mersenne estimate in (1.1).
No checked source disproves it.  The route therefore remains active.
