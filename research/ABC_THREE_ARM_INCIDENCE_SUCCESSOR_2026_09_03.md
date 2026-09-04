# Three-arm incidence covers and complementary-prime transport

**Author:** ChatGPT

**Date:** 2026-09-03

**Status:** RAW-3C and the ordered gate CT-3C are rigorously refuted by
different infinite complete-premise families; their conditional implications
to standard \(abc\) remain valid.

## 1. Scope and claim discipline

This note continues the valuation-incidence route on the full domain of
positive primitive triples
\[
P=(a,b,c),\qquad a+b=c,\qquad
\gcd(a,b)=\gcd(b,c)=\gcd(c,a)=1.
\]
It has two simultaneous aims. First, it proves that a precise three-arm
incidence estimate would imply the unchanged logarithmic \(abc\) conjecture.
Second, it attacks that estimate with infinite structured families and a
bounded exhaustive search.

The first estimate, RAW-3C, fails on an infinite family and is retired in its
exact stated form. Its ordered complement-transport successor, CT-3C, is also
retired by the later prime-square obstruction recorded in
`ABC_ORDERED_PRIME_TRANSPORT_OBSTRUCTION_2026_09_03.md`. No claim below
proves the \(abc\) conjecture. Finite computational evidence is used only to
expose obstructions and guide the next proof step.

## 2. Three-arm faces

Put
\[
n_A=a,\qquad n_B=b,\qquad n_C=c.
\]
A face \(F\) chooses, for each arm \(i\in\{A,B,C\}\), a subset
\(S_i\) of the prime divisors of \(n_i\). For \(p\mid n_i\), write
\(v_{i,p}=v_p(n_i)\). Define
\[
\begin{aligned}
R_i(F)&=\prod_{p\in S_i}p, &
\overline R_i(F)&=\prod_{\substack{p\mid n_i\\p\notin S_i}}p,\\
D_i(F)&=\prod_{p\in S_i}p^{v_{i,p}-1}, &
M_i(F)&=\prod_{p\in S_i}p^{v_{i,p}}.
\end{aligned}
\]
The corresponding global quantities are
\[
R(F)=\prod_iR_i(F),\qquad
\overline R(F)=\prod_i\overline R_i(F),\qquad
D(F)=\prod_iD_i(F),\qquad
M(F)=\prod_iM_i(F).
\]
Empty products are one. Thus these definitions also cover unit arms.

**Proposition 2.1 (exact factorizations).** Every face satisfies
\[
R(F)D(F)=M(F)
\]
and
\[
R(F)\overline R(F)=\operatorname{rad}(abc).
\]

**Proof.** For each selected prime \(p\),
\(p\cdot p^{v_{i,p}-1}=p^{v_{i,p}}\); multiplying first over \(S_i\)
and then over the three arms gives the first identity. On each arm the
selected and unselected prime sets form a disjoint partition of the prime
divisors of \(n_i\). Hence
\(R_i(F)\overline R_i(F)=\operatorname{rad}(n_i)\). Pairwise coprimality
of \(a,b,c\) gives
\[
\prod_i\operatorname{rad}(n_i)=\operatorname{rad}(abc),
\]
which proves the second identity. \(\square\)

Call \(F\) a **weak covering face** when
\[
c\le M(F),
\]
and say that it **strictly reconstructs the endpoint** when
\[
c<M(F).
\]
The weak relation is exactly what the height argument needs. The strict
relation supplies a genuine uniqueness interval for the three-arm
congruences.

**Proposition 2.2 (local incidence signature).** The selected moduli obey
\[
c\equiv b\pmod{M_A(F)},\qquad
c\equiv a\pmod{M_B(F)},\qquad
c\equiv0\pmod{M_C(F)}.
\]
Moreover \(M_A(F),M_B(F),M_C(F)\) are pairwise coprime.

**Proof.** Each \(M_i(F)\) divides its coordinate \(n_i\). The three
congruences therefore follow from \(c=a+b\). Any common divisor of two
selected arm moduli divides the corresponding two coordinates, whose gcd is
one. \(\square\)

**Proposition 2.3 (strict three-arm reconstruction).** Suppose
\(c<M(F)\). If \(0\le x<M(F)\) has the same three congruences displayed in
Proposition 2.2, then \(x=c\).

**Proof.** Proposition 2.2 and transitivity of congruence give
\[
x\equiv c\pmod{M_A(F)},\qquad
x\equiv c\pmod{M_B(F)},\qquad
x\equiv c\pmod{M_C(F)}.
\]
The moduli are pairwise coprime, so the Chinese remainder theorem gives
\(x\equiv c\pmod{M(F)}\). Both numbers lie in the half-open interval
\([0,M(F))\), hence they are equal. \(\square\)

The distinction between weak coverage and strict reconstruction is necessary:
the equality case \(c=M(F)\) is sufficient for the logarithmic estimate but
does not put \(c\) in the reconstruction interval.

## 3. The raw-defect gate and its consequence

Write
\[
h(P)=\log c,\qquad
\operatorname{cond}(P)=\log\operatorname{rad}(abc).
\]
The first candidate was the following uniform statement.

**RAW-3C.** For every \(\varepsilon>0\), there is a real
\(C_\varepsilon\) such that every positive primitive point \(P\) has a face
\(F\) satisfying
\[
c\le M(F)
\]
and
\[
\log D(F)\le
\varepsilon\operatorname{cond}(P)+C_\varepsilon.
\]

This is a precise sufficient condition rather than a restatement of \(abc\):
it requires the height to be covered by products of actual selected
prime-power vertices and separately bounds their repeated valuation layers.

**Proposition 3.1 (RAW-3C implies \(abc\)).** If RAW-3C holds, then for every
\(\varepsilon>0\) there is \(C_\varepsilon\) such that
\[
h(P)\le
(1+\varepsilon)\operatorname{cond}(P)+C_\varepsilon
\]
for every positive primitive point \(P\).

**Proof.** Since \(R(F)\) is a divisor of
\(\operatorname{rad}(abc)\), the cover and Proposition 2.1 give
\[
c\le M(F)=R(F)D(F)
\le\operatorname{rad}(abc)D(F).
\]
All quantities are positive, so taking logarithms and applying RAW-3C yields
\[
\begin{aligned}
h(P)
&\le \operatorname{cond}(P)+\log D(F)\\
&\le (1+\varepsilon)\operatorname{cond}(P)+C_\varepsilon.
\end{aligned}
\]
This is the standard logarithmic \(abc\) inequality. \(\square\)

## 4. Infinite counterexample to RAW-3C

For \(t\ge1\), define
\[
x_t=2t+1,\qquad
y_t=2t(t+1),\qquad
z_t=2t^2+2t+1
\]
and
\[
P_t=(x_t^2,y_t^2,z_t^2).
\]

**Lemma 4.1.** Each \(P_t\) is a positive primitive \(abc\) point.

**Proof.** Direct expansion gives
\[
x_t^2+y_t^2=z_t^2.
\]
The number \(x_t\) is odd, and
\[
\gcd(2t+1,t)=\gcd(2t+1,t+1)=1,
\]
so \(\gcd(x_t,y_t)=1\). Also
\[
z_t\equiv1\pmod t,\qquad
z_t\equiv1\pmod{t+1},
\]
and \(z_t\) is odd, so \(\gcd(y_t,z_t)=1\). Finally,
\[
z_t=t(2t+1)+(t+1)
\]
together with \(\gcd(2t+1,t+1)=1\) gives
\(\gcd(x_t,z_t)=1\). Squaring preserves these pairwise gcds. \(\square\)

**Lemma 4.2 (squarefull face obstruction).** Let \(F\) be any covering face
of \(P_t\). Then
\[
z_t\le D(F).
\]

**Proof.** Every prime in every coordinate of \(P_t\) has valuation at least
two. Therefore each selected factor \(p\) in \(R(F)\) is bounded by its
corresponding factor \(p^{v_p-1}\) in \(D(F)\), and hence
\[
R(F)\le D(F).
\]
Using the cover and Proposition 2.1,
\[
z_t^2=c\le M(F)=R(F)D(F)\le D(F)^2.
\]
Taking the monotone square root on nonnegative integers gives
\(z_t\le D(F)\). \(\square\)

**Lemma 4.3 (radical bound).** For every \(t\ge1\),
\[
\operatorname{rad}(x_t^2y_t^2z_t^2)\le z_t^3.
\]

**Proof.** For each positive integer \(u\),
\(\operatorname{rad}(u^2)=\operatorname{rad}(u)\le u\). Also
\(x_t\le z_t\) and \(y_t<z_t\). Consequently
\[
\operatorname{rad}(x_t^2y_t^2z_t^2)
\le x_ty_tz_t\le z_t^3.
\]
\(\square\)

**Theorem 4.4 (RAW-3C is false).** No constants in RAW-3C can satisfy its
quantifiers.

**Proof.** Assume RAW-3C and specialize it to
\(\varepsilon=\frac14\), with constant \(C\). For every \(t\), choose the
covering face supplied by the statement. Lemmas 4.2 and 4.3 imply
\[
\log z_t
\le\log D(F)
\le\frac14\log\operatorname{rad}(x_t^2y_t^2z_t^2)+C
\le\frac34\log z_t+C.
\]
Thus
\[
\frac14\log z_t\le C
\]
for every \(t\). But \(z_t\) is unbounded, a contradiction. \(\square\)

This counterexample meets every premise of RAW-3C. It retires that exact
candidate. It does not refute the parent valuation-incidence route or the
\(abc\) conjecture. A different family later refutes the particular ordered
transport successor below without retiring the parent route.

## 5. Complementary-prime transport

RAW-3C discards the unused prime vertices. CT-3C gives them finite capacity
and imposes an order constraint.

For a face \(F\), create one source token
\[
s=(i,p,j)
\]
for every selected \(p\in S_i\) and every excess layer
\(1\le j\le v_{i,p}-1\). Its weight and key are
\[
w(s)=\log p,\qquad k(s)=p.
\]
Create one sink token \(q=(i,q)\) for each unselected prime vertex, with
capacity and key
\[
\overline w(q)=\log q,\qquad \overline k(q)=q.
\]
The arm labels distinguish vertices but do not restrict the transport.

A **complement transport** is a nonnegative real matrix \(f(s,q)\) such that
\[
\sum_q f(s,q)\le w(s)
\]
for each source,
\[
\sum_s f(s,q)\le\overline w(q)
\]
for each sink, and
\[
f(s,q)>0\quad\Longrightarrow\quad k(s)\le\overline k(q).
\]
Define total source mass, total flow, and unmatched mass by
\[
S(F)=\sum_s w(s),\qquad
\Phi(f)=\sum_{s,q}f(s,q),\qquad
U(f)=S(F)-\Phi(f).
\]
Source capacities make \(U(f)\ge0\).

**Proposition 5.1 (exact masses).** For every complement transport,
\[
S(F)=\log D(F)
\]
and the total sink capacity is
\[
\sum_q\overline w(q)=\log\overline R(F).
\]

**Proof.** A selected prime \(p\) contributes exactly
\(v_{i,p}-1\) source tokens, each of weight \(\log p\). Therefore its total
source contribution is
\[
(v_{i,p}-1)\log p=\log p^{v_{i,p}-1}.
\]
Summing over selected vertices gives \(\log D(F)\). Each unselected prime
appears once as a sink of capacity \(\log q\), so summing gives the logarithm
of their product, \(\log\overline R(F)\). \(\square\)

**Proposition 5.2 (flow accounting).** Every complement transport satisfies
\[
\log D(F)\le\log\overline R(F)+U(f).
\]

**Proof.** By definition and Proposition 5.1,
\[
\log D(F)=\Phi(f)+U(f).
\]
The sink capacity inequalities give
\[
\Phi(f)\le\log\overline R(F).
\]
Combining these relations proves the claim. \(\square\)

The order condition produces more information than the total capacity
inequality. For an integer threshold \(m\), let \(S_{>m}\) be the source
mass carried by primes greater than \(m\), and let \(Q_{>m}\) be the sink
capacity carried by primes greater than \(m\).

**Proposition 5.3 (weighted Hall obstruction).** Every complement transport
satisfies
\[
S_{>m}-Q_{>m}\le U(f)
\]
for every \(m\).

**Proof.** A source whose key is greater than \(m\) may send mass only to a
sink whose key is at least that source key, hence only into the sink tail
\(\overline k(q)>m\). At most \(Q_{>m}\) of the mass of these sources
can be transported. Their remaining mass is part of the global unmatched
mass, proving the inequality. \(\square\)

**Proposition 5.4 (transport height bound).** If \(F\) covers \(P\), then
every complement transport on \(F\) satisfies
\[
h(P)\le\operatorname{cond}(P)+U(f).
\]

**Proof.** Coverage, Proposition 2.1, and Proposition 5.2 give
\[
\begin{aligned}
h(P)
&\le\log R(F)+\log D(F)\\
&\le\log R(F)+\log\overline R(F)+U(f)\\
&=\operatorname{cond}(P)+U(f).
\end{aligned}
\]
\(\square\)

This yields the ordered gate that is tested and refuted in the companion
obstruction report.

**CT-3C.** For every \(\varepsilon>0\), there is a real
\(C_\varepsilon\) such that every positive primitive point \(P\) has a
covering face \(F\) and a complement transport \(f\) satisfying
\[
U(f)\le\varepsilon\operatorname{cond}(P)+C_\varepsilon.
\]

**Theorem 5.5 (CT-3C implies \(abc\)).** CT-3C implies
\[
h(P)\le
(1+\varepsilon)\operatorname{cond}(P)+C_\varepsilon
\]
for every positive primitive point \(P\).

**Proof.** Apply Proposition 5.4 to the face and transport supplied by CT-3C,
then substitute the CT-3C bound for \(U(f)\). \(\square\)

CT-3C is not vacuous. The zero matrix is always a legal transport, but then
\(U(f)=\log D(F)\); mere existence of a flow therefore gives no gain. A useful
transport must obey every source capacity, every finite sink capacity, and
the prime order condition while leaving only uniformly sublinear unmatched
mass. The Hall inequalities in Proposition 5.3 are necessary obstructions to
exactly that requirement.

## 6. Adversarial computation

The reproducible search package is
research/computation/2026_09_03_three_arm_incidence_successor.
It enumerates every support face and evaluates weak coverage, selected
defect, complementary radical, and the optimum unmatched mass for the
nested order relation \(p\le q\).

The transport optimizer processes source and sink keys in descending order.
When the largest remaining sink is smaller than the current source, the
source is declared unmatched while that sink is preserved for later smaller
sources. This preservation is essential: for sources of masses one at keys
\(5,2\) and a sink of capacity one at key \(3\), the optimum unmatched mass
is one, not two. The script contains this example as a regression test.

**Lemma 6.1 (optimality of the descending greedy transport).** For finite
nonnegative source masses \(a_s\), sink capacities \(b_q\), positive-integer
keys, and edges allowed exactly when \(p_s\le q\), the minimum unmatched
source mass is
\[
\max\left(0,\max_{m\ge0}
  \left(\sum_{p_s>m}a_s-\sum_{q>m}b_q\right)\right).
\]

**Proof.** For any threshold \(m\), every source above \(m\) can use only a
sink above \(m\). Hence every transport leaves at least the displayed tail
excess unmatched.

For the converse, group equal keys and process distinct keys from largest to
smallest. Before processing the sources at a key, add the sink capacity at
that key to the available reservoir. Match as much of the current source mass
as possible against this reservoir; a residual source mass is permanently
unmatched, while a residual sink capacity is retained for lower keys. Let
\(\Delta_r=A_r-B_r\) be cumulative source mass minus cumulative sink capacity
after the first \(r\) key groups, and let \(U_r\) be cumulative unmatched
mass produced by the greedy rule. If \(V_{r-1}\) is the retained capacity
before group \(r\), conservation gives
\[
V_{r-1}=U_{r-1}-\Delta_{r-1}.
\]
Consequently the new unmatched increment is
\[
\max(0,\Delta_r-U_{r-1}),
\]
and therefore
\[
U_r=\max(U_{r-1},\Delta_r).
\]
Starting from \(U_0=0\), induction gives
\[
U_r=\max(0,\Delta_1,\ldots,\Delta_r).
\]
At the last group these cumulative differences are precisely the upper-tail
differences obtained by placing a threshold between consecutive keys. The
greedy value attains the universal lower bound, so it is optimal. \(\square\)

For every enumerated face, the implementation also checks the greedy value
against this upper-tail formula. Thus the word “optimum” in the tables is
backed by the preceding exchange-free cumulative proof as well as two
agreeing finite calculations.

With parameters
\[
c\le1200,\qquad 1\le r\le12,\qquad 1\le t\le80,
\]
the run found:

- \(218{,}893\) unordered positive primitive triples \(a\le b\);
- \(1{,}669\) triples with no zero-defect covering face;
- maximum displayed optimized-flow ratio approximately \(0.613147\), at
  \((1,8,9)\);
- for the balanced family
  \((2^{2r},3^r,2^{2r}+3^r)\), maximum displayed ratio approximately
  \(0.461195\), at \(r=2\), namely \((16,9,25)\), with zero unmatched mass
  in \(8\) of the \(12\) tested rows;
- for the Pythagorean-square family, maximum displayed ratio approximately
  \(0.505618\), at \(t=3\), namely \((49,576,625)\), with zero unmatched mass
  in \(53\) of the \(80\) tested rows;
- among the final twenty tested Pythagorean rows, maximum displayed ratio
  approximately \(0.103276\).

Here the displayed ratio is optimized unmatched mass divided by
\(\log\operatorname{rad}(abc)\). Integer factorization, support enumeration,
face products, coverage, radicals, defects, and gcd tests are exact.
Floating-point logarithms are used only for finite flow values and ranking.

These observations by themselves neither prove nor refute CT-3C. A finite
positive ratio is absorbed by its additive constant, while finitely many zero
values cannot establish a uniform asymptotic theorem. The subsequent family
\((1,p^2-1,p^2)\), indexed by all odd primes, supplies the required unbounded
complete-premise obstruction and supersedes the bounded evidence.

## 7. Lean formalization and trust boundary

The ordinary proofs above were established before their formal counterparts.
The Lean module is
Lean/IUTThreeClosures/ABCThreeArmIncidenceSuccessor20260903.lean, with
one-to-one public-declaration audit in
Lean/IUTThreeClosures/ABCThreeArmIncidenceSuccessor20260903AxiomAudit.lean.

The formalization includes:

- the full positive-domain face and all four selected/complement quantities;
- exact radical, defect, and modulus identities;
- pairwise coprime local moduli, the three incidence congruences, and strict
  CRT reconstruction;
- the RAW-3C implication theorem;
- the complete Pythagorean-square refutation of RAW-3C;
- actual monotone weighted complement flows, including an explicit zero flow;
- exact source and sink mass identities, flow accounting, and every-threshold
  Hall obstruction;
- the CT-3C height estimate and its implication to the unchanged
  ABCConjecture.

There are \(65\) public declarations and exactly \(65\) corresponding
axiom-audit queries. Both the main module and the audit compile with
warnings treated as errors. The union of reported foundational axioms is
only propext, Classical.choice, and Quot.sound. The module introduces
no custom axiom, no admitted proof, and no inhabitant of CT-3C. The companion
obstruction module adds a proof of its negation.

## 8. Route disposition and next proof obligations

RAW-3C is retired because Theorem 4.4 gives an infinite complete-premise
counterexample. CT-3C is now also retired because the prime-square family
forces an unmatched source mass at least \(\log p\) against conductor less
than \(3\log p\). This second result does not retire the parent labelled
incidence complex.

Lemma 6.1 still gives the exact converse to Proposition 5.3 for this nested
finite transport problem:
\[
\inf_f U(f)
=
\max_{m\ge0}\bigl(S_{>m}-Q_{>m}\bigr)_+.
\]
The prime-square family realizes an upper-tail excess of \(\log p\) and thus
identifies the exact obstruction. The next positive task is no longer to
bound this false ordered gate. It is to permit downward transport while
retaining a nonnegative displacement cost, or to construct a genuinely
multi-face or homological incidence invariant. Completely unordered flow is
only the positive part of the scalar height defect and therefore supplies no
independent mechanism. Each corrected candidate remains active until a
complete-premise counterexample is proved; difficulty, a missing bridge, or a
bounded no-hit search does not retire it.
