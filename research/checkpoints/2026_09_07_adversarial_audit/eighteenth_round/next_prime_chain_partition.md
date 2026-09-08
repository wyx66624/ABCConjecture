# NG1–NG5. Actual prime chains and a medium-prime central barrier

Next-only ordinary manuscript, 2026-09-07; outside the frozen publication.
Status: complete proof and author exact replay; root and critical full ordinary
reviews PASS, including critical independent execution of the exact replay.
The preliminary NG1–NG2 gap argument was independently checked by critical.
No unspecified factorization or abstract prime allocation is used below.

For the actual endpoint c=2^e 3^f, e,f>=2, put M=2^e, N=3^f,
A=M/2, B=N/3 and Q=rad(c-1). Retain both full premises

    max(M,N)<2min(M,N)-1,             AB>Q.                    (NG0)

The published DP no-proper-face calculation then gives the exact original
FCRT/SCRT/PBT optimum D+Gamma, where

    D=log(AB/Q)>0,
    Gamma=min_{H|Q} dist(log H,[log(Q/B),log A]).

Each divisor uses each actual prime at most once. Assigning a prime still
assigns its entire prime-power contribution in the original endpoint.

## NG1. The exact maximum gap of the full actual divisor set

Let Q>1 be any squarefree integer with primes p_1<...<p_s. Write
R_i=prod_{j<i}p_j and

    Lambda(Q)=max_i p_i/R_i.

The maximum difference of consecutive logarithms of actual divisors of Q
is exactly log Lambda(Q).

Proof. The divisor-log set after adding p_i is S union (S+a), with
a=log p_i and S having endpoints 0,T=log R_i. If a>T, the sets have
disjoint spans, so the largest gap is max(old gap,a-T). If a<=T, their
spans overlap. Any gap of their union lies inside at least one of the
two spans and is contained in a gap of that set; its length is at most
the old maximum. This gives the upper bound by induction, beginning
with the two divisors of p_1.

For the lower bound, whenever p_i>R_i the two integers R_i and p_i are
consecutive divisors even in the FINAL Q. A divisor below p_i cannot use
p_i or any later prime, so it divides R_i and is at most R_i. Thus this
is an actual gap log(p_i/R_i). At least i=1 has positive gap, and taking
the largest proves equality. QED.

This is an O(number of prime factors) test once the full prime support is
known. It does not assert that factoring Q is easy or replace Q by a
chosen subproduct.

## NG2. A true sufficient arithmetic class, and its limitation

For every real A,B>=1 with AB>Q,

    Gamma <= max(0,log Lambda(Q)-D)/2
          <= max(0,log P^+(Q)-D)/2.                         (NG1)

In particular the full arithmetic class

    p_i <= (AB/Q) R_i   for every actual prime p_i|Q         (NG2)

has Gamma=0. This criterion is about ordered prime factors, not an
assumption that a central divisor already exists.

Proof. The second bound follows from R_i>=1. If Gamma>0, the closed
central interval cannot contain 0 or log Q, since these are divisor
logs. Because A,B>=1 it lies strictly inside [0,log Q]. It lies inside
one open gap (u,v) of the actual divisor-log set. Its length is D, so
the two distances to u and v sum to v-u-D. Their minimum is at most
(log Lambda-D)/2 by NG1. If Gamma=0 the inequality is immediate.
The sufficient condition is exactly log Lambda<=D. QED.

The criterion controls a full class, but its membership has not been
proved for all actual endpoints. It can also miss central successes:
a large gap near an end of the divisor set need not be the required
central gap. The next actual example explicitly exhibits this limitation.

## NG3. A successful nonsquare actual partition outside DP

Take e=41,f=26. The complete factorization is

    c-1=7^2 * 439 * 857 * 2729 * 292183 * 380261663.       (NG3)

All six factors are prime; deterministic certificates are given in NG5.
Both premises (NG0) hold. The full radical has the actual divisor

    H=2729*380261663=1037734078327,
    J=Q/H=7*439*857*292183.

Direct integer comparisons give H<=2^40=A and J<=3^25=B. Hence Gamma=0.
Here D=log(7c/(6(c-1)))>0. Because e is odd, c is not a square and this
endpoint does not belong to the earlier DP square family. Its global
Lambda equals 439/7, which is larger than AB/Q; thus the global-gap
sufficient test (NG2) deliberately does not certify every successful
central partition. This is one actual finite example, not an infinite
nonsquare family claim.

## NG4. A full medium-prime barrier theorem and actual counterexample

The largest-prime cutoff alone does not repair the central gap problem.
Here is an arithmetic theorem accounting for all divisors.

Let Q=qR be squarefree, with q prime and p<r the two smallest prime
factors of R. Suppose A,B>=1, AB>Q and

    prq <= R < r^2 q,               rq>max(A,B).            (NG4)

Then R/r and rq are consecutive actual divisors of Q and

    Gamma=log(rq/max(A,B))>0,
    D+Gamma=log(min(A,B)/(R/r)).                            (NG5)

Proof. A divisor of R smaller than r is either 1 or p, because R is
squarefree and r is its second smallest prime. If H|Q contains q and
H<rq, then H=q d with d|R,d<r, so H<=pq<=R/r. If H omits q and H>R/r,
then R/H is a divisor of R smaller than r; hence H is R or R/p, both
at least rq by (NG4). The strict inequality R<r^2q ensures R/r<rq,
and both endpoints divide Q. This proves consecutiveness for the FULL
radical. Their product is Q. Since rq>A,B, the central interval lies
strictly between their logs. Its distances to the two endpoints are
log(rq/B) and log(rq/A). Their minimum gives (NG5); adding D gives the
second formula. QED.

Now take e=123,f=78, the cube of the previous c. Put

    q=257077829249200341434761489003997119,
    R=7*31*439*857*919*2729*292183*380261663*4266021703.

The complete factorization is c-1=7qR, so Q=qR, with no omitted cofactor.
Here p=7,r=31. Both (NG0) and (NG4) hold by exact integer comparisons.
More strongly, every prime factor of Q is at most q and

    20q < min(A,B),                                         (NG6)

where

    A=5316911983139663491615228241121378304,
    B=5474401089420219382077155933569751763.

The consecutive bracket is

    R/31=3130566812026385226903752016561167657,
    31q =7969412706725210584477606159123910689.

Since B>A,

    D=log(7c/(6(c-1))),
    Gamma=log(31q/B),
    Gamma>2D>0,             D<log(6/5)<1.                    (NG7)

The strict comparison is made without decimal logs:

    31q * [6(c-1)]^2 > B*(7c)^2.

Likewise 7c< (36/5)(c-1) proves the displayed D bound. The exact balance
margin 2min(M,N)-1-max(M,N) is
4844444664297995820229445163776257926, which is positive.
All these integer comparisons are checked by the verifier, as are the
1024 actual divisors and their consecutive bracket. The explicit proof
above additionally explains why the bracket is complete without relying
on a near-center search heuristic.

Thus even (NG0), c nonsquare, 0<D<1, and P^+(Q)<min(A,B)/20 do not imply
Gamma=0 or Gamma<=D. This excludes exactly those strengthened statements.
It does not refute any bound with an arbitrary additive C_epsilon, prove
an infinite family with large normalized cost, or disprove ABC. It also
does not exclude a different certificate whose legal construction and
once-only prime accounting still need to be proved. In the existing
certificate (NG0), NG5 is the exact optimum, not a poor assignment choice.

## NG5. Complete deterministic primality and endpoint certificates

The standalone standard-library verifier is
`next_replay_medium_partition.py`, with input
`next_verification/medium_prime_lucas_certificate.json`.
It checks 47 prime nodes and 134 witnesses: base 2, 45 full p-minus-one
nodes and one full Gaussian norm-one p-plus-one node. No probable-prime
predicate or factorization routine is used by the verifier. Candidate
factorizations used during generation are not assumptions in its proof.

For the minus-one nodes, the complete predecessor criterion and proof
are exactly the Lucas lemma proved in the published LP section. For
clarity the plus-one criterion is proved here as well.

Let m>2 be odd, with the complete factorization of m+1 into already
proved smaller primes. For every r|m+1 supply z_r=a_r+b_r i in
(Z/mZ)[i] such that

    a_r^2+b_r^2=1 mod m,
    z_r^(m+1)=1,
    gcd(N(z_r^((m+1)/r)-1),m)=1.                            (NG8)

Then m is prime. Indeed, for any prime ell|m, ell is odd. The algebra
F_ell[i] is either the split product F_ell x F_ell or the quadratic
field F_(ell^2), as X^2+1 has no repeated root. Its norm-one group has
order ell-1 in the split case and ell+1 in the field case: in the
former it is {(u,u^(-1))}; in the latter it is the kernel of the
surjective finite-field norm, of size (ell^2-1)/(ell-1).
The first two conditions place each reduced z_r in that group with
order dividing m+1. The last condition makes z_r^((m+1)/r)-1 a unit
modulo ell, hence nonzero. Thus the order contains the FULL r-adic
part of m+1. Applying this for every r gives m+1 dividing the group
order ell-1 or ell+1. Therefore ell>=m. Since ell|m, ell=m and m is
prime. This proof does not assume a Jacobi-symbol test proves primality.

The sole plus-one node is

    m=13098839766085821942054493478243,
    m+1=2^2*3^5*7*23*1427*10691*40507*135446661817793.

All its factors are earlier proved nodes. The top endpoint prime has
q-1=2*3*3271*m, a full minus-one node. Gaussian powers and norms are
computed by literal integer-pair multiplication modulo m; each witness
is checked, rather than relying on its method of construction.

The verifier checks both full c-1 factorizations, primitivity, source
balance, positive D, nonsquareness, all 64 and 1024 divisors respectively,
the exact maximum-gap formula, all central memberships and all strict
rational comparisons. Both generation and read-only --check returned
PASS. The canonical output SHA256 is

    26d04f39748d763f5139794465afb78058f18474567b629f6937abcae2ec9af2.

These are two certified finite endpoints and elementary complete proofs
of the stated classes. No Lean claim, prime-value infinitude, complete
ABC result, or change to the frozen publication is made.
