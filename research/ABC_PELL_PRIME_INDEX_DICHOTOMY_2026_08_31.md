# Prime-index Pell dichotomy: a four-prime, two-depth-three obstruction

**Date:** 2026-08-31  
**Scope:** the balancing sequence only  
**Status:** unconditional reductions and finite certificates; neither a proof
nor a disproof of the abc conjecture

## 0. Claim discipline and the new result

Put

\[
 u_0=0,\qquad u_1=1,\qquad u_{n+2}=6u_{n+1}-u_n.
\]

The exact prime-index question is whether every odd prime \(\ell\) has a
prime \(q\) with \(q\parallel u_\ell\).  This note does not decide that
question.  It proves the following exhaustive and substantially sharpened
dichotomy.

> **Prime-index dichotomy.** For every odd prime \(\ell\), exactly one of the
> following alternatives holds.
>
> 1. Some prime \(q\) satisfies \(q\parallel u_\ell\), so \(u_\ell\) is not
>    squarefull.
> 2. The integer \(u_\ell\) is squarefull.  Then \(\ell\ne7\), and its two
>    coprime Pell factors contain at least four distinct primes of rank exactly
>    \(\ell\).  Every one of the four is balancing-Wieferich, and at least one
>    prime in each factor has first-occurrence valuation at least three.

The second alternative is not known to occur.  A single occurrence would
give one unusually strong abc point, but one point cannot disprove the abc
conjecture because its constant is not prescribed.  Infinitely many such
prime indices, or any other unbounded squarefull subsequence of \(u_n\),
would rigorously disprove standard abc through the adjacent Pell points.

There are two additional finite results.

* An exact scan of every odd prime \(q\le2{,}500{,}000\) finds no prime with
  first-occurrence valuation at least three.  Hence both distinguished
  depth-three primes in alternative 2 must exceed \(2{,}500{,}000\).
  This is a finite lower bound, not an asymptotic theorem.
* Seven of the nine formerly unresolved prime indices below 2000 now have
  completely local exponent-one certificates.  Together with the permanent
  repository bundle, all \(2\le n\le2000\) except \(1873\) and \(1951\) are
  certified nonsquarefull.  The two exceptions are unresolved, not hits.

## 1. Pell factorization

Let

\[
 \delta=1+\sqrt2,\qquad
 \delta^n=A_n+B_n\sqrt2,
\]

and let \(\delta'=1-\sqrt2=-\delta^{-1}\).  Also put

\[
 \alpha=\delta^2=3+2\sqrt2,
 \qquad \beta=\alpha^{-1}=3-2\sqrt2.
\]

### Proposition 1.1

For every \(n\ge0\),

\[
 A_n^2-2B_n^2=(-1)^n,\qquad
 \gcd(A_n,B_n)=1,\qquad
 u_n=A_nB_n.                                           \tag{1.1}
\]

For odd \(n\), both \(A_n\) and \(B_n\) are odd.  If \(n\ge3\), both are
greater than one.

**Proof.**  Taking norms in \(\mathbb Z[\sqrt2]\) gives the first identity:

\[
 (A_n+B_n\sqrt2)(A_n-B_n\sqrt2)
   =N(\delta)^n=(-1)^n.
\]

Every common divisor of \(A_n\) and \(B_n\) divides the left side, hence
divides 1.  For the third identity,

\[
 A_nB_n
 =\frac{(\delta^n+\delta'^n)(\delta^n-\delta'^n)}{4\sqrt2}
 =\frac{\alpha^n-\beta^n}{4\sqrt2}=u_n,
\]

because \(\alpha-\beta=4\sqrt2\).  In the binomial expansions, when \(n\)
is odd the constant term makes \(A_n\) odd, while the \(\sqrt2\)-coefficient
is congruent to \(n\) modulo 2.  Positivity and the recurrence give the last
claim. \(\square\)

### Corollary 1.2

For odd \(n\), \(u_n\) is squarefull if and only if both \(A_n\) and
\(B_n\) are squarefull.

**Proof.**  Their prime supports are disjoint by Proposition 1.1, so every
positive prime valuation of the product is the valuation in exactly one
factor. \(\square\)

For a prime \(\ell\), the equality

\[
 u_\ell=\frac{\alpha^\ell-\beta^\ell}{\alpha-\beta}
       =\Phi_\ell(\alpha,\beta)                              \tag{1.2}
\]

is the homogeneous cyclotomic factorization.  Thus the entire term is its
prime-rank cyclotomic layer; there are no lower-index cyclotomic factors to
discard.

## 2. Prime rank and the two factor channels

For an odd prime \(q\), let \(z(q)\) be the least positive \(n\) such that
\(q\mid u_n\), and put

\[
 e(q)=v_q(u_{z(q)}),\qquad s_q=\left(\frac2q\right).
\]

All finite-field calculations below take place in
\(\mathbb F_q(\sqrt2)\).  The denominator \(4\sqrt2\) is nonzero because
\(q\) is odd.

### Lemma 2.1 (rank bound, proved in this normalization)

For every odd prime \(q\),

\[
                         z(q)\mid q-s_q.                    \tag{2.1}
\]

**Proof.**  The divisibility \(q\mid u_n\) is equivalent to
\(\alpha^{2n}=1\).  If \(s_q=1\), then \(\alpha\in\mathbb F_q^\times\), so
its order divides \(q-1\).  If \(s_q=-1\), Frobenius sends
\(\sqrt2\) to \(-\sqrt2\), and therefore sends \(\alpha\) to
\(\beta=\alpha^{-1}\).  Hence \(\alpha^{q+1}=1\).  In either case the order
of \(\alpha^2\), which is \(z(q)\), divides \(q-s_q\). \(\square\)

### Lemma 2.2 (prime-index rank)

If \(\ell\) is an odd prime and \(q\mid u_\ell\), then \(q\ne\ell\) and

\[
                         z(q)=\ell.                          \tag{2.2}
\]

**Proof.**  The binomial formulas give

\[
 A_\ell\equiv1\pmod\ell,
 \qquad
 B_\ell\equiv2^{(\ell-1)/2}
       \equiv\left(\frac2\ell\right)\pmod\ell.             \tag{2.3}
\]

Thus \(\ell\nmid A_\ell B_\ell=u_\ell\).  Also \(u_\ell\) is odd, so
\(q\) is odd.  Since \(z(q)\mid\ell\), while \(q\nmid u_1=1\), primality
of \(\ell\) forces \(z(q)=\ell\). \(\square\)

### Theorem 2.3 (factor-channel residue and order theorem)

Let \(\ell\) be an odd prime and \(q\mid u_\ell\).

1. If \(q\mid A_\ell\), then

   \[
   \left(\frac2q\right)=1,\qquad q\equiv1\pmod{2\ell},      \tag{2.4}
   \]

   and more precisely

   \[
   q\equiv
   \begin{cases}
   1             &\pmod{4\ell},&q\equiv1\pmod4,\\
   2\ell+1       &\pmod{4\ell},&q\equiv3\pmod4.
   \end{cases}                                             \tag{2.5}
   \]

   The multiplicative order of \(\delta\) is \(\ell\) or \(2\ell\).

2. If \(q\mid B_\ell\), then \(q\equiv1\pmod4\), and

   \[
   q\equiv
   \begin{cases}
   1             &\pmod{4\ell},&\left(\frac2q\right)=1,\\
   2\ell-1       &\pmod{4\ell},&\left(\frac2q\right)=-1.
   \end{cases}                                             \tag{2.6}
   \]

   The multiplicative order of \(\delta\) is exactly \(4\ell\).

In particular, every \(A\)-channel prime is at least \(2\ell+1\), and every
\(B\)-channel prime is at least \(2\ell-1\).

**Proof.**  Suppose first that \(q\mid A_\ell\).  The norm identity at odd
index gives \(2B_\ell^2\equiv1\pmod q\), so 2 is a square modulo \(q\).
Lemmas 2.1 and 2.2 imply \(\ell\mid q-1\).  Since \(q-1\) is even and
\(\ell\) is odd, \(2\ell\mid q-1\), proving (2.4).  The two lifts from
modulus \(2\ell\) to modulus \(4\ell\) are distinguished by \(q\bmod4\),
which proves (2.5).

For odd \(\ell\),

\[
 A_\ell=\frac{\delta^\ell-\delta^{-\ell}}2,
 \qquad
 B_\ell=\frac{\delta^\ell+\delta^{-\ell}}{2\sqrt2}.        \tag{2.7}
\]

If \(t\) is the order of \(\delta\), then
\(z(q)=\operatorname{ord}(\delta^4)=t/\gcd(t,4)\).  The first equality in
(2.7) shows \(t\mid2\ell\); together with \(z(q)=\ell\), this gives
\(t\in\{\ell,2\ell\}\).

Now suppose \(q\mid B_\ell\).  The norm identity gives
\(A_\ell^2\equiv-1\pmod q\), hence \(q\equiv1\pmod4\).  The rank bound
gives \(q\equiv s_q\pmod{2\ell}\).  Combining this with \(q\equiv1\pmod4\)
by the Chinese remainder theorem yields (2.6).

The second equality in (2.7) gives \(\delta^{2\ell}=-1\).  Thus
\(t\mid4\ell\) but \(t\nmid2\ell\); the equality
\(t/\gcd(t,4)=\ell\) forces \(t=4\ell\).  This also gives a Galois proof of
(2.6): in the split case \(t\mid q-1\), while in the nonsplit case
\(\delta^q=-\delta^{-1}\), so
\(\delta^{q+1}=-1=\delta^{2\ell}\) and
\(q+1\equiv2\ell\pmod{4\ell}\). \(\square\)

## 3. Exact congruences and Jacobi parity

### Proposition 3.1

For every odd prime \(\ell\), with
\(s_\ell=(2/\ell)\),

\[
 A_\ell\equiv
 \begin{cases}
 1&\pmod{4\ell},&\ell\equiv1\pmod4,\\
 2\ell+1&\pmod{4\ell},&\ell\equiv3\pmod4,
 \end{cases}                                               \tag{3.1}
\]

and

\[
 B_\ell\equiv
 \begin{cases}
 1&\pmod{4\ell},&s_\ell=1,\\
 2\ell-1&\pmod{4\ell},&s_\ell=-1.
 \end{cases}                                               \tag{3.2}
\]

**Proof.**  Equation (2.3) and oddness give
\(A_\ell\equiv1\pmod{2\ell}\) and
\(B_\ell\equiv s_\ell\pmod{2\ell}\).  From the binomial expansion,

\[
 A_\ell\equiv1+2{\ell\choose2}
              =1+\ell(\ell-1)\equiv\ell\pmod4.             \tag{3.3}
\]

Similarly,

\[
 B_\ell\equiv\ell+2{\ell\choose3}\equiv1\pmod4.          \tag{3.4}
\]

For (3.4), \({\ell\choose3}\) is even when \(\ell\equiv1\pmod4\) and
odd when \(\ell\equiv3\pmod4\); this follows directly from
\({\ell\choose3}=\ell(\ell-1)(\ell-2)/6\).  The Chinese remainder theorem
now gives (3.1)--(3.2). \(\square\)

### Corollary 3.2 (valuation-parity constraints)

Let

\[
 E_A=\sum_{\substack{q\mid A_\ell\\q\equiv3\ (4)}}v_q(A_\ell),
 \qquad
 E_B=\sum_{\substack{q\mid B_\ell\\(2/q)=-1}}v_q(B_\ell).
\]

Then

\[
 E_A\equiv\frac{\ell-1}{2}\pmod2,
 \qquad
 E_B\equiv\frac{1-s_\ell}{2}\pmod2.                        \tag{3.5}
\]

**Proof.**  By Theorem 2.3, the nontrivial \(A\)-channel residue class
modulo \(4\ell\) is \(2\ell+1\), an element of order two.  Multiplying the
prime factorization of \(A_\ell\) modulo \(4\ell\) and comparing with (3.1)
gives the first congruence.  The same argument with the order-two class
\(2\ell-1\) and (3.2) gives the second. \(\square\)

Consequently, if a hypothetical squarefull term has
\(\ell\equiv3\pmod4\), some \(A\)-channel prime congruent to 3 modulo 4 has
odd valuation at least three.  If \((2/\ell)=-1\), some nonsplit
\(B\)-channel prime has odd valuation at least three.  These are genuine
Jacobi-symbol refinements, although they do not by themselves give a
contradiction.

## 4. Valuation lifting and balancing-Wieferich depth

The one external valuation input is Sanna's exact lifting law, specialized
to \(U_n(6,1)\): whenever an odd prime \(q\) and a positive integer \(n\)
satisfy \(z(q)\mid n\),

\[
 v_q(u_n)=e(q)+v_q\!\left(\frac n{z(q)}\right).              \tag{4.1}
\]

This is Theorem 1.5 and Corollary 1.6 of Sanna's paper in the cited
normalization.  In the standard \(U_n(P,Q)\) convention the parameters are
\((P,Q)=(6,1)\); in Sanna's plus-sign recurrence they are
\((a,b)=(6,-1)\).  The law propagates the initial exponent \(e(q)\); it does
not bound that exponent.

Dutta--Patel--Ray call \(q\) balancing-Wieferich when

\[
 q^2\mid u_{q-(8/q)}=u_{q-(2/q)}.                            \tag{4.2}
\]

### Proposition 4.1

For every odd prime \(q\),

\[
 q^k\mid u_{q-(2/q)}\quad\Longleftrightarrow\quad e(q)\ge k
 \qquad(k\ge1).                                             \tag{4.3}
\]

**Proof.**  Lemma 2.1 gives \(z(q)\mid m=q-(2/q)\).  Neither \(m\) nor
\(z(q)\) is divisible by \(q\), because \(z(q)\mid q\pm1\); consequently
\(m/z(q)\) is not divisible by \(q\).  Equation (4.1) therefore gives
\(v_q(u_m)=e(q)\), proving (4.3). \(\square\)

Thus balancing-Wieferich means \(e(q)\ge2\).  In this note, a
**depth-three balancing-Wieferich prime** means \(e(q)\ge3\); this is a local
term, introduced only to distinguish the stronger condition.

## 5. Perfect-power amplification

Two deep, unconditional perfect-power theorems are used as cited inputs.

* Cohn's 2003 Theorem 6.1 concerns the recurrence
  \(Q_0=Q_1=1\), \(Q_{n+2}=2Q_{n+1}+Q_n\), which is exactly \(A_n\).
  It says that its only perfect-power value is 1.
* For the Pell recurrence
  \(P_0=0,P_1=1,P_{n+2}=2P_{n+1}+P_n\), which is exactly \(B_n\),
  Ljunggren's square theorem and Cohn's 1996 higher-power theorem together
  say that the only perfect-power values are \(0,1,169\), with
  \(B_7=169=13^2\).

These are imported theorems, not reproved here.  Every new deduction from
them is proved below.

### Lemma 5.1 (elementary exponent amplification)

Let \(N>1\) be squarefull and not a perfect power.  Then \(N\) has at least
two distinct prime divisors and at least one prime divisor \(p\) with
\(v_p(N)\) odd and at least three.

**Proof.**  If only one prime divided \(N\), then \(N=p^a\) with \(a\ge2\),
a perfect power.  If every prime valuation were even, \(N\) would be a
square.  Hence some valuation is odd; squarefullness raises that positive
odd valuation from at least one to at least three. \(\square\)

### Theorem 5.2 (four-prime, two-depth-three packet)

Let \(\ell\) be an odd prime.  If \(u_\ell\) is squarefull, then
\(\ell\ne7\), and there are four pairwise distinct primes

\[
 p_A,r_A\mid A_\ell,\qquad p_B,r_B\mid B_\ell               \tag{5.1}
\]

such that

\[
 \begin{aligned}
 &z(p_A)=z(r_A)=z(p_B)=z(r_B)=\ell,\\
 &e(p_A),e(r_A),e(p_B),e(r_B)\ge2,\\
 &e(p_A)\ge3,\qquad e(p_B)\ge3.                             \tag{5.2}
 \end{aligned}
\]

All four primes are balancing-Wieferich.  The congruence classes of every
support prime are exactly those in Theorem 2.3.

**Proof.**  At \(\ell=7\),

\[
 u_7=40391=13^2\cdot239,
\]

so \(239\parallel u_7\), contradicting squarefullness.  Hence
\(\ell\ne7\).

Corollary 1.2 makes both \(A_\ell\) and \(B_\ell\) squarefull.  They are
greater than one.  Cohn's 2003 theorem says that \(A_\ell\) is not a perfect
power, and the combined Pell perfect-power theorem says the same for
\(B_\ell\) because \(\ell\ne7\).  Lemma 5.1 therefore supplies two distinct
support primes in each factor and a prime of odd valuation at least three in
each factor; name the latter primes \(p_A,p_B\).  Coprimality of the two
factors makes all four selected primes distinct.

Lemma 2.2 gives rank \(\ell\) to every support prime.  Its first valuation is
its valuation in \(u_\ell=A_\ell B_\ell\), hence is at least two.  Proposition
4.1 makes all four balancing-Wieferich, and gives depth at least three to
\(p_A,p_B\). \(\square\)

This improves the earlier two-prime obstruction in two independent ways:
there are at least four same-rank Wieferich primes, and at least two of them
must survive modulo the third power.

### Theorem 5.3 (the exhaustive dichotomy)

For every odd prime \(\ell\), either some prime satisfies
\(q\parallel u_\ell\), or the full conclusion of Theorem 5.2 holds.  The two
alternatives are mutually exclusive.

**Proof.**  Factor \(u_\ell>1\).  If any positive prime valuation is one,
the first alternative holds.  Otherwise every positive valuation is at
least two, so \(u_\ell\) is squarefull and Theorem 5.2 applies.  The defining
valuation conditions make the alternatives disjoint. \(\square\)

### Theorem 5.4 (largest-prime descent into the packet)

Suppose \(N>1\) and \(u_N\) is squarefull.  Then \(N\) has an odd prime
divisor.  If \(\ell\) is the largest prime divisor of \(N\), then
\(u_\ell\) is squarefull and therefore the full packet of Theorem 5.2 occurs
at rank \(\ell\).

**Proof.**  If \(N=2^a\), then \(z(3)=2\), \(e(3)=v_3(u_2)=1\), and
Sanna's formula gives

\[
 v_3(u_N)=e(3)+v_3(N/2)=1,
\]

contrary to squarefullness.  Hence the largest prime divisor \(\ell\) is
odd.

Let \(q\mid u_\ell\).  Lemma 2.2 gives \(z(q)=\ell\), while Theorem 2.3
gives \(q\ge2\ell-1>\ell\).  Maximality of \(\ell\) therefore implies
\(q\nmid N\).  Since \(\ell\mid N\), equation (4.1) gives

\[
 v_q(u_N)=e(q)+v_q(N/\ell)=e(q)=v_q(u_\ell).                \tag{5.3}
\]

The left side is at least two.  This holds for every prime divisor of
\(u_\ell\), proving that \(u_\ell\) is squarefull.  Theorem 5.2 now applies.
\(\square\)

Thus a proof that alternative 1 holds at every odd prime index would rule
out every nonunit squarefull balancing number, including all composite
indices.  Conversely, any squarefull term at any index forces the exceptional
four-prime packet at its largest prime divisor.

## 6. Adjacent Pell point and the sharpened radical bound

At odd index,

\[
                         1+A_\ell^2=2B_\ell^2.               \tag{6.1}
\]

The triple \((1,A_\ell^2,2B_\ell^2)\) is primitive.  Indeed,
\(A_\ell\) is odd and \(\gcd(A_\ell,B_\ell)=1\), so
\(\gcd(A_\ell^2,2B_\ell^2)=1\).  The packet theorem improves its standard
half-slope radical estimate.

### Lemma 6.1

If \(N\) is squarefull, \(p\) is prime, and \(p^3\mid N\), then

\[
                         \operatorname{rad}(N)
                 \le \sqrt{N/p}.                            \tag{6.2}
\]

**Proof.**  Write \(N=\prod r^{a_r}\).  Then every \(a_r\ge2\), and
\(a_p\ge3\).  Therefore

\[
 \operatorname{rad}(N)^2=\prod r^2
 \le p^{a_p-1}\prod_{r\ne p}r^{a_r}=N/p. \quad\square
\]

### Theorem 6.2

Under the squarefull alternative of Theorem 5.3, choose \(p_A,p_B\) as in
Theorem 5.2.  Then

\[
 \begin{aligned}
 \operatorname{rad}(2A_\ell^2B_\ell^2)
 &=2\operatorname{rad}(A_\ell)\operatorname{rad}(B_\ell)\\
 &\le2\sqrt{\frac{A_\ell B_\ell}{p_Ap_B}}\\
 &\le2\sqrt{\frac{u_\ell}{4\ell^2-1}}
 <\frac{2}{\sqrt{4\ell^2-1}}\sqrt{2B_\ell^2}.              \tag{6.3}
 \end{aligned}
\]

**Proof.**  Apply Lemma 6.1 separately to the two coprime odd factors.
Theorem 2.3 gives \(p_A\ge2\ell+1\) and \(p_B\ge2\ell-1\), so
\(p_Ap_B\ge4\ell^2-1\).  Finally, (6.1) implies
\(A_\ell<\sqrt2B_\ell<2B_\ell\), and hence
\(u_\ell=A_\ell B_\ell<2B_\ell^2\). \(\square\)

If alternative 2 occurs for infinitely many prime indices, their heights
are unbounded.  In the repository's standard normalization
\(H\le C_\varepsilon\operatorname{rad}^{1+\varepsilon}\), equation (6.3),
already with its exponent \(1/2\), contradicts the abc inequality for any
fixed \(0<\varepsilon<1\), because \((1+\varepsilon)/2<1\).  This is the
rigorous conditional disproof mechanism.  No finite collection of points has
that consequence.

## 7. Exhaustive depth-three scan through 2,500,000

For each of the 183,071 odd primes \(3\le q\le2{,}500{,}000\), the C++
program computes

\[
              u_{q-(2/q)}\pmod{q^3}                         \tag{7.1}
\]

by the doubling identities

\[
 U_{2k}=U_k(2U_{k+1}-6U_k),\qquad
 U_{2k+1}=U_{k+1}^2-U_k^2.                                 \tag{7.2}
\]

The bound was chosen so that \(q^3<2^{64}\); products are taken in unsigned
128-bit arithmetic.  An independent Python implementation regenerates the
sieve, uses arbitrary-precision modular integers, replays every prime, and
checks the CSV hash.

Exactly three balancing-Wieferich primes occur:

| \(q\) | \((2/q)\) | canonical index | \(u_m\bmod q^3\) | depth |
|---:|---:|---:|---:|---:|
| 13 | -1 | 14 | 507 | exactly 2 |
| 31 | 1 | 30 | 1922 | exactly 2 |
| 1546463 | 1 | 1546462 | 1164272437426319532 | exactly 2 |

There are zero depth-three hits.  Proposition 4.1 proves that this scan sees
every \(e(q)\ge3\) prime in the interval.  Consequently, a packet from
Theorem 5.2 has

\[
                         p_A,p_B>2{,}500{,}000.              \tag{7.3}
\]

This does not permit extrapolation past the endpoint.  In particular, it is
not evidence that depth-three primes are globally absent.

Artifacts:

* `super_wieferich_scan.cpp`
* `super_wieferich_hits.csv`
* `verify_super_wieferich_scan.py`
* `super_wieferich_verification.json`

The CSV SHA-256 is
`6e1fc5d39664bf4cdd7c0797cad4da91e47320c91517b58cf680e316804891a6`.

## 8. Seven new local exponent-one certificates

Component-wise queries of \(A_\ell\) and \(B_\ell\) supplied candidate
factors.  FactorDB was used only for discovery.  Final acceptance does not
use its primality labels or its claimed cofactorization.

For every displayed \(p\), primality is proved by a recursive, full
factorization-of-\(p-1\) Pocklington certificate.  The leaves, all at most
100,000, are checked by exhaustive trial division.  The verifier then
computes \(u_\ell\) modulo \(p^2\) both by the direct recurrence and by fast
doubling, and checks that the two residues agree, are divisible by \(p\),
and are nonzero modulo \(p^2\).

| \(\ell\) | channel | certified prime \(p\) | \(u_\ell/p\bmod p\) |
|---:|:---:|---:|---:|
| 1009 | A | 1428951990795364409792791 | 1345071080946434836517817 |
| 1181 | A | 55156734003440107783 | 3847308876020019460 |
| 1667 | A | 113653897322901071 | 62080860403250630 |
| 1699 | A | 250873031800583 | 10602070480875 |
| 1723 | B | 379876347061 | 6788056868 |
| 1847 | A | 106632747508897 | 12632179406130 |
| 1901 | B | 2577254284187536181509 | 309325492200531232707 |

Every last-column entry is nonzero, so \(p\parallel u_\ell\).

For completeness, the primality criterion replayed by the independent
verifier is also proved here.  Suppose the complete factorization
\(N-1=\prod q_i^{a_i}\) is known, every \(q_i\) is prime, and for each
distinct \(q_i\) there is an integer \(b_i\) such that

\[
 b_i^{N-1}\equiv1\pmod N,
 \qquad
 \gcd\!\left(b_i^{(N-1)/q_i}-1,N\right)=1.                 \tag{8.1}
\]

For any prime \(r\mid N\), the order of \(b_i\bmod r\) divides \(N-1\),
while the gcd condition forces its \(q_i\)-adic order component to be the
full \(q_i^{a_i}\).  Hence \(N-1\mid r-1\), so \(r\ge N\).  Since
\(r\mid N\), one has \(r=N\), proving that \(N\) is prime.

The independent replay is in
`verify_new_prime_index_certificates.py`; the frozen proof tree is
`selected_prime_pocklington_certificates.json`.  Combining these seven rows
with the repository's already verified 1,990 rows leaves exactly
\(1873,1951\) unresolved among the 1,999 indices \(2\le n\le2000\).

## 9. Why fixed Chebotarev and tame Kummer arguments do not yet close the gap

The residue classes in Theorem 2.3 are genuine Galois information, but a
naive Chebotarev conclusion would cross two invalid logical steps.

First, for fixed \(\ell\), the condition \(q\mid u_\ell\) is a principal
divisor condition on the fixed algebraic integer
\(\alpha^\ell-\beta^\ell\).  Only finitely many rational primes satisfy it.
Chebotarev distributes primes having a Frobenius class in a fixed extension;
it does not force one of the finitely many divisors of a prescribed integer
to have a desired valuation.

Second, \(e(q)\ge2\) or \(e(q)\ge3\) is a congruence modulo \(q^2\) or
\(q^3\) at the same varying prime \(q\).  It is ray-depth information at a
prime which is itself changing.  A fixed tame Kummer extension can detect
residual order or whether a fixed unit is an \(m\)-th power modulo \(q\); it
does not distinguish the first, second, and third \(q\)-adic lifts in (4.3).
A field such as \(\mathbb Q(\zeta_q,\delta^{1/q})\) also changes with \(q\)
and is ramified at \(q\), so ordinary unramified Chebotarev at that same
prime is unavailable.

This rules out only the direct mechanism

```text
a fixed Frobenius class supplies a simple divisor at every prescribed rank.
```

It does not refute a global Galois strategy using a uniformly controlled
tower, an effective family of ray-class estimates, or a new reciprocity law.
Those routes remain active because no counterexample to their exact claims
has been produced.

## 10. Lean-ready elementary declarations

The companion module
`Lean/IUTThreeClosures/PellPrimeIndexDichotomy20260831.lean` formalizes the
following elementary cores independently of the literature inputs.  It also
kernel-checks the exact exceptional-index identities
`sqrtTwoOrbit 7 = (239,169)`, `u_7=40391`, and
`239^2 \nmid u_7`, hence proves that `u_7` is not squarefull.  The literature
theorems of Cohn and Sanna are not introduced as hidden axioms.

```lean
-- An exponent in a squarefull factor which is odd has depth at least three.
theorem odd_exponent_ge_three {e : ℕ}
    (hfull : 2 ≤ e) (hodd : e % 2 = 1) : 3 ≤ e := by
  omega

-- The finite-exponent core used once non-squareness supplies an odd depth.
theorem squarefull_nonsquare_depth_three
    {ι : Type*} (v : ι → ℕ)
    (hfull : ∀ i, 2 ≤ v i)
    (hnonsquare : ∃ i, v i % 2 = 1) :
    ∃ i, 3 ≤ v i ∧ v i % 2 = 1 := by
  rcases hnonsquare with ⟨i, hi⟩
  exact ⟨i, odd_exponent_ge_three (hfull i) hi, hi⟩

-- The numerical endpoint used after the two channel lower bounds.
theorem channel_lower_bound_product {ell pA pB : ℝ}
    (hA : 2 * ell + 1 ≤ pA) (hB : 2 * ell - 1 ≤ pB)
    (hell : 1 ≤ ell) :
    4 * ell ^ 2 - 1 ≤ pA * pB := by
  have hright : 0 ≤ 2 * ell - 1 := by linarith
  have hpA : 0 ≤ pA := by linarith
  calc
    4 * ell ^ 2 - 1 = (2 * ell + 1) * (2 * ell - 1) := by ring
    _ ≤ pA * (2 * ell - 1) := mul_le_mul_of_nonneg_right hA hright
    _ ≤ pA * pB := mul_le_mul_of_nonneg_left hB hpA
```

These declarations now compile using only finite types and ordered-ring
arithmetic.  The
radical lemma (6.2) has an exact primewise proof through `Nat.factorization`,
but its declaration should reuse the repository's chosen radical definition.
The factor-channel theorem will require finite-field and Legendre-symbol
infrastructure and is therefore not advertised as a small elementary Lean
closure.

## 11. Remaining exact targets

The proof direction is now concentrated in either of the following claims:

1. prove that a four-prime, two-depth-three same-rank packet cannot occur for
   any odd prime rank; or
2. prove directly that one support prime has \(e(q)=1\).

The counterexample direction must construct an unbounded set of squarefull
indices, not merely one packet.  At a squarefull prime rank it must create
both coprime channel packets simultaneously, including one depth-three prime
in each channel, while respecting (2.5), (2.6), and (3.5).

Neither target has been contradicted, so neither route is abandoned.

## References

* J. H. E. Cohn, *Perfect Pell Powers*, Glasgow Mathematical Journal 38
  (1996), 19--20, DOI 10.1017/S0017089500031207.
* J. H. E. Cohn, *The Diophantine equation \(x^n=Dy^2+1\)*, Acta
  Arithmetica 106 (2003), 73--83, DOI 10.4064/aa106-1-5.  Section 6,
  Theorem 6.1 is the associated-Pell perfect-power input.
* W. Ljunggren, *Zur Theorie der Gleichung \(x^2+1=Dy^4\)*, Avhandlinger
  Norske Videnskaps-Akademi i Oslo I, no. 5 (1942).
* C. Sanna, *The p-adic valuation of Lucas sequences*, Fibonacci Quarterly
  54(2) (2016), 118--124.
* U. K. Dutta, B. K. Patel, and P. K. Ray, *A brief remark on
  balancing-Wieferich primes*, Mathematica 60(83), no. 1 (2018), 48--53,
  DOI 10.24193/mathcluj.2018.1.05.

Exact source URLs, local hashes, artifact hashes, and reproduction commands
are recorded in `SOURCE_NOTES.md`, `ENVIRONMENT.txt`, `REPRODUCE.md`, and
`SHA256SUMS` beside this report.
