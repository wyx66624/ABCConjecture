# LM1--LM5. Actual affine selectors, their content cost, and full signed compensation

Complete ordinary candidate, 2026-09-07, before any formalization.
This is a new additive construction, separate from the common-multiplier
map in CD and the full-product norm in CP. It handles a genuinely
nonrectangular finite packet: different primes may select different
original roots. It does not keep its output inside the original power
family. That distinction, and the fixed-data quantifiers, are essential.

Write O=Z[zeta], zeta^2-zeta+1=0, N(a+b zeta)=a^2+ab+b^2,
P(a+b zeta)=ab(a+b), and |Z|=sqrt(N(Z)). For nonzero Z define its positive
integer content as the gcd of its two coordinates. For P(Z)!=0 put

    J(Z)=sum_(p | |P(Z)|) (v_p(P(Z))-3) log p.

Depth one and two contribute -2 log p and -log p; they are never discarded.

## LM1. The true additive image and an actual short kernel

For any finite set I of actual roots and integer n>=1, let

    S: Z^I -> O,       c -> sum_(k in I)c_k w_k^n.

Its integer image has rank at most two. Thus constraints which depend
only on this output, for example

    ell_q(S(c))=0 mod q^e_q

for an arbitrary finite family of primes and integer linear forms ell_q,
always contain ker S. Increasing the number of coefficient variables
does not increase the rank of the actual output quotient Z^I/ker S.

There is an explicit small nonzero coefficient vector on each n+2
consecutive roots:

    sum_(j=0)^(n+1) (-1)^j binom(n+1,j) w_(k+j)^n = 0,       (LM1)

with coefficient absolute values at most 2^(n+1). It belongs to every
one of the homogeneous congruence lattices above, at arbitrary precisions
and for arbitrary owner patterns.

Proof. Both coordinates of (3X+zeta)^n are integer polynomials in X of
degree at most n. The (n+1)-st finite difference vanishes. One can prove
this without a difference operator: for a monomial X^m with m<=n, apply
(T d/dT)^m to (1-T)^(n+1) and evaluate at T=1. Every term still contains
1-T. Expansion gives the required alternating binomial sum, and linearity
gives (LM1). The first coefficient is one, so the vector is nonzero;
the binomial sum 2^(n+1) bounds each coefficient. The rank assertion is
the literal identification O=Z^2. QED.

In particular the reviewed block B=n^4 for prime n>324 contains such
vectors. This is a complete actual counterexample to treating an arbitrary
small nonzero coefficient-lattice vector as a nonzero Eisenstein output.
It does not refute a lattice argument which separately proves that its
vector escapes the kernel or retains a higher-dimensional actual output.

## LM2. Exact nonrectangular selector and primitive preservation

Let Z1,Z2 be primitive Eisenstein integers with

    Delta=det(Z1,Z2)!=0,        P(Z1)P(Z2)!=0.

Let S1,S2 be nonempty finite disjoint sets of rational primes q>3.
For q in Si suppose

    e_q=v_q(P(Zi))>=1,         q does not divide N(Zi).

No hypothesis says that both roots hit each q. In particular these
conditions permit exactly one actual owner per prime. Define

    Mi=product_(q in Si) q^(e_q+1),       M=M1 M2.

The moduli M1,M2 are coprime and exceed one. By the integer CRT there
are infinitely many integers t satisfying

    t=1 mod M1,       t=0 mod M2.                         (LM2)

For every such t set U_t=t Z1+(1-t)Z2, g_t=cont(U_t), V_t=U_t/g_t.
Then U_t is nonzero and

    g_t | |Delta|,       gcd(g_t,M)=1,                    (LM3)
    v_q(P(V_t))=e_q  for all q in S1 union S2.            (LM4)

Consequently the entire signed contribution of the selected primes is
preserved, including negative contributions:

    sum_(q in S1 union S2)(v_q(P(V_t))-3)log q
       =sum_i sum_(q in Si)(e_q-3)log q.                 (LM5)

Proof. Linear independence of Z1,Z2 over Q makes U_t nonzero for
every rational t: its two coefficients t,1-t cannot both vanish.
The two determinant identities are

    det(U_t,Z2)=t Delta,
    det(U_t,Z1)=-(1-t) Delta.

Their sum with the appropriate sign shows that g_t divides Delta.
For q in S1, U_t=Z1 modulo q^(e_q+1); for S2 replace Z1 by Z2.
Hence the cubic P(U_t) has exactly valuation e_q. The norm N(U_t)
is a q-unit because the selected owner's norm is a q-unit. In particular
q does not divide g_t. Division by this q-unit changes the cubic by
g_t^(-3) and preserves the exact valuation. This proves (LM3)--(LM5).
The proof does not make any assertion about unselected primes. QED.

Using e_q+1, not just e_q, fixes the exact depths. Neither a selected
prime of depth one nor one of depth two is lost from the signed ledger.

## LM3. A height cost that survives primitive cancellation

Every t in LM2 satisfies

    |t|>=M2,           |1-t|>=M1.

Moreover its actual primitive output obeys

    log |V_t| >= log(sqrt(3)/2)
                 +max(log M2-log |Z2|, log M1-log |Z1|).  (LM6)

For actual roots Z_i=w_(k_i)^n with k_i in [B,2B), this implies

    log |V_t| >= (log M)/2-n log(6B)+log(sqrt(3)/2).       (LM7)

Proof. The congruences exclude t=0,1. The nonzero integers t and 1-t
are divisible by M2 and M1 respectively. The Gram determinant bound
in actual Eisenstein coordinates is

    |det(X,Y)| <= (2/sqrt(3)) |X| |Y|.

Apply it to (V_t,Z2) and use (LM3):

    (2/sqrt(3)) |V_t| |Z2|
       >= |t| |Delta|/g_t >= |t|.

The second determinant gives the same inequality with |1-t| and Z1.
Taking logarithms proves (LM6). Finally |w_k|<6B, and
max(log M1,log M2)>=log M/2, prove (LM7). QED.

Conversely, choose the representative 0<=t<M of the CRT class.
It is neither 0 nor 1, and

    |V_t| <= |U_t| < M(|Z1|+|Z2|).                       (LM8)

Thus this is a genuine actual selector, rather than a formal incidence
assignment. Its modulus cost does not disappear merely on dividing by
content. LM6 is a lower bound, not a claim of optimality among all maps.

## LM4. A positive-density actual family pays the full selected packet

Here all data Z1,Z2,S1,S2,e_q are FIXED. Assume in addition that

    Z2=(a2,b2),    Z1-Z2=(a0,b0),    a0,b0>0.

Choose t_* in the CRT class sufficiently large that U_(t_*) has positive
coordinates. Let E be the finite set of primes dividing

    6 M Delta a0 b0(a0+b0).

For p in E write F_p=v_p(P(U_(t_*))), and define

    H=product_(p in E) p^(F_p+1),
    t(j)=t_*+Hj  (j>=1),        g=cont(U_(t_*)).

The integer H is divisible by M. For every j>=1,

    cont(U_(t(j)))=g,
    V_j=U_(t(j))/g=(a_j,b_j),       a_j,b_j>0.

The three positive arms a_j,b_j,a_j+b_j are affine integer polynomials
in j with positive slopes. Define fixed depths

    f_p=F_p-3v_p(g)>=0,       K=product_(p in E)p^f_p.

There exists a set G of positive integers with natural density

    d(G)=product_(p not in E)(1-3/p^2) >= 1/4             (LM9)

such that for EVERY j in G,

    T_j=a_j b_j(a_j+b_j)=K R_j,
    R_j is squarefree,       gcd(K,R_j)=1,
    every prime of R_j is outside E.                    (LM10)

On this actual primitive family the full signed identity is

    J(V_j)=-2 log T_j+3 log(K/rad(K)),                   (LM11)

and, as j in G tends to infinity,

    J(V_j)/log(a_j+b_j) -> -6.                          (LM12)

In particular, for a constant C depending on these fixed data,

    a_j+b_j <= C rad(T_j)^(1/3)   (j in G).

Proof. At every p in E the congruence U_(t(j))=U_(t_*) modulo
p^(F_p+1) preserves the valuation F_p of the cubic. It also preserves
the common coordinate valuation. To see the latter directly, let
v=min(v_p(a_*),v_p(b_*)); then F_p>=3v, so F_p+1>v and the
coordinate which has valuation v retains that valuation.
No prime outside E divides any content, by g_t | |Delta|. Hence the
content is exactly g for every j. In particular g divides H, so the
quotient arms are affine integer polynomials. Their positive slopes
and the chosen positive starting pair prove positivity.

For p outside E, both the slopes and H/g are p-units. The determinant
of the slope and constant pairs of V_j is H Delta/g^2 up to sign,
also a p-unit. The three affine factors a_j,b_j,a_j+b_j therefore
each have a simple root modulo p^2, and the three roots are distinct
already modulo p. Exactly three residue classes modulo p^2 are
forbidden by p^2 | T_j. Note p>=5 outside E.

For a fixed real cutoff Y, the CRT gives natural density
product_(p<=Y,p not in E)(1-3/p^2) for avoiding these finitely many
classes. The infinite tail is controlled elementarily. Each individual
positive affine arm at 1<=j<=X is at most C0 X for a constant C0
depending on the fixed data (increase it to include X=1). If p^2
divides an arm, then p<=sqrt(C0 X). At p outside E there are at most
three relevant classes modulo p^2. Thus

    #{1<=j<=X : some p>Y, p not in E, p^2 | T_j}
       <=3X sum_(p>Y)1/p^2+3 sqrt(C0 X).                (LM13)

Here distinctness of the three roots ensures p^2 cannot arise from
two different arms each divisible by p. Dividing by X, taking X to
infinity, and then Y to infinity proves existence and the exact
infinite-product density. Positivity, with the claimed simple lower
bound, follows from

    sum_(p>=5) 3/p^2
       <=3 sum_(m>=5)1/m^2 <3 integral_4^infinity x^-2 dx=3/4,

and the finite inequality product(1-u_i)>=1-sum u_i for 0<=u_i<=1.
Pass to the convergent product. Excluding additional primes in E
only increases the lower bound. No prime-distribution theorem is used.

At p in E the exact primitive depth is f_p, and outside E the good
parameters have depth zero or one. This proves (LM10), including
the complete finite-prime exceptions in K. In particular

    rad(T_j)=rad(K)R_j=T_j/(K/rad(K)).

Consequently J=log T_j-3log rad(T_j) gives (LM11) exactly. Since all
three affine slopes are positive,

    log T_j=3log j+O(1),      log(a_j+b_j)=log j+O(1).

These prove (LM12). Their positive leading coefficients also give
T_j >= c0 (a_j+b_j)^3 for a fixed c0>0 after, if necessary, decreasing
c0 to cover the finitely many small positive j. The displayed radical
identity gives the final inequality. QED.

The cutoff after which these asymptotics are useful is NOT uniform
as the roots, exponent, prescribed primes or prescribed depths vary.
In particular K and C0 may be very large. The lower density 1/4
is a natural-density statement for a fixed progression, not a density
in the original block K_B at a scale varying with n.

## LM5. Nonemptiness from the actual power block and the remaining gate

The positivity and nonparallelism used above hold for two distinct roots
of the original block. More precisely, let n>=2, B>=n be integers and
B<=k2<k1<2B. Then Z_i=(3k_i+zeta)^n are primitive unramified powers,
P(Z_i)>0, Delta!=0, and both coordinates of Z1-Z2 are positive.

Proof. Primitivity and nonramification of 3k+zeta give the previously
proved primitive-power property. For real x>=B let

    theta(x)=arg(3x+zeta)=arctan(sqrt(3)/(6x+1)).

It is positive, strictly decreasing, and less than 1/(3x).
Thus 0<n theta(x)<1/3<pi/3. Each power lies strictly inside the
positive Eisenstein coordinate cone. The two arguments are distinct
and differ by less than pi, so their determinant is nonzero. Finally

    (3k1+zeta)^n-(3k2+zeta)^n
       =integral_(k2)^(k1) 3n(3x+zeta)^(n-1) dx.

For n>=2 the integrand is strictly inside the same cone; its integral
has both coordinates positive. QED.

For example, n=2 with w_2=6+zeta and w_3=9+zeta gives the explicit
two roots

    Z2=(35,13),       P(Z2)=35*13*48,
    Z1=(80,19),       P(Z1)=80*19*99.

The prime 19 belongs only to the first boundary and 13 only to the
second. Their exact depths are both one and their selected norms are
units. Thus S1={19}, S2={13} satisfies all conditions, including
genuine different owners, and LM4 gives a nonempty infinite actual
positive family. General prescribed packets in LM2 may include
arbitrary positive depths; LM4 keeps all of them exactly.

This n=2, B=2 example belongs to the extended actual-power root family
of LM5. It is not an example satisfying the original US restrictions
n>324 prime and B=n^4, and supplies no membership statement in that
restricted moving block. The algebraic selector lemma applies to roots
from that block when actual prime packets satisfying LM2 are supplied.

This supplies a full, unconditional signed estimate on a positive-density
family of NEW primitive affine outputs. It is not just an implication
from an unproved squarefreeness premise: that premise was proved for
the actual linear arms by the complete elementary sieve.

There are also explicit input packets with positive signed costs. Still
take n=2, and use

    k1=21720+2*19^5=4973918,      k2=61882+13^6=4888691.

They belong to the extended block B=4880000, and their second coordinates
are exactly 19^4*229 and 13^5*79. For q>3 dividing that coordinate, the
first coordinate is -3/4 modulo q, so the full boundary depths are
respectively 4 and 5. The other owner's boundary is a unit at the marked
prime (k1=1 mod13, k2=10 mod19). Thus the distinct-owner packet has
positive signed cost log19+2log13 and is retained by LM2 and paid by
LM4's new negative support. These small marked primes and n=2 do not
satisfy the original US far-prime or prime-exponent restrictions.

It does not bound the signed tails of the original Z_i, and it does
not assert that V_j is an n-th power or has a small-residual n-th-power
representation. The output family and its scale change. Applying its
fixed-data constant uniformly over moving packets would be invalid.
Likewise, LM1 rules out only a kernel-blind coefficient-lattice argument,
not every additive or nonlinear interpolation scheme. Full original
boundary tails, exceptional roots, independent-domain complements and
general ABC coverage remain open.

The next test is a genuinely additional constraint: can an affine or
nonlinear selector simultaneously retain useful original compression
and a provable supply of the new negative-credit support? This note
establishes the exact output map and a nonempty paid-output class,
but makes no claim that those two properties already hold together.
