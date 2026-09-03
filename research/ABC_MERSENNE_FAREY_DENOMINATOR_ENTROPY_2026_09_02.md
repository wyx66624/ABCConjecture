# Denominator Entropy at the Mersenne Farey Endpoint

**Author:** ChatGPT
**Date:** 2 September 2026
**Status:** unconditional denominator-concentration theorem, a new reduction
to the critical counting exponent (1/2) for base-two super-Wieferich
primes, and a common-index saturation countermodel delimiting the argument.
The critical counting estimate is open.  This report does **not** prove the
abc conjecture.

## 1. The exact question

Continue with the notation of
`research/ABC_MERSENNE_SIGMA_ONE_EXACT_ORDER_COUPLING_2026_09_02.md`.  Thus

\[
 A=A_m:=\log(3m),\qquad L=L_m:=\log A,
 \qquad Q=Q_m:=A^k,
 \qquad H=H_m:=\left\lfloor\sqrt{A/L}\right\rfloor,
\]

where \(k>0\) is fixed.  The actual low-multiplier, depth-three support is

\[
\mathcal S_k(m)=
 \left\{(q,r,p):
 \begin{array}{l}
 q\mid m,\ q<Q,\ d=m/q,\\
 p\text{ prime},\ \operatorname{ord}_p(2)=d,\\
 p=1+dr,\ 1\le r<H,\\
 v_p(2^d-1)\ge3
 \end{array}
 \right\}.
\]

Its correlation-preserving energy is

\[
 E_k(m)=\sum_{(q,r,p)\in\mathcal S_k(m)}\frac rq.
\tag{1.1}
\]

The preceding checkpoint proved that

\[
 E_k(m)=o(\log m)
\tag{1.2}
\]

is sufficient to make the low-multiplier deep arm \(V\) negligible.  The
problem here is to make genuine progress on (1.2), while neither inserting
it as an axiom nor discarding the route because fixed-base Wieferich
distribution is difficult.

## 2. What the available literature does and does not supply

The primary-source audit was refreshed on 2 September 2026.  The relevant
conclusions are as follows.

1. **Erdős--Murty, multiplicative order.**  Their almost-all theorem makes
   \(\operatorname{ord}_p(2)>p^{1/2+o(1)}\) for almost all primes.  Rows in
   \(\mathcal S_k(m)\) already satisfy the much stronger relation
   \(d=(p-1)/r>p/H+O(1)\), with \(H\) only polylogarithmic in \(m\).
   Consequently the theorem does not make this selected set exceptional.

2. **Murty--Séguin, cyclotomic values and Brun--Titchmarsh.**  Their
   weighted Brun--Titchmarsh estimate closes the low one-copy arm in the
   preceding report.  Their order-lifting dictionary also identifies the
   repeated exact-order layers.  It gives no upper count for the
   simultaneous fixed-base, exact-order, cube-divisible packet here.

3. **Yamada, pointwise \(p\)-adic valuation.**  Yamada bounds
   \(v_p(2^{p-1}-1)\) after \(p\) is selected.  This transfers depth weights
   to the Farey energy, as already proved, but it does not bound the number
   of primes for which the valuation is at least three.

4. **Shparlinski, Fermat-quotient large sieve.**  The large-sieve estimates
   in the archived primary manuscript concern exponential sums or value
   sets, often on average over the prime modulus or over a varying base.
   They do not yield a zero-frequency estimate for the fixed value
   \(q_p(2)\equiv0\pmod{p^2}\), and hence cannot be specialized to the count
   required below.

5. **Fellini--Murty and Li--Zhao (2026).**  Fellini--Murty obtain
   quantitative non-Wieferich conclusions assuming number-field abc or
   finiteness of the relevant super-Wieferich primes.  Li--Zhao prove
   eventual order growth after a threshold depending on one fixed prime
   ideal and the base.  Neither statement is uniform over the varying
   rational primes in \(\mathcal S_k(m)\).

6. **Katz's probabilistic model.**  The model predicts about
   \(\log\log x\) ordinary base-two Wieferich primes up to \(x\), and its
   next-depth heuristic predicts only finitely many primes satisfying the
   cube congruence.  This motivates the route but is not a theorem used in
   any proof below.

7. **Dorais--Klyve computation.**  Their published exhaustive search found
   no ordinary base-two Wieferich prime other than \(1093\) and \(3511\)
   below \(6.7\times10^{15}\).  The repository's exact certificates show
   that these two primes have depth exactly two at their exact orders.
   Therefore the published interval contains no depth-three row.  This is a
    finite exclusion, not an asymptotic estimate.

8. **Laniewski's Mersenne-defect preprint (29 August 2026).**  This latest
   official preprint gives an exact reduction of fixed-exponent Mersenne
   transgression to aggregate order--defect growth over ordinary Wieferich
   primes.  It explicitly leaves that growth open and supplies no upper
   count for the depth-three fixed-base packet in (3.1).

9. **Falk--Harrington--Jones (31 July 2026).**  Their generalized
   Wieferich criteria characterize monogenicity for certain trinomials.
   These are algebraic equivalences for individual primes, not a counting
   estimate for base two or for cube divisibility.

No primary result found in this audit proves an unconditional upper bound at
the critical exponent isolated in Section 5.  In particular, an average over
bases, a typical-order theorem, or a count of non-Wieferich primes cannot be
silently substituted for the needed upper count of fixed-base
super-Wieferich primes.

## 3. Every actual row is a super-Wieferich prime

Define the global base-two depth-three counting function

\[
W_3(x):=\#\{p\le x:p\text{ prime and }
                    p^3\mid2^{p-1}-1\}.
\tag{3.1}
\]

For a denominator cutoff \(T\), also put

\[
 \Delta_3(m;T):=\#\left\{p:\ p\text{ prime},\quad
 \frac{m}{Q_m}<p<1+\frac{mH_m}{T},\quad
 p^3\mid2^{p-1}-1\right\}.
\tag{3.2}
\]

### Proposition 3.1 (depth transport)

If \((q,r,p)\in\mathcal S_k(m)\), then

\[
 p^3\mid2^{p-1}-1.
\tag{3.3}
\]

#### Proof

Put \(d=m/q=\operatorname{ord}_p(2)\).  The row identity gives
\(p-1=dr\), while the depth premise gives \(p^3\mid2^d-1\).  The elementary
factorization

\[
 2^d-1\mid 2^{dr}-1=2^{p-1}-1
\]

proves (3.3). \(\square\)

### Proposition 3.2 (the row-to-prime map is injective)

For fixed \(m\), two rows of \(\mathcal S_k(m)\) carrying the same prime are
equal.

#### Proof

A prime has a unique exact order, so equality of the primes gives equality
of \(d\).  Then \(q=m/d\) and \(r=(p-1)/d\) are equal as well. \(\square\)

Also every row satisfies

\[
 p=1+\frac mq r\le1+mH.
\tag{3.4}
\]

Thus any lower bound for the row cardinality is automatically a lower bound
for \(W_3(1+mH)\).  This is the arithmetic input that a generic Farey set
does not possess.

More precisely, if a row has \(q>T\), then

\[
 p>m/Q_m,
 \qquad
 T(p-1)<mH_m,
\tag{3.5}
\]

so it lies in the interval counted by \(\Delta_3(m;T)\).  The first
inequality uses \(q<Q_m\) and \(r\ge1\); the second follows by multiplying
\(r/q<H_m/T\) by \(mT\).

## 4. The denominator-entropy inequality

For an integer \(T\) with \(1\le T<Q\), define

\[
 N_{>T}(m):=
 \#\{(q,r,p)\in\mathcal S_k(m):q>T\},
\qquad
 \mathcal H_T:=\sum_{q=1}^{T}\frac1q.
\tag{4.1}
\]

### Theorem 4.1 (exact denominator split)

For all such \(m,T\),

\[
 E_k(m)
 \le
 \frac{H(H-1)}2\,\mathcal H_T
 +\frac HT N_{>T}(m).
\tag{4.2}
\]

#### Proof

Split (1.1) at \(q=T\).  Fix \(q\le T\).  Once \(m,q,r\) are fixed, the
relation

\[
 p=1+(m/q)r
\]

determines \(p\), so at most one row occurs for a given \(r\).  Since every
row has \(1\le r<H\), the entire \(q\)-fibre contributes at most

\[
 \frac1q\sum_{r=1}^{H-1}r
 =\frac{H(H-1)}{2q}.
\]

Summing this bound over \(q\le T\) gives the first term of (4.2).  In the
tail, \(q>T\) and \(r<H\), hence each row contributes

\[
 \frac rq<\frac HT.
\]

Multiplication by the number of tail rows gives the second term. \(\square\)

The point is not the harmonic estimate by itself.  The parameter \(T\) may
be a fixed positive power of \(A=\log(3m)\).  A positive fraction of the
critical energy cannot then hide at small denominators; it forces a very
large population of distinct arithmetic rows in the tail.

## 5. Linear Farey energy forces a super-Wieferich swarm

### Theorem 5.1 (denominator-entropy swarm theorem)

Fix \(k>0\).  Suppose that for some \(\varepsilon>0\) and an infinite
sequence \(m\to\infty\),

\[
 E_k(m)\ge\varepsilon A_m.
\tag{5.1}
\]

Put

\[
 \eta:=\min\{\varepsilon/4,k/2\}>0,
 \qquad T_m:=\lfloor A_m^\eta\rfloor.
\tag{5.2}
\]

Then, along that sequence and for all sufficiently large \(m\),

\[
 N_{>T_m}(m)
 \gg_\varepsilon
 A_m^{1/2+\eta}L_m^{1/2},
\tag{5.3}
\]

and consequently

\[
 \Delta_3(m;T_m)
 \gg_\varepsilon
 A_m^{1/2+\eta}L_m^{1/2},
\tag{5.4}
\]

and hence

\[
 W_3(1+mH_m)
 \gg_\varepsilon
 A_m^{1/2+\eta}L_m^{1/2}.
\tag{5.5}
\]

#### Proof

Because \(\eta<k\), eventually \(1\le T_m<Q_m=A_m^k\).  Moreover

\[
 \mathcal H_{T_m}\le1+\log T_m
 =\eta L_m+O(1)
\]

and

\[
 H_m^2\le A_m/L_m.
\]

The prefix term in Theorem 4.1 is therefore at most

\[
 \frac{A_m}{2L_m}(\eta L_m+O(1))
 =\frac\eta2A_m+o(A_m)
 \le\frac\varepsilon8A_m+o(A_m).
\tag{5.6}
\]

For all sufficiently large \(m\), this is at most
\(\varepsilon A_m/4\).  Equations (5.1) and (4.2) then force

\[
 \frac{H_m}{T_m}N_{>T_m}(m)
 \ge\frac{3\varepsilon}{4}A_m.
\tag{5.7}
\]

Since \(T_m\asymp A_m^\eta\) and

\[
 \frac{A_m}{H_m}\ge\sqrt{A_mL_m},
\]

(5.7) gives (5.3).  Propositions 3.1--3.2 and (3.5) give (5.4), and the
global bound (5.5) follows.
\(\square\)

This conclusion is substantially stronger than the elementary estimate
\(N_k(m)\ge E_k(m)/H_m\).  That estimate would force only about
\(\sqrt{A_mL_m}\) rows.  The denominator split produces an additional fixed
power \(A_m^\eta\) whenever the energy has a fixed positive linear density.

### Corollary 5.2 (critical global counting exponent \(1/2\))

Assume the following stand-alone but currently unproved counting statement:

\[
 \limsup_{x\to\infty}
 \frac{\log\max\{1,W_3(x)\}}{\log\log x}
 \le\frac12.
\tag{5.8}
\]

Then for every fixed \(k>0\),

\[
 E_k(m)=o(\log m).
\tag{5.9}
\]

#### Proof

If (5.9) failed, positivity would give an \(\varepsilon>0\) and a sequence
satisfying (5.1).  Theorem 5.1 would yield, for one fixed \(\eta>0\),

\[
 W_3(1+mH_m)
 \gg A_m^{1/2+\eta}L_m^{1/2}.
\]

Since \(H_m\) is polylogarithmic,

\[
 \log(1+mH_m)=\log m+O(\log H_m),
 \qquad
 \log\log(1+mH_m)=L_m+o(1).
\]

The last lower bound makes the limsup in (5.8) at least
\(1/2+\eta\), a contradiction.  Finally \(A_m\sim\log m\).
\(\square\)

Condition (5.8) is far weaker than finiteness of base-two
super-Wieferich primes and weaker than the direct cardinality condition
\(W_3(x)=o(\sqrt{\log x\log\log x})\).  It still is not known
unconditionally.  It must remain an explicit open arithmetic gate.

Combining Corollary 5.2 with the Yamada transfer from the preceding report
would close the low-multiplier deep arm \(V\).  It would not by itself close
the stable high-multiplier packet \(B+G\), and therefore would not prove abc.

## 6. Why ordinary Brun--Titchmarsh still stops at the endpoint

For a fixed \(d=m/q\), ordinary Brun--Titchmarsh applied to
\(p=1+dr\le dH\) gives schematically

\[
 \#\{r<H:1+dr\text{ prime}\}
 \ll \frac{d}{\varphi(d)}\frac{H}{\log H}.
\]

At worst \(d/\varphi(d)\) has order \(L_m\), while
\(\log H_m\sim L_m/2\).  These factors cancel.  Summation over the
denominators then returns an \(O(A_m)\) bound rather than \(o(A_m)\).
Large-sieve estimates averaged over a varying base do not repair this for
the fixed base \(2\).

Theorem 5.1 changes the target.  It shows that a failure is not merely a
dense set of primes in one progression: it is a polynomial-in-\(\log m\)
swarm of distinct primes satisfying a second Fermat-quotient vanishing
condition.  This is exactly where future \(p\)-adic or fixed-base input must
act.

## 7. A common-index saturation countermodel

It is important to test whether the new conclusion might follow from common
divisibility and slope injectivity alone.  It does not.

Let

\[
 m_n=\operatorname{lcm}(1,2,\ldots,n),
 \quad A_n=\log(3m_n),\quad L_n=\log A_n,
 \quad H_n=\left\lfloor\sqrt{A_n/L_n}\right\rfloor.
\]

Take \(k=1\) and the abstract rows

\[
 \widetilde{\mathcal S}_n=
 \{(q,r):q\le n/2,\ 1\le r<H_n,\ (q,r)=1\}.
\tag{7.1}
\]

For all large \(n\), \(q\mid m_n\) and \(q<A_n=Q_{m_n}\).  Every row gives
an integer

\[
 \widetilde p=1+(m_n/q)r,
\]

and the reduced slopes \(r/q\) are pairwise distinct.  Nevertheless, using

\[
 \sum_{\substack{r<H\\ (r,q)=1}}r
 =\frac{H^2}{2}\frac{\varphi(q)}q+O(H\tau(q)),
\]

\[
 \sum_{q\le x}\frac{\varphi(q)}{q^2}
 =\frac6{\pi^2}\log x+O(1),
 \qquad
 \sum_{q\le x}\frac{\tau(q)}q=O(\log^2x),
\]

and the prime number theorem form
\(\log\operatorname{lcm}(1,\ldots,n)\sim n\), one obtains

\[
 \sum_{(q,r)\in\widetilde{\mathcal S}_n}\frac rq
 =\left(\frac3{\pi^2}+o(1)\right)A_n.
\tag{7.2}
\]

Thus (7.1) preserves the actual \(H,Q\) scales, the single common index,
\(q\mid m\), integrality of \(1+(m/q)r\), and cross-fibre slope
injectivity, yet has linear endpoint energy.  It omits three premises:

1. \(\widetilde p\) need not be prime;
2. it need not have exact base-two order \(m_n/q\);
3. its cube need not divide the exact-order Mersenne value.

This is a counterexample to the proposed inference that common divisibility
plus Farey injectivity supplies (1.2).  It is **not** a counterexample to the
Mersenne route because it fails the full arithmetic premises.  The route is
therefore retained, with primality, exact order, and especially depth three
identified as indispensable sources of saving.

## 8. Full-premise counterexample search

The frozen local scan
`research/computation/2026_09_02_mersenne_sigma_one/` tests every one of the
\(50,847,534\) primes through \(10^9\).  Its only ordinary base-two
Wieferich hits are

\[
 (p,d,r,w)=(1093,364,3,2),
 \qquad (3511,1755,2,2).
\]

Both fail the required premise \(w\ge3\).  Hence this range contains no row
of \(\mathcal S_k(m)\).  The Dorais--Klyve published search extends the
ordinary-Wieferich exclusion to \(6.7\times10^{15}\); together with the two
exact depth certificates, it likewise gives no full-premise depth-three
prime in that larger finite range.

No full-premise counterexample to (1.2) was found.  In fact, a counterexample
would have to be asymptotic: by Theorem 5.1 it would force, for one common
\(m\), a growing polynomial swarm of distinct super-Wieferich primes with
their exact orders in the same polylogarithmic codivisor window.  Neither a
single exceptional prime nor an abstract Farey saturation meets those
quantifiers.

Accordingly, the exact-order Farey route is not retired.

## 9. Reproducible computation

The new evidence bundle is
`research/computation/2026_09_02_mersenne_farey_denominator_entropy/`.
Its standard-library Python verifier performs the following checks.

1. It constructs \(m_n=\operatorname{lcm}(1,\ldots,n)\) for
   \(n=100,300,1000,3000,10000\), enumerates the reduced support (7.1), and
   verifies all divisibility, range, and pairwise-slope conditions.
2. It evaluates every energy and both sides of Theorem 4.1 with exact
   `Fraction` arithmetic.
3. At \(n=10000\) it finds (96,737) abstract rows and
   \(\widetilde E/A=0.2961553070\ldots\), consistent with the limit
   \(3/\pi^2=0.30396355\ldots\).
4. It re-reads the frozen \(10^9\) scan, checks its prime count and two hits,
   and checks the exact square/cube residues proving that both hits have
   depth two and that the depth-three hit list is empty.

The computation proves no limit and is not used as an arithmetic substitute
for the open hypothesis (5.8).

## 10. Lean formalization and axiom boundary

The companion module is
`Lean/IUTThreeClosures/MersenneFareyDenominatorEntropy20260902.lean`, with a
separate audit module.  Lean proves the following finite statements.

1. fibre slope mass equals numerator mass divided by the denominator;
2. a fibre contained in \(1,\ldots,H-1\) is bounded by the triangular
   capacity;
3. the whole denominator prefix is bounded by triangular capacity times the
   exact harmonic prefix;
4. \(r\le H\), \(T\le q\), \(T>0\) imply \(r/q\le H/T\);
5. the whole tail is bounded by tail cardinality times \(H/T\);
6. an energy defect forces a cardinality product lower bound;
7. exact-order depth three implies the standard base-two super-Wieferich
   congruence;
8. for a fixed common index, the map from exact-order rows to their represented
   primes is injective;
9. a tail row obeys the division-free short-window inequality
   \(T(p-1)<mH\);
10. the exact (1093) and (3511) witnesses fail depth three.

The theorem-level axiom audit reports only

\[
 \{\texttt{Classical.choice},\texttt{Quot.sound},\texttt{propext}\}.
\]

Lean does not assert the harmonic asymptotic, the prime number theorem, the
limsup hypothesis (5.8), the Dorais--Klyve exhaustive range, or any abc
consequence.

## 11. Remaining gate and next attacks

The exact new target is to prove an unconditional upper bound strong enough
to contradict (5.4).  Three nonexclusive versions remain active.

1. Prove the global critical-exponent estimate (5.8).
2. Prove only the localized version

   \[
   \#\{p\le1+mH_m:p\text{ occurs in }\mathcal S_k(m)\}
   \le A_m^{1/2+o(1)},
   \]
   which is weaker than a global theorem and already suffices.
3. Use exact order before global counting, for example through a fixed-base
   \(p\)-adic large sieve that controls the simultaneous conditions
   \(p^3\mid2^{(p-1)/r}-1\) for \(r<H_m\).

Ordinary Brun--Titchmarsh, generic Farey spacing, and current average-base
Fermat-quotient estimates have now been pressure-tested and do not close the
gate.  They remain useful components, but the route must retain the
depth-three fixed-base condition rather than average it away.

## References

1. P. Erdős and M. Ram Murty, *On the order of (a) (mod (p))* , in
   *Number Theory*, CRM Proceedings and Lecture Notes **19** (1999),
   87--97.  Archived in
   `research/sources/mersenne_prime_layer_radical_2026_09_01/`.
2. M. Ram Murty and François Séguin, *Prime divisors of sparse values of
   cyclotomic polynomials and Wieferich primes*, Journal of Number Theory
   **201** (2019), 1--22,
   <https://doi.org/10.1016/j.jnt.2019.02.016>.
3. Tomohiro Yamada, *A note on the paper by Bugeaud and Laurent
   “Minoration effective de la distance p-adique entre puissances de nombres
   algébriques”*, Journal of Number Theory **130** (2010), 1889--1897,
   <https://doi.org/10.1016/j.jnt.2010.02.018>.
4. Igor E. Shparlinski, *Fermat quotients: exponential sums, value set and
   primitive roots*, <https://arxiv.org/abs/1104.3909>.
5. François G. Dorais and Dominic Klyve, *A Wieferich prime search up to
   \(6.7\times10^{15}\)*, Journal of Integer Sequences **14** (2011),
   Article 11.9.2,
   <https://cs.uwaterloo.ca/journals/JIS/VOL14/Klyve/klyve3.pdf>.
6. Nicholas M. Katz, *Wieferich past and future*, in *Topics in Finite
   Fields*, Contemporary Mathematics **632** (2015), 253--270.  Author copy:
   <https://web.math.princeton.edu/~nmk/wieferich38.pdf>.
7. Nic Fellini and M. Ram Murty, *Wieferich primes in number fields and the
   conjectures of Ankeny--Artin--Chowla and Mordell*, Journal of Number
   Theory **285** (2026), 209--229,
   <https://doi.org/10.1016/j.jnt.2026.01.002>.
8. Ruofan Li and Jiuzhou Zhao, *Non-Wieferich property of prime ideals and a
   conjecture of Erdős*, <https://arxiv.org/abs/2601.12753>.
9. R. Laniewski, *Radical defects, Wieferich primes, and the abc conjecture*,
   arXiv:2609.00039v1 (29 August 2026),
   <https://arxiv.org/abs/2609.00039>.
10. Amy Falk, Joshua Harrington, and Lenny Jones, *Generalized Wieferich
    primes and monogenic trinomials*, arXiv:2607.29329v1 (31 July 2026),
    <https://arxiv.org/abs/2607.29329>.
