# A corrected log-volume model and the zero-holonomy gate for the IUT same-pilot route

**Author:** ChatGPT  
**Date:** 2026-09-01  
**Status:** unconditional local and finite-packet theorems; a consistency
model for the repaired interface; a necessary closed-loop condition. No
same-pilot object is constructed, and neither IUT nor the abc conjecture is
proved or disproved.

## 1. Purpose and source boundary

At the latest public `lana-agents/iut` main commit
`ddaddc274281adb5674d647e24fa478745ac6d40`, the field
`LogVolumeData.componentVol_prime_preimage` is quantified over every set and
takes values in `Real`. Applied to the empty set, its nonzero additive shift
is contradictory. The preceding audit proved this directly for the actual
`RHSData` record. The remote `main` head was checked again on 2026-09-01 and
is still that commit.

The intended source regime is the Haar log-volume of nonempty regions of
finite positive measure. This note takes the next positive step. It gives an
inhabited restricted model on the standard compact-open valuation balls,
proves that normalized packet and procession aggregation preserve the prime
shift, and isolates the additive obstruction that every proposed same-pilot
closed diagram must discharge.

The model is deliberately elementary. It proves that restricting the domain
repairs the logical inconsistency; it does not instantiate the local fields,
theta data, Ind1--Ind3 operations, determinant normalization, or global
arithmetic line bundles of IUT III.

## 2. Compact-open valuation balls

Fix a rational prime \(p\). Normalize Haar measure on \(\mathbb Q_p\) by
\(\mu(\mathbb Z_p)=1\). For \(k\in\mathbb Z\), put

\[
 B_p(k)=p^k\mathbb Z_p,
 \qquad
 \lambda_p(k)=\log\mu(B_p(k))=-k\log p.                 \tag{2.1}
\]

Every \(B_p(k)\) is nonempty and has finite positive measure. Thus the
ordinary real logarithm in (2.1) is defined for every object in this domain.

### Theorem 2.1 (restricted prime-preimage law)

For every \(k\in\mathbb Z\),

\[
 (x\mapsto px)^{-1}B_p(k)=B_p(k-1),
 \qquad
 \lambda_p(k-1)=\lambda_p(k)+\log p.                    \tag{2.2}
\]

#### Proof

The condition \(px\in p^k\mathbb Z_p\) is equivalent to
\(x\in p^{k-1}\mathbb Z_p\), proving the set equality. The volume identity is

\[
 \lambda_p(k-1)=-(k-1)\log p
 =-k\log p+\log p=\lambda_p(k)+\log p.
\]

All sets appearing here stay inside the nonempty finite-positive-volume
domain. In particular, the empty-set fixed-point argument is unavailable.
\(\square\)

### Proposition 2.2 (normalization and monotonicity)

The integral ball has log-volume zero. Moreover,

\[
 B_p(k)\subseteq B_p(m)\quad\Longleftrightarrow\quad m\le k,
 \qquad
 m\le k\quad\Longrightarrow\quad \lambda_p(k)\le\lambda_p(m). \tag{2.3}
\]

#### Proof

Equation (2.1) gives \(\lambda_p(0)=0\). The containment criterion is the
standard valuation criterion: divisibility by \(p^k\) implies divisibility by
\(p^m\) precisely when \(m\le k\). Since \(p>1\), one has
\(\log p>0\); multiplying \(m\le k\) by \(-\log p\) reverses the order and
gives the last assertion. \(\square\)

The model therefore supplies exactly the monotonicity that was absent from
the pinned total-real interface, on a domain where that law is mathematically
valid.

## 3. Normalized finite packets

Let \(I\) be a nonempty finite fiber and let real weights \(w_i\) satisfy

\[
 w_i>0,
 \qquad
 \sum_{i\in I}w_i=1.                                    \tag{3.1}
\]

For a packet of valuation balls with exponents
\(k=(k_i)_{i\in I}\in\mathbb Z^I\), define

\[
 \Lambda_{p,w}(k)=\sum_{i\in I}w_i\lambda_p(k_i).        \tag{3.2}
\]

Write \(k-\mathbf 1=(k_i-1)_{i\in I}\) for simultaneous prime preimage in
every component.

### Theorem 3.1 (packet shift survives normalized aggregation)

For every packet \(k\),

\[
 \Lambda_{p,w}(k-\mathbf1)=\Lambda_{p,w}(k)+\log p.      \tag{3.3}
\]

#### Proof

Apply Theorem 2.1 componentwise and use (3.1):

\[
\begin{aligned}
 \Lambda_{p,w}(k-\mathbf1)
 &=\sum_iw_i\bigl(\lambda_p(k_i)+\log p\bigr)\\
 &=\Lambda_{p,w}(k)+\left(\sum_iw_i\right)\log p\\
 &=\Lambda_{p,w}(k)+\log p.
\end{aligned}
\]
\(\square\)

Positivity of the individual weights is required by the intended arithmetic
interpretation, but only their normalization is needed for (3.3).

Now take a procession with \(N>0\) capsules and packet volumes
\(\Lambda_0,\ldots,\Lambda_{N-1}\). Its unweighted normalized volume is

\[
 \overline\Lambda=\frac1N\sum_{j=0}^{N-1}\Lambda_j.      \tag{3.4}
\]

### Corollary 3.2 (procession shift)

If simultaneous prime preimage adds \(\log p\) to every capsule volume, then
it adds exactly \(\log p\) to the procession-normalized volume.

#### Proof

The transformed average is

\[
 \frac1N\sum_j(\Lambda_j+\log p)
 =\overline\Lambda+\frac{N\log p}{N}
 =\overline\Lambda+\log p.
\]

The division is legitimate because \(N>0\). \(\square\)

Thus neither fiber normalization nor procession averaging removes the local
prime shift. Any closed same-pilot diagram must cancel it elsewhere.

## 4. Logarithmic transport and holonomy

Let \(X\) be an object type and \(\nu:X\to\mathbb R\) a normalized log-volume
coordinate. A logarithmic transport from \(x\) to \(y\) with shift
\(\delta\in\mathbb R\) is a certificate

\[
                         \nu(y)=\nu(x)+\delta.           \tag{4.1}
\]

The number \(\delta\) is the logarithmic holonomy of the transport.

### Theorem 4.1 (composition and reversal)

If \(x\to y\) has shift \(\delta\) and \(y\to z\) has shift \(\varepsilon\),
their composite \(x\to z\) has shift \(\delta+\varepsilon\). Reversing a
transport of shift \(\delta\) gives a transport of shift \(-\delta\).

#### Proof

Substitute the first equality into the second:

\[
 \nu(z)=\nu(y)+\varepsilon
       =\nu(x)+\delta+\varepsilon.
\]

Solving (4.1) for \(\nu(x)\) gives
\(\nu(x)=\nu(y)-\delta=\nu(y)+(-\delta)\). \(\square\)

### Theorem 4.2 (zero-holonomy necessity)

Every closed transport \(x\to x\) has shift zero. Consequently a transport
with nonzero shift cannot identify its endpoint with its starting object.

#### Proof

For a closed transport, (4.1) reads
\(\nu(x)=\nu(x)+\delta\), hence \(\delta=0\). The contrapositive gives the
second assertion. \(\square\)

### Corollary 4.3 (the required log-Kummer correction)

Suppose the prime-preimage part of a proposed loop contributes \(\log p\)
and the remaining correction contributes \(\kappa\). If the loop returns to
the same pointed pilot object, then

\[
                              \kappa=-\log p.             \tag{4.2}
\]

More generally, if the successive scale contributions are
\(\delta_1,\ldots,\delta_r\), the remaining correction must equal
\(-\sum_j\delta_j\).

#### Proof

Theorem 4.1 says that the total shift is
\(\log p+\kappa\), or respectively
\(\sum_j\delta_j+\kappa\). Theorem 4.2 makes this total zero. \(\square\)

This condition is necessary before any volume inequality is taken. It cannot
replace the stronger object-level assertion that the loop ends at the same
pilot, since equality of one real coordinate does not identify the underlying
arithmetic objects.

### Corollary 4.4 (uncorrected positive scale loops are impossible)

If every edge shift is nonnegative and at least one is positive, their
composite cannot be a closed same-pilot loop.

#### Proof

The total shift is a sum of nonnegative reals with a positive summand, hence
is positive. Theorem 4.2 rules out closure. \(\square\)

This is a full no-go theorem for an *uncorrected* scaling-loop mechanism. It
does not refute a source construction carrying a genuine negative
log-Kummer, determinant, or metric correction.

## 5. Prime-by-prime balance for rational scale coefficients

The global log coordinate is assembled from rational-place contributions.
For rational coefficients there is no hidden cancellation among logarithms
of distinct rational primes.

### Theorem 5.1 (rational independence of prime logarithms)

Let \(p_1,\ldots,p_r\) be distinct rational primes and
\(c_1,\ldots,c_r\in\mathbb Q\). If

\[
                         \sum_{i=1}^r c_i\log p_i=0,     \tag{5.1}
\]

then every \(c_i=0\).

#### Proof

Choose a positive common denominator \(D\) and put
\(m_i=Dc_i\in\mathbb Z\). Multiplying (5.1) by \(D\) and exponentiating gives

\[
                           \prod_i p_i^{m_i}=1.           \tag{5.2}
\]

Move the negative powers to the other side:

\[
 \prod_{m_i>0}p_i^{m_i}
   =\prod_{m_i<0}p_i^{-m_i}.                              \tag{5.3}
\]

Both sides are positive integers. Unique prime factorization and the
distinctness of the \(p_i\) imply \(m_i=0\) for every \(i\), hence
\(c_i=0\). \(\square\)

Therefore, whenever all pieces of a proposed global holonomy are rational
linear combinations of \(\log p\), closedness forces cancellation separately
at every rational prime. A global weighted sum cannot conceal a residual
local prime shift. This converts the same-pilot gate into a place-by-place
ledger: each prime coefficient contributed by theta transport, log-Kummer
correction, determinant power, and normalization must sum to zero.

### Corollary 5.2 (prime-local closure ledger)

Let a finite transport have total shift

\[
                 \delta=\sum_{i=1}^r c_i\log p_i,
                 \qquad c_i\in\mathbb Q,                 \tag{5.4}
\]

for distinct rational primes \(p_i\). If the transport returns to the same
pointed object, then every \(c_i=0\).

#### Proof

Theorem 4.2 gives \(\delta=0\). Substitution into (5.4) and Theorem 5.1 give
\(c_i=0\) for each prime. \(\square\)

This is stronger than checking only the final real number: under the stated
rationality hypothesis it demands a separate cancellation certificate at
every rational place.

### Proposition 5.3 (full counterexample without rational coefficients)

The rationality hypothesis in Theorem 5.1 cannot be replaced by arbitrary
real coefficients. At the two distinct primes \(2\) and \(3\), take

\[
                   c_2=\log3,\qquad c_3=-\log2.          \tag{5.5}
\]

Both coefficients are nonzero, but

\[
 c_2\log2+c_3\log3
 =(\log3)(\log2)-(\log2)(\log3)=0.                        \tag{5.6}
\]

This example satisfies every hypothesis of the deliberately broadened
real-coefficient independence claim and disproves it. It does not contradict
Theorem 5.1 or any source construction whose coefficients are proved to be
rational local-degree ratios. It shows that the present low-resolution
interface, whose weight fields merely have type Real, must carry an
additional arithmetic rationality theorem before prime-by-prime cancellation
can be inferred. The weights themselves are positive; signed coefficients
arise only after oriented transport and correction contributions are combined
in the loop ledger.

### Proposition 5.4 (positive normalized scalar reconstruction fails)

Even positivity and normalization do not make a single weighted log-volume
scalar determine its placewise weights. Put

\[
             a=\log 2,\qquad b=\log 3,\qquad c=\log 5 .
\]

Thus \(a<b<c\). Define two triples, indexed by the places \(2,3,5\), by

\[
 \begin{aligned}
 W&=\left(\frac{c-b}{2(c-a)},\frac12,
                   \frac{b-a}{2(c-a)}\right),\\
 V&=\left(\frac{c-b}{3(c-a)},\frac23,
                   \frac{b-a}{3(c-a)}\right).
 \end{aligned}                                             \tag{5.7}
\]

Every coordinate of both triples is strictly positive. Moreover,

\[
 \frac{c-b}{n(c-a)}+\left(1-\frac1n\right)
       +\frac{b-a}{n(c-a)}=1                              \tag{5.8}
\]

for \(n=2,3\), so both triples are normalized. Their weighted log scalars
nevertheless coincide. Indeed, for either \(n=2\) or \(n=3\),

\[
 \begin{aligned}
 &\frac{c-b}{n(c-a)}a+\left(1-\frac1n\right)b
       +\frac{b-a}{n(c-a)}c\\
 &\quad=\frac{(c-b)a+(b-a)c}{n(c-a)}
       +\left(1-\frac1n\right)b\\
 &\quad=\frac{b(c-a)}{n(c-a)}
       +\left(1-\frac1n\right)b=b .                       \tag{5.9}
 \end{aligned}
\]

But \(W\ne V\), already because their middle coordinates are \(1/2\) and
\(2/3\). Hence the statement

> two strictly positive normalized real place-weight systems with equal
> weighted log-volume scalar must agree place by place

has a counterexample satisfying all of its hypotheses. This closes that
precise scalar-reconstruction mechanism. It does not show that two complete
pilots with equal scalar volume are isomorphic, nor does it contradict a
construction that transports the labelled placewise data themselves. Such
an object-level same-pilot theorem remains a live route.

## 6. Exact route disposition

The restricted valuation-ball model proves that the obvious domain repair is
consistent and preserves the intended local normalization through finite
packets and processions. The old unrestricted total-set interface remains
closed by its empty-set contradiction; the repaired interface is active and
inhabited.

The new holonomy ledger gives two rigorous checks for any future same-pilot
construction:

1. the total logarithmic shift of a closed pointed loop must be zero;
2. when the coefficients are rational combinations of rational-prime logs,
   the shift must cancel prime by prime.

Proposition 5.4 adds a third check: equality of one real aggregate, even for
strictly positive normalized weights, cannot by itself recover the labelled
local weights. A future same-pilot proof must retain additional placewise or
object-level information.

The remaining hard work is still object-level. One must construct the
q-pilot inside the corrected container, transport it through the horizontal
theta link and every allowed Ind1--Ind3 branch, identify the determinant and
metric normalizations, prove the prime-by-prime zero-holonomy ledger, and
prove that the endpoint is the same pointed pilot rather than merely an
object with the same scalar volume. No counterexample in this note satisfies
those full source hypotheses, so the corrected IUT/LANA and abc routes remain
open.

## 7. Primary sources

* `lana-agents/iut`, commit
  `ddaddc274281adb5674d647e24fa478745ac6d40`, especially
  `Iut/Cor312/LogVolume.lean`, `Container.lean`, and `Statement.lean`.
* Shinichi Mochizuki, *Inter-universal Teichmüller Theory III*, Proposition
  3.9, Remark 3.9.5, and Corollary 3.12, unchanged May 2020 author PDF.
* Fumiharu Kato et al., *LANA Project Activity Report and an Introduction to
  Inter-universal Teichmüller Theory*, July 2026 source, especially the volume
  container, log-volume, and same-pilot discussion.
