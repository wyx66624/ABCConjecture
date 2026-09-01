# A divisor-pair Wall--Sun--Sun amplification for the Danilov survivor

**Date:** 2026-09-01  
**Author:** ChatGPT  
**Status:** unconditional mathematical implication, exact finite local
computation, and a sharply identified open endpoint

## 0. Verdict

This note does **not** prove or disprove the standard abc conjecture, and it
does not prove that the final Danilov progression is empty. It strengthens
the surviving bad case substantially.

Let \(Q_*\) be the verified 4398-digit squarefree modulus with 638 distinct
prime factors from the recursive-lift computation. If an index \(t\) in the
final progression made the associated Danilov integer \(K_t\) squarefull,
then there would exist at least

\[
                              2^{638}-622                  \tag{0.1}
\]

**distinct** Wall--Sun--Sun primes. A distinguished subfamily of at least
\(2^{637}\) of them would consist entirely of primes exceeding
\(10^{2199}\), and at least one would exceed \(10^{4399}\). These conclusions
are unconditional as implications. They are not contradictions: no theorem
currently rules out the existence of that many Wall--Sun--Sun primes.

The proof uses the full squarefull-survivor hypothesis, not merely failure of
a simple primitive divisor at one cyclotomic layer. It combines the exact
Danilov--Fibonacci factorization, Carmichael--Yabuta primitive divisors at
many divisor indices, the split rank congruence, Sanna's exact valuation
formula, and divisor pairing in the 638-prime squarefree modulus.

The same audit shows why cyclotomic derivatives and discriminants do not by
themselves force multiplicity one. A primitive root is already a simple
root modulo \(p\); the Wall--Sun--Sun condition says that the fixed algebraic
unit happens to equal its unique Hensel lift modulo \(p^2\). Nonvanishing of
the derivative supplies uniqueness of the lift, not exclusion of the lift.

## 1. Exact setup

Write

\[
 F_0=0,\qquad F_1=1,\qquad F_{n+2}=F_{n+1}+F_n.
\]

The Danilov orbit satisfies

\[
 \alpha_t=\varphi^{60t+15},\qquad
 L_t=2\operatorname{Re}(\alpha_t)+11,\qquad
 K_t=\frac{27L_t}{125},                                  \tag{1.1}
\]

where \(\varphi=(1+\sqrt5)/2\). Put

\[
                         R=3t+1,\qquad N=10R.              \tag{1.2}
\]

Then \(60t+15=20R-5\), and the Lucas addition identity gives

\[
 L_t=5F_NF_{N-5},\qquad
 K_t=\frac{27}{25}F_NF_{N-5}.                             \tag{1.3}
\]

Both Fibonacci factors in (1.3) are divisible by \(5\), so \(K_t\) is an
integer. Strong divisibility gives

\[
                         \gcd(F_N,F_{N-5})=F_5=5.          \tag{1.4}
\]

At the final verified state, \(3T_*+1=Q_*\). Thus, for every
\(t=T_*+Q_*r\) with \(r\ge0\),

\[
                    R=3t+1=Q_*(1+3r),                    \tag{1.5}
\]

so \(Q_*\mid R\).

For a prime \(p\ne2,5\), let \(z(p)\) be its Fibonacci rank of apparition.
A Wall--Sun--Sun prime is a prime satisfying

\[
                  p^2\mid F_{p-(5/p)}.                    \tag{1.6}
\]

The preceding simple-primitive-divisor report proved the two facts used
below:

* if \(m>5\), \(5\mid m\), and \(p\) is primitive at \(F_m\), then
  \(z(p)=m\) and \(p\equiv1\pmod m\);
* for such a prime, \(v_p(F_m)=v_p(F_{p-1})\), so
  \(p^2\mid F_m\) is equivalent to the Wall--Sun--Sun condition.

## 2. The divisor-pair amplification theorem

### Theorem 2.1

Let \(Q>1\) be squarefree with \(\gcd(Q,10)=1\), let \(R\) be a positive
multiple of \(Q\), and put \(N=10R\). Suppose

\[
                         \frac{27}{25}F_NF_{N-5}           \tag{2.1}
\]

is squarefull. If \(Q\) has \(s\) distinct prime factors, then there are at
least

\[
                              2^{s-1}                      \tag{2.2}
\]

distinct Wall--Sun--Sun primes. More precisely, they may be indexed by

\[
                  \mathcal D_-(Q)=\{d:d\mid Q,\ d<Q/d\},  \tag{2.3}
\]

and the prime \(p_d\) indexed by \(d\) satisfies

\[
             z(p_d)=\frac Nd,\qquad
             p_d\equiv1\pmod{N/d},\qquad
             p_d>\frac{N}{\sqrt Q}.                       \tag{2.4}
\]

#### Proof

Because \(Q\) is squarefree and \(Q>1\), it is not a square. The involution
\(d\mapsto Q/d\) on the divisors of \(Q\) has no fixed point. Exactly one
member of every pair satisfies \(d<Q/d\). Since a squarefree integer with
\(s\) prime factors has \(2^s\) divisors,

\[
                         |\mathcal D_-(Q)|=2^{s-1}.        \tag{2.5}
\]

Fix \(d\in\mathcal D_-(Q)\), and put \(m_d=N/d\). This is an integer
because \(d\mid Q\mid R\). Since \(d\) is odd, \(10\mid m_d\); in
particular \(m_d\notin\{1,2,6,12\}\). Carmichael's theorem in the exact
Fibonacci form proved by Yabuta supplies a primitive prime divisor \(p_d\)
of \(F_{m_d}\). Its rank is \(z(p_d)=m_d\). Because \(5\mid m_d\), the
split-rank theorem gives

\[
                              p_d\equiv1\pmod{m_d}.        \tag{2.6}
\]

The inequality \(d<Q/d\) implies \(d^2<Q\le R<N\), so
\(d<m_d=N/d\). Equation (2.6) consequently gives

\[
                              p_d\ge m_d+1>d.              \tag{2.7}
\]

Since \(N=m_dd\), equations (2.6)--(2.7) show that \(p_d\) divides
neither \(m_d\) nor \(d\). Hence

\[
                              p_d\nmid N.                  \tag{2.8}
\]

Now \(m_d\mid N\), so \(p_d\mid F_N\). The prime \(p_d\) is greater than
five, and (1.4) shows that it does not divide \(F_{N-5}\). It also divides
neither \(27\) nor \(25\). Therefore its valuation in (2.1) is exactly
\(v_{p_d}(F_N)\). Squarefullness of (2.1) forces

\[
                              v_{p_d}(F_N)\ge2.             \tag{2.9}
\]

Sanna's valuation formula, \(z(p_d)=m_d\mid N\), and (2.8) give

\[
 v_{p_d}(F_N)
   =v_{p_d}(N)+v_{p_d}(F_{z(p_d)})
   =v_{p_d}(F_{m_d}).                                     \tag{2.10}
\]

Thus \(p_d^2\mid F_{m_d}\). The split-rank valuation equivalence makes
\(p_d\) a Wall--Sun--Sun prime.

If \(d,e\in\mathcal D_-(Q)\) and \(p_d=p_e\), then the same prime would
have ranks \(N/d\) and \(N/e\). Uniqueness of the rank gives \(d=e\).
Hence all \(p_d\) are distinct, and (2.5) proves (2.2).

Finally \(d<\sqrt Q\), so

\[
                         p_d\ge\frac Nd+1
                              >\frac N{\sqrt Q},           \tag{2.11}
\]

which completes the proof. \(\square\)

### Corollary 2.2 (the verified final progression)

Let \(Q_*\) and \(T_*\) be the final verified recursive-lift state. If
\(t=T_*+Q_*r\), where \(r\ge0\), and \(K_t\) is squarefull, then there are at least
\(2^{637}\) distinct Wall--Sun--Sun primes.

#### Proof

Equation (1.5) supplies \(Q_*\mid R\). The verified modulus \(Q_*\) is
squarefree, coprime to \(30\), and has 638 distinct prime factors. Apply
Theorem 2.1 with \(s=638\). \(\square\)

### Corollary 2.3 (size of every forced Wall--Sun--Sun prime)

Every prime supplied by Corollary 2.2 exceeds \(10^{2199}\).

#### Proof

The integer \(Q_*\) has 4398 decimal digits, so
\(Q_*\ge10^{4397}\). Since \(R\ge Q_*\), Theorem 2.1 gives

\[
 p_d>\frac{10R}{\sqrt{Q_*}}
     \ge10\sqrt{Q_*}
     \ge10^{2199.5}>10^{2199}.                            \tag{2.12}
\]

\(\square\)

### Corollary 2.4 (one much larger forced prime)

Under the hypotheses of Corollary 2.2, at least one of the forced
Wall--Sun--Sun primes satisfies

\[
                              p\ge41N+1>10^{4399}.          \tag{2.13}
\]

#### Proof

Here \(N=10R\ge10Q_*\ge10^{4398}\). Since \(\log 10>2.3\),

\[
                         \log N>4398(2.3)>10036.           \tag{2.14}
\]

Hong's Theorem 1.1 and the printed \(\kappa=40\) entry of his Table 2
therefore supply a primitive prime divisor \(p\) of \(F_N\) which is not
any of \(jN\pm1\), \(1\le j\le40\). Because \(5\mid N\), the split-rank
argument forces \(p\equiv1\pmod N\), say \(p=kN+1\). The exclusions imply
\(k\ge41\). Squarefullness transfers \(p^2\mid F_N\) exactly as in the
proof of Theorem 2.1, so \(p\) is Wall--Sun--Sun. Finally
\(p\ge41N+1>10^{4399}\). \(\square\)

### Theorem 2.5 (factor-bound amplification)

In Theorem 2.1, suppose additionally that every prime factor of \(Q\) is at
most \(B\). Let

\[
 E_B(Q)=|\{e:e\mid Q,\ 10e\le B\}|.                      \tag{2.15}
\]

Then a squarefull value (2.1) forces at least

\[
                              2^s-E_B(Q)                  \tag{2.16}
\]

distinct Wall--Sun--Sun primes.

#### Proof

Write \(R=kQ\) with \(k\ge1\). For every divisor \(e\mid Q\) satisfying
\(10e>B\), put

\[
                d=Q/e,\qquad m_e=N/d=10ke.               \tag{2.17}
\]

Carmichael--Yabuta gives a primitive prime \(p_e\) at \(F_{m_e}\), and the
split-rank argument gives \(p_e\equiv1\pmod {m_e}\). Hence
\(p_e\ge m_e+1>B\). Since every prime factor of \(Q\) is at most \(B\),
we have \(p_e\nmid Q\), and in particular \(p_e\nmid d\). Also
\(p_e\nmid m_e\), so \(p_e\nmid N=m_ed\).

The valuation transfer (2.9)--(2.10) now applies unchanged and proves that
\(p_e\) is Wall--Sun--Sun. Distinct divisors \(e\) give distinct ranks
\(m_e=10ke\), hence distinct primes. A squarefree \(Q\) has \(2^s\)
divisors, exactly \(E_B(Q)\) of which fail \(10e>B\). This proves (2.16).
\(\square\)

### Corollary 2.6 (near-doubling at the verified endpoint)

A squarefull survivor in the final progression forces at least

\[
                              2^{638}-622                  \tag{2.18}
\]

distinct Wall--Sun--Sun primes.

#### Proof

The exact factor reconstruction gives
\(B=P(Q_*)=99{,}966{,}059\). Thus the exceptions in (2.15) are precisely
the divisors \(e\mid Q_*\) with \(e\le9{,}996{,}605\). Truncated exact
subset-product enumeration of the 638 certified prime factors gives 622
such divisors. Apply Theorem 2.5. \(\square\)

The sorted 622-divisor list, encoded as newline-delimited decimal integers,
has SHA-256
`793e089d9f3d6fa31903a5d3bc72380de7c0625dee220de7f73a4bed68c69e08`.
The count is verified without enumerating the full \(2^{638}\) divisor set.

## 3. What the amplification does and does not prove

Failure of a simple primitive divisor at the single top index \(10Q_*\)
forces all primitive factors of one cyclotomic value to be Wall--Sun--Sun.
Theorem 2.1 uses the stronger hypothesis of an **actual squarefull Danilov
survivor**. It applies Carmichael at \(2^{637}\) distinct divisor indices
\(N/d\), and squarefullness transfers every one of their primitive factors
to multiplicity at least two. The factor-bound refinement uses all but 622
of the \(2^{638}\) divisor indices, while the half-divisor subfamily retains
the much stronger uniform size bound (2.12).

This is a strict strengthening of the full bad case. It is still not a
contradiction. The nonexistence of even one Wall--Sun--Sun prime remains
open, and no unconditional theorem bounds their total number. Finite
searches below \(10^{15}\), or later distributed computations, say nothing
about the primes in (2.12).

The amplification also does not provide the next recursive digit. A
Wall--Sun--Sun prime \(p_d\) already square-divides the relevant Fibonacci
term, so the first-order local slope vanishes. Adding such a prime to the
modulus without a forced residue would destroy the state invariant used by
the recursive proof.

## 4. Cyclotomic derivative and discriminant audit

Let \(p\) be primitive at \(F_m\), \(p\nmid 5m\), and let
\(\gamma=\alpha/\beta\). Modulo \(p\), the element \(\gamma\) has exact
order \(m\). It is therefore a root of \(\Phi_m(X)\), while

\[
                 (X^m-1)'\big|_{X=\gamma}
                    =m\gamma^{m-1}\ne0\pmod p.            \tag{4.1}
\]

Thus the relevant cyclotomic root is already simple; equivalently, \(p\)
does not divide the cyclotomic discriminant coming from that root. Hensel's
lemma gives a **unique** lift of this root modulo \(p^2\). The
Wall--Sun--Sun condition is exactly the assertion that the fixed algebraic
unit \(\gamma\), reduced modulo \(p^2\), equals that unique lift. Equation
(4.1) cannot exclude this equality.

The real-Lucas counterexample from the preceding report makes the logical
failure numerical. For

\[
                         f(X)=\Phi_{10}(X)
                              =X^4-X^3+X^2-X+1,
\]

one has

\[
 f(-3)=121=11^2,\qquad f'(-3)=-142,\qquad
 \gcd(121,142)=1,\qquad \operatorname{disc}(f)=125.        \tag{4.2}
\]

Hence \(11^2\mid f(-3)\), even though \(11\) divides neither the derivative
at the evaluated point nor the discriminant. This is a full counterexample
to the generic inference that a square divisor of a cyclotomic value must
come from a multiple root. It does not refute a Fibonacci-specific
valuation-one theorem.

## 5. Exact local branch computation at the final state

The seven primes \(p\le10^8\) which divide the final \(L_{T_*}\) to exact
valuation one do not satisfy the norm-one packet condition
\(\eta^{Q_*}\equiv1\pmod p\). A separate exact computation analyzed their
full local zero sets.

For \(A=\alpha_{T_*}\), \(g=\eta^{Q_*}\), and an odd prime
\(p\mid L_{T_*}\), the points \(Ag^r\) all have norm \(-1\). A point of
norm \(-1\) with the same real coordinate as \(A\) is either \(A\) or its
conjugate. Consequently

\[
 p\mid L_{T_*+Q_*r}
 \quad\Longrightarrow\quad
 g^r=1\ \text{or}\ g^r=\bar A/A\pmod p,                  \tag{5.1}
\]

so there are at most two zero classes modulo
\(\operatorname{ord}_p(g)\). For every one of the seven saved primes there
are exactly two, and each class has one exact lift modulo \(p^2\):

| \(p\) | \(\operatorname{ord}_p(g)\) | zero classes |
|---:|---:|---:|
| 13 | 7 | \(0,2\) |
| 11621 | 581 | \(0,387\) |
| 141961 | 7 | \(0,2\) |
| 178093 | 89047 | \(0,29682\) |
| 3561881 | 89047 | \(0,29682\) |
| 10685641 | 89047 | \(0,29682\) |
| 59127209 | 7390901 | \(0,4927267\) |

This proves a finite structural statement, not a global cover. Outside the
two displayed classes a given prime does not divide the term at all, which
is fully compatible with squarefullness. The seven primes therefore do not
yield a successor progression.

The exact script, JSON output, and independent verifier are in
**research/computation/2026_09_01_danilov_wss_escape/**. Their scope is only
the seven already saved primes.

### 5.1 Exact final-state provenance

The independent verifier binds \(Q_*\) to the canonical endpoint

`research/computation/2026_09_01_danilov_recursive_lift/search_stage13_100m.json`

whose SHA-256 is

`2b87f6fd5be958ec9477ecf4c8f70e821e0cbf1990f811cd8645ae0b662859c7`.

It checks the published SHA-256 of each of the fourteen canonical stage
files, collects the twelve initial factors followed by the 626 packet primes
in canonical stage-and-row order, applies deterministic 64-bit primality
tests to all of them, verifies that they are 638 distinct primes, and
multiplies them back to the exact decimal integer \(Q_*\). It also verifies
\(\gcd(Q_*,30)=1\), \(3T_*+1=Q_*\), 4398 decimal digits, and largest factor
\(99{,}966{,}059\). Thus squarefreeness and the coprimality claim are checked
from the factor list rather than copied from a summary file.

For value-level provenance, the SHA-256 of the ASCII decimal expansion of
\(Q_*\) is

`51216920fd7197cafc62ce7337f68f348acbfd2bc9267780ba2ef739071b39ae`,

and the SHA-256 of the newline-delimited ordered 638-factor list is

`c5d5a40e7ea0303ea9a0c29a787271f200a20ae86d8ce033656b28bdbc4a9319`.

## 6. Counterexample audit

No Fibonacci counterexample satisfying the adaptive Danilov hypotheses was
found. A full squarefull survivor in the final progression would, by
Corollary 2.6, immediately produce at least \(2^{638}-622\) Wall--Sun--Sun
primes, while none is presently known.

The bounded search was also filtered to genuine top-index Danilov
parameters. Among the 121 integers

\[
 2\le Q\le1000,\qquad Q\equiv1\pmod3,\qquad
 Q\text{ squarefree},\qquad\gcd(Q,30)=1,
\]

105 have an exact certificate of a prime \(p\Vert F_{10Q}\) primitive at
index \(10Q\). For \(t=(Q-1)/3\), such a prime divides \(K_t\) exactly once
because \(\gcd(F_{10Q},F_{10Q-5})=5\), so these 105 full squarefull
hypotheses are rigorously excluded. The remaining sixteen values

\[
 37,67,133,331,457,541,553,589,619,721,793,817,877,907,913,919
\]

are unresolved after the declared \(p\le5\cdot10^7\) certificate search.
They are not counterexamples. The new verifier rechecks every one of the 105
rank and valuation-one certificates used in this restricted conclusion; the
source CSV has SHA-256
`cff864120ca421082cee89fcb5963307728890f4db6fdeaa6dd4f6343d228007`.

The real Lucas example

\[
 U_{n+2}=2U_{n+1}+3U_n,\qquad
 U_{10}=2\cdot11^2\cdot61
\]

remains a complete counterexample only to the sequence-uniform shortcut. It
does not satisfy the Fibonacci-specific hypothesis and cannot close the
Danilov route.

Similarly, the exact Fibonacci value

\[
 C_{110}=142585201=11\cdot331\cdot39161                  \tag{6.1}
\]

shows why one must not claim that the cyclotomic correction vanishes for
every squarefree multiple of ten: \(11\) is the nonprimitive correction,
since \(110=11z(11)\) and \(z(11)=10\). The correction vanishes at the
current 4399-digit index only because the verified size and prime-factor
bound exclude \(n=qz(q)\).

## 7. Literature and open boundary

The proof of Theorem 2.1 uses:

* Minoru Yabuta, “A Simple Proof of Carmichael's Theorem on Primitive
  Divisors,” *The Fibonacci Quarterly* **39** (2001), 439--443
  ([official PDF](https://www.fq.math.ca/Scanned/39-5/yabuta.pdf));
* Carlo Sanna, “The \(p\)-adic Valuation of Lucas Sequences,” *The
  Fibonacci Quarterly* **54** (2016), 118--124
  ([official PDF](https://www.fq.math.ca/Papers1/54-2/Sanna02242016.pdf)).
* Haojie Hong, “On Big Primitive Divisors of Fibonacci Numbers,” *The
  Ramanujan Journal* **67** (2025), Article 20
  ([author preprint](https://arxiv.org/abs/2312.04354)); Theorem 1.1 and the
  printed \(\kappa=40\), \(n_0=10036\) entry of Table 2 are used only in
  Corollary 2.4.

The difficulty is consistent with the broader powerful-value boundary.
Paulo Ribenboim's 2005 “FFF: (Favorite Fibonacci Flowers)” records that even
the existence of a powerful
Fibonacci number which is not a proper power was unknown, and that standard
finiteness results use abc
([official journal PDF](https://www.mathstat.dal.ca/FQ/Papers1/43-1/paper43-1-1.pdf),
Section 4). That statement concerns \(F_n\), whereas the simple-primitive
bottleneck concerns a cyclotomic factor \(C_n\); it is cited only as
context, not as an input.

The Yabuta, Sanna, and Hong PDFs are locally archived in the preceding
simple-primitive bundle and are cross-bundle pinned by
`research/computation/2026_09_01_danilov_wss_escape/UPSTREAM_INPUTS.json`.
The Ribenboim PDF is archived directly in the new bundle as
`sources/Ribenboim_2005_Fibonacci_Powers.pdf`, with SHA-256
`ff645e8cb7e3094442537964c5b4b3d4a9094a44eefa455b8046867bae051775`.

## 8. Formalization and route ledger

The mathematical theorem above precedes its Lean formalization. The new
module **Lean/IUTThreeClosures/DanilovWSSEscape20260901.lean** formalizes
the \(2^{637}\) divisor-pair count, deletion of exactly 622 exceptions from
the full 638-bit divisor code, the retained cardinal \(2^{638}-622\),
injectivity of primitive witnesses on that retained family, repeated-rank
witness transfer, the elementary Hong-plus-splitting gap, and an abstract
valuation-transfer kernel. It
introduces no axiom and no **sorry**. Carmichael--Yabuta, Sanna, the exact
Fibonacci factorization, and the 4398-digit certificate remain explicit
hypotheses or external paper-and-certificate inputs; Lean does not pretend
to formalize those sources.

The route ledger is therefore:

* **Unconditional theorem:** a full final-progression survivor forces at
  least \(2^{638}-622\) distinct Wall--Sun--Sun primes; at least \(2^{637}\)
  of them are \(>10^{2199}\), with at least one \(>10^{4399}\).
* **Finite exact computation:** the seven final valuation-one divisors have
  the two-class local structure in Section 5 and do not cover the parameter
  line.
* **Complete auxiliary counterexamples:** derivative/discriminant
  multiplicity inference and the real-Lucas sequence-uniform shortcut.
* **Open:** exclude the \((2^{638}-622)\)-prime Wall--Sun--Sun alternative, obtain
  a fresh valuation-one packet by another mechanism, or find an actual
  squarefull survivor. Difficulty and finite no-hit do not close the route.
