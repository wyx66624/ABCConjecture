# Prime-Layer Radical Bounds for Mersenne Order Blocks

**Author:** ChatGPT  
**Date:** 2026-09-01  
**Status:** unconditional elementary theorem, exact counterexamples, and an
accepted-literature/cyclotomic tail reduction; this is not a proof or
disproof of the abc conjecture.

## Abstract

Let \(M_n=2^n-1\), and let \(E_d\) be the base powerful excess carried by
primes whose exact multiplicative order of \(2\) is \(d\). At a prime index
\(\ell\), every prime divisor of \(M_\ell=\Phi_\ell(2)\) belongs to the
single order block \(\ell\), and there is no index-lifting remainder. Hence

\[
E_\ell=\frac{M_\ell}{\operatorname{rad}(M_\ell)}.
\]

This note proves that a composite \(M_\ell\), for odd prime \(\ell\), cannot
be a nontrivial prime power and therefore has two distinct prime factors.
Each such factor is \(1\pmod {2\ell}\). Consequently

\[
(2\ell+1)^2\le \operatorname{rad}(M_\ell),
\qquad
(2\ell+1)^2E_\ell\le M_\ell.                    \tag{A}
\]

Combining the same argument with the Erdős--Shorey/Stewart lower bound
\(P(2^\ell-1)\gg \ell\log\ell\) gives, for sufficiently large prime
\(\ell\),

\[
\frac{E_\ell}{\Phi_\ell(2)}
  \ll \frac1{\ell^2\log\ell}.                   \tag{B}
\]

This improves the one-factor budget by a factor of order
\(\ell\log\ell\), but it remains polynomial. It does not imply
\(\log E_\ell=o(\ell)\).  For general \(d\), the exact identity
\(E_d=\Phi_d(2)/\operatorname{rad}(\Phi_d(2))\) turns the target into a
blockwise near-squarefreeness problem.  Brun--Titchmarsh removes all
same-order repeated-prime mass below
\(\varphi(d)^2/\log\log(3d)\); a failure must come from deep lifts,
near-quadratic same-order clustering, or a weighted exceptional small-order
tail.  The value \(M_6=3^2\cdot7\) is a complete
counterexample to the uncorrected global identity that omits the lifting
remainder. Two further exact factorizations refute stronger universal claims:
\(M_{37}=223\cdot616318177\) has exactly
two prime factors, refuting “every composite prime layer with
\(\ell\ge37\) has at least three”; and \(M_{11}=23\cdot89\) refutes the
universal cubic replacement for (A). These examples do not refute an
eventual estimate or the order-block route itself.

## 1. Base-layer mass, lifting mass, and the endpoint target

For an odd prime \(q\), write

\[
d_q=\operatorname{ord}_q(2),
\qquad
w_q=v_q(2^{d_q}-1).
\]

For each positive integer \(d\), define the exact-order radical and
**base-layer excess**

\[
R_d=\prod_{d_q=d}q,
\qquad
E_d=\prod_{d_q=d}q^{w_q-1}.
\]

Only finitely many primes occur because \(q\mid2^d-1\). For \(m\ge1\), let

\[
W_m=\frac{M_m}{\operatorname{rad}(M_m)}
\]

be the full Mersenne power loss. If \(q\mid M_m\), then \(d_q\mid m\), and
the exact LTE formula is

\[
v_q(M_m)=w_q+v_q(m/d_q).                         \tag{1.1}
\]

The second summand in (1.1) must not be omitted. Define

\[
B_m=\prod_{d\mid m}E_d,
\qquad
L_m=\prod_{q\mid M_m}q^{v_q(m/d_q)}.
\]

Grouping the prime powers in \(W_m\) by exact order gives the correct
identity

\[
W_m=L_mB_m
   =L_m\prod_{d\mid m}E_d.                       \tag{1.2}
\]

This correction is visible already at \(m=6\):

\[
M_6=63=3^2\cdot7,
\qquad
W_6=63/21=3.
\]

The prime \(3\) has \(d_3=2\) and \(w_3=v_3(2^2-1)=1\); the prime \(7\)
has \(d_7=3\) and \(w_7=v_7(2^3-1)=1\). There are no other prime factors.
Thus every base exponent \(w_q-1\) is zero and

\[
B_6=\prod_{d\mid6}E_d=1,
\qquad
L_6=3.
\]

Therefore \(W_6\ne\prod_{d\mid6}E_d\). This is a complete counterexample
to the uncorrected identity that omits the lifting remainder; the corrected
identity (1.2) gives \(W_6=L_6B_6=3\).

The lifting term is harmless at the endpoint scale. Since
\(d_q\mid q-1\), one has \(q\nmid d_q\). Therefore, whenever \(d_q\mid m\),

\[
v_q(m/d_q)=v_q(m).
\]

Consequently

\[
L_m=\prod_{q\mid M_m}q^{v_q(m)}\mid m,
\qquad
\log L_m\le\log m=o(m).                           \tag{1.3}
\]

Thus the base-layer mass is the genuinely difficult part, but the full loss
is not literally the base-layer product.

For prime \(\ell\), every prime \(q\mid M_\ell\) has order dividing
\(\ell\). The order is not \(1\), since \(2\not\equiv1\pmod q\), so it is
exactly \(\ell\). Moreover \(d_q=\ell\mid q-1\), hence \(q\ne\ell\);
therefore \(v_q(\ell)=0\) and \(L_\ell=1\). It follows that

\[
R_\ell E_\ell=M_\ell=\Phi_\ell(2),
\qquad
W_\ell=E_\ell,
\qquad
\frac{E_\ell}{\Phi_\ell(2)}=\frac1{R_\ell}.      \tag{1.4}
\]

The abc endpoint triples \((1,M_m,2^m)\) require
\(\log W_m=o(m)\). On prime indices this already forces

\[
\log E_\ell=o(\ell),                              \tag{1.5}
\]

or equivalently

\[
\log R_\ell=\ell\log2-o(\ell).                    \tag{1.6}
\]

Thus a polynomial lower bound for \(R_\ell\), even a substantially improved
one, cannot close the endpoint.

## 2. A composite Mersenne value is not a prime power

### Lemma 2.1

Let \(\ell>1\). If \(2^\ell-1=q^v\) for a prime \(q\) and \(v>0\), then
\(v=1\).

### Proof

The number \(2^\ell-1\) is odd, so \(q\) is odd. Suppose first that \(v\)
is even. Then \(q^v\equiv1\pmod8\), while \(q^v+1=2^\ell\). For
\(\ell\ge3\), the right side is \(0\pmod8\), whereas the left side is
\(2\pmod8\), a contradiction. The remaining case \(\ell=2\) gives
\(q^v=3\), and also has \(v=1\).

It remains to consider odd \(v\). Factor

\[
q^v+1=(q+1)H,
\qquad
H=q^{v-1}-q^{v-2}+\cdots-q+1.
\]

The factor \(H\) is odd: it is an alternating sum of an odd number of odd
terms. Since \((q+1)H=2^\ell\), every positive divisor is a power of two, so
the odd number \(H\) must be \(1\). If \(v=2k+1\ge3\), however,

\[
H=q^{2k-1}(q-1)+q^{2k-3}(q-1)+\cdots+q(q-1)+1>1.
\]

Therefore \(v=1\). ∎

### Corollary 2.2

If \(\ell>1\) and \(M_\ell\) is composite, then it has at least two distinct
prime divisors.

### Proof

An integer at least \(2\) with only one distinct prime divisor is a prime
power. Lemma 2.1 rules this out for a composite \(M_\ell\). ∎

The Lean proof uses the repository's already formalized elementary special
case `exponent_eq_one_of_prime_pow_add_one`; it does not assume Catalan's
theorem. The perfect-power observation is consistent with the standard
consequence of Mihăilescu's theorem recorded in Cambraia et al., but no part
of the present proof depends on that paper.

## 3. Exact order and the square radical bound

### Lemma 3.1

Let \(\ell\) be an odd prime. If \(q\) is prime and \(q\mid M_\ell\), then

\[
\operatorname{ord}_q(2)=\ell,
\qquad
2\ell\mid q-1,
\qquad
q\ge2\ell+1.                                      \tag{3.1}
\]

### Proof

The factor \(q\) is odd. Divisibility by \(M_\ell\) gives
\(2^\ell\equiv1\pmod q\), so the order divides the prime \(\ell\). It cannot
be \(1\), because that would give \(2\equiv1\pmod q\). Thus the order is
\(\ell\). Lagrange's theorem gives \(\ell\mid q-1\). Oddness of \(q\) gives
\(2\mid q-1\), and \(\gcd(2,\ell)=1\); hence \(2\ell\mid q-1\). The
numerical lower bound follows. ∎

### Theorem 3.2 (unconditional prime-layer square saving)

Let \(\ell\) be an odd prime and suppose \(M_\ell\) is composite. Then

\[
(2\ell+1)^2\le\operatorname{rad}(M_\ell),         \tag{3.2}
\]

and consequently

\[
(2\ell+1)^2E_\ell\le\Phi_\ell(2).                 \tag{3.3}
\]

### Proof

By Corollary 2.2, choose distinct primes \(q,r\mid M_\ell\). Lemma 3.1
gives \(q,r\ge2\ell+1\). Since the radical contains one copy of both distinct
primes,

\[
\operatorname{rad}(M_\ell)\ge qr\ge(2\ell+1)^2.
\]

Multiplying by \(E_\ell\) and using (1.4) proves (3.3). ∎

This argument needs no primitive-divisor theorem and remains valid when one
or both prime factors occur with multiplicity greater than one.

## 4. Adding a largest-prime-factor theorem

### Theorem 4.1 (asymmetric radical lemma)

Under the hypotheses of Theorem 3.2, suppose additionally that a prime
\(q\mid M_\ell\) satisfies \(q\ge H\). Then

\[
H\,(2\ell+1)\le\operatorname{rad}(M_\ell),        \tag{4.1}
\]

and

\[
H\,(2\ell+1)E_\ell\le\Phi_\ell(2).                \tag{4.2}
\]

### Proof

Corollary 2.2 supplies a distinct prime factor \(r\ne q\). Lemma 3.1 gives
\(r\ge2\ell+1\). The radical contains \(qr\), so
\(\operatorname{rad}(M_\ell)\ge qr\ge H\,(2\ell+1)\). Equation (1.4) gives
(4.2). ∎

Erdős and Shorey proved that the greatest prime factor satisfies

\[
P(2^\ell-1)\gg \ell\log\ell                       \tag{4.3}
\]

for prime \(\ell\); their opening page states that
\(P(2^p-1)/p\) exceeds a constant multiple of \(\log p\). Ford, Luca, and
Shparlinski restate the result as
\(P(2^p-1)>c\,p\log p\) for all sufficiently large primes \(p\). The
original and modern sources are archived with this report.

### Corollary 4.2 (accepted-literature synthesis)

There is an absolute constant \(C>0\) such that, for every sufficiently large
prime \(\ell\),

\[
\frac{E_\ell}{\Phi_\ell(2)}
 \le \frac{C}{\ell^2\log\ell}.                    \tag{4.4}
\]

### Proof

If \(M_\ell\) is composite, apply Theorem 4.1 to its largest prime factor and
then (4.3):

\[
\operatorname{rad}(M_\ell)
 \gg(\ell\log\ell)(2\ell+1)
 \gg\ell^2\log\ell.
\]

Now use (1.4). If \(M_\ell\) is prime, then \(E_\ell=1\) and
\(E_\ell/\Phi_\ell(2)=1/(2^\ell-1)\), which is smaller than the right side of
(4.4) for all sufficiently large \(\ell\). ∎

The external input (4.3) is not reproved in Lean. Lean formalizes Theorem
4.1 with an explicit hypothesis giving the large factor. This separates the
accepted literature theorem from the kernel-checked arithmetic implication.

## 5. Why the new bound does not close the Mersenne route

Taking logarithms of (4.2) and (4.3) yields only

\[
\log E_\ell
 \le \ell\log2-2\log\ell-\log\log\ell+O(1).       \tag{5.1}
\]

The right side still has leading term \(\ell\log2\). In comparison, the
endpoint needs (1.5). Equivalently, the desired ratio in (1.4) must be
exponentially small up to a subexponential correction:

\[
\frac{E_\ell}{\Phi_\ell(2)}
 =\exp\bigl(-\ell\log2+o(\ell)\bigr).              \tag{5.2}
\]

Thus (4.4), although a genuine improvement over the single-factor
\(O(1/\ell)\) budget, cannot be iterated or rephrased into the missing result.
It removes only \(2\log\ell+\log\log\ell+O(1)\) from an exponential-size
budget.

## 6. The smallest clean new theorem for the full order-block sum

Put \(e_d=\log E_d\ge0\). A natural sufficient theorem, strictly weaker than
a fixed power saving \(e_d=O(d^{1-\delta})\), is

\[
e_d=o(\varphi(d)).                                  \tag{6.1}
\]

### Proposition 6.1

If (6.1) holds, then \(\log W_m=o(m)\) through all positive integers \(m\).

### Proof

Fix \(\varepsilon>0\). Choose \(D\) so that
\(e_d\le\varepsilon\varphi(d)\) whenever \(d\ge D\), and put

\[
C_D=\sum_{d<D}e_d.
\]

Using nonnegativity and the classical identity
\(\sum_{d\mid m}\varphi(d)=m\),

\[
\begin{aligned}
\log B_m
 &=\sum_{d\mid m}e_d\\
 &\le C_D+\varepsilon\sum_{d\mid m}\varphi(d)\\
 &=C_D+\varepsilon m.
\end{aligned}                                      \tag{6.2}
\]

The corrected decomposition (1.2) and the lifting bound (1.3) now give

\[
\log W_m
 \le \log m+C_D+\varepsilon m.                     \tag{6.3}
\]

Divide by \(m\) and let \(m\to\infty\). Since \(\log m/m\to0\), the limit
superior is at most \(\varepsilon\); because \(\varepsilon\) is arbitrary,
the limit is zero. ∎

The genuinely missing mathematical input is (6.1), or an alternative that
implies the same base-mass divisor-sum estimate. On prime \(d=\ell\), (6.1)
is already the necessary scale \(\log E_\ell=o(\ell)\). Neither Theorem 3.2
nor Corollary 4.2 approaches it.

The first Lean module formalizes the finite base-mass inequality (6.2) and an
abstract total-mass bound under explicit decomposition and lifting premises.
Two companion modules now discharge those arithmetic premises.  They define
\(L_m=\gcd(m,2^m-1)\), prove \(L_m\mid m\), prove the exact-order form of LTE,
construct the finite relative order blocks, and kernel-check

\[
 W_m=L_m\prod_{d\mid m}E_d.
\]

They then define an index-independent canonical block \(E_d\), prove that it
equals the relative block whenever \(d\mid m\), identify the logarithm of the
product with the divisor mass sum, and instantiate the full asymptotic
passage

\[
 \log E_d=o(\varphi(d))\quad\Longrightarrow\quad \log W_m=o(m).
\]

The antecedent remains the genuinely open arithmetic hypothesis.  It is a
premise of the final Lean theorem, not a Lean axiom and not a claimed result.

### Proposition 6.2 (exact cyclotomic and powerful-part reformulations)

For every \(d>1\),

\[
 E_d=\frac{\Phi_d(2)}{\operatorname{rad}(\Phi_d(2))}. \tag{6.4}
\]

Moreover

\[
 \log\Phi_d(2)=\varphi(d)\log2+\rho_d,
 \qquad |\rho_d|\le2.                              \tag{6.5}
\]

Consequently (6.1) is equivalent to

\[
 \log\operatorname{rad}(\Phi_d(2))
       =\varphi(d)\log2+o(\varphi(d)).              \tag{6.6}
\]

If \(V_d\) denotes the powerful part of \(\Phi_d(2)\), namely the product
of the full prime powers \(q^a\Vert\Phi_d(2)\) with \(a\ge2\), then

\[
                        E_d\le V_d\le E_d^2,         \tag{6.7}
\]

so (6.1) is also equivalent to \(\log V_d=o(\varphi(d))\).

### Proof

Murty and Wong record the standard cyclotomic divisor classification: if a
prime \(q\nmid ab\) divides \(\Phi_d(a,b)\), then either
\(q\equiv1\pmod d\), or \(q\) is the largest prime factor of \(d\); the
exceptional divisor occurs to at most the first power.  For \((a,b)=(2,1)\),
the primes in the first class have exact order \(d\).  The exceptional prime
contributes nothing after division by the radical.  Every exact-order prime
\(q\) contributes exponent \(w_q-1\), proving (6.4).

The cyclotomic product formula gives

\[
 \log\Phi_d(2)
 =\sum_{e\mid d}\mu(d/e)\log(2^e-1)
 =\varphi(d)\log2+
   \sum_{e\mid d}\mu(d/e)\log(1-2^{-e}).
\]

For \(0\le x\le1/2\), \(-\log(1-x)\le2x\).  Hence the absolute value of the
last sum is at most
\(\sum_{e\ge1}2^{1-e}=2\), proving (6.5).  Since
\(\varphi(d)\to\infty\), subtracting the logarithm of (6.4) proves the
equivalence with (6.6).  Finally a prime power \(q^a\), \(a\ge2\), contributes
\(q^{a-1}\) to \(E_d\) and \(q^a\) to \(V_d\).  The inequalities
\(a-1\le a\le2(a-1)\) prove (6.7) prime by prime and the final equivalence
follows. ∎

This is an important change of viewpoint: the open input is exactly a
near-squarefreeness theorem for the individual cyclotomic values
\(\Phi_d(2)\), on the natural \(\varphi(d)\) scale.  The abc-dependent
powerful-part lemma of Murty--Wong controls a divisor product on the larger
index scale; it does not supply this unconditional, blockwise estimate when
\(\varphi(d)/d\) is small.

### Proposition 6.3 (unconditional near-quadratic small-support bound)

Let

\[
 \mathcal W_d=\{q:\ q\text{ prime},\ d_q=d,\ w_q\ge2\},
 \qquad
 T_d=\prod_{q\in\mathcal W_d}q,
 \qquad
 D_d=\prod_{\substack{d_q=d\\w_q\ge3}}q^{w_q-2}.   \tag{6.8}
\]

Then \(E_d=T_dD_d\).  Put

\[
 Y_d=\frac{\varphi(d)^2}{\log\log(3d)},
 \qquad
 T_d^{\le Y}=\prod_{\substack{q\in\mathcal W_d\\q\le Y_d}}q. \tag{6.9}
\]

As \(d\to\infty\),

\[
                         \log T_d^{\le Y}=o(\varphi(d)).        \tag{6.10}
\]

### Proof

If \(d_q=d\), then \(d\mid q-1\), so every prime in (6.9) lies in the
progression \(1\pmod d\).  For all sufficiently large \(d\), one has
\(Y_d>d\), and Brun--Titchmarsh gives

\[
 \pi(Y_d;d,1)\le
 \frac{2Y_d}{\varphi(d)\log(Y_d/d)}.
\]

Therefore

\[
 \log T_d^{\le Y}
 \le \frac{2Y_d\log Y_d}
          {\varphi(d)\log(Y_d/d)}.                 \tag{6.11}
\]

The classical uniform lower bound
\(\varphi(d)\gg d/\log\log(3d)\) shows both that \(Y_d/d\to\infty\) and
that
\(\log Y_d/\log(Y_d/d)\to2\).  Hence

\[
 \frac{\log T_d^{\le Y}}{\varphi(d)}
 \le
 \frac{2}{\log\log(3d)}
 \frac{\log Y_d}{\log(Y_d/d)}
 \longrightarrow0.
\]

This proves (6.10).  The identity \(E_d=T_dD_d\) follows by splitting each
exponent \(w_q-1\) into one copy of \(q\) when \(w_q\ge2\), plus the residual
exponent \(w_q-2\) when \(w_q\ge3\). ∎

The worst-case lower bound for \(\varphi(d)\) also gives the convenient
uniform variant \(Y_d=c d^2/(\log\log(3d))^3\) for any fixed
\(c>0\).  More generally, the same proof permits
\(Y_d=d^2/L(d)\) whenever
\(L(d)/(\log\log(3d))^2\to\infty\) and \(\log L(d)=o(\log d)\).  Thus the
uncontrolled support begins only near the quadratic order scale; merely
finding finitely many small Wieferich primes cannot refute (6.1).

### Proposition 6.4 (three surviving failure mechanisms)

Fix \(\delta>0\).  If (6.1) is false, then there are \(\epsilon>0\), a
sequence \(d_j\to\infty\), and a subsequence on which at least one of the
following holds:

1. **deep lifts:** \(\log D_{d_j}\ge\epsilon\varphi(d_j)/4\);
2. **near-quadratic clustering:** the interval
   \(Y_{d_j}<q\le d_j^{2+\delta}\) contains at least
   \[
   \frac{\epsilon\varphi(d_j)}
        {4(2+\delta)\log d_j}                       \tag{6.12}
   \]
   distinct base-two Wieferich primes, all having exact order \(d_j\);
3. **extreme small order:**
   \[
   \sum_{\substack{d_q=d_j,\ w_q\ge2\\q>d_j^{2+\delta}}}
          \log q
       \ge\epsilon\varphi(d_j)/4.                  \tag{6.13}
   \]

Every prime in (6.13) satisfies
\(\operatorname{ord}_q(2)<q^{1/(2+\delta)}\).  By the Erdős--Murty
almost-all order theorem, such primes lie in a zero-density exceptional set.
That density statement does not rule out the weighted sparse sequence in
(6.13).

### Proof

Failure of (6.1), together with nonnegativity of \(\log E_d\), gives an
\(\epsilon>0\) and \(d_j\to\infty\) such that
\(\log E_{d_j}\ge\epsilon\varphi(d_j)\).  Split the exact identity
\(E_d=T_dD_d\) into four disjoint logarithmic exponent-layer contributions:
the one-copy support with \(q\le Y_d\), with
\(Y_d<q\le d^{2+\delta}\), or with \(q>d^{2+\delta}\), together with the
remaining deep exponents in \(D_d\).  Proposition 6.3 makes the first logarithm at most
\(\epsilon\varphi(d_j)/4\) for large \(j\).  The other three nonnegative
logarithms therefore have sum at least
\(3\epsilon\varphi(d_j)/4\).  One of them is at least
\(\epsilon\varphi(d_j)/4\); an infinite pigeonhole argument fixes the same
arm on a subsequence.

In the middle arm each summand is at most
\((2+\delta)\log d_j\), so its mass lower bound gives (6.12).  In the last
arm \(q>d_j^{2+\delta}\) implies
\(d_j<q^{1/(2+\delta)}\), and \(d_j=\operatorname{ord}_q(2)\).  Erdős and
Murty prove that, for each prescribed positive function
\(\eta(q)\to0\), all but a zero-density set of primes satisfy
\(\operatorname{ord}_q(2)\ge q^{1/(2+\eta(q))}\).  Taking
\(\eta(q)<\delta\) for large \(q\) places the last arm in their exceptional
set, without giving a weighted bound there. ∎

### Corollary 6.5 (a transition failure uses a fixed fraction of the square budget)

Let \(s_d=|\mathcal W_d|\).  Then

\[
 s_d\log(d+1)\le\log T_d
 \le\frac12\log\Phi_d(2)
 <\frac{\varphi(d)+1}{2}\log2.                    \tag{6.14}
\]

Define the real square-budget cap

\[
 B_d=\frac{(\varphi(d)+1)\log2}{2\log(d+1)}.
\]

On the transition alternative in Proposition 6.4, if
\(\mathcal W_d^{\mathrm{tr}}=\{q\in\mathcal W_d:Y_d<q\le
d^{2+\delta}\}\), then

\[
 \frac{|\mathcal W_d^{\mathrm{tr}}|}{B_d}
 \ge
 \frac{\epsilon}{2(2+\delta)\log2}
 \frac{\varphi(d)}{\varphi(d)+1}
 \frac{\log(d+1)}{\log d}.                        \tag{6.15}
\]

Thus a transition-arm counterexample would occupy a fixed positive
proportion of the largest repeated-prime support compatible with the mere
square divisibility budget.

### Proof

Every \(q\in\mathcal W_d\) satisfies \(q\ge d+1\), so
\(s_d\log(d+1)\le\log T_d\).  Every such prime occurs at least twice in
\(\Phi_d(2)\), hence \(T_d^2\mid\Phi_d(2)\) and
\(2\log T_d\le\log\Phi_d(2)\).  Pomerance's bound
\(\Phi_d(2)<2^{\varphi(d)+1}\) proves (6.14).  Divide the transition
cardinality lower bound (6.12) by \(B_d\) and simplify to obtain (6.15). ∎

This strengthens the structural description without excluding it.  A deep
arm may still be carried by one prime with a very large lifting exponent, and
no unconditional theorem rules out a fixed-proportion transition cluster.

The exact Wieferich reindexing used above is also unconditional.  Because
\(q-1=d_q((q-1)/d_q)\) and \(q\nmid(q-1)/d_q\), LTE gives

\[
 v_q(2^{q-1}-1)=w_q.
\]

Thus \(w_q\ge2\) is precisely the base-two Wieferich condition and
\(w_q\ge3\) is the super-Wieferich condition.  Each fixed prime belongs to
one canonical order block only.  Repeated appearances in
\(2^{kd_q}-1\) therefore cannot manufacture a counterexample to (6.1).
Finiteness of base-two super-Wieferich primes would make \(D_d=1\)
eventually, but it would leave the near-quadratic and extreme support arms
untouched.  Fellini--Murty's 2026 results on non-Wieferich primes do not give
the weighted, same-exact-order estimate needed here.  Murty--Séguin identify
this exact cyclotomic/Wieferich reindexing and, under uniformly bounded
canonical valuations (in particular under finiteness of super-Wieferich
primes), obtain a largest factor of order at least \(\varphi(d)^2\).  That is
still a polynomial radical contribution and does not bound either surviving
support tail.  Pomerance's 2025 cyclotomic compositeness theorems likewise do
not provide exponential radical saturation on the \(\varphi(d)\) scale.

## 7. Complete counterexamples and the exact scope of what they retire

### 7.1 Omitting the lifting remainder

The exact data at \(m=6\) above give

\[
W_6=3,
\qquad
\prod_{d\mid6}E_d=1.
\]

This refutes, with every definition instantiated, the statement

> For every \(m\ge1\), the full Mersenne power loss equals
> \(\prod_{d\mid m}E_d\).

The prime-layer module checks the support, radical, orders, base valuations,
and power loss at \(m=6\).  The decomposition module independently closes the
same numerical ledger with `mersennePowerLoss_six`,
`mersenneLiftingFactor_six`, `mersenneOrderBlockProduct_six`, and
`mersennePowerLoss_six_orderBlockDecomposition`.  Thus Lean represents both
the false omission and the corrected product without turning the false
identity into an assumption.  This counterexample closes only the omission
of \(L_m\); it supports (1.2) and leaves the order-block route open.

### 7.2 The three-support strengthening at the requested threshold

The exact identity

\[
2^{37}-1=137438953471=223\cdot616318177             \tag{7.1}
\]

has two prime factors; both primality statements are kernel-checked by Lean.
Therefore the following fully quantified statement is false:

> For every prime \(\ell\ge37\), if \(2^\ell-1\) is composite, then it has at
> least three distinct prime divisors.

The Lean theorem
`not_all_composite_prime_index_mersenne_three_support` proves the negation
with all hypotheses present. This counterexample retires that exact universal
strengthening. It does not refute a claim beginning at some unknown threshold
greater than \(37\), nor a weighted estimate that permits two highly unequal
factors.

### 7.3 A universal cubic radical replacement

Similarly,

\[
2^{11}-1=2047=23\cdot89,
\qquad
\operatorname{rad}(M_{11})=2047<23^3=(2\cdot11+1)^3. \tag{7.2}
\]

Thus replacing the square in Theorem 3.2 by a cube for every composite odd
prime layer is false. The Lean theorem
`not_all_composite_prime_index_mersenne_cubic_radical` proves the negation.
This finite witness says nothing against an eventual cubic bound.

### 7.4 A genuine nontrivial canonical block at \(d=364\)

The classical base-two Wieferich prime \(p=1093\) gives a complete hit in the
base mass rather than in the lifting factor.  Direct integer calculations give

\[
 1093^2\mid 2^{364}-1,
 \qquad 1093^3\nmid 2^{364}-1,                         \tag{7.3}
\]

and

\[
 2^{182}\equiv1092,
 \qquad 2^{52}\equiv27,
 \qquad 2^{28}\equiv121\pmod {1093}.                 \tag{7.4}
\]

Since \(1093\) is prime and \(364=2^2\cdot7\cdot13\), the standard
prime-divisor test for multiplicative order applies.  Divisibility in (7.3)
gives \(2^{364}\equiv1\pmod {1093}\), while (7.4) shows that division of the
exponent by any prime divisor \(2,7,13\) does not kill \(2\).  Hence

\[
 \operatorname{ord}_{1093}(2)=364.
\]

The two divisibilities in (7.3) then give
\(v_{1093}(2^{364}-1)=2\).  Consequently the canonical product contains the
factor \(1093^{2-1}\), so

\[
                         1093\mid E_{364},\qquad E_{364}>1. \tag{7.5}
\]

This is a full-premise counterexample to the universal strengthening
\(E_d=1\) for every \(d\), equivalently to squarefreeness of every underlying
exact-order component of \(2^d-1\).  It does not say that the excess factor
\(E_{364}\) itself is nonsquarefree.  It does not refute (6.1): one fixed nonzero
ratio \(\log E_{364}/\varphi(364)\) has no effect on a limit at infinity.

### 7.5 Routes that remain open

No complete counterexample in this note refutes any of the following:

1. an eventual lower bound with more than two factors;
2. a distribution theorem for the repeated-prime base mass \(E_d\);
3. the relative base-block estimate \(\log E_d=o(\varphi(d))\);
4. another near-exponential lower bound for \(R_d\); or
5. the Mersenne endpoint route itself.

The lifting remainder is already bounded by \(L_m\mid m\); the open bridge is
the base mass in item 3. The other routes remain open because difficulty and
finite absence of examples are not counterexamples.

## 8. Reproducible finite audit

The computation directory scans every prime index \(3\le\ell\le61\), where
all \(M_\ell<2^{64}\). It uses a fixed Pollard-rho schedule and the standard
seven-base deterministic Miller--Rabin test for unsigned 64-bit integers.
An independent script verifies the listed prime factors, exact products,
radicals, power losses, congruences, prime-index order tests, and Theorem 3.2
on every composite row.

The composite rows are:

| \(\ell\) | complete factorization of \(2^\ell-1\) | support size |
|---:|---|---:|
| 11 | \(23\cdot89\) | 2 |
| 23 | \(47\cdot178481\) | 2 |
| 29 | \(233\cdot1103\cdot2089\) | 3 |
| 37 | \(223\cdot616318177\) | 2 |
| 41 | \(13367\cdot164511353\) | 2 |
| 43 | \(431\cdot9719\cdot2099863\) | 3 |
| 47 | \(2351\cdot4513\cdot13264529\) | 3 |
| 53 | \(6361\cdot69431\cdot20394401\) | 3 |
| 59 | \(179951\cdot3203431780337\) | 2 |

No repeated prime factor occurs in this finite range. This is recorded only
as a no-hit. It is not evidence sufficient to assert squarefreeness at the
next index, at all prime indices, or asymptotically.

Run from the repository root:

```powershell
$py = 'C:\Users\Admin\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe'
& $py research/computation/2026_09_01_mersenne_prime_layer_radical/scan_prime_layers.py --max-index 61 --output research/computation/2026_09_01_mersenne_prime_layer_radical/prime_layers_3_61.json
& $py research/computation/2026_09_01_mersenne_prime_layer_radical/verify_prime_layers.py research/computation/2026_09_01_mersenne_prime_layer_radical/prime_layers_3_61.json --output research/computation/2026_09_01_mersenne_prime_layer_radical/verification.json
```

The checked output has `verified: true` and an empty failure list. The
directory's `SHA256SUMS` fixes the delivered artifact bytes.

Re-download the primary-source PDFs into a separate directory and verify all
delivered source/computation hashes with:

```powershell
& research/sources/mersenne_prime_layer_radical_2026_09_01/RETRIEVE_SOURCES.ps1 -Destination tmp/mersenne_prime_layer_sources
& research/computation/2026_09_01_mersenne_prime_layer_radical/verify_hashes.ps1
```

## 9. Lean formalization ledger

The formal development consists of five imported modules:

- `Lean/IUTThreeClosures/MersennePrimeLayerRadical20260901.lean`;
- `Lean/IUTThreeClosures/MersenneOrderBlockDecomposition20260901.lean`;
- `Lean/IUTThreeClosures/MersenneOrderBlockAsymptotic20260901.lean`;
- `Lean/IUTThreeClosures/MersenneCanonicalBlockWitness20260901.lean`;
- `Lean/IUTThreeClosures/MersenneWieferichTailReduction20260901.lean`.

| Paper result | Lean theorem |
|---|---|
| Lemma 2.1 | `mersenne_not_primePow_of_composite` |
| Corollary 2.2 | `mersenne_composite_two_support` |
| exact order in Lemma 3.1 | `prime_index_mersenne_factor_order` |
| \(2\ell\mid q-1\) | `prime_index_mersenne_factor_two_mul_dvd` |
| \(q\ge2\ell+1\) | `prime_index_mersenne_factor_lower` |
| Theorem 3.2, radical form | `composite_prime_index_mersenne_radical_lower` |
| Theorem 3.2, excess form | `composite_prime_index_powerLoss_bound` |
| Theorem 4.1, radical form | `composite_prime_index_radical_of_large_factor` |
| Theorem 4.1, excess form | `composite_prime_index_powerLoss_of_large_factor` |
| finite base-mass part of Proposition 6.1 | `orderBlockMassSum_le_prefix_add_totient_tail` |
| abstract total-mass bridge with explicit decomposition/lifting premises | `totalMass_le_prefix_add_totient_tail_add_log` |
| exact-order LTE and lifting factor \(L_m=\gcd(m,2^m-1)\) | `factorization_mersenne_eq_exactOrder_add_index`, `mersenneLiftingFactor_dvd_index` |
| finite exact-order product \(B_m=\prod_{d\mid m}E_d\) | `mersenneBaseQuotient_eq_orderBlockProduct` |
| corrected global identity (1.2) | `mersennePowerLoss_eq_lifting_mul_orderBlockProduct` |
| relative block equals canonical \(E_d\) for \(d\mid m\) | `mersenneOrderBlock_eq_canonical` |
| exact logarithmic divisor-sum identity | `log_mersennePowerLoss_eq_divisorMassSum_add_lifting` |
| Proposition 6.1 with its open premise explicit | `log_mersennePowerLoss_isLittleO_of_orderBlocks` |
| finite powerful-part comparison in Proposition 6.2 | `finitePowerfulExcess_le_part_le_square`, `finitePowerful_logMass_comparison` |
| finite mass trichotomy in Proposition 6.4 | `deep_or_transition_or_extreme_of_small_control` |
| transition-cluster cardinality core | `transitionCard_lowerBound_of_log_bound` |
| square-budget support cap, realized-support fraction, and the exact ambient-budget ratio in (6.15) | `repeatedSupport_card_log_budget`, `transitionCard_fixedFraction_of_squareBudget`, `transitionCard_fixedFraction_of_ambientSquareBudget` |
| exact order and nontrivial canonical block at \(1093,364\) | `mersenneExactOrder_1093`, `prime_1093_dvd_mersenneCanonicalOrderBlock_364` |
| exact index-six support, radical, orders, base valuations, and power loss | `mersenne_six_factorization` through `mersenne_six_powerLoss` |
| exact support at \(\ell=37\) | `mersenne_37_support_exactly_two` |
| negation of universal three-support claim | `not_all_composite_prime_index_mersenne_three_support` |
| exact radical at \(\ell=11\) | `mersenne_11_radical` |
| negation of universal cubic claim | `not_all_composite_prime_index_mersenne_cubic_radical` |

Compile directly:

```powershell
Set-Location Lean
lake env lean IUTThreeClosures/MersennePrimeLayerRadical20260901.lean
lake env lean IUTThreeClosures/MersenneOrderBlockDecomposition20260901.lean
lake env lean IUTThreeClosures/MersenneOrderBlockAsymptotic20260901.lean
lake env lean IUTThreeClosures/MersenneCanonicalBlockWitness20260901.lean
lake env lean IUTThreeClosures/MersenneWieferichTailReduction20260901.lean
```

Every printed theorem-axiom audit is free of `sorryAx`; only standard
Mathlib foundations such as propositional extensionality, quotient soundness,
and classical choice appear.  The Mersenne continuation modules contain 97
theorem declarations and 97 corresponding `#print axioms` commands.  Their direct
compile exit codes are zero.  The continuation validation bundle records the
complete logs, exact source inventory, input hashes, and computation replays.

## References

1. P. Erdős and T. N. Shorey, “On the greatest prime factor of
   \(2^p-1\) for a prime \(p\) and other expressions,” *Acta Arithmetica* 30
   (1976), 257–265. DOI:
   [10.4064/aa-30-3-257-265](https://doi.org/10.4064/aa-30-3-257-265).
2. K. Ford, F. Luca, and I. E. Shparlinski, “On the largest prime factor of
   the Mersenne numbers,” *Bulletin of the Australian Mathematical Society*
   79 (2009), 455–463. DOI:
   [10.1017/S0004972709000033](https://doi.org/10.1017/S0004972709000033).
3. A. Cambraia Jr., M. P. Knapp, A. Lemos, B. K. Moriya, and P. H. A.
   Rodrigues, “On prime factors of Mersenne numbers,” arXiv:1606.08690v5,
   [primary manuscript](https://arxiv.org/abs/1606.08690).
4. M. Ram Murty and S. Wong, “The ABC conjecture and prime divisors of the
   Lucas and Lehmer sequences,” in *Number Theory for the Millennium, III*,
   A K Peters, 2002, 43--54,
   [author manuscript](https://mast.queensu.ca/~murty/murty-wong.pdf).
5. P. Erdős and M. Ram Murty, “On the order of \(a\) modulo \(p\),” in
   *Number Theory* (Ottawa, ON, 1996), CRM Proceedings and Lecture Notes 19,
   American Mathematical Society, 1999, 87--97,
   [author scan](https://mast.queensu.ca/~murty/erdos-ram.pdf).
6. N. Fellini and M. Ram Murty, “Wieferich primes in number fields and the
   conjectures of Ankeny--Artin--Chowla and Mordell,” *Journal of Number
   Theory* 285 (2026), 209--229,
   [doi:10.1016/j.jnt.2026.01.002](https://doi.org/10.1016/j.jnt.2026.01.002).
7. C. Pomerance, “Cyclotomic primes,” *Journal of Number Theory* 276 (2025),
   198--208,
   [doi:10.1016/j.jnt.2025.02.013](https://doi.org/10.1016/j.jnt.2025.02.013).
8. M. Ram Murty and F. Séguin, “Prime divisors of sparse values of
   cyclotomic polynomials and Wieferich primes,” *Journal of Number Theory*
   201 (2019), 1--22,
   [doi:10.1016/j.jnt.2019.02.016](https://doi.org/10.1016/j.jnt.2019.02.016).
