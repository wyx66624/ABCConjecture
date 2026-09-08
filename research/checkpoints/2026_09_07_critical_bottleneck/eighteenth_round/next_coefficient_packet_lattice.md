# Actual coefficient-packet lattices: an obstruction and the correct resultant test

Status: next-only complete ordinary candidate, 2026-09-07. This file is outside
the frozen publication inventory. No new Lean or numerical verification is
claimed. Statements CG1--CG4 below concern actual roots in the original block;
CG5--CG6 give a correct positive certificate and its immediate limitation.

## Setup and the proposed bridge being tested

Let n>324 be prime, B=n^4, and let zeta satisfy zeta^2-zeta+1=0, with positive
imaginary part. Work in O=Z[zeta]. For z=A+C zeta put

    N(z)=A^2+AC+C^2,       P(z)=AC(A+C).

For B<=k<2B set w_k=3k+zeta, z_k=w_k^n and T_k=P(z_k). These are the original
one-coordinate roots and original exponent/block parameters. All their three
raw arms A,C,A+C are positive: if theta=arg(w_k), then
0<n theta<n/(3k)<=1/3, so
A=|w_k|^n(cos(n theta)-sin(n theta)/sqrt(3))>0 and C>0.

The powers z_k are primitive. Indeed, for p!=3 the algebra O/pO is reduced
(the discriminant is -3); z_k=0 in that algebra would imply w_k=0, impossible
because its zeta coefficient is 1. At p=3, N(w_k)=9k^2+3k+1 is a unit, so
z_k cannot have both coordinates divisible by 3. Consequently the three arms
are pairwise coprime. If a prime divides one arm, it does not divide N(z_k),
and hence does not divide N(w_k).

A packet here is a finite set of DISTINCT rational primes p, an assigned
actual owner k(p) in [B,2B), and a depth e_p>=1 with
v_p(T_{k(p)})=e_p. It defines an evaluation lattice in the coefficient space of
polynomials of degree at most d:

    L = {G in Z[X]_{<=d}: G(k(p))=0 mod p^{e_p} for every packet prime p}.

The false bridge to be tested is that the existence of ONE primitive, nonzero
coefficient vector of small height in L forces the lattice index to be at
most a fixed power of that height, uniformly in n. No such assertion follows
from a short vector. CG1--CG4 disprove it using an actual boundary polynomial
and a genuinely nonconstant owner assignment, without using a zero polynomial
or the additive selector kernel.

## CG1. The literal boundary polynomial is primitive after removing 3

Define

    P_n(a)=P((a+zeta)^n),
    T_n(X)=P_n(3X),       F_n(X)=T_n(X)/3.

Then T_n has content exactly 3. Thus F_n belongs to Z[X], is primitive and
nonzero, has degree d=3n-1, and satisfies

    ||F_n||_1 <= 64^n/3 <= 64^n.                         (CG1)

Proof. The sixth roots of unity have coordinates
(1,0),(0,1),(-1,1),(-1,0),(0,-1),(1,-1). Since n=1 or 5 modulo 6,
P_n(0)=0 and P_n'(0)=n. Explicitly, in the first case zeta^n=zeta and the
vanishing A arm has derivative n. In the second case zeta^n=1-zeta and the
vanishing A+C arm has derivative -n, while AC=-1. Therefore

    P_n(a)=n a+a^2 R_n(a),             R_n in Z[a].       (CG2)

All coefficients of T_n are divisible by 3, while its X coefficient is 3n.
In O/nO[X], the binomial theorem gives

    T_n(X) = +(3X)^n((3X)^n+1) mod n,   if n=1 mod 6,
    T_n(X) = -(3X)^n((3X)^n+1) mod n,   if n=5 mod 6.

This is a nonzero polynomial over F_n, so n does not divide the content.
The content, a divisor of 3n divisible by 3, is exactly 3.

Write (3X+zeta)^n=A_n(X)+C_n(X)zeta. The leading degrees of A_n,C_n,A_n+C_n
are n,n-1,n, with leading coefficients 3^n,n3^{n-1},3^n. This proves
d=3n-1. In the binomial expansion, each coordinate of zeta^j, as well as the
sum of its coordinates, has absolute value at most 1. Therefore each of
||A_n||_1, ||C_n||_1, ||A_n+C_n||_1 is at most
sum_j binom(n,j)3^{n-j}=4^n. Submultiplicativity gives (CG1). QED.

## CG2. Two different actual owners carry two positive-depth labels

Put k_0=B. Then

    v_3(T_{k_0})=1,       v_n(T_{k_0})=5,
    v_5(T_{k_0})=0.                                      (CG3)

There is a k_1 in [B,2B) satisfying

    k_1=5^4 mod 5^5,       k_1=1 mod n,

and for every such k_1,

    v_5(T_{k_1})=4,       v_n(T_{k_1})=0.                 (CG4)

Proof. Formula (CG2) at a=3B proves v_3(T_B)=1, because 3 does not divide nB.
At the prime n, expand (a+zeta)^n at a=3n^4. At a=0 exactly one of the three
arms is zero, and its first term is +/-n a, of valuation 5. Every term of
degree 2 through n-1 has valuation at least 1+4*2=9, because n divides the
corresponding binomial coefficient; the last term has valuation 4n. The
other two arms remain units modulo n. This proves v_n(T_B)=5.

Since B=n^4=1 mod 5, w_B=3+zeta in F_25. Its norm is 13=3 mod 5, so
(3+zeta)^6=3, while its fifth power is its conjugate 4-zeta. The exponent n
is 1 or 5 modulo 6. Thus w_B^n is a nonzero scalar multiple of either
3+zeta or 4-zeta; their P values are 12 and -12, both nonzero modulo 5.

The two conditions for k_1 are soluble by CRT with modulus 5^5 n. The least
solution >=B is <B+3125n<2B because n^3>3125. Formula (CG2), now with
v_5(k_1)=4, proves v_5(T_{k_1})=4: the first term 3n k_1 has valuation 4,
and all later terms have valuation at least 8. The polynomial congruence
from CG1 at k_1=1 mod n gives T_{k_1}=+/-12 mod n, which is nonzero.
The owners are distinct, since k_0=0 mod n and k_1=1 mod n. QED.

These are actual positive signed contributions: the label n at k_0 has
(e_n-3)log n=2 log n, and the label 5 at k_1 has log 5. They are small
primes relative to the moving cutoffs used in the far-tail theorems. This
construction is not a counterexample to any far-tail estimate.

## CG3. Exact packet index with a primitive short vector

Let m_0=F_n(B)=T_B/3. Give every prime p dividing m_0 to owner k_0, with its
FULL actual depth e_p=v_p(m_0)=v_p(T_B). Add the distinct prime 5 at owner
k_1, with its full actual depth 4. Then all packet primes are norm units at
their assigned owner, and

    M=5^4 m_0,       [Z^{d+1}:L]=M,       F_n in L.        (CG5)

Here the packet is not a common-hit rectangle: n belongs to the first owner
and not the second, while 5 belongs to the second and not the first.

Proof. By (CG3), m_0 is coprime to 15. Primitivity in the setup proves the
norm-unit assertion. Consider the additive evaluation homomorphism

    ev: Z[X]_{<=d} -> (product_{p|m_0} Z/p^{e_p}Z) x Z/5^4Z.

It is surjective: a constant polynomial can realize arbitrary entries in
the target by the ordinary CRT for these pairwise coprime moduli. The
kernel is L, so its index is the order M of the target. The polynomial F_n
vanishes modulo each first-owner modulus at B; it has valuation 4 at 5 when
evaluated at k_1, since division by 3 does not change that valuation. Thus
F_n lies in L, and CG1 proves that its literal coefficient vector is primitive.
In particular this is not the zero polynomial, and its value at B is the
large positive integer m_0, rather than zero. QED.

All full signed costs of the first owner are retained. If

    J(T)=sum_{p|T}(v_p(T)-3)log p,

then the exact selected packet ledger is

    sum_{p|m_0}(e_p-3)log p + log 5
        = J(T_B)+2 log 3+log 5.                          (CG6)

The term 2 log 3 merely removes the depth-one label 3 from T_B. Equation
(CG6) includes every depth-one and depth-two negative term at the first
owner. Neither its sign nor its asymptotic size is asserted.

## CG4. No fixed-power short-vector/index bound

Let H_n=max(2,||F_n||_1). For every fixed C>0 and C_0>0, all sufficiently
large prime n in the above construction satisfy

    [Z^{d+1}:L] > C_0 H_n^C.                             (CG7)

Proof. Let r=|3B+zeta|>=3B and u=n arg(3B+zeta). Then 0<u<1/3. The elementary
inequalities cos u>=1-u^2/2 and sin u<=u give

    A_B=r^n(cos u-sin u/sqrt(3))>r^n/2.

Since C_B is a positive integer and A_B+C_B>A_B,

    T_B > (3B)^{2n}/4,
    M > (625/12)(3B)^{2n}.                               (CG8)

Consequently

    log M > 8n log n+2n log 3+log(625/12),
    log H_n <= n log 64.

Their ratio tends to infinity along primes, proving (CG7). QED.

This refutes only bounds with absolute fixed exponents based on ONE short
primitive coefficient vector. The dimension d+1 grows with n. It does not
refute a dimension-dependent bound, a bound that pays the evaluation height
B, or Hadamard applied to a full independent basis. In particular, a kernel
having one short primitive vector is not evidence for a small covolume.

## CG5. A correct certificate: a coprime second polynomial

Let F,G be nonzero polynomials in Z[X], of actual degrees d,e>=1, coprime in
Q[X]. Suppose a finite packet has pairwise distinct primes p, positive
depths h_p and arbitrary integer owners a_p such that

    p^{h_p} divides F(a_p) and G(a_p).

Then, without any monicity or prime-to-leading-coefficient assumption,

    product_p p^{h_p} divides Res(F,G),                  (CG9)

and

    sum_p h_p log p
       <= e log ||F||_2 + d log ||G||_2.                 (CG10)

Proof. The Sylvester determinant is an integer and is nonzero precisely
because F,G are coprime over Q. The adjugate of the integer Sylvester matrix
gives polynomials U,V in Z[X] with

    U F+V G=Res(F,G),

up to an inessential sign convention. One direct verification is to view
the Sylvester matrix as the coefficient matrix of the map
(U,V) -> UF+VG, with deg U<e and deg V<d, and apply its adjugate to the
constant basis vector. Evaluating this identity at each a_p proves
p^{h_p}|Res(F,G), including every full prime-power depth. Distinct primes
then give (CG9). No root in a field and no division by a leading coefficient
was used.

The Sylvester matrix has e shifted coefficient rows of F and d shifted
coefficient rows of G. Their Euclidean row lengths are respectively ||F||_2
and ||G||_2. Hadamard's determinant inequality gives
|Res(F,G)|<=||F||_2^e ||G||_2^d. Taking logarithms of the nonzero integer
multiple in (CG9) proves (CG10). QED.

The degree-zero case can also be included directly: for a nonzero constant
G=c, Res(F,c)=c^d, and each packet modulus divides c. It gives no useful
short certificate unless the entire packet modulus is already small.

This is a nonrectangular result: different primes may have different
owners. It uses their actual integer evaluations simultaneously. A single
G suffices, provided the coprimality condition is proved. It is stronger
than asking for a whole lattice basis, but it is an interface until a
sufficiently short such G is constructed for the target packet.

## CG6. The automatic owner polynomial pays the old height again

First consider the actual block polynomial F_n and a nonempty finite
assigned T-packet whose primes are all DIFFERENT FROM 3. Let K be its
set of distinct owners, s=|K|>=1. Then the packet moduli divide F_n at
their assigned owners, and the polynomial

    G_K(X)=product_{k in K}(X-k)

is an unconditional certificate for CG5: it is zero at every owner and is
coprime to F_n, because F_n(k)=T_k/3>0 for every block owner. Moreover

    |Res(F_n,G_K)|=product_{k in K}F_n(k),               (CG11)
    ||G_K||_2<=||G_K||_1=product_{k in K}(1+k)<=(2B)^s.

Thus its Sylvester estimate is only

    log M <= s log ||F_n||_2 + d s log(2B).             (CG12)

The exact identity (CG11) follows either from the product formula for a
resultant with the monic split polynomial G_K, or by applying the evaluation
formula successively to its linear factors. The coefficient-norm equality
uses positivity of all k, so the absolute elementary symmetric coefficients
sum to product(1+k).

Equation (CG11) recovers the elementary bound obtained by assigning each
prime-power modulus to its owner and multiplying the corresponding integer
values. It supplies no saving over that owner-by-owner height accounting and
contains no compensation from the negative depth-one/two terms. In CG3 it
is simply G_K=(X-B)(X-k_1), with resultant F_n(B)F_n(k_1). This valid second
certificate is consistent with the large index of CG4.

The restriction at three is necessary because F_n=T_n/3. There is an
exact extension to every nonempty T-packet in the setup. If three is
included, write k_3 for its assigned owner. Formula (CG2) gives

    e_3=v_3(T_{k_3})=1+v_3(k_3),

since the linear term has this valuation and every higher term has
valuation at least 2+2v_3(k_3). Thus the corresponding F_n-packet uses
h_p=e_p for p!=3 and h_3=e_3-1, omitting the latter label if h_3=0.
This does not assume v_3(k_3)=0. Denote the two modulus products by
M_T and M_F. For the full packet, with three present,

    M_T=3M_F,       log M_T=log M_F+log 3.            (CG13)

The same G_K, using all original owners, is a valid certificate for
the adjusted F_n-packet (even if that packet is empty). Therefore

    log M_T <= s log||F_n||_2+d s log(2B)+log 3.

For a packet with three absent the final log 3 is absent too. One must
also distinguish the radical when translating the signed ledger. If
J_T and J_F are the sums of (depth-3)log p over their respective
positive-depth supports, then

    J_T=J_F-2log 3,     if e_3=1,
    J_T=J_F+log 3,      if e_3>=2.                    (CG14)

Indeed in the first case rad(M_T)=3rad(M_F), while in the second
case rad(M_T)=rad(M_F). These identities retain the depth-one and
depth-two negative terms exactly. They also show why a full T-packet
cannot simply be called a packet for F_n without adjusting three.

More generally the correct resultant certificate CG5 has the exact
signed consequence

    J_F <= deg(G)log||F_n||_2+d log||G||_2
                           -3log rad(M_F).         (CG15)

For a full T-packet the completely equivalent bound, with its original
radical and delta_3 indicating whether three is present, is

    J_T <= deg(G)log||F_n||_2+d log||G||_2
                    +delta_3 log 3-3log rad(M_T),   (CG16)

provided G is coprime to F_n and satisfies the adjusted F_n-packet
congruences. This is just (CG9)--(CG10) and the exact identity
J=log M-3log rad(M); no negative prime depth is discarded.

### Precise remaining issue

For a genuine new cross-prime gain, one would need a coprime certificate G
whose degree and coefficient height make

    deg(G) log||F_n||_2 + (3n-1)log||G||_2

smaller than the relevant owner-height budget, or one would need an argument
that combines such a resultant with the complete signed ledger. Merely
choosing a small lattice vector can return a multiple of F_n; merely taking
the product of owner factors gives (CG11). No existing result cited here
constructs the required shorter coprime certificate on the original
independent domain, and no dependence on M is being hidden in its height.

The positive classes NP/CU remain separate fixed-exponent selector results.
CG1--CG6 do not rule out useful small intersections or other nonlinear
maps, do not control the far-tail signed sum, and do not close the exceptional
set, the dependent-root complement, or the passage from this special block
to all primitive ABC triples.
