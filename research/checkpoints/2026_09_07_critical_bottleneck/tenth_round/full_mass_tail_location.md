# FM1--FM3. Almost all actual boundary mass lies beyond the controlled windows

Date: 2026-09-07. Ordinary candidate submitted for independent review.
Ninth-round mathematical sources remain frozen. This is an independent
analytic study of the complete remaining tail, not a modularity argument.
It distinguishes full valuation mass from signed cost and from the radical.

The actual root block is

    w_k=3k+zeta, Q_k=9k^2+3k+1, B<=k<2B,
    T_n(k)=|P(w_k^n)|, t_k=log c_n(k),

for positive integers n,B. Here c_n(k) is the largest side after sector
normalization. These are primitive unramified nonunit roots with nonzero
boundary at every index. The already proved elementary bounds are

    t_k>=n log(3B),
    log|P(w_k^d)|<=3d log(6B+1).                       (FM1)

## FM1. An actual full-mass mean bound

For a real Z>=5 with Z>3n, define

    H_Z(k)=sum_{5<=q<=Z} v_q(T_n(k)) log q,

where q ranges over primes. Unlike the earlier window observable, there
is no positive-part subtraction and no lower cutoff. Then

    (1/B)sum_{B<=k<2B} H_Z(k)/t_k
      <= 6 tau(n) log Z (1+log Z)/(n log(3B))
         +36 Z sigma(n)/(B n log(Z/(3n)))
         +log n/(n log(3B)).                          (FM2)

Here tau(n) is the number of divisors and sigma(n) their sum. One may
replace tau(n) in the first term by the smaller sum_{d|n} phi(d)/d.

Proof. At every supported q>=5, partition each actual root by the rank
d=ord((w_k/bar(w_k))^3 mod q). Then d|n and q does not divide d. A prime
dividing Q_k cannot divide the boundary, so no supported state is lost.
Let s=v_q(T_d(k)) be its first depth. The exact homogeneous law is

    v_q(T_n(k))=s+v_q(n).

The exponent-lifting contribution, summed over supported primes, is at
most log n for each actual k, without any distribution premise.

For fixed d,q the exact-rank root count is at most 3phi(d), and every
root lifts simply and uniquely to each depth. Consequently the count
of actual k in the interval with first depth at least e is at most

    3phi(d)(B/q^e+1).

This is the established actual interval count, not a uniform random
residue assumption. The cap in (FM1) permits only

    e<=floor(3d log(6B+1)/log q)

for a contributing actual root. Sum from e=1, not from e=4, and multiply
by log q. The entire first-depth mass of this rank-prime pair, summed
over the actual block, is at most

    3phi(d) B log q/(q-1)+9phi(d)d log(6B+1).           (FM3)

The bound remains valid if the cap is zero. There is no hypothesis that
any actual depth is simple or bounded by a fixed number.

For the first term, an eligible rank-d prime belongs to one of the two
progressions q=3dj+1 or q=3dj-1, j>=1. All their relevant j are at most
Z. In the first progression 1/(q-1)=1/(3dj); in the second it is at
most 1/(dj), since 3dj-2>=dj. Hence, even on replacing eligible primes
by all these integers,

    sum_{eligible q<=Z} log q/(q-1)
      <= 2 log Z (1+log Z)/d.                        (FM4)

The harmonic sum bound uses floor(Z) and is valid for real Z>=5. This
step retains the rank-dependent progression spacing; merely summing
over all primes would lose this divisor saving. Multiplication of
(FM4) by 3phi(d)B and summation over d|n gives the first term in (FM2)
after using phi(d)/d<=1 and normalizing by Bn log(3B).

For the endpoint term, the established Brun--Titchmarsh bound gives

    #{eligible q<=Z}
      <=4Z/(phi(3d) log(Z/(3d))).

It applies for every d|n because Z>3n. With phi(3d)>=2phi(d), the
second part of (FM3), summed over all ranks and primes, is at most

    18 Z sigma(n) log(6B+1)/log(Z/(3n)).

Division by Bn log(3B), and log(6B+1)<=2log(3B), give the second
term of (FM2). The lifting cost supplies the final term. Every
normalization used nonnegative mass and the actual lower bound t_k
in (FM1), completing the proof.

## FM2. Full boundary mass escapes the all-index window

For integers n tending to infinity through all indices, set

    B=n^4,
    Z=floor(B sqrt(log n)/(1+log log n)),
    eta_n=(log n)^(-1/4).                             (FM5)

There are absolute constants C,N such that for all n>=N,

    (1/B)sum_k [sum_{q<=Z}v_q(T_n(k))log q]/t_k
       <= C (log n)^(-1/2).                          (FM6)

All primes, including 2 and 3, occur in this statement. Consequently,
outside at most a proportion C eta_n of the actual k in the block,

    3-A log(4n)/n-eta_n
      <= [sum_{q>Z}v_q(T_n(k))log q]/t_k <=3,         (FM7)

where A is an absolute effective constant from the established
archimedean logarithmic-form estimate. In particular the complete
valuation mass above Z, normalized by the actual height, tends to
three on a proportion tending to one of these actual roots.

Proof. In (FM2), the elementary bound tau(n)<=2sqrt(n) makes the first
term O(log n/sqrt(n)), since log Z is asymptotic to 4log n and
log(3B) to 4log n. The proved all-index estimate

    sigma(n)/n<=exp(18)(1+log log n)

cancels the matching denominator in Z/B. Since
log(Z/(3n)) is asymptotic to 3log n, the endpoint term is
O((log n)^(-1/2)); the lifting term is O(1/n).

For q=2,3 use the reviewed all-prime two-place bound with unit residual
and lambda=1/n. It gives

    [v_2(T_n)log2+v_3(T_n)log3]/t_k
       <=A_2(4log2+9log3)log^2(4n)/n.

Sector normalization preserves these valuations and the height, so the
positive-coordinate domain of that theorem is met. This proves (FM6).
Markov at eta_n gives the stated exceptional proportion. On each
remaining actual root, subtract the full small-prime mass from

    log T_n/t_k=3-Delta_n/t_k,
    0<=Delta_n/t_k<=A log(4n)/n.

This proves both inequalities in (FM7). No fixed-root bound is inferred
from the mean, and the exceptional set is still present explicitly.

## FM3. At prime index, the escaping mass is in the actual top rank

Now let n tend to infinity through primes at least five, keeping (FM5).
For the same nonexceptional actual roots,

    [sum_{q>Z, d_q(k)=n}v_q(T_n(k))log q]/t_k ->3,    (FM8)

uniformly on that nonexceptional set. At these primes q>Z>3n, the
valuation is exactly the first depth, with no exponent-lifting term.

Proof. The only ranks dividing a prime n are 1 and n. Since q>Z>n,
the rank-one contribution equals the old-boundary valuation at index
one, by the homogeneous valuation law. Its complete mass is at most
log T_1(k). The elementary bounds give

    log T_1(k)/t_k <= [(3/2)log Q_k]/[(n/2)log Q_k]=3/n.

Subtract this from the lower bound in (FM7); the upper bound three
continues to hold. This proves (FM8) with its actual rank restriction.

## What this does and does not prove

The conclusion locates the principal amount of integer boundary size:
the primes beyond the presently controlled window carry essentially
all of its full valuation mass, and at prime index this is the actual
top-rank first-depth packet. It shows why a finite-window estimate,
even one reaching beyond the root-interval length, does not by itself
dispose of the main remaining arithmetic object.

This is NOT a lower bound on the signed cost or a failure of ABC.
An exponent-one prime contributes positive full mass but negative
signed cost -2log q. The mass in (FM7)--(FM8) could consist almost
entirely of such useful negative credits. Conversely no bound on its
radical or its deep private owners follows from these estimates.
The unresolved task remains to relate those actual shallow credits
to the high depths, including the exceptional roots.

Dependencies: actual primitive root blocks and elementary heights ->
exact-rank simple-root lifting and interval counts -> full first-depth
sum and rank-dependent harmonic bound -> Brun--Titchmarsh endpoint ->
all-index divisor-sum estimate -> two-place control only at 2,3 and at
the archimedean place -> actual full-mass concentration. No modular
representation theorem, probabilistic independence, or unproved
radical-saving hypothesis is used in this chain.

The established sieve source and its exact real-endpoint deduction
were independently opened and reviewed in the seventh-round note
`sieved_rank_window.md`: Montgomery--Vaughan, The large sieve,
Mathematika 20 (1973), Theorem 2, printed page 121, equation (1.10),
https://personal.science.psu.edu/rcv4/personal/Publications/large_sieve.pdf.
The new step here is summing actual depths from one and retaining the
rank spacing in the main harmonic term. This note is an ordinary proof;
it is not presented as a completed Lean formalization.
