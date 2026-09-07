# A sieved endpoint for actual rank-stratified root blocks

Status: ordinary proof, 2026-09-07. The complete SW1--SW3 proof, including
the primary sieve source and the index subclasses, passed independent review by
`adversarial_audit`. This note extends the sixth-round actual block
estimate; it does not change that frozen transcription. The new external
input is the established Brun--Titchmarsh inequality. No full ABC or
single-root tail assertion is made.

## SW1. Exact scope and established sieve input

Let n,B be positive integers. For every integer B<=k<2B put

    w_k=3k+zeta,  Q_k=N(w_k)=9k^2+3k+1,
    T_n(k)=|P(w_k^n)|,  t_k=log c_n(k),

where c_n(k) is the largest positive side of the primitive triple
obtained by sector normalization. The sixth-round proof gives

    t_k >= n log(3B),
    log|P(w_k^d)| <= 3d log(6B+1).                            (SW1)

All these are actual integer roots, with primitive unramified powers.
In particular, the boundary is nonzero and no probabilistic model is
substituted for the interval. For real 5<=Y<=Z define the nonnegative
window cost

    F_YZ(k)=sum_{Y<p<=Z} (v_p(T_n(k))-3)_+ log p.

The classical inequality needed here is, for integers q>=1 and a
coprime to q and every real X>q,

    pi(X;q,a) <= 2X/[phi(q) log(X/q)].                        (SW2)

I actually opened Montgomery--Vaughan, *The large sieve*, Mathematika
20 (1973), 119--134, Theorem 2, printed page 121, equation (1.10),
at the author's primary PDF:

https://personal.science.psu.edu/rcv4/personal/Publications/large_sieve.pdf

That theorem gives the stronger interval form for positive real x,y
with y>q. To get (SW2), take x tending to zero and y=X-x; the left
side is pi(X;q,a) once x<2, and the right side tends continuously
to the expression displayed. No asymptotic or fixed-modulus
qualification is inserted into (SW2).

## SW2. The sieved actual mean bound

Assume in addition that Z>3n. Write sigma(n)=sum_{d|n}d. Then

    (1/B) sum_{B<=k<2B} F_YZ(k)/t_k
       <= 10 log Y/[Y^3 log(3B)]
          +36 Z sigma(n)/[B n log(Z/(3n))]
          +log n/[n log(3B)].                                (SW3)

Proof. The sixth-round exact-rank lemma says that, at p>3, the
number of root parameters modulo p with rank exactly d is
`3 phi(d)-1_(d=1)` when `d | (p-chi(p))/3`, and zero otherwise.
Here chi(p)=(-3/p). Every such root is simple and lifts uniquely;
its actual first depth is the valuation of P(w_k^d). The corresponding
interval contribution to positive first-depth cost is at most

    3 phi(d) B log p/[p^3(p-1)]
       +9 phi(d)d log(6B+1).                                 (SW4)

This follows from the actual count `3 phi(d)(B/p^e+1)` at depth
e and the height cap in (SW1). The sum over e>=4 is the positive
cost. For a fixed prime, sum phi(d) over the allowed divisors d|n;
it is at most n by the divisor identity for phi. Summing the first
term of (SW4) therefore gives exactly the first term of (SW3),
with the same generous constant ten as in the sixth-round proof.

For the endpoint term, sum over ranks first. A rank-d prime must
belong to one of the two reduced residue classes 1,-1 modulo 3d.
These classes are distinct since 3d>=3. By (SW2), their total
number through Z is at most

    4Z/[phi(3d) log(Z/(3d))].                                (SW5)

The premise Z>3n makes this legitimate for every d|n. Moreover
phi(3d) equals 2 phi(d) if 3 does not divide d and equals
3 phi(d) otherwise. Thus the total endpoint contribution before
normalization is at most

    36 Z log(6B+1) sum_{d|n}
       d phi(d)/[phi(3d) log(Z/(3d))]
      <= 18 Z sigma(n) log(6B+1)/log(Z/(3n)).                 (SW6)

Divide by B n log(3B) and use `6B+1 <= (3B)^2`. This proves
the middle term of (SW3). Finally the actual lifting beyond first
depth is bounded at each root by `sum_p v_p(n) log p=log n`.
The inequality `(s+u-3)_+ <= (s-3)_+ + u` accounts for this
without imposing any condition on the first depth. This gives the
last term of (SW3) and finishes the proof.

The two available endpoint estimates can be minimized: when Z>3n,
one may replace the middle term by

    min(12(Z+1)/B,
        36Z sigma(n)/[B n log(Z/(3n))]).                      (SW7)

This is an improvement in the count of eligible primes, not an
assumption that their actual high depths are rare or simple.

## SW3. A window beyond the root-parameter interval length

Let n tend to infinity through any integers satisfying
sigma(n)/n<=C for a fixed constant C. Prime indices and prime-power
indices are concrete examples: sigma(q^j)/q^j <= q/(q-1)<=2.
Set

    B=n^4,  Y=n^(1/6),  Z=floor(B sqrt(log n)).

For all sufficiently large n the premises of (SW3) hold. Its first
term is at most `5/(12 sqrt(n))`; its last is at most `1/(4n)`.
Since `Z/B <= sqrt(log n)` and

    log(Z/(3n)) = 3 log n + (1/2)log log n - log 3 + o(1),

the middle term is `O_C((log n)^(-1/2))`. Consequently

    mean_k F_YZ(k)/t_k = O_C((log n)^(-1/2)).                 (SW8)

Markov's inequality gives

    proportion {k : F_YZ(k)/t_k > (log n)^(-1/4)}
       = O_C((log n)^(-1/4)).                                (SW9)

Here Z/B tends to infinity. Thus this actual block result controls
a prime window extending beyond the length B of the integer-root
interval. For prime index n, it extends beyond the first possible
primitive top-rank progression; no prime existence inside that window
is assumed. The root norms are comparable to n^8 and
the homogeneous compression parameter is 1/n.

## Dependency chain and remaining arithmetic gate

The new chain is: actual primitive roots and height cap -> exact-rank
simple-root counts -> actual interval depth counts -> Brun--Titchmarsh
on the rank-dependent progressions -> the finite-window mean bound.
The totient in the sieve denominator removes the exact-rank root
count, leaving the divisor sum sigma(n). Bounded sigma(n)/n is
verified for the displayed index subclasses, not assumed for all
integers. Formula (SW3) itself is valid for every positive n with
the stated Z premise.

This still leaves every prime above Z and every exceptional root.
In particular it does not bound a prescribed actual root's net
top-layer packet. The elementary cyclotomic size bound is only a
linear budget, and the existence of one primitive prime divisor only
gives a logarithmic radical saving. Neither is silently promoted
to the required sublinear signed-tail estimate. The global gate
remains open.
