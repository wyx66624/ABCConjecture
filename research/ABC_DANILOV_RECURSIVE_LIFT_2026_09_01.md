# Recursive prime-square lifts on the Danilov survivor class

**Date:** 2026-09-01  
**Author:** ChatGPT  
**Status:** mathematical theorem report, bounded exact computation, and a
Lean-checked elementary recursive kernel

## 0. Verdict and scope

This investigation does **not** prove or disprove the standard abc
conjecture, and it does not prove that the surviving Danilov progression is
empty.  It does produce four rigorous advances.

1. The Danilov orbit is exactly a Fibonacci orbit.  If a recursive state is
   written as `t=T+Qr` and satisfies

   \[
                      3T+1=hQ,\qquad h\in\{1,2\},          \tag{0.1}
   \]

   then

   \[
        L_T=5F_{10hQ}F_{10hQ-5}.                          \tag{0.2}
   \]

2. A prime with \(p\parallel F_{10Q}\) supplies a nondegenerate
   prime-square lift.  Squarefullness forces the unique congruence

   \[
                         h+3r\equiv0\pmod p,               \tag{0.3}
   \]

   and the updated state again satisfies (0.1).

3. Carmichael's theorem unconditionally supplies a **primitive** divisor of
   \(F_{10Q}\), and primitivity makes it fresh relative to \(Q\).  It does
   not say that the divisor has valuation one.  Thus the exact missing input
   is a simple primitive divisor, equivalently the exclusion of total
   Fibonacci-Wieferich degeneration at each adaptively generated index.

4. A bounded exact recursion found 626 distinct nondegenerate lift primes in
   thirteen nonempty batches.  The resulting modulus has 4398 decimal digits
   and exactly 638 distinct prime factors.  At the next state there is no
   eligible packet with \(p\le 10^8\).  This last statement is only a finite
   endpoint.  It cannot be extrapolated to all primes.

The route therefore remains active.  The positive proof direction has been
reduced to a precise valuation-one theorem; a one-step packet by itself is
also shown below not to imply an infinite recursion.

## 1. Input and previous unconditional sieve

Work in \(\mathbf Z[\sqrt5]\).  The normalized Danilov orbit is

\[
 \alpha_t=\alpha_0\eta^t=z_t+w_t\sqrt5,
 \quad \alpha_0=682+305\sqrt5,
 \quad \eta=1730726404001+774004377960\sqrt5,              \tag{1.1}
\]

with \(N(\alpha_0)=-1\) and \(N(\eta)=1\).  Put

\[
                  L_t=2z_t+11,\qquad K_t={27L_t\over125}. \tag{1.2}
\]

The earlier global index sieve proves

\[
 K_t\text{ squarefull}\Longrightarrow
 t\equiv T_0\pmod {Q_0},                                 \tag{1.3}
\]

where

\[
\begin{aligned}
T_0&=122136955032565025967809449110840347537827,\\
Q_0&=183205432548847538951714173666260521306741,
\end{aligned}                                             \tag{1.4}
\]

and \(3T_0+1=2Q_0\).  The exact factorization used here is

\[
 Q_0=11\cdot89\cdot179\cdot199\cdot331\cdot661\cdot1069
 \cdot9791\cdot39161\cdot68531\cdot474541\cdot1801361. \tag{1.5}
\]

All twelve primes are distinct.  The valuation transfer used throughout is
elementary: if \(p\nmid3375\), then the identity
\(125K_t=27L_t\) gives \(v_p(K_t)=v_p(L_t)\).  Therefore squarefullness of
\(K_t\), together with \(p\mid L_t\), forces \(p^2\mid L_t\).

## 2. General local packet and the nesting logic

Let `t=T+Qr`, let \(p\nmid3375Q\) be an odd prime, and suppose modulo
\(p^2\) that

\[
 \alpha_T=x+y\sqrt5,\qquad
 \eta^Q=1+pd\sqrt5,\qquad
 L_T=pc.                                                   \tag{2.1}
\]

The absence of a real first-order term in the middle formula follows from
\(N(\eta^Q)=1\): if initially
\(\eta^Q=1+p(e+d\sqrt5)\), reduction of the norm modulo \(p^2\) gives
\(2e=0\pmod p\), hence \(e=0\) because \(p\) is odd.

Since the square of \(pd\sqrt5\) vanishes modulo \(p^2\),

\[
 (\eta^Q)^r=1+rpd\sqrt5\pmod {p^2}.
\]

Multiplying by \(\alpha_T\) and taking twice the real coordinate yields

\[
             L_{T+Qr}=p(c+10ydr)\pmod {p^2}.              \tag{2.2}
\]

If \(a=10yd\not\equiv0\pmod p\), squarefullness forces

\[
 r\equiv\rho:=-ca^{-1}\pmod p.                           \tag{2.3}
\]

Writing \(r=\rho+ps\) gives the next state

\[
        T'=T+Q\rho,\qquad Q'=Qp,
        \qquad t=T'+Q's.                                  \tag{2.4}
\]

This proves the local recursive-lift lemma without computation.

Now suppose packets \(p_0,p_1,\ldots\) are nested using (2.4), with
\(p_j\nmid3375Q_j\) at each stage.  For one fixed hypothetical squarefull
index \(t\), induction applies every local lemma to that same \(t\).  Hence
\(t=T_j+Q_jr_j\) at every stage and every \(p_j\) divides the one fixed
nonzero integer \(L_t\).  Freshness makes the \(p_j\) pairwise distinct.
An infinite chain, or chains of arbitrary finite length from the same root
state, is therefore impossible.  This is the rigorous contradiction that a
successful recursive existence theorem would provide.

The quantifier is essential: packets on unrelated progressions do not force
different primes to divide one fixed \(L_t\).

## 3. Exact Fibonacci structure

Let

\[
                         \varphi={1+\sqrt5\over2}.
\]

Write \(\Lambda_n\) for the Lucas number, reserving \(L_t\) for the
Danilov remainder.  The standard identity
\(\varphi^n=(\Lambda_n+F_n\sqrt5)/2\), together with direct integer arithmetic,
gives

\[
                  \alpha_0=\varphi^{15},\qquad
                  \eta=\varphi^{60}.                     \tag{3.1}
\]

Thus

\[
                         \alpha_t=\varphi^{60t+15}.        \tag{3.2}
\]

Assume (0.1).  Then

\[
                   60T+15=20hQ-5.                         \tag{3.3}
\]

The two indices \(20hQ-5\) and 5 are odd.  The Lucas addition identity

\[
          \Lambda_m+\Lambda_n=5F_{(m+n)/2}F_{(m-n)/2}
          \qquad(m,n\text{ odd},m\ge n)
\]

applied with \(m=20hQ-5\), \(n=5\), proves (0.2):

\[
 L_T=\Lambda_{20hQ-5}+\Lambda_5
     =5F_{10hQ}F_{10hQ-5}.                               \tag{3.4}
\]

At the earlier state \((T,Q,h)=(326,979,1)\), this specializes to the exact
4091-digit identity

\[
                         L_{326}=5F_{9790}F_{9785}.        \tag{3.5}
\]

The independent verifier also checks

\[
 \gcd\bigl(L_{326},\operatorname{Im}(\eta^{979}),
                 \operatorname{Re}(\eta^{979})-1\bigr)=F_{9790}. \tag{3.6}
\]

This explains the common factor used by the original ten-prime lift.

## 4. A simple divisor of \(F_{10Q}\) gives the next lift

### Theorem 4.1 (Fibonacci packet)

Assume \(3T+1=hQ\) with \(h\in\{1,2\}\).  Let
\(p\notin\{2,3,5\}\) be a prime satisfying

\[
                            p\parallel F_{10Q}.            \tag{4.1}
\]

Then \(p\mid L_T\), \(\eta^Q\equiv1\pmod p\), and the local slope in
(2.2) is nonzero.  If \(K_{T+Qr}\) is squarefull, then (0.3) holds.  If
\(\rho\) is its least nonnegative solution and

\[
                T'=T+Q\rho,\qquad Q'=Qp,                 \tag{4.2}
\]

then \(3T'+1=h'Q'\) for an \(h'\in\{1,2\}\).

**Proof.**  Put \(n=10Q\) and \(\zeta=\varphi^{2n}=\varphi^{20Q}\).
Modulo \(p\), the identity
\(\varphi^n=F_n\varphi+F_{n-1}\) makes \(\varphi^n\) a scalar.  Cassini's
identity and the evenness of \(n\) give \(F_{n-1}^2=1\pmod p\).  Hence

\[
                              \zeta=1\pmod p.             \tag{4.3}
\]

Moreover \(F_{2n}=F_n\Lambda_n\).  The identity
\(\Lambda_n^2-5F_n^2=4\) shows that \(p\nmid\Lambda_n\).  Thus (4.1) gives
\(v_p(F_{2n})=1\).  In the quadratic ring modulo \(p^2\), write
\(\zeta=1+p(a+d\sqrt5)\).  Since \(N(\zeta)=1\), one has
\(a=0\pmod p\); the imaginary coordinate is \(F_{2n}/2\), so \(d\ne0\).
Therefore

\[
                         \zeta=1+pd\sqrt5\pmod {p^2},
                         \qquad d\ne0\pmod p.             \tag{4.4}
\]

Equations (3.2)--(3.3) give the exact identity

\[
 \alpha_{T+Qr}=\varphi^{-5}\zeta^{h+3r},
 \qquad \varphi^{-5}={-11+5\sqrt5\over2}.                \tag{4.5}
\]

Using (4.4) in (4.5) and taking twice the real coordinate gives

\[
                  L_{T+Qr}=25pd(h+3r)\pmod {p^2}.         \tag{4.6}
\]

This proves \(p\mid L_T\) and \(\eta^Q=\zeta^3\equiv1\pmod p\).
Since \(25d\ne0\pmod p\), the slope is nonzero.  The valuation transfer
and squarefullness force (0.3).

Finally

\[
 3T'+1=Q(h+3\rho).
\]

The positive integer \(h+3\rho\) is a multiple of \(p\) and is strictly
less than \(3p\), so it equals \(h'p\) with \(h'\in\{1,2\}\).  This proves
the invariant for the new state. \(\square\)

## 5. What Carmichael proves, and what it does not prove

For a state satisfying (0.1), apply Carmichael's primitive-divisor theorem
to the Fibonacci number \(F_n\) with \(n=10Q\).  Since the present \(n\)
is not \(1,2,6,12\), the theorem gives a primitive prime divisor \(p\) of
\(F_n\).

Primitivity makes this prime fresh.  Indeed, for \(p\ne2,5\), let \(z(p)\)
be its Fibonacci rank of apparition.  In \(\mathbf F_{p^2}\), Frobenius
fixes or swaps \(\varphi\) and its conjugate according as
\((5/p)=1\) or \(-1\).  It follows that

\[
                         F_{p-(5/p)}\equiv0\pmod p.
\]

Strong divisibility of Fibonacci numbers then gives
\(z(p)\mid p-(5/p)\).  A primitive divisor of \(F_n\) has \(z(p)=n\), so

\[
                             10Q=n\le p+1.                \tag{5.1}
\]

Consequently \(p>Q\) and in particular \(p\nmid Q\).

The missing conclusion is \(v_p(F_n)=1\).  If instead \(p^2\mid F_n\),
the argument of Theorem 4.1 gives

\[
                         \zeta=1\pmod {p^2}.              \tag{5.2}
\]

Then (4.6) is zero modulo \(p^2\) for every residue \(r\); this prime gives
no new digit.  It is a Fibonacci-Wieferich-type degeneration.

The logical distinction is real.  For the Lucas sequence

\[
 U_0=0,\quad U_1=1,\quad U_{m+2}=2U_{m+1}+U_m,
\]

one has

\[
 U_1,\ldots,U_7=1,2,5,12,29,70,169,\qquad169=13^2.
\]

The prime 13 is a primitive divisor of \(U_7\), but it occurs with
valuation two.  Thus a primitive-divisor theorem alone cannot imply a simple
primitive divisor, even for a real Lucas sequence.

### Conditional theorem 5.1 (simple-primitive closure)

Start at \((T_0,Q_0,h_0)\) from (1.4).  Assume that at every state generated
by (0.3) and (4.2), \(F_{10Q}\) has a primitive divisor \(p\) with
\(v_p(F_{10Q})=1\).  Then no index in the initial progression has squarefull
\(K_t\).

**Proof.**  Equation (5.1) makes every selected prime fresh.  Theorem 4.1
supplies and nests the next packet while preserving (0.1).  Thus packets of
arbitrary finite length exist.  If one fixed \(t\) in the initial
progression had squarefull \(K_t\), Section 2 would make every selected,
pairwise distinct prime divide the fixed nonzero integer \(L_t\).  Choosing a
chain longer than the number of distinct prime divisors of \(L_t\) is a
contradiction. \(\square\)

This theorem is conditional.  Neither Carmichael's theorem nor any source
audited here supplies its valuation-one hypothesis.

## 6. A complete counterexample to automatic local continuation

The following example proves that one nondegenerate packet cannot, from its
local axioms alone, generate a successor.  In \(\mathbf Z[\sqrt5]\), put

\[
 u=9+4\sqrt5,\quad
 \eta=u^8=5374978561+2403763488\sqrt5,\quad
 \alpha_0=19+\sqrt5,\quad
 L_r=K_r=2\operatorname{Re}(\alpha_0\eta^r)+11.
\]

Here \(N(\eta)=1\), all terms are positive, and modulo \(49\),

\[
                        \eta=1+35\sqrt5,\qquad L_0=49.
\]

At \((T,Q,p)=(0,1,7)\), the slope is
\(10\cdot1\cdot5=1\pmod7\), and exact linearization gives

\[
                           L_r=7r\pmod {49}.               \tag{6.1}
\]

Thus this is a valid nondegenerate packet, its forced root is \(r=0\), and
the surviving term \(K_0=49\) is squarefull.  The updated state is
\((T',Q')=(0,7)\).  A fresh successor would need a prime
\(q\mid L_0=49\) with \(q\nmid Q'\), and no such prime exists.

This counterexample satisfies the complete abstract local-packet hypotheses
and the required valuation-transfer implication.  It does not have the special Danilov initial
norm and therefore does not refute a Danilov-specific simple-primitive
theorem.  It precisely refutes the inference “one packet implies an infinite
packet chain.”

## 7. Bounded exact recursion

The script `search_recursive_lifts.py` enumerates every odd prime up to the
declared endpoint.  For each \(p\nmid3375Q\), it checks \(p\mid L_T\) and
\(\eta^Q=1\pmod p\), computes the complete packet modulo \(p^2\), and batches
all unique forced residues by CRT.  No probabilistic primality label is used;
the saved rows include exhaustive trial-division bounds, while the independent
verifier also applies deterministic 64-bit Miller--Rabin.

The canonical nested chain is:

| stage | prime endpoint | digits of current \(Q\) | divisors of \(L_T\) found | nondegenerate packets |
|---:|---:|---:|---:|---:|
| 0 | \(10^6\) | 42 | 57 | 36 |
| 1 | \(10^6\) | 217 | 63 | 28 |
| 2 | \(10^6\) | 361 | 51 | 10 |
| 3 | \(10^6\) | 413 | 7 | 7 |
| 4 | \(10^6\) | 449 | 10 | 6 |
| 5 | \(10^6\) | 481 | 8 | 2 |
| 6 | \(10^6\) | 492 | 1 | 1 |
| 7 | \(10^7\) | 498 | 225 | 145 |
| 8 | \(10^7\) | 1451 | 20 | 14 |
| 9 | \(10^7\) | 1543 | 3 | 1 |
| 10 | \(5\cdot10^7\) | 1550 | 221 | 215 |
| 11 | \(5\cdot10^7\) | 3136 | 178 | 9 |
| 12 | \(10^8\) | 3204 | 349 | 152 |
| 13 | \(10^8\) | 4398 | 7 | 0 |

There are 626 distinct packet primes.  Every packet is classified
`unique_forced_residue`; none has zero slope.  The independent verifier
checks for all 626 that

\[
                  p\parallel F_{10Q},\qquad h+3\rho=0\pmod p. \tag{7.1}
\]

Together with the twelve factors in (1.5), the final squarefree CRT modulus
has exactly 638 distinct prime factors.  The final state has 4398-digit \(T\)
and \(Q\), satisfies \(3T+1=Q\), and has no eligible packet with
\(p\le10^8\).  Its seven detected divisors of \(L_T\),

\[
 13,11621,141961,178093,3561881,10685641,59127209,
\]

all occur to valuation exactly one.  In particular the least representative
\(T\) is not squarefull, so any squarefull index in this final progression
would have to be at least \(T+Q\).

These are finite, exact statements.  The absence of a packet below \(10^8\)
does not imply the absence of a larger packet; Carmichael in fact guarantees
an enormous primitive divisor, but its valuation remains uncontrolled.

## 8. Primary source and theorem boundary

The primitive-divisor input is Theorem 1 of:

* Minoru Yabuta, “A Simple Proof of Carmichael's Theorem on Primitive
  Divisors,” *The Fibonacci Quarterly* **39** (2001), 439--443.

The unchanged archived primary PDF is
`research/sources/alternative_counterexample_2026_08_31/Yabuta_Carmichael_Primitive_Divisors_2001.pdf`,
1695369 bytes, SHA-256
`69543ae7c2fd2193ce633a5cfbae1f448204f114fd07da11b3add2ef694eff70`.
The archived OCR text is adjacent to it.  Yabuta assumes a real Lucas
sequence generated by \(x^2-Lx+M\), with nonzero coprime integers \(L,M\)
and \(L>0\).  Apart from indices \(1,2,6\), a primitive divisor exists, with
the single extra exception \(n=12,L=1,M=-1\).  Applying this to Fibonacci
\((L,M)=(1,-1)\) at \(n=10Q\) is within scope because the adaptive indices
are far outside all exceptions.

The source says **primitive divisor**, not valuation-one primitive divisor.
All statements requiring the latter are explicitly conditional in this
report.

## 9. Reproducibility and formalization boundary

`verify_fibonacci_structure.py` independently checks the Fibonacci
factorization, the original ten packets, the final constants from the prior
sieve, and the local countermodel.  `verify_recursive_chain.py` checks every
saved packet modulo \(p^2\), all CRT transitions, all 626 Fibonacci
valuation-one assertions, and all state invariants.  `REPRODUCE.md` records
the exact generator commands required to re-enumerate every bounded prime
range.  `FILE_MANIFEST.json` and `SHA256SUMS` freeze the artifacts.

Only after the mathematical proof above was complete, the new module
`Lean/IUTThreeClosures/DanilovRecursiveLift20260901.lean` was written.  It
kernel-checks the existence and uniqueness of the next multiplier
`h' in {1,2}`, preservation of `3T+1=hQ`, the finite prime-support
contradiction for arbitrarily many distinct primes dividing one fixed nonzero
`L_t`, and every elementary assertion in the abstract modulo-49 countermodel.
It imports the earlier finite ten-prime global sieve.

The Fibonacci representation, the general local packet theorem in its full
quadratic-unit setting, Carmichael--Yabuta, rank freshness, the conditional
simple-primitive closure, and the 626-packet extension remain
paper-and-certificate mathematics.  None of the simple-primitive-divisor
hypothesis, the cited primitive-divisor theorem, or the desired global
Danilov elimination is introduced as a Lean axiom.

## 10. Route ledger

* **Unconditional:** Fibonacci representation (3.1)--(3.4), local packet
  theorem, invariant preservation, rank-based freshness of a primitive
  divisor, fixed-index contradiction from an arbitrarily long fresh chain,
  and the counterexamples in Sections 5--6 to two invalid strengthenings.
* **Conditional:** elimination of the whole survivor class under the
  simple-primitive hypothesis at every adaptively generated \(10Q\).
* **Finite exact evidence:** the 626 nested packets and the no-packet endpoint
  \(p\le10^8\).
* **Unresolved:** prove a fresh valuation-one divisor exists at every state,
  find another nondegenerate packet mechanism, or construct an actual
  squarefull survivor.  None has been done here.

Difficulty does not close this route.  Only a proof of the missing universal
existence statement, a strict impossibility theorem under its full
hypotheses, or an actual counterexample to the precise target can change its
status.
