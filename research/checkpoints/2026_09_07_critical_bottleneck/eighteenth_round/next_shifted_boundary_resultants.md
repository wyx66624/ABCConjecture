# SR1--SR5. Actual shifted boundary resultants and the complete signed residual

Next-only complete ordinary candidate, 2026-09-07. This is outside the
current fixed-curve publication. It supplies an unconditional
cross-prime bound on an actual common-depth part of the ORIGINAL block,
with no multiplicative-independence hypothesis. It does not bound
unmatched high depth. All cited CG facts refer to the corrected full
ordinary candidate with SHA
216e6695ea1cf0bf43dd6441fb8746841c604b670c5bb7cf362c7238ca08eb64.

## Setup

Let n>324 be prime, B=n^4, and O=Z[zeta], zeta^2-zeta+1=0 with
positive imaginary part. Put

    P_n(a)=P((a+zeta)^n),       P(A+C zeta)=AC(A+C),
    T_n(X)=P_n(3X),            F_n(X)=T_n(X)/3,
    d=3n-1.

By CG1, F_n is primitive integral of degree d and
||F_n||_2 <= ||F_n||_1 <= 64^n. For every integer B<=k<2B,
T_k=T_n(k)>0 and its three arms are primitive and pairwise coprime.
Every boundary prime is an actual input-norm unit.

Fix a nonzero INTEGER h with |h|<B. Let

    I_h={k in Z: B<=k<2B and B<=k+h<2B}.

This set is nonempty. All gcds, lcms and valuations below concern
literal positive integers evaluated at these actual roots.

## SR1. Complete root-orbit classification excludes every integer translate

For every nonzero integer h, not merely |h|<B,

    gcd_Q[X](F_n(X),F_n(X+h))=1.                       (SR1)

This does not use a generic-polynomial assertion.

Proof. Work temporarily with roots in the a coordinate. Set
xi=zeta^2, a primitive cube root, K=Q(zeta), and L=Q(zeta,eta),
where eta is a primitive nth root. The cyclotomic Galois group
Gal(L/K) has order n-1 and sends eta to eta^j for every
1<=j<=n-1. Indeed [Q(zeta_{3n}):Q]=2(n-1), K has degree two,
and the automorphisms with residue 1 modulo three have arbitrary
nonzero residues modulo n by CRT.

Write (a+zeta)^n=A_n(a)+C_n(a)zeta. If a is a root of P_n, then
a is neither -zeta nor -bar(zeta). At either of those two exceptional
values, one of (a+zeta)^n and (a+bar(zeta))^n is zero and the other
is nonzero. Any of A_n=0, C_n=0, or A_n+C_n=0 would force both
embeddings to vanish; this is a contradiction.
Thus the ratio

    alpha=(a+zeta)/(a+bar(zeta))

is defined and nonzero, and

    alpha^n=1 if C_n=0,
    alpha^n=xi if A_n=0,
    alpha^n=xi^2 if A_n+C_n=0.                         (SR2)

Conversely each of these three ratio equations gives its indicated
arm zero, by subtracting the two power embeddings. Also alpha!=1
since zeta!=bar(zeta). Solving for a gives the injective map

    a=(zeta-alpha*bar(zeta))/(alpha-1).                (SR3)

It follows that the roots are exactly the images of
mu_{3n}\{1}. There are 3n-1 distinct values. This also verifies
all multiplicities by the known degree 3n-1.
The two alpha in mu_3\{1} give the rational roots a=0,-1.
The remaining alpha form three Gal(L/K) orbits

    {xi^j eta^t : 1<=t<=n-1},       j=0,1,2.

Each has n-1 elements. Equation (SR3) preserves orbit cardinality.
Since n is invertible modulo three, (SR2) puts one full orbit
in each of the three arms after its possible rational root is
removed. This accounts for all 3(n-1)+2 roots.

Define the average trace mu(a)=Tr_{L/K}(a)/(n-1), also for a
rational root. The leading coefficients of the arms in the
a coordinate are

    A_n: degree n, coefficient of a^(n-1) is 0;
    C_n: leading n*a^(n-1), next n(n-1)/2*a^(n-2);
    A_n+C_n: degree n, coefficient of a^(n-1) is n.

Therefore their total root sums are 0, -(n-1)/2, -n.
If n=1 modulo six, A_n has rational root zero and A_n+C_n
has rational root -1. If n=5 modulo six, these two rational
roots are interchanged. The three nonrational orbit means are
accordingly

    n=1 mod6:       0,             -1/2,    -1;
    n=5 mod6:       1/(n-1),       -1/2,    -n/(n-1).  (SR4)

The rational roots have means 0 and -1. The diameter of all
possible means is thus at most (n+1)/(n-1)<3.
This trace calculation does not presume identical minimal
polynomials for two roots; both are elements of the SAME L
and the normalized full-field trace is linear for every root.

If F_n(X) and F_n(X+h) had a common root x, then a=3x and
b=3x+3h would both be roots of P_n. Both belong to L by (SR3).
Linearity would give mu(b)-mu(a)=3h, whose absolute value is
at least three. This contradicts (SR4). This proves (SR1). QED.

## SR2. An actual all-prime lcm bound independent of the number of owners

Define the complete positive integers

    C_F(h)=lcm_{k in I_h} gcd(F_n(k),F_n(k+h)),
    C_T(h)=lcm_{k in I_h} gcd(T_k,T_{k+h}).

Then

    C_F(h) | Res(F_n(X),F_n(X+h)),                    (SR5)
    C_T(h)=3 C_F(h),                                 (SR6)

and, putting

    H_n(h)=2dn log64+d^2 log(1+|h|),

one has the unconditional bound

    log C_T(h) <= H_n(h)+log3.                        (SR7)

In particular, for each FIXED nonzero integer h this is O_h(n^2),
although I_h contains B-|h| actual root pairs.

Proof. For every prime p, let

    b_p=max_{k in I_h} min(v_p(F_n(k)),v_p(F_n(k+h))).

When b_p>0, choose any actual pair attaining this maximum.
The finite nonrectangular packet of these DISTINCT primes satisfies
the CG5 hypotheses for F_n and G_h(X)=F_n(X+h). The maximum may
have a different witness pair for each prime. SR1 gives
coprimality, so the integral Sylvester-adjugate identity proves
p^{b_p}|Res, for every p. Thus the complete lcm C_F divides
the nonzero resultant. No leading-coefficient unit condition is
required and no prime-power depth is shortened.

For every pair, gcd(3F_n(k),3F_n(k+h)) is three times its F gcd.
An lcm of a nonempty list commutes with multiplication by three.
This proves SR6, including all possible higher three-adic depths.
Equivalently the maximum common T depth at three is exactly
one plus its maximum common F depth, not universally one.

Translation has the explicit coefficient bound

    ||F_n(X+h)||_2 <= ||F_n(X+h)||_1
       <= ||F_n||_1(1+|h|)^d.

Indeed each monomial X^j acquires coefficient norm
(1+|h|)^j. The two degree-d Sylvester row blocks and CG5 give

    log |Res| <= d log||F_n||_2+d log||F_n(X+h)||_2
              <= 2dn log64+d^2 log(1+|h|).

Combine this with SR5--SR6. QED.

This is one actual cross-prime bound, not a sum of separate bounds
at each prime, and the second polynomial has no hidden packet
modulus in its degree or coefficient height. Its degree d may be
far less than the number of distinct witness owners. It improves
the automatic product-of-owner-factors bound for this genuinely
paired part. It says nothing about a prime's excess depth at one
owner beyond the depth at the chosen neighboring owner.

## SR3. Full signed accounting, unmatched depth, and multiple shifts

Let P be any finite set of distinct primes with assigned actual
owners k_p in I_h and full depths e_p=v_p(T_{k_p})>=1. Put

    b_p=min(e_p,v_p(T_{k_p+h})),       u_p=e_p-b_p,
    P_c={p in P:b_p>0},              R_c=product_{p in P_c}p.

For b_p>0, the product of the common powers p^{b_p} divides
C_T(h), but the complete negative credit must be retained.
The exact original packet identity is

    J_P := sum_{p in P}(e_p-3)logp
      = sum_{p in P_c}(b_p-3)logp
        +sum_{p in P_c}u_p logp
        +sum_{p in P\P_c}(e_p-3)logp.                 (SR8)

Its proved consequence is

    J_P <= H_n(h)+delta_3 log3-3log R_c
           +sum_{p in P_c}u_p logp
           +sum_{p in P\P_c}(e_p-3)logp,              (SR9)

where delta_3 indicates 3 in P_c.

Proof. Apply CG5 to precisely the selected common packet,
with its depth at three reduced by one and omitted if zero.
SR1 and the same row bound apply; restoring its original
T radical gives H_n(h)+delta_3 log3-3log R_c by corrected
CG16. Equation SR8 is termwise addition; substitution proves
SR9. Thus depth-one/two terms in both the common packet and
the unmatched support are present with their actual signs. QED.

In particular the COMPLETE lcm packet has the signed bound

    J(C_T(h)) <= H_n(h)+log3-3log rad(C_T(h)).

One must not replace a chosen subpacket's radical by this larger
radical: signed sums are not monotone under addition of depth-one
or depth-two labels.

For a finite set H of nonzero integer shifts, allow each distinct
packet prime its own shift h_p in H and its actual pair in I_{h_p}.
Partition the primes by their chosen shift. Applying the same
resultant argument to each part gives, for the common packet,

    log M_common <= sum_{h in H} H_n(h)+delta_3 log3,
    J_common <= sum_{h in H} H_n(h)+delta_3 log3
                                      -3log rad(M_common).      (SR10)

Only one log3 is needed because three is a SINGLE assigned label.
The unmatched terms from SR8 must still be added. A prime has
not been counted once per owner pair; each label is used once.

For comparison with the actual block scale put

    W_n=sum_{B<=k<2B} n log|3k+zeta|.

It satisfies W_n>=Bn log(3B). A fixed finite H consequently has
sum_h H_n(h)/W_n ->0. More generally, if

    |H| n log(1+max|h|)/(B log B) ->0,

the same normalized conclusion holds (max|h|>=1).
Summing the individual resultants over all shifts up to B does
NOT give a saving: the resulting bound is of order
B n^2 log B, rather than B n log B. Neither a covering by few
shifts nor a bound for the unmatched terms has been proved here.
The ultra-large singleton part may have no deep partner at all.

## SR4. A nonempty original-block example with different positive labels

There are genuine positive-depth nonrectangular packets covered by
SR2--SR3 for every sufficiently large original prime index; in fact
the following fixed choices fit every n>324.
Let

    L0=7^4*13^5=891474493,       h=(L0-1)/3=297158164.

Choose k_7 to be the first integer at least B satisfying

    k_7=7^4 mod7^5,       k_7=1 mod13,

and choose k_13 similarly with

    k_13=13^5 mod13^6,    k_13=1 mod7.

The respective CRT steps are 218491 and 33787663. As
h+33787663<331000000<324^4<B, all four indices
k_7,k_7+h,k_13,k_13+h lie in the original block.

The pairs have exact full common depths four at seven and five
at thirteen. To prove this, P_n(a)=na+O(a^2) integrally by CG1,
and also

    P_n(-1-a)=P_n(a),       P_n'(-1)=-n.

The first identity follows by taking -bar(a+zeta), raising to
the odd power n, and noting that P(-bar z)=P(z).
At k_q the first expansion gives v_q(T)=e for (q,e)=(7,4),
(13,5), since n is a q-unit. At the shifted index,

    3(k_q+h)+1=3k_q+L0.

After division by q^e its residue is respectively
3+13^5=2 modulo seven and 3+7^4=12 modulo thirteen.
Both are units. The expansion at a=-1 therefore gives exactly
the same depth e at the second owner. All four roots are
primitive and the marked norms are units as in the original setup.

Neither prime hits either member of the other pair. Here is a
check on the complete boundary, rather than just one factor.
For p=7 or 13, and n>324 prime, the power n is coprime to p-1.
If the input norm is nonzero, its ratio alpha lies in the split
norm-one group of order p-1. By SR2 and gcd(n,p-1)=1, a
boundary hit forces alpha in mu_3, hence a=0 or -1 modulo p.
If the norm is zero, primitive coordinates and the norm identity
exclude any boundary hit instead. At the other pair the input
a values are 3 and 2 modulo p, since k=1 and
h=-1/3 modulo p. Neither is zero or minus one.
This proves the asserted absence.

The two pairs are distinct: modulo seven the first pair has
indices 0 and -1/3=2, and the second pair 1 and 1-1/3=3.
Thus the selected common packet has exactly

    M_selected=7^4 13^5,        J_selected=log7+2log13>0,

with different primes assigned to different actual pairs. No
factorization of the remaining boundary is assumed. This example
is only a witness of nonemptiness of the original-block theorem;
its primes are fixed and small, so it is not a far-tail example.
No multiplicatively independent-domain membership is asserted.

## SR5. Precise remaining degree-height requirement

For ANY original assigned full T-packet, let M_T be its product,
R_T=rad(M_T), and let delta_3 indicate whether it includes three.
A nonzero integer polynomial G coprime to F_n must satisfy the
adjusted F-packet: its depth at three is e_3-1 if positive,
and its other depths are unchanged. Define its actual cost

    D_n(G)=deg(G) log||F_n||_2+d log||G||_2.

Corrected CG16 gives the full and exact-sign inequality

    J_packet <= D_n(G)+delta_3 log3-3log R_T.           (SR11)

If a larger actual signed ledger has the exact decomposition
J_total=J_packet+J_remainder, a sufficient certificate at a
specified positive scale W and tolerance epsilon is exactly

    D_n(G) <= 3log R_T-delta_3 log3
                         -J_remainder+epsilon W.     (SR12)

One may replace deg(G)log||F_n||_2 by the larger explicit
deg(G)*nlog64; this makes a stronger sufficient hypothesis.
Equivalently the required coefficient height for degree m is

    log||G||_2 <=
      (3log R_T-delta_3 log3-J_remainder
                         +epsilon W-m log||F_n||_2)/d.

The remainder here includes its negative depth-one/two terms;
discarding them is not an equivalent test. A negative right
side cannot be met by a nonzero integer coefficient vector.
This degree-height criterion alone does not construct G and
does not imply a pointwise ABC estimate from an averaged signed
sum. All representation, exceptional and complementary domains
retain their separate obligations.

SR1--SR3 provide one actual G with a coefficient bound independent
of the modulus on a precisely defined nonempty paired-depth part.
They do not manufacture a partner for a singleton label. The
next test is whether some actual unmatched part admits a different
coprime certificate with the saving in SR12, or can be transferred
to few shifts while bounding the exact excess terms in SR8.
The automatic owner product merely returns the owner-value
resultant and does not settle this test. Even reducing its degree
alone is insufficient: the CG example also allows
G=625(X-B), degree one for two owners, but its exact resultant
is 625^d F_n(B), which still pays the old large owner height.

This note neither refutes the parent signed route nor replaces
its open ultra-large singleton and dependent-root parts. It
changes one specific layer: common depth across differently
assigned primes has an unconditional polynomial-height budget
independent of how many actual owner pairs witness it.
