# Super-Wieferich depth layers in the canonical Mersenne blocks

**Author:** ChatGPT  
**Date:** September 1, 2026  
**Status:** unconditional finite reductions, one complete counterexample, and
explicit open asymptotic inputs.  This note does not prove or disprove the abc
conjecture.

## 1. The exact obstruction

For an odd prime $q$, write

\[
 d_q=\operatorname{ord}_q(2),\qquad
 w_q=v_q(2^{d_q}-1).
\]

Because $d_q\mid q-1$ and $q\nmid(q-1)/d_q$, LTE gives

\[
 v_q(2^{q-1}-1)=w_q.                                \tag{1.1}
\]

Thus $w_q\ge2$ is exactly the base-two Wieferich condition and
$w_q\ge3$ is the super-Wieferich condition.  At exact order $d$, put

\[
 T_d=\prod_{d_q=d,\,w_q\ge2}q,\qquad
 D_d=\prod_{d_q=d,\,w_q\ge3}q^{w_q-2}.
\]

The canonical excess block satisfies $E_d=T_dD_d$.  The preceding
Mersenne report reduced the route to

\[
                         \log E_d=o(\varphi(d)).      \tag{1.2}
\]

Its Brun--Titchmarsh argument controls only a near-quadratic initial part of
the one-copy support $T_d$.  The purpose of this note is to separate the
two logically different ways in which the genuinely deep factor $D_d$
could remain large: many super-Wieferich primes in one order fibre, or a
small set of primes with unbounded lifting depth.

## 2. Literature boundary

Murty--Séguin, Lemmas 4.2--4.3, prove that a base-$a$ prime $q$ is
$k$-super-Wieferich precisely when $q^k$ divides one cyclotomic value,
and that the only possible first index is
$f(q)=\operatorname{ord}_q(a)$.
This is exactly the reindexing in (1.1).  Their largest-prime-factor results
do not give a weighted upper bound inside a fixed order fibre.

Fellini--Murty prove quantitative lower bounds for non-Wieferich prime ideals
under Masser's number-field abc conjecture, and also under finiteness of the
relevant super-Wieferich primes.  Neither hypothesis is available
unconditionally here, and a lower count of non-Wieferich primes does not
bound the mass of the exceptional exact-order primes.  In particular, no
result cited in the repository proves either term on the right of (5.1)
below to be little-oh.

The primary copies used for this audit are

* `research/sources/mersenne_prime_layer_radical_2026_09_01/`
  `Murty_Seguin_2019_Cyclotomic_Wieferich.pdf`;
* the same directory's
  `Fellini_Murty_2026_Wieferich_number_fields.pdf`;
* the Murty--Wong and Pomerance papers already recorded in that directory's
  `SOURCE_NOTES.md` and `SHA256SUMS`.

## 3. Exact layer-cake identity

For $j\ge3$, define the logarithmic depth layer

\[
 \Theta_{d,j}
   =\sum_{\substack{d_q=d\\w_q\ge j}}\log q.         \tag{3.1}
\]

### Proposition 3.1

For every $d$,

\[
                         \log D_d=\sum_{j\ge3}\Theta_{d,j}. \tag{3.2}
\]

The sum is finite.  More precisely, if $M\ge w_q$ for every prime in the
order-$d$ super support, then the right side may be truncated at $M$.

### Proof

A fixed prime $q$ contributes $(w_q-2)\log q$ to $\log D_d$.  It occurs
once in each layer $j=3,4,\ldots,w_q$, and therefore contributes exactly

\[
 \sum_{j=3}^{w_q}\log q=(w_q-2)\log q.
\]

Both the prime support and every valuation are finite, so the two finite
sums may be interchanged.  Summing the displayed identity over $q$ proves
(3.2).  ∎

This identity is stronger than recording only the set of super-Wieferich
primes.  A small first layer $\Theta_{d,3}$ need not control the full sum
unless the high-depth tail is uniformly integrable.

## 4. Threshold decomposition

For an integer $K\ge3$, define

\[
 R_d(K)=\sum_{\substack{d_q=d\\w_q\ge3}}
              (w_q-K)_+\log q,                       \tag{4.1}
\]

and let

\[
 S_d^{(3)}=\prod_{\substack{d_q=d\\w_q\ge3}}q       \tag{4.2}
\]

be the one-copy super-Wieferich support.

### Proposition 4.1 (exact truncation and upper bound)

For every $K\ge3$,

\[
\begin{split}
 \log D_d
 &=\sum_{\substack{d_q=d\\w_q\ge3}}
       \min(w_q-2,K-2)\log q+R_d(K),                 \tag{4.3}\\
 \log D_d
 &\le (K-2)\log S_d^{(3)}+R_d(K).                  \tag{4.4}
\end{split}
\]

Moreover $R_d(K)=\sum_{j=K+1}^{\infty}\Theta_{d,j}$.

### Proof

For every integer $w\ge0$ and $K\ge2$, truncated subtraction gives the
identity

\[
 w-2=\min(w-2,K-2)+(w-K)_+.                          \tag{4.5}
\]

Multiply (4.5) by $\log q\ge0$ and sum over the super support to obtain
(4.3).  The first coefficient in (4.3) is at most $K-2$; summing this
pointwise inequality gives (4.4).  Finally, $w-K$ is the number of integer
layers $K+1\le j\le w$, which proves the last assertion by the same finite
sum interchange as Proposition 3.1.  ∎

### Corollary 4.2 (frequency/depth dichotomy)

If $K>2$ and $\log D_d\ge A$, then

\[
 \frac{A}{2(K-2)}\le\log S_d^{(3)}
 \quad\hbox{or}\quad
 \frac A2\le R_d(K).                                \tag{4.6}
\]

### Proof

If the first alternative fails, then
$(K-2)\log S_d^{(3)}<A/2$.  Inequality (4.4) and
$\log D_d\ge A$ force $R_d(K)>A/2$.  ∎

Consequently a failure
$\log D_{d_i}\ge\epsilon\varphi(d_i)$ cannot be described merely as
"some super-Wieferich primes exist."  For every chosen threshold $K_i>2$,
one of the following quantitatively stronger statements holds:

\[
 \log S_{d_i}^{(3)}\ge
   \frac{\epsilon\varphi(d_i)}{2(K_i-2)},            \tag{4.7}
\]

or

\[
 R_{d_i}(K_i)\ge\frac{\epsilon\varphi(d_i)}2.       \tag{4.8}
\]

If the one-copy super support is sparse even after multiplication by
$K_i$, failure is forced into valuations exceeding the growing threshold
$K_i$.

## 5. A sufficient theorem for the deep factor and the full block

### Theorem 5.1 (moving-threshold closure)

Let $K_d\ge3$ be any integer threshold.  If

\[
 (K_d-2)\log S_d^{(3)}=o(\varphi(d))                 \tag{5.1}
\]

and

\[
 R_d(K_d)=o(\varphi(d)),                             \tag{5.2}
\]

then

\[
                         \log D_d=o(\varphi(d)).      \tag{5.3}
\]

If in addition $\log T_d=o(\varphi(d))$, then

\[
                         \log E_d=o(\varphi(d)),      \tag{5.4}
\]

and the exact divisor-block theorem already in the repository gives

\[
 \log\frac{2^m-1}{\operatorname{rad}(2^m-1)}=o(m).  \tag{5.5}
\]

### Proof

Apply (4.4) with $K=K_d$.  Both terms on its right are nonnegative and are
little-oh of $\varphi(d)$ by (5.1)--(5.2), proving (5.3).  The exact
identity $E_d=T_dD_d$ gives
$\log E_d=\log T_d+\log D_d$, so the additional hypothesis proves (5.4).
The previously formalized order-block summation theorem applies (5.4) to
the exact identity

\[
 W_m=L_m\prod_{d\mid m}E_d,\qquad L_m\mid m,
\]

and proves (5.5).  ∎

This theorem is a genuine sufficient criterion, but (5.1) and (5.2) remain
open fixed-base distribution statements.  A uniform bound $w_q\le K$ only
makes (5.2) vanish; one must still prove that the one-copy super support has
little-oh logarithmic mass.  Conversely, sparsity of the super support alone
does not control an unbounded high-depth tail.

### 5.2 The weaker divisor-average interface

The companion weighted-order-tail continuation proves that the actual
Mersenne endpoint is equivalent to

\[
 \sum_{d\mid m}\log E_d=o(m).                        \tag{5.6}
\]

Therefore pointwise conditions (5.1)--(5.2) are stronger than necessary.
Let $U_d$ denote the uncontrolled one-copy support left after the
Brun--Titchmarsh small arm.  From (4.4), a weaker sufficient input is the
single divisor-average estimate

\[
 \sum_{d\mid m}\left(
   U_d+(K_d-2)\log S_d^{(3)}+R_d(K_d)
 \right)=o(m).                                      \tag{5.7}
\]

Indeed, every summand is nonnegative, the actual uncontrolled remainder is
bounded termwise by the summand in parentheses, and the controlled small arm
has divisor average $o(m)$ by
$\sum_{d\mid m}\varphi(d)=m$.  Equation (5.6) then closes the endpoint.
The three pointwise little-oh estimates imply (5.7), but the converse is
false in general: a divisor average may tolerate large values at sparse
orders.  Likewise, (4.4) is an upper bound and its threshold hypotheses are
sufficient, not necessary.

## 6. A complete parity counterexample at $3511$

A tempting specialization is to restrict repeated exact-order primes to
even cyclotomic indices, where identities involving $2^{d/2}\pm1$ are
available.  The second classical base-two Wieferich prime supplies a complete
counterexample.

For primality, factor
$3511-1=3510=2\cdot3^3\cdot5\cdot13$ and take the Pocklington witness
$a=7$.  Direct calculation gives $7^{3510}\equiv1\pmod{3511}$ and, for
$r\in\{2,3,5,13\}$,
$\gcd(7^{3510/r}-1,3511)=1$.  Since the known factor
$F=3510>\sqrt{3511}$, Pocklington's criterion proves that $3511$ is prime.

Direct modular arithmetic gives

\[
\begin{aligned}
 2^{1755}&\equiv1\pmod {3511^2},\\
 2^{1755}&\equiv21954602502\not\equiv1\pmod {3511^3},\tag{6.1}\\
 2^{585}&\equiv756\pmod {3511},\\
 2^{351}&\equiv1578\pmod {3511},\\
 2^{135}&\equiv88\pmod {3511}.
\end{aligned}
\]

Also $3511$ is prime and
$1755=3^3\cdot5\cdot13$.  The first congruence in (6.1) shows that the
order divides $1755$.  The last three congruences exclude division of the
order by each prime divisor $3,5,13$.  Therefore

\[
 \operatorname{ord}_{3511}(2)=1755,
 \qquad v_{3511}(2^{1755}-1)=2.                      \tag{6.2}
\]

In particular the exact order is odd.  This refutes, with all premises
present, the universal statement

> Every prime $q$ for which
> $q^2\mid2^{\operatorname{ord}_q(2)}-1$ has even
> $\operatorname{ord}_q(2)$.

The counterexample closes only this parity strengthening.  Its valuation is
two, so it neither supplies a super-Wieferich prime nor refutes (5.1),
(5.2), or (1.2).

## 7. Reproducible finite search

The companion directory
`computation/2026_09_01_mersenne_super_wieferich_depth/` scans every prime
up to $10^7$, tests the base-two Fermat congruence modulo
$q^2$, computes the exact order and the first failing prime-power modulus
for every hit, and runs an independent verifier.  Its JSON metadata labels
the scan as finite and prohibits asymptotic inference.

The two independent enumerations agree on all $664579$ primes in the
interval.  The only hits are $1093$ and $3511$; their exact orders are
$364$ and $1755$, and both canonical depths are exactly two.  Thus this
finite range contains no super-Wieferich hit, while $3511$ supplies the
odd-order counterexample in Section 6.

The scan is useful for checking the $3511$ certificate and for detecting
implementation mistakes in the depth definitions.  Absence of a
super-Wieferich hit in any finite interval is not a proof of (5.2), and is
not used to discard the route.

## 8. Formalization boundary

`IUTThreeClosures/MersenneSuperWieferichDepth20260901.lean` proves:

1. the exact finite layer-cake identity;
2. the threshold decomposition, upper bound, and frequency/depth dichotomy;
3. the moving-threshold little-oh theorem with every analytic input explicit;
4. the actual cyclotomic definitions of $S_d^{(3)}$ and $D_d$, their
   logarithmic identities, and the exact factorization $E_d=T_dD_d$;
5. the resulting sufficient implication to the existing Mersenne
   power-loss endpoint; and
6. the prime, order, valuation, odd-order counterexample, and canonical-block
   divisibility certificates at $3511$.

No theorem assumes abc, finiteness of super-Wieferich primes, a random-base
model, or a hidden same-order density assertion.  The open target after this
note is precise: establish (5.1)--(5.2) for some moving threshold while also
controlling the two surviving one-copy support tails in $T_d$.
