# Actual root-height blocks and polynomial prime windows

Date: 2026-09-07. Sixth-round ordinary proof, submitted for independent
review. All fifth-round mathematical texts remain unchanged.

This result averages over an actual finite block of integer roots, not a
uniform residue reference space. It controls a specified finite prime
window for most roots. It does not control the primes beyond that window
or every individual root.

## RW1. Primitive homogeneous blocks and their exact height corridor

Fix integers n,B>=1. For each integer k in [B,2B), let

    w_k=3k+zeta,   Q_k=N(w_k)=9k^2+3k+1,
    T_{k,n}=|P(w_k^n)|,

where zeta^2-zeta+1=0 and P(a+b*zeta)=ab(a+b).
All these roots are primitive and their norms are one modulo three.
Consequently all powers w_k^n remain primitive and have nonzero
boundary. Choose their positive unit rotation, with largest side c_{k,n},
and put t_{k,n}=log c_{k,n}. Then

    t_{k,n} >= n log(3B),                                        (R1)
    log|P(w_k^m)| <= 3m log(6B+1)       for every m>=1.             (R2)

Proof. Oriented Eisenstein factorization, with no ramified factor,
proves primitivity at every exponent. A zero boundary would make the
root/conjugate ratio a root of unity and force a primitive unramified
root to be a unit, contrary to Q_k>=13. Unit rotation preserves norm
and absolute boundary. Thus Q_k^n<=c_{k,n}^2. Since Q_k>=(3B)^2,
this gives (R1). Also Q_k<=(3k+1)^2<=(6B+1)^2. The cubic difference
identity gives |P(w_k^m)|<=Q_k^(3m/2), proving (R2).

## RW2. Removing the lifting part before counting simple roots

For each prime p>3, set a_p=v_p(n), m_p=n/p^{a_p}. Let

    G_m(X)=P((3X+zeta)^m) in Z[X].

If p does not divide m, every root of G_m modulo p is simple and
there are at most 3m roots. Each such root lifts to a unique root
modulo every p^e. Hence, if r_{p,m} is the number of its roots modulo p,

    #{k in [B,2B): p^e | G_m(k)}
        <= r_{p,m}(B/p^e+1),      r_{p,m}<=3m.                    (R3)

Proof. Work over F_p or its quadratic extension containing the two
distinct roots z,zbar of X^2-X+1. At a zero of G_m, neither 3X+z
nor 3X+zbar can vanish: if one vanished, the cubic-difference identity
would force both to vanish, contradicting z!=zbar. Their ratio is
therefore defined. The same identity is

    3(z-zbar)G_m(X)=(3X+z)^{3m}-(3X+zbar)^{3m}.

At a root, differentiation of the ratio expression gives a nonzero
derivative, because p does not divide 3m and the ratio derivative is
3(zbar-z)/(3X+zbar)^2. This works in both the split and inert cases.
The polynomial degree is at most 3m, so there are at most that many
roots. Simple-root lifting preserves their number at every precision.
Each residue class modulo p^e meets a block of B consecutive integers
at most B/p^e+1 times, giving (R3).

For an actual k with p not dividing Q_k, the homogeneous rank and LTE
law implies

    v_p(T_{k,n})=v_p(|G_{m_p}(k)|)+a_p
                      if v_p(|G_{m_p}(k)|)>0,
    v_p(T_{k,n})=0      otherwise.                              (R4)

Indeed the rank is prime to p and hence divides n if and only if it
divides m_p; the latter exponent has no lifting contribution at p.
If p divides Q_k, neither primitive boundary is divisible by p, so
both valuations in (R4) are zero. In particular, for every k,p,

    (v_p(T_{k,n})-3)_+
      <= (v_p(|G_{m_p}(k)|)-3)_+ + v_p(n).                       (R5)

Thus primes dividing n are included; no derivative at the inseparable
exponent n is used. Summing the last terms over any prime window costs
at most log n.

## RW3. An unconditional actual-window average

Let real cutoffs satisfy Z>=Y>=5, and define

    E_{k,n}(Y,Z)=sum_{Y<p<=Z} (v_p(T_{k,n})-3)_+ log p.

This is the primewise positive excess of the actual integer boundary
in the indicated finite window. One has

    (1/B) sum_{B<=k<2B} E_{k,n}(Y,Z)/t_{k,n}
      <= 10 log Y/[Y^3 log(3B)]
          +18 n*pi(Z)/B + log n/[n log(3B)].                     (R6)

Every constant is uniform in n, B, both cutoffs, and the actual roots.

Proof. Fix p and put m=m_p. Set
H_p=floor(3m log(6B+1)/log p). By (R2) this covers every possible
valuation of the nonzero integer G_m(k) in the block. Summing (R3)
over the positive-excess layers e>=4 up to H_p gives

    sum_k (v_p(|G_m(k)|)-3)_+ log p
      <= r_{p,m} B log p/[p^3(p-1)]
          + r_{p,m} H_p log p
      <= 3m B log p/[p^3(p-1)] +9m^2 log(6B+1).                 (R7)

This bound includes the endpoint errors at every depth. An empty layer
range contributes zero, and all boundaries are nonzero. Use m<=n,
sum over Y<p<=Z, divide by the common lower height n log(3B), and
then average over the B roots. Since

    6B+1 <= (3B)^2       for integer B>=1,

the endpoint error is at most 18 n*pi(Z)/B. The lifting contribution
from (R5) is at most log n/[n log(3B)]. Finally the elementary estimate

    3 sum_{p>Y} log p/[p^3(p-1)] <= 10 log Y/Y^3                 (R8)

proves the first term. To verify this deliberately loose constant,
use p/(p-1)<=5/4, bound the prime sum by the integer sum of
log j/j^4, and integrate the decreasing function from floor Y.
Its integral equals (log(floor Y)/3+1/9)/(floor Y)^3. Since
floor Y>=4Y/5 and log Y>=1, the resulting constant is less than ten.
All uses of the lower height involve nonnegative quantities, so they
remain valid with varying actual heights t_{k,n}.

## RW4. A genuine moving-root subclass inside any fixed polynomial window

Fix an integer A>=2. As n tends to infinity, take

    B=n^{A+2},  Y=n^{1/6},  Z=n^A.

For all sufficiently large n, Y>=5 and (R6), using only pi(Z)<=Z,
gives

    mean_k E_{k,n}(Y,Z)/t_{k,n}
      <= 5/[3(A+2)sqrt(n)] +18/n +1/[(A+2)n].                  (R9)

Outside at most

    5/[3(A+2)n^{1/4}] +(18+1/(A+2))/n^{3/4}                  (R10)

of the proportion of roots in this actual block, one has

    E_{k,n}(Y,Z)/t_{k,n} <= n^{-1/4}.                          (R11)

Proof. Substitute the parameters and log(3B)>=(A+2)log n in
(R6). The first term becomes at most
10(log n)/[6 sqrt(n)(A+2)log n], and the other two terms have the
stated bounds. Markov's inequality applies to the nonnegative actual
excess at threshold n^(-1/4), yielding (R10).

Every member is a genuine unit-residual homogeneous profile with
lambda=1/n; the moving root norms have size comparable to n^{2A+4}.
At A=2 the window reaches n^2. This is beyond the first possible
top-rank primes for prime n, unlike a sublinear-in-n prime cutoff.
For this main application the average is bounded by
5/(12 sqrt n)+18/n+1/(4n).

The conclusion is for most roots, not for each one, and only up to
the specified Z. Primes beyond every fixed polynomial window and
the exceptional actual roots remain uncontrolled. A counterexample
family could in principle lie in those exceptional sets. The theorem
therefore does not establish ABC or the full signed-tail gate.

## RW5. Totient stratification removes the exponent from the discrepancy

The critical agent's rank-stratified refinement, independently reviewed
here, improves (R6) to

    mean_k E_{k,n}(Y,Z)/t_{k,n}
      <= 10 log Y/[Y^3 log(3B)]
          +12(Z+1)/B + log n/[n log(3B)].                      (R12)

Here every rank and first depth is taken from the actual integer root
being counted. The proof does not assume a uniform law for the output
of a power map.

For p>3, write chi_p=1 for split primes and -1 for inert primes, and
N_p=p-chi_p. The fractional-linear map

    a -> (a+zeta)/(a+bar(zeta))

is a bijection from residues a of nonzero norm onto the norm-one group
minus its identity. Its inverse is
(R*bar(zeta)-zeta)/(1-R); in the inert case conjugation fixes this
inverse, and hence it belongs to F_p. In the split case the same
formula applies in the split quadratic algebra. Since 3 divides N_p,
the cube map has kernel of order three. It follows that the number of
residues k for which the cube of this ratio has exact order d is

    r_p(d)=3 phi(d)-1_{d=1},   if d | N_p/3,
    r_p(d)=0,                 otherwise.                      (R13)

For d in (R13) one has p not dividing d. Each such residue is a simple
root of G_d by RW2 and lifts uniquely to every modulus p^e, preserving
its rank modulo p. Restricting to those roots gives at most
3 phi(d)(B/p^e+1) actual parameters in the block at depth at least e.
The cap log|G_d(k)|<=3d log(6B+1) therefore bounds their positive
first-depth cost by

    3 phi(d) B log p/[p^3(p-1)]
       +9 phi(d)d log(6B+1).                                  (R14)

At a fixed p the possible ranks divide gcd(n,N_p/3), so the sum of
phi(d) over these ranks is at most n. Thus the first term in (R14)
gives the same geometric-series main term as (R6).

For the endpoint errors sum in the opposite order. Rank d requires
p congruent to either 1 or -1 modulo 3d. All positive primes p>3 in
these two progressions have the form 3dj+1 or 3dj-1 with j>=1.
Consequently there are at most 2(Z+1)/(3d) candidates up to Z.
This bound remains valid for d=1, since the nonprime p=1 is excluded.
The total endpoint error is at most

    sum_{d|n} 9 phi(d)d log(6B+1) * 2(Z+1)/(3d)
       =6n(Z+1)log(6B+1).                                    (R15)

Divide by Bn log(3B) and use log(6B+1)<=2log(3B). This yields
12(Z+1)/B. The lifting contribution remains at most log n per
actual root. Primes dividing its norm contribute nothing, because
all the actual powers are primitive. This proves (R12).

## RW6. Windows approaching the root-parameter interval length

For the concrete actual block B=n^4, take Y=n^{1/6} and Z=n^3.
For all sufficiently large n, (R12) gives

    mean_k E_{k,n}(Y,Z)/t_{k,n}
      <=5/(12 sqrt n)+12/n+12/n^4+1/(4n).                     (R16)

At threshold n^{-1/4} the exceptional proportion is at most

    5/(12 n^{1/4})+(12+1/4)/n^{3/4}+12/n^{15/4}.             (R17)

Thus most actual homogeneous roots of norm comparable to n^8 have
vanishing positive excess through the larger window n^3. In
particular this window includes possible primes of top rank n.
More generally the discrepancy in (R12) tends to zero whenever
Z=o(B), provided the main and lifting terms also tend to zero.
For B=n^4 one may take Z=floor(B/(log n)^2), obtaining average
O((log n)^{-2}+n^{-1/2}) and exceptional proportion O(1/log n)
at threshold 1/log n. Here each prime window is finite and depends
on n. Neither the discarded primes above Z nor any prescribed
exceptional integer root has been bounded.

## Dependencies and independent review

The arithmetic input is the established primitive homogeneous
Eisenstein rank/LTE law, together with explicit polynomial root
simplicity and actual block counting. The proof uses simple-root
lifting, an elementary geometric series, and elementary real estimates.
No uniform residue distribution is assumed for the integer roots.
The general bound (R6) was independently checked by the critical
agent before this full manuscript was written. Root requested the
polynomial-window application so that it enters the primitive top-rank
range. The complete written RW1--6 have passed the critical agent's
independent ordinary review, including the actual-window and
exceptional-proportion constants. RW5--6 integrate that agent's
`sixth_round/rank_stratified_root_window.md`, whose complete proof was
independently reviewed here: the norm-one bijection, exact rank root
count, preservation of rank under simple lifting, the exclusion of
p=1 from the progression count, and the cancellation in (R15) all
hold in both split and inert cases. Root's final review remains to
be recorded. No part of this note claims a Lean formalization.
