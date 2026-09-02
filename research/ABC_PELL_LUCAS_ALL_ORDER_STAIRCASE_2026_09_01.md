# All-order Lucas staircases and companion-channel reconstruction in the balancing-Pell packet

**Author:** ChatGPT  
**Date:** 2026-09-01  
**Status:** unconditional identities, an all-order support-coprimality theorem,
and a full-premise counterexample to one local-rigidity subclaim; no proof or
disproof of the standard abc conjecture.

## 0. Route policy and claim boundary

This report enforces the following route rule.

* Difficulty, a missing uniform estimate, failure of a bounded search to find
  an example, or the present absence of a Lean library component does not
  retire a route.
* A route statement is retired only after a counterexample satisfying every
  displayed premise has been proved and independently replayed.  The
  counterexample retires only that exact statement, not weaker repairs or a
  broader strategy containing it.

The new primary input is Geng-Rui Zhang's arXiv preprint
`arXiv:2608.30389v1`, dated 2026-08-31.  Proposition 5.1 gives an all-orders
norm-one Lucas multiplication formula; Corollaries 5.2--5.4 give the
fourth-order truncation and exact local deviations; Theorem 5.6 proves local
surjectivity of the normalized second-order correction.  The source PDF,
source archive, extracted TeX, hashes, and a literal quantifier audit are in

`research/sources/pell_fourth_order_lucas_2026_09_01/`.

The source is recent and is presently an arXiv v1 preprint.  Every
specialization used below is therefore derived explicitly rather than being
inferred from the abstract.  The local-surjectivity theorem rules out one
tempting rigidity argument, but its theorem is single-channel.  The
all-order and paired-companion routes remain active.

## 1. The norm-one Lucas sequence is the two Pell channels multiplied

Write

\[
 (1+\sqrt 2)^n=A_n+B_n\sqrt2
\]

and define

\[
 \alpha=3+2\sqrt2,\qquad \beta=3-2\sqrt2.
\]

Let

\[
 u_0=0,\quad u_1=1,\quad u_{n+2}=6u_{n+1}-u_n,
\]

\[
 v_0=2,\quad v_1=6,\quad v_{n+2}=6v_{n+1}-v_n.
\]

### Proposition 1.1 (exact channel splice)

For every integer \(n\ge0\),

\[
 u_n=\frac{\alpha^n-\beta^n}{\alpha-\beta}
     =\frac{B_{2n}}2=A_nB_n,                             \tag{1.1}
\]

\[
 v_n=\alpha^n+\beta^n=2A_{2n},                          \tag{1.2}
\]

and

\[
 v_n^2-32u_n^2=4.                                       \tag{1.3}
\]

#### Proof

The numbers \(\alpha,\beta\) are the roots of
\(X^2-6X+1\), so their symmetric and antisymmetric Binet expressions obey
the two displayed recurrences and initial values.  Moreover,

\[
 \alpha^n=(1+\sqrt2)^{2n}=A_{2n}+B_{2n}\sqrt2,
\]

\[
 \beta^n=(1-\sqrt2)^{2n}=A_{2n}-B_{2n}\sqrt2.
\]

Since \(\alpha-\beta=4\sqrt2\), subtraction and addition give
\(u_n=B_{2n}/2\) and \(v_n=2A_{2n}\).  Squaring
\((1+\sqrt2)^n\) gives \(B_{2n}=2A_nB_n\), proving (1.1).
Finally \((\alpha-\beta)^2=32\), and the standard Binet calculation gives
(1.3). \(\square\)

Thus the norm-one sequence in Zhang's theorem does not model just one Pell
channel.  At an odd index it is exactly their coprime product.

## 2. Prime-index support lies beyond every multiplication coefficient

Fix an odd prime \(\ell\), and abbreviate

\[
 A=A_\ell,\qquad B=B_\ell,\qquad U=u_\ell=AB.
\]

The inherited rank theorem and the channel congruences give, for every prime
\(p\mid U\),

\[
 p\equiv \left(\frac2p\right)\pmod{2\ell}.              \tag{2.1}
\]

In the \(A\)-channel the sign is \(+1\); in the \(B\)-channel it is the
displayed Legendre sign.  In particular,

\[
 p\ge2\ell-1>\ell+1,                                    \tag{2.2}
\]

so \(p\nmid 32\ell(\ell^2-1)\).

For \(0\le r\le(\ell-1)/2\), put

\[
 c_r(\ell)=
 \frac{\ell\prod_{j=1}^{r}
       \bigl(\ell^2-(2j-1)^2\bigr)}
      {4^r(2r+1)!},\qquad
 a_r=32^r c_r(\ell).                                    \tag{2.3}
\]

Zhang proves that each \(c_r(\ell)\) is a positive integer.

### Lemma 2.1 (every all-order coefficient is a support unit)

For every \(0\le r\le(\ell-1)/2\),

\[
                         \gcd(a_r,U)=1.                 \tag{2.4}
\]

At the last index \(\theta=(\ell-1)/2\), one has

\[
                         c_\theta(\ell)=1.              \tag{2.5}
\]

#### Proof

Let \(p\mid U\) be prime.  Equation (2.2) gives \(p>\ell\), so
\(p\nmid\ell\).  For \(1\le j\le r\),

\[
 2\le \ell-(2j-1)<p,
 \qquad
 \ell+(2j-1)\le2\ell-2<p.
\]

Hence \(p\) divides neither factor of
\(\ell^2-(2j-1)^2\).  It therefore does not divide the numerator in
(2.3).  Since that numerator equals
\(4^r(2r+1)!c_r(\ell)\), divisibility of \(c_r(\ell)\) by \(p\) would
contradict the preceding conclusion.  Also \(p\) is odd, so \(p\nmid32\).
Thus \(p\nmid a_r\).  This holds for every prime divisor of \(U\), proving
(2.4).

For (2.5), write \(\ell=2\theta+1\).  Then

\[
 \prod_{j=1}^{\theta}
 \bigl(\ell^2-(2j-1)^2\bigr)
 =4^\theta\theta!\frac{(2\theta)!}{\theta!}
 =4^\theta(2\theta)!.
\]

Multiplication by \(\ell=2\theta+1\) makes the numerator of
\(c_\theta\) equal its denominator. \(\square\)

The strict bound \(2\ell-2<p\) is the reason the prime-index
specialization is stronger than the unrestricted all-orders formula.

## 3. The all-order support-unit staircase

Zhang's Proposition 5.1, specialized to the parameter \(a=6\), discriminant
\(\delta=32\), base index \(n=\ell\), and odd multiplier \(k=\ell\), gives
the exact integer identity

\[
 Q_\ell:=\frac{u_{\ell^2}}{u_\ell}
 =\sum_{i=0}^{\theta}a_iU^{2i},
 \qquad \theta=\frac{\ell-1}{2}.                        \tag{3.1}
\]

For \(0\le r\le\theta\), define the tail

\[
 D_r=Q_\ell-\sum_{i=0}^{r-1}a_iU^{2i}                  \tag{3.2}
\]

and its normalized value

\[
 E_r=\sum_{i=r}^{\theta}a_iU^{2(i-r)}.                  \tag{3.3}
\]

### Theorem 3.1 (all-order support-unit staircase)

For every \(0\le r\le\theta\),

\[
 D_r=U^{2r}E_r,\qquad E_r\equiv a_r\pmod{U^2},
 \qquad \gcd(E_r,U)=1.                                  \tag{3.4}
\]

Consequently, if \(p\mid U\) and \(e_p=v_p(U)\), then

\[
                         v_p(D_r)=2r e_p.               \tag{3.5}
\]

At the final step,

\[
 D_\theta=32^\theta U^{\ell-1}.                         \tag{3.6}
\]

#### Proof

Factor \(U^{2r}\) from the tail of (3.1).  This proves the first identity
in (3.4) and gives (3.3).  Every term of (3.3) after its first is divisible
by \(U^2\), so \(E_r\equiv a_r\pmod{U^2}\).  Lemma 2.1 says that
\(a_r\) is coprime to \(U\); adding a multiple of \(U^2\) preserves this
coprimality.  Thus \(E_r\) is a unit at every prime in the support of
\(U\).  Taking the \(p\)-adic valuation of
\(D_r=U^{2r}E_r\) proves (3.5).  Equation (3.6) follows from
\(c_\theta(\ell)=1\) and the fact that the last tail has one term.
\(\square\)

For a hypothetical squarefull packet, every \(e_p\ge2\), so every step
\(r\) has depth at least \(4r\) at every support prime.  At the nontrivial
odd kernels, \(e_p\ge3\), and the depth is at least \(6r\).  These are exact
equalities, not lower-bound heuristics.  They do not yet contradict the
packet, because the normalized tails remain support units.

## 4. Fourth-order companion correlation reconstructs the two channels

The first nonconstant term of (3.1) is

\[
 a_1=\frac{4\ell(\ell^2-1)}3.                           \tag{4.1}
\]

Define

\[
 W=\frac{u_{\ell^2}/u_\ell-\ell}{U^2}.                 \tag{4.2}
\]

Theorem 3.1 gives

\[
 W\equiv\frac{4\ell(\ell^2-1)}3\pmod{U^2},
 \qquad \gcd(W,U)=1.                                    \tag{4.3}
\]

Zhang's companion expansion in Corollary 5.2 gives

\[
 \frac{v_{\ell^2}}{v_\ell}
 \equiv1+4(\ell^2-1)U^2\pmod{U^4}.                    \tag{4.4}
\]

Put

\[
 S=\frac{v_{\ell^2}-v_\ell}{U^2}.                     \tag{4.5}
\]

Then

\[
 S\equiv4v_\ell(\ell^2-1)\pmod{U^2}.                  \tag{4.6}
\]

### Theorem 4.1 (paired quotient and channel splitter)

The two corrections satisfy

\[
 \ell S\equiv3v_\ell W\pmod{U^2}.                     \tag{4.7}
\]

Moreover,

\[
 \ell S\equiv 6W\pmod{A^2},
 \qquad
 \ell S\equiv-6W\pmod{B^2}.                           \tag{4.8}
\]

The number \(6W\) is coprime to \(U\).  Hence the unique residue
\(Z\pmod{U^2}\) satisfying

\[
                         6WZ\equiv\ell S\pmod{U^2}     \tag{4.9}
\]

obeys

\[
 Z\equiv A_{2\ell}\pmod{U^2},\qquad
 Z\equiv1\pmod{A^2},\qquad Z\equiv-1\pmod{B^2}.       \tag{4.10}
\]

Thus

\[
                         Z^2\equiv1\pmod{U^2}.         \tag{4.11}
\]

#### Proof

Multiply (4.6) by \(\ell\), and multiply (4.3) by
\(3v_\ell\).  Their right sides are both
\(4\ell v_\ell(\ell^2-1)\), proving (4.7).  Proposition 1.1 and the
negative Pell equation give

\[
 \frac{v_\ell}{2}=A_{2\ell}=2A^2+1=4B^2-1.             \tag{4.12}
\]

Substitute \(v_\ell\equiv2\pmod{A^2}\) and
\(v_\ell\equiv-2\pmod{B^2}\) into (4.7) to obtain (4.8).

Every prime divisor of \(U\) is greater than \(\ell+1\ge4\), so it
divides neither 6 nor \(W\).  Thus \(6W\) is invertible modulo \(U^2\),
which proves existence and uniqueness in (4.9).  Equation (4.7) shows that
\(A_{2\ell}\) is a solution, proving the first congruence in (4.10).
The other two follow from (4.12).  Since \(A^2-2B^2=-1\), one has
\(\gcd(A,B)=1\), so the two squared channel congruences combine modulo
\(A^2B^2=U^2\) and give (4.11). \(\square\)

The single-channel correction in (4.3) is locally flexible, but its
companion is not independent: their ratio recovers the exact idempotent
that separates \(A\) and \(B\).  This is the active correlated route.

## 5. A full-premise counterexample to fixed local rigidity

Consider the following precise subclaim.

> **Fixed-zero subclaim R0.**  For \(n=3\), \(s=5\), \(t=1\), every
> positive odd \(k\equiv1\pmod{u_3^2}\) has
> \[
> \frac{u_{3k}/u_3-1}{u_3^2}\equiv0\pmod5.
> \]

### Proposition 5.1 (R0 is false)

The integer

\[
                       k=2451=1+2\cdot35^2             \tag{5.1}
\]

satisfies every premise of R0, but

\[
 \frac{u_{3k}/u_3-1}{u_3^2}\equiv2\pmod5.              \tag{5.2}
\]

#### Proof

Here \(u_3=35\), and (5.1) is positive, odd, and congruent to one modulo
\(35^2\).  Exact recurrence powering gives

\[
 u_{7353}\equiv85785=35\cdot2451
       \pmod{214375=35\cdot(5\cdot35^2)}.               \tag{5.3}
\]

The Lucas divisibility in Proposition 5.1 of the source gives
\(35\mid u_{7353}\).  Divide (5.3) by 35 to obtain

\[
 \frac{u_{7353}}{35}\equiv2451
       \pmod{5\cdot35^2}.
\]

Since \(2451-1=2\cdot35^2\), division by \(35^2\) proves (5.2).
Two independent recurrence implementations replay (5.3) in the computation
bundle. \(\square\)

This is also the first nonzero residue promised by Zhang's Theorem 5.6.  The
same bundle realizes all five residues modulo 5.  Therefore R0 is retired by
a full-premise counterexample.  The following statements are not retired:

* the all-order staircase in Theorem 3.1;
* the paired companion correlation in Theorem 4.1;
* any rigidity statement using two channels, more than one multiplier, or a
  global height/radical constraint.

No counterexample satisfying the full squarefull Pell packet has been
found.

## 6. Relation to the opposite-channel depth-three gate

In the original sequence \(B_n\), a prime in the \(B_\ell\)-channel has
rank \(\ell\), while a prime in the \(A_\ell\)-channel has rank
\(2\ell\): it first enters through
\(B_{2\ell}=2A_\ell B_\ell\).  A hypothetical squarefull packet, together
with the inherited non-perfect-power classifications, therefore forces two
distinct odd-kernel primes of depth at least three, one of original Pell
rank \(\ell\) and one of rank \(2\ell\).  In the spliced norm-one sequence
both have rank \(\ell\), and Theorem 3.1 supplies their complete all-order
valuation staircase simultaneously.

The certified exhaustive search already in

`research/computation/2026_09_01_pell_four_prime_coupling/`

proves that every rational depth-three balancing prime exceeds \(10^9\).
Hence both primes in such a paired packet exceed \(10^9\).  This is a
finite lower bound only.  It is not used to declare the route false or
finished.

The next sufficient target is a genuinely correlated exclusion: prove that
the two opposite-channel odd-kernel primes cannot simultaneously share the
same norm-one rank \(\ell\) while satisfying the all-order staircase,
the channel splitter (4.8), the kernel character triangle, and the existing
third-order factorization ledger.  No theorem audited here supplies that
uniform exclusion.

## 7. Formalization and reproducibility boundary

The companion Lean module is

`Lean/IUTThreeClosures/PellLucasAllOrderStaircase20260901.lean`.

It kernel-checks the generic tail factorization, preservation of Bézout
coprimality after adding a square-modulus tail, exact divisibility transfer,
the paired fourth-order congruence, the two channel signs, the induced
square root of one, and the logical consequence of local surjectivity that
fixed-zero rigidity is false.  The literature recurrence theorem enters
only through explicit hypotheses; it is not declared as an axiom.

The source and numerical replay bundle are described in

`research/computation/2026_09_01_pell_lucas_all_order/REPRODUCE.md`.

The Lean module does not claim a proof of Zhang's complete Lucas theorem,
the inherited rank congruence, or the nonexistence of the remaining
squarefull packet.  Those boundaries remain literal.

## References

* Geng-Rui Zhang, *13 unknowns over quadratic integer rings and Lucas
  congruences*, arXiv:2608.30389v1, 2026, especially Proposition 5.1,
  Corollaries 5.2--5.4, and Theorem 5.6.
* Christian J.-C. Ballot and Hugh C. Williams, *The Lucas Sequences: Theory
  and Applications*, Springer, 2023, Section 2.2, cited by Zhang for the
  classical multiplication polynomial.
* The inherited Pell rank, channel, perfect-power, and depth-three results
  are audited in `research/ABC_PELL_FOUR_PRIME_COUPLING_2026_09_01.md` and
  `research/ABC_PELL_ODD_KERNEL_THIRD_ORDER_PACKET_2026_09_01.md`.
