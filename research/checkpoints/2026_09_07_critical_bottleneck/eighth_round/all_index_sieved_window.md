# A sieved actual root window for every exponent index

Status: ordinary proof independently reviewed in full by adversarial_audit,
2026-09-07. The review includes the Euler-product constants, partial
summation endpoints, floor in Z and all-index Markov quantifiers.
This extends the index scope of the preceding sieved interval estimate.
It does not change the frozen seventh-round theorem and does not control
the full tail or a prescribed exceptional root.

## AW1. An elementary uniform divisor-sum estimate

For every integer n>=8,

    sigma(n)/n <= exp(18) [1+log log n].                    (AW1)

Only the previously proved elementary bound theta(x)<=3x is needed,
together with the Euler product for zeta(s), s>1. The large constant
is deliberately loose and is not an optimization claim.

Proof. For x>=2 set s=1+1/log x. The positive logarithmic series gives

 log product_{p<=x}[(1-p^(-s))/(1-p^(-1))]
   =sum_{p<=x} sum_{j>=1}(p^(-j)-p^(-sj))/j
   <=(s-1) sum_{p<=x} log p/(p-1),                        (AW2)

using 1-exp(-u)<=u for u>=0. Since p/(p-1)<=2,

 sum_{p<=x} log p/(p-1)
   <=2[theta(x)/x+integral_2^x theta(t)/t^2 dt]
   <=6+6 log x.

Thus the right side of (AW2) is at most 6+6/log 2<15. The finite
Euler product with factors (1-p^(-s))^(-1) is at most zeta(s), and
the elementary integral comparison gives zeta(s)<=1+1/(s-1).
Consequently

    product_{p<=x}(1-1/p)^(-1)<=exp(15)(1+log x).          (AW3)

Now set x=log n>=2. If k distinct prime factors of n exceed x,
then k log x<=log n=x. Their additional logarithmic product is at most

 sum_{p|n,p>x} -log(1-1/p)
   <=sum_{p|n,p>x}1/(p-1)
   <=x/[(x-1)log x]<=2/log 2<3.                           (AW4)

Finally sigma(n)/n<=product_{p|n}(1-1/p)^(-1). Combining (AW3)
and (AW4) proves (AW1). This is a standard elementary Euler-product
argument specialized to the constant needed here; no new maximal-order
theorem for sigma is claimed.

## AW2. A uniform actual window beyond the root-interval length

For each n>=1 and integer B>=1, keep the actual primitive roots
w_k=3k+zeta for B<=k<2B, their boundary T_n(k), and largest-side
height t_k. The seventh-round theorem gives, when 5<=Y<=Z and Z>3n,

 mean_k [sum_{Y<p<=Z}(v_p(T_n(k))-3)_+ log p]/t_k
   <=10 log Y/[Y^3 log(3B)]
       +36 Z sigma(n)/[B n log(Z/(3n))]
       +log n/[n log(3B)].                               (AW5)

Let n tend to infinity through all positive integers, with no
subsequence condition. Set

 B=n^4, Y=n^(1/6),
 Z=floor[n^4 sqrt(log n)/(1+log log n)].                  (AW6)

Then Z/B tends to infinity, Z>3n eventually, and

    mean_k [sum_{Y<p<=Z}(v_p(T_n(k))-3)_+ log p]/t_k
       =O((log n)^(-1/2)),                               (AW7)

with an absolute constant. The proportion of actual roots whose
normalized cost exceeds (log n)^(-1/4) is O((log n)^(-1/4)).

Proof. The first and third terms in (AW5) are at most 5/(12 sqrt n)
and 1/(4n). The factor 1+log log n in (AW1) is canceled by its
appearance in the denominator of Z in (AW6). Moreover

 log(Z/(3n))=3 log n+(1/2)log log n
               -log(1+log log n)-log 3+o(1)
             ~3 log n.

The middle term is therefore O((log n)^(-1/2)) uniformly for all n.
Markov's inequality proves the stated exceptional proportion. This
uses the actual root-block estimate, not independence of valuations
or uniform distribution of the power-map output.

## Remaining scope

The earlier larger window B*sqrt(log n) remains available on the
bounded sigma(n)/n subclasses. The present slightly smaller window
works at every exponent index. Both extend beyond the integer-root
interval length. Both still leave all primes above their specified
endpoint and their explicitly allowed exceptional roots. In particular
neither gives the signed radical saving for one actual top-rank packet.
The elliptic residual-class and modular-congruence routes remain
independent of this analytic average argument.
