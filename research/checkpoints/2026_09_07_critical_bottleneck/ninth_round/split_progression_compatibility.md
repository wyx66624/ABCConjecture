# AC1--AC3. The first power norm sharpens common-exponent support to 1 modulo 6p

Date: 2026-09-07. Ninth-round ordinary proof submitted for independent review.
This is a joint use of the actual arm-quotient structure SA1 and the
independent-route common-exponent allocation CE1--CE3. No modularity or
prime-density statement is used.

Let a,b be positive coprime integers, c=a+b, and suppose

    M=a^2+ab+b^2=R^p,
    F=a^4+3a^3b+5a^2b^2+3ab^3+b^4=Q^p,                (AC1)

where p>=5 is prime and R,Q are positive integers. For a modulus m, write

    c_bad(m)=prod_{q prime, q not=1 mod m} q^{v_q(c)},
    c_good(m)=c/c_bad(m).

These are full prime-power parts. The conclusions below are necessary
conditions for the stated actual seeds, not an assertion that such seeds
exist or that all large moving prime factors can be excluded.

## AC1. A single actual input arm controls the new excluded primes

There exists a primitive unramified Eisenstein integer w=x+y*zeta of
norm R, with w^p=a+b*zeta. Define the actual input arm

    ell=x+y     if p=1 mod 6,
    ell=x       if p=5 mod 6.                            (AC2)

It is a nonzero integer and

    J=prod_{q|c, q=1 mod p, q not=1 mod 6p} q^{v_q(c)}
        divides |ell|,
    |ell| <= (2/sqrt(3))*sqrt(R).                        (AC3)

Proof of the power root. The established Eisenstein factorization applies
to the actual primitive element a+b*zeta. A primitive element has no inert
rational factor and no pair of conjugate split factors. Its valuation at the
ramified rational norm prime 3 is at most one: if 3 divides M, primitiveness
gives a=b nonzero modulo 3, and direct expansion gives v_3(M)=1. This is
incompatible with M=R^p. Hence the element is unramified. Each remaining
oriented split-prime exponent is divisible by p because its norm exponent
is divisible by p. Unique factorization therefore gives a+b*zeta=u*w_0^p
with N(w_0)=R and unit u in mu_6. Since gcd(p,6)=1, the p-th power map
on mu_6 is bijective; absorb a unit p-th root into w_0. The resulting w
has the asserted norm and remains primitive and unramified. It is not a
unit because M>=3. In particular its actual norm R is at least seven,
and all its boundary arms are nonzero.

Apply SA1 to this w and n=p. If p=1 modulo 6, the sum of the normalized
output coordinates is c, and the corresponding input arm is x+y. If p=5
modulo 6, the normalized output is bar(w)^p=bar(a+b*zeta), whose first
coordinate is c. Its corresponding input arm is x. Thus in both cases

    c=ell*D_j,
    T_p/T_1=|D_1D_2D_3|,                               (AC4)

for the actual quotient arms in SA1. Signs are allowed in ell,D_j.

Take a prime q in the product J. Since q=1 modulo the odd prime p and
q is prime, q>=2p+1>3 and q is different from p. If it split in the
Eisenstein field then q=1 modulo 3 as well as modulo p. Its oddness would
then imply q=1 modulo 6p. Consequently q is inert, so q=2 modulo 3.
Also gcd(M,c)=1 gives q not dividing R.

The established actual homogeneous rank law is available at q. Let

    d_q=ord((w/bar(w))^3 modulo q).

Because q divides the boundary at exponent p, d_q divides p. In the
inert case the norm-one residue group is cyclic of order q+1, and its
cube subgroup has order (q+1)/3. If d_q=p, this would force
p|(q+1)/3, impossible since q+1=2 modulo p. Therefore d_q=1.
The exact homogeneous valuation law gives

    v_q(T_p)=v_q(T_1)+v_q(p)=v_q(T_1).

It follows from (AC4) that every D_i has zero q-valuation: their
nonnegative valuations sum to that of T_p/T_1, which is zero. The actual
identity c=ell*D_j therefore gives v_q(c)=v_q(ell). This proves J|ell
with the full valuations, not merely the radical divisibility.
Finally each input arm has absolute value at most
(2/sqrt(3))*sqrt(N(w)), proving the numerical bound in (AC3).

## AC2. Almost all denominator mass lies in a split progression

The preceding CE theorem, applied to exactly (AC1), gives

    c_bad(p) <= (2/3)R.                                 (AC5)

For clarity, its proof uses D=Q-R^2>0 and
S=sum_{j=0}^{p-1}Q^{p-1-j}R^{2j}, so DS=ab*c^2. Every prime factor
of S other than p has exact multiplicative order p for Q/R^2; its only
possible factor outside 1 modulo p is a single p. Hence the full bad part
of ab*c^2 divides pD. The inequalities
S>=pR^(2p-2) and ab*c^2/M^2<=4/9 give pD<=4R^2/9, proving (AC5).
This restatement retains the full p-exception.

The parts c_bad(p) and J have disjoint prime supports and their product
is exactly c_bad(6p), since the progression 1 modulo 6p is contained in
the progression 1 modulo p. Therefore (AC3) and (AC5) imply

    c_bad(6p) <= (4/(3*sqrt(3)))*R^(3/2),
    c_good(6p) >= (3*sqrt(3)/4)*c/R^(3/2)
                 > (3*sqrt(3)/4)*c^(1-3/p).             (AC6)

The last inequality is strict because M=c^2-ab<c^2, so R<c^(2/p).
In particular c_good(6p)>1 for p>=5, and c has an actual prime divisor
q congruent to 1 modulo 6p. Such a prime satisfies q>=6p+1. The precise
valuation-mass conclusion is

    sum_{q|c, q=1 mod 6p} v_q(c)log q
       > (1-3/p)log c+log(3*sqrt(3)/4).                  (AC7)

The leading retained fraction tends to one as p grows. Unlike a density
statement about all primes, (AC7) concerns the full valuations of this
actual seed, uniformly for its moving roots and exponent.

## AC3. Unequal exponents and remaining scope

If M=A^h and F=B^g have arbitrary positive integer bases and exponents
h,g>=2, every prime p>=5 dividing gcd(h,g) yields (AC1) by setting
R=A^(h/p), Q=B^(g/p). Thus (AC6)--(AC7) hold for each such common
prime, whether or not it equals h or g. For any sequence with chosen
common prime divisors p tending to infinity, the left side of (AC7)
divided by log c tends to one, since it lies between 1-3/p and 1.

This conclusion uses the first norm's actual oriented power root in
addition to the second norm's cyclotomic difference. It is not obtained
by treating two unrelated congruence conditions as independent. The loss
from the CE progression 1 modulo p to the finer split progression 1
modulo 6p is paid by one specific input arm of height at most half log R.

Primes already in that input arm have been retained in the bound, including
all their depths. Large new primes in the surviving progression are still
possible, and their radical and multiplicities are not bounded sufficiently
for ABC. The common-prime condition, pure first norm, and pure second norm
are essential to the displayed proof. The ramified first norm 3*A^h,
nonunit residuals, and relatively prime exponents are not addressed here.
No failure of those other branches is inferred from these hypotheses.
