# Ordinary arithmetic bridge before the residual-bill formalization

This is the finite actual-prime counterpart of IL2. The oriented UFD
calculation supplying the local reflection law remains an ordinary theorem.
It must appear as an explicit local premise, not an axiom or an assumption
of the desired global divisibility.

For positive integers n,a,f and nonnegative integers b,r, suppose
|a-nf|=b+nr. Then n<=a+b. If a>=n the claim is immediate. Otherwise
nf>=n>a, and the equality becomes a+b=n(f-r)>0. A positive integer
multiple of positive n is at least n. All three positivity assumptions
are part of the domain.

Let C,V,Vprime,R,Rprime be positive natural numbers and n>0. At each
actual prime p dividing C suppose a=v_p(V)>0, f=v_p(R)>0 and
|a-nf|=v_p(Vprime)+n*v_p(Rprime). The previous inequality gives
n<=v_p(V)+v_p(Vprime)=v_p(V Vprime). Thus p^n divides V Vprime.
The powers of distinct primes are coprime, so multiplying over the
actual support of C proves

    (product over p in C.primeFactors of p)^n divides V Vprime.

The product is the actual radical of C, not C itself. The proof can be
formalized using Nat.factorization, Int absolute value, finite products,
and pairwise coprimality of distinct primes. No prime allocation outside
the displayed local reflection law is assumed.

If every prime divisor of C is at least seven and V Vprime<7^n, then
C=1. Otherwise choose an actual prime divisor p of C. Since p divides
the radical, 7^n<=p^n<=rad(C)^n<=V Vprime, a contradiction. This is
the exact integer form of the strict joint logarithmic residual threshold.
No conversion of the real-log threshold is claimed until separately proved.

The ordinary norm-seven family realizes the sharp local bill with a=f=1,
b=n-1 and r=0. It is still a single-map family, not a double-profile seed.
The proposed formal bridge does not formalize the entire UFD, general
integral inverse, positive-sector normalization or actual point existence.
