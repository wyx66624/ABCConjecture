# Independent review of the prime-power progression theorem

Date: 2026-09-07. Complete ordinary review of PP1--PP5: PASS.
No mathematical correction was required. This review changes no source
outside the reviewer's checkpoint.

The complete reviewed source is
`2026_09_07_signed_compatibility/prime_power_progression.md`, SHA256
`59ee307be31c6a150bcea05b11a22f51a8985562fad63af8de33e62ed633990d`.
The version reviewed includes the additional PP5 for arbitrary positive
common exponents. The preceding CE, SA, AC and exact homogeneous
rank/LTE results were already independently reviewed; the specific
dependencies used below have been checked again against this statement.

## Top factor and the exceptional prime

All bases are positive integers; p>=5 is prime, k>=1,
n=p^k and m=p^(k-1), so n=pm. Actual primitivity gives
gcd(M,abc)=gcd(M,F)=1 and hence gcd(Q,R)=1. The identity
F-M^2=ab*c^2 is strictly positive, which gives Q>R^2.

With X=Q^m and Y=R^(2m), the factor S is exactly the homogeneous
Phi_p(X,Y)=Phi_(p^k)(Q,R^2), and D=X-Y is positive. The identity
DS=ab*c^2 retains the complete product, including all lower factors
inside D; it does not replace those factors by a radical.

For q dividing S, both Q and R are q-units. For q!=p, putting
t=Q/R^2 gives t^n=1 but t^m!=1, because the geometric sum at
t^m=1 would be p!=0 in F_q. Every proper divisor of p^k divides m,
so the order is exactly n, rather than merely a multiple of p.
Consequently q=1 modulo n. This argument also rules out any small
prime such as 2 that cannot have that order; it requires no separate
unstated exclusion.

In characteristic p the same sum is (X-Y)^(p-1). Thus p divides S
if and only if p divides D. In that case X,Y are p-units. In the
expansion in D, the first term pY^(p-1) has valuation one, the
intermediate terms have both factors p and D, and the last term
D^(p-1) has valuation at least p-1>=4. The exact depth of S at p
is therefore one, independently of k and of the depth of D. The
case k=1 is included. No p contribution was silently removed.

## Full bad part at the finer modulus

For every prime outside 1 modulo n other than p, the depth of S is
zero. At p it is at most one. Applying DS=ab*c^2 prime by prime
therefore gives U=(ab*c^2)_bad(n) dividing pD, at full depth.
In particular c_bad(n)^2 divides U.

Every term of S is at least R^(2m(p-1)). Combining its p terms
with the actual certificate

    4M^2-9ab*c^2=(a-b)^2(4a^2+7ab+4b^2)>=0

gives D<=4R^(2m)/(9p) and U<=4R^(2m)/9. Taking positive square
roots and using M=R^n<c^2 proves

    c_bad(n)<=2R^m/3 < (2/3)c^(2/p).

The exponent 2/p stays fixed as k grows. The improvement is the
finer modulus n, not a claim that the bound becomes c^(2/n).

## Actual root and the inert rank-one exception

The pure first norm excludes the ramified prime, since a primitive
first norm divisible by 3 has exact 3-adic depth one, incompatible
with exponent n>=5. Primitive Eisenstein factorization then gives
a+b*zeta=u*w0^n, with every oriented exponent divisible by n.
Because gcd(n,6)=1, the unit has an n-th root among the six units.
It can be absorbed to obtain the exact identity w^n=a+b*zeta.
The resulting primitive unramified nonunit root has norm R>=7.

The two SA arm identifications remain valid for the full n: if
n=1 modulo 6, c is the sum arm and ell=x+y; if n=5 modulo 6,
the normalized output is bar(w)^n=(c,-b), so c is the first arm
and ell=x. Thus c=ell*D_j with the actual integral SA quotient.
Signs are harmless because valuations use absolute values.

For q in J, q=1 modulo n but q!=1 modulo 6n. Such q is odd,
greater than n, distinct from 3 and p, and coprime to R by
gcd(M,c)=1. A split q would also be 1 modulo 3 and therefore
1 modulo 6n. Hence q is inert. Its cubic boundary rank d divides
n, while the inert norm-one group gives d dividing (q+1)/3.
Since q+1=2 modulo p, gcd(n,q+1)=1, forcing d=1. This step
correctly handles all intermediate ranks p^j, not only 1 and n.

The exact homogeneous valuation law gives

    v_q(T_n)=v_q(T_1)+v_q(n)=v_q(T_1).

Consequently the product of all actual quotient arms has zero
q-valuation. Each arm is an integer, so each individual depth is
zero. From c=ell*D_j one gets v_q(c)=v_q(ell) at full depth.
Multiplication over J proves J divides |ell|. The actual identities
4R-3(x+y)^2=(x-y)^2 and 4R-3x^2=(x+2y)^2 give 3J^2<=4R.

## Product budget, limits, and the full-exponent height bound

The supports of c_bad(n) and J are disjoint and partition exactly
the primes outside 1 modulo 6n, with complete valuations. Their
product is c_bad(6n). Squaring the earlier bounds yields

    27*c_bad(6n)^2<=16*R^(2m+1).

Using R<c^(2/n) therefore gives the stated strict mass estimate

    log c_good(6n) > (1-2/p-1/n)log c+log(3sqrt(3)/4).

Its constant exceeds one before logarithms, and 1-2/p-1/n>0
for n>=p>=5. Hence there is an actual prime q dividing c with
q=1 modulo 6n, so q>=6n+1. This existence refers to one prime
in the good part, not to every prime dividing c.

At fixed p and k tending to infinity the guaranteed fraction
approaches 1-2/p. The theorem correctly does not assert that the
actual fraction has this limit, or that it tends to one. When p
also tends to infinity the lower bound and the trivial upper
bound one do force the fraction to tend to one. Unequal pure
exponents may be replaced by any common prime-power divisor,
using positive integer substituted bases.

PP5 is independently correct for every positive integer n, including
n=1. Its complete geometric sum has n terms each at least
R^(2n-2). Cancelling this positive quantity in the actual norm
identity gives 9n(Q-R^2)<=4R^2. Integrality supplies Q-R^2>=1,
hence R^2>=9n/4. Finally R^n=M<c^2 gives

    log c > (n/4)log(9n/4).

PP5 needs no primality, order, valuation or unramified-root argument.
It is a lower bound on height, not an upper bound or a contradiction.

## Review scope

This is an ordinary proof review. The full valuation and rank inputs
are previously established ordinary results, not claimed to have
been formalized here. No finite search or external analytic theorem
is used to justify the conclusion. The surviving progression can
still carry large multiplicities. Uniform control of its radical,
existence or general membership, and a height upper bound remain
unproved. Ramified first norms, nonunit residuals and relatively
prime exponents remain distinct open branches. No ABC proof or
disproof follows from these necessary conditions.
