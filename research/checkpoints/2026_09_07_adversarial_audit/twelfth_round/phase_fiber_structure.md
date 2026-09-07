# PF1--PF4. Exact positive phase fibers and their denominator boundary

Status: complete ordinary proof submitted for independent review. This is
twelfth-round work; all eleventh-round files remain frozen. The input is
the actual root block used in MC, not an arbitrary replacement random model.
No prime-power membership is asserted for the explicit collision examples.

Write zeta^2-zeta+1=0. The product of (a+zeta) and (b+zeta) is

    (ab-1)+(a+b+1)zeta.

Its positive rational phase is (ab-1)/(a+b+1). Let B be a positive
integer and put A_B={3k:B<=k<2B, k an integer}. Thus its smallest and
largest elements are 3B and 6B-3. A fiber below consists of ordered
pairs in A_B^2; an unordered pair permits a=b and is counted once.

## PF1. Exact divisor parameterization, including the block congruence

Let u,v be coprime positive integers and K=u^2+uv+v^2. Positive integer
pairs of phase u/v are in bijection with positive divisors P of K satisfying

    P == -u (mod v).

The maps are

    P=va-u, Q=vb-u,        a=(P+u)/v, b=(K/P+u)/v.       (PF1)

Indeed the phase equation gives

    (va-u)(vb-u)=K,
    b(va-u)=u(a+1)+v>0,
    a(vb-u)=u(b+1)+v>0.

Thus P,Q are positive. Conversely gcd(P,v)=1 follows from the proposed
congruence and gcd(u,v)=1. Since K==u^2 (mod v), the equation PQ=K
forces Q==-u (mod v). Both reconstructed coordinates are positive
integers, and expansion of PQ=K gives their phase equation. These maps
are inverse, so the second coordinate and the ordering are retained.

If a,b are multiples of three, reduction of the fraction implies

    u+v == 0 (mod 3),       3 does not divide uv.           (PF2)

To see this, the unreduced numerator is -1 modulo 3 and the denominator
is 1 modulo 3, so their gcd is prime to 3 and division preserves the
negative ratio. Under (PF2), the exact divisor condition for multiples
of three is

    P == -u (mod 3v).                                    (PF3)

The condition on Q is again automatic: gcd(u,3v)=1 and
K-u^2=v(u+v) is divisible by 3v. Finally the exact block conditions are

    3vB-u <= P < 6vB-u,   3vB-u <= K/P < 6vB-u.           (PF4)

Positive P and Q must still be required when testing a candidate phase
before knowing that its block fiber is nonempty. For a nonempty actual
fiber the lower endpoint in (PF4) is strictly positive, as proved next.
Failure of (PF2) means the block fiber is empty; no extra splitting-prime
heuristic is part of this bijection.

## PF2. Denominator-sensitive cardinality and a genuine injective subclass

Every nonempty actual block fiber satisfies

    (9B^2-1)/(6B+1) <= u/v
        <= ((6B-3)^2-1)/(12B-5),
    B < u/v < 3B.                                      (PF5)

For fixed b the difference of the phases at a and a' is

    (a-a') (b^2+b+1)/[(a+b+1)(a'+b+1)].

This proves the first bounds by monotonicity in both coordinates. The
lower endpoint exceeds B because 3B^2-B-1>0 for B>=1. For the strict
upper bound, (ab-1)/(a+b+1)<ab/(a+b)<3B when a,b<6B. In particular
L=3vB-u>0 for every nonempty fiber. With U=6vB-u, one may equivalently
intersect the congruent positive divisors with

    L<=P<U,       K/U<P<=K/L.

A second, sometimes stronger bound comes from the actual sum. Put
s=a+b+1. A fiber of the reduced phase u/v has v|s, s==1 (mod 3), and

    6B+1 <= s <= 12B-5.

Because 3 does not divide v, such sums form one residue progression of
step 3v. For each fixed sum s, the phase determines ab=us/v+1. The
quadratic X^2-(s-1)X+(us/v+1) has at most one unordered pair of integer
roots. Consequently

    # unordered pairs <= 1+floor((2B-2)/v),
    # ordered pairs <= min(tau(K), 2[1+floor((2B-2)/v)]). (PF6)

Here tau(K) is the number of positive divisors of K. The interval length
is 6B-6, so the progression bound includes both endpoints and also the
B=1 case. Diagonal pairs contribute one ordered pair, never two, which
only strengthens the upper bound. In particular, if v>2B-2, the phase
fiber has at most one unordered pair. This is a proved subclass, with
an explicit denominator condition, rather than a general injectivity
claim.

The estimate has not been shown to improve the global MC bound: small
phase denominators are actual possibilities. Bounding their incidence
among a chosen deep-root set remains a separate question.

## PF3. Actual repeated fibers disprove two specific stronger claims

Take n=7, B=n^4=2401. The previously identified phase u/v=4526/1 has

    K=20489203=7^2*67*79^2,
    (a,b)=(7809,10767), (8397,9819),
    (P,Q)=(3283,6241), (3871,5293).

Every displayed coordinate lies in A_B. It disproves injectivity even
after removing the interchange (a,b)<->(b,a).

A further actual phase u/v=4799/1 has

    K=23035201=7*19*31*37*151,
    (a,b)=(7668,12828), (8922,10386), (9480,9720),
    (P,Q)=(2869,8029), (4123,5587), (4681,4921).

All six coordinates are multiples of three in [7203,14406), and direct
multiplication gives PQ=K in each row. Substitution in (PF1) verifies
the phase exactly. There are therefore at least three distinct unordered
pairs and six ordered pairs. This disproves the unconditional claim
that every actual block phase fiber has at most two unordered pairs.
The denominator condition in PF2 is not met in either example.

The accompanying exact replay fully factors these two integers and
enumerates their divisors. Its optional bounded search covers only the
1201 integer phases u==2 (mod 3) in [floor(3B/2),3B), not all rational
phases. Neither example asserts fourth-depth membership at a common
prime, multiplicative dependence of all block ratios, or a counterexample
to the signed-tail gate. No finite search proves a uniform fiber bound.

## PF4. Several marked primes: the finite implication and its limitation

Let S be any subset of A_B. Let H be a finite set with a binary operation,
and assign an image phi(a) in H to each a in S. Suppose m>864B^3 is an
integer and equal pair images imply

    m | (ab-1)(c+d+1)-(cd-1)(a+b+1).                (PF7)

The actual height bound makes this determinant zero. Thus every nonempty
image fiber is contained in one actual rational phase fiber, and (PF6)
can be applied to its reduced denominator. In particular, for a positive
integer v0, let E_<v0 count the ordered pairs in S^2 whose reduced phase
denominator is less than v0. Then

    |S|^2 <= E_<v0 + 2|H|[1+floor((2B-2)/v0)].     (PF8)

Proof: discard the low-denominator pairs and partition the rest by their
image in H. Each occupied image has a single phase, of denominator at
least v0, and contributes at most the second term's factor by PF2.
This is a finite implication with its genuine low-denominator remainder
displayed. No unproved estimate on E_<v0 is assumed or inferred.

For the MC prime-power application, take distinct primes q_i>3 with
q_i not dividing n, precisions e_i>=1, and actual simultaneous conditions
q_i^e_i | T_n(a), where T_n(a) is the absolute cubic boundary of
(a+zeta)^n. Such a hit forces N(a+zeta) to be a unit modulo q_i: a
vanishing conjugate together with the cubic equality would force both
conjugates zero, impossible since their difference is a unit at q_i>3.
The ratio (a+zeta)/(a+bar(zeta)) therefore exists and lies in the
3n-torsion group H_i of the norm-one units modulo q_i^e_i.

The reviewed MC finite-ring argument gives

    |H_i|=gcd(3n,q_i-chi_i),

where chi_i=1 in the split case and -1 in the inert case. Indeed the
residue-field norm-one group is cyclic of order q_i-chi_i; all roots
of X^(3n)-1 lift uniquely because q_i does not divide 3n. Use the product
group H=product H_i and m=product q_i^e_i. If m>864B^3, equality of its
pair images gives (PF7) by the same conjugate-cross-product calculation
at every prime power and then coprimality of the moduli.

This allows combined precision from several primes, but its image bound
is the product of the |H_i|, not one copy of 3n. Thus it does not supply
a pointwise signed-tail bound or automatically improve the single-prime
energy estimate. A quantitative bound for E_<v0 on the actual marked
set, or additional dependence among its product images, is an explicit
remaining target. Multiple marks and lower denominators are retained,
not discarded on heuristic grounds.
