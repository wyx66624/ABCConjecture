# Unit normalization and signed moment balls

Fifteenth-round complete ordinary proof, 2026-09-07. This is separate
from the fourteenth-round release, whose TeX, formal source and
inventory remain unchanged. Root, independent_route and adversarial_audit each read the full proof, all ordinary PASS before formalization.
No new Lean result or global far-tail estimate is claimed.

## US1. Removing the three arm phases at the actual prime

Let n>324 be prime, B=n^4, L=log(8B), and

    w_k=3k+zeta,   alpha_k=w_k/bar(w_k),   zeta^2=zeta-1

for integers B<=k<2B. Fix any subset I on which the actual alpha_k
are multiplicatively independent. The norm obeys Q_k<36B^2.
Write w_k^n=A_k+C_k*zeta and

    T_k=|A_k C_k(A_k+C_k)|,    t_k=log max(|A_k|,|C_k|,|A_k+C_k|).

The powers are primitive and unramified. Their three arms are
nonzero and pairwise coprime, and

    nlog(3B)<=t_k<nL,
    v_q(T_k)log q<=t_k     for q>8B.              (US1)

Fix a prime q>8B. For each k with q|T_k, precisely one arm is
divisible by q. If q^e|T_k, the same arm is zero modulo q^e and
the other two are units there. Direct division in the Eisenstein
algebra modulo q^e gives

    alpha_k^n = 1       if C_k=0,
                zeta^2  if A_k=0,
                zeta^4  if A_k+C_k=0.            (US2)

For the last case use zeta-1=zeta^2 and
bar(zeta)-1=-zeta. All denominators are units, since a prime
dividing a primitive boundary arm does not divide its norm.
These identities work in both the split and inert residue algebras.

Let u_(q,k) be the corresponding GLOBAL cube root of unity in
{1,zeta^2,zeta^4}. It is fixed by the arm already at precision one
and therefore does not change with e<=v_q(T_k).
Since gcd(n,3)=1, choose the unique tau_(q,k) in that same group
with tau_(q,k)^n=u_(q,k)^(-1), and put

    beta_(q,k)=tau_(q,k)*alpha_k.                 (US3)

This actual algebraic ratio satisfies beta_(q,k)^n=1 modulo q^e
for every e<=v_q(T_k). The map v -> v/bar(v) on the six global
Eisenstein units has image exactly the three cube roots. We may
thus write beta_(q,k) as the ratio of a unit-rotated actual root
v_(q,k)w_k and its conjugate.

Every collection of these beta ratios on different actual indices
is still multiplicatively independent: cube any integer-exponent
relation to eliminate all tau factors, then use independence of
the original alpha_k. This recovers every signed exponent.
No independent unit root is adjoined.

For fixed q the choices can be made once on the whole set of its
hits, consistently at all precisions. They depend on which actual
arm is hit, hence in general on q. This is not a single normalized
ratio map fixed for all primes simultaneously. There are only three
possible twists per index, but they cannot be silently identified.

The norm-one n-torsion group H_(q,e) has at most n elements.
At precision one the split norm-one group is isomorphic to F_q^*;
in the inert case it is the norm-one subgroup of F_(q^2)^*.
Both are cyclic. Since q does not divide n, each n-torsion element
has exactly one lift through each principal q-kernel. Equivalently,
the n-th power map is invertible on these kernels. Thus the cardinal
bound holds at every precision. This is the same established
simple-lifting argument, with n in place of 3n.

## US2. Gram rigidity for signed products of bounded length

Let e,nu be positive integers with

    e log q>=2nu L.                              (US4)

Restrict to I_e(q)={k in I:q^e|T_k}, of size M_e.
For an integer exponent vector x=(x_k) on these indices with
sum_k |x_k|<=nu, represent its beta-product as z_x/bar(z_x):
use v_(q,k)w_k when x_k is positive and its conjugate when it is
negative, with the specified repetitions. Use z_0=1.
These are actual nonzero Eisenstein integers. Their norm satisfies

    |z_x|=sqrt(Nz_x)<=(6B)^nu.                   (US5)

This includes the empty product and every smaller length.
Units and conjugation preserve the norm.

For any two Eisenstein integers z=R+S*zeta and z'=R'+S'*zeta,
the actual Gram identity is

    4N(z)N(z')-(2RR'+RS'+SR'+2SS')^2
        =3(RS'-R'S)^2.

Therefore the integer determinant D=RS'-R'S for the two products
has the uniform bound

    |D|<=(2/sqrt(3))|z_x||z_y|
         <=(2/sqrt(3))(6B)^(2nu)<(8B)^(2nu).     (US6)

The final inequality follows for every nu>=1 from

    (2/sqrt(3))(3/4)^(2nu)
       <=9/(8sqrt(3))<1.

It needs neither equal lengths, a small argument, nor cancellation
of a highest-degree term.

If the beta-products agree modulo q^e, their conjugate cross
difference is divisible by q^e. The factor zeta-bar(zeta) is a unit
at q>3, so q^e|D. Now US4--US6 force D=0 and equality of the exact
algebraic ratios. Independence from US1 recovers x=y.
Thus the signed exponent vectors in this l1 ball inject into the
actual finite n-torsion group H_(q,e).

The exact cardinality of the integer l1 ball is

    C(M,nu)=sum_(j=0)^min(M,nu)
                  2^j choose(M,j) choose(nu,j).  (US7)

To prove this, select j nonzero coordinates, choose their signs,
and choose their positive absolute values with sum at most nu.
The latter count is choose(nu,j), by subtracting one from each and
adding a slack coordinate. The j=0 term counts the zero vector.
This also covers M=0. Consequently

    C(M_e,nu)<=|H_(q,e)|<=n.                     (US8)

The slack coordinate is only combinatorial. Opposite signs on one
index are not independently selected: the vector has one net signed
exponent, represented canonically as above.

Useful exact special cases are

    C(M,2)=2M^2+2M+1,
    C(M,3)=(4M^3+6M^2+8M+3)/3,
    C(2,nu)=2nu^2+2nu+1.                         (US9)

They follow by expanding US7, including the small M or nu cases.

## US3. A single owner and the complete actual layer budgets

Put r=ceil(sqrt(n/2)). Then 2r^2>=n and r<=sqrt(n) for n>324.
For the latter inequality use
sqrt(n/2)<=(3/4)sqrt(n) and 1<=sqrt(n)/4.
For every prime q>8B define

    h=max(4,ceil(2rL/log q)).

The choices (e,nu)=(4,2) in US8 give

    M_4<=sqrt(n/2).                              (US10)

At (e,nu)=(h,r), if M_h>=2 the vectors supported on just two
indices give

    n>=C(2,r)=2r^2+2r+1>n,

a contradiction. Thus M_h<=1.

The full layers from 4 through h-1 have total cost at most

    (h-4)M_4 log q<=2r sqrt(n/2)L
                         <=sqrt(2)nL<(3/2)nL.

If h=4 that range is empty. All remaining layers belong to at most
one actual index; its entire depth is at most nL by US1. Hence

    sum_(k in I)(v_q(T_k)-3)_+log q <=(5/2)nL,
    (1/B)sum_(k in I)(v_q(T_k)-3)_+log q/t_k<=5/B. (US11)

These hold for every prime q>8B, with no upper bound on q.
All positive layers are counted; subtracting four absorbs the
integer ceiling error.

There is also a smaller complete remainder after removing the
single actual index of largest depth. Set

    h0=max(4,ceil(6L/log q)),
    h1=max(h0,ceil(2rL/log q)).

US8--US9 give

    M_4<=sqrt(n/2),     M_(h0)<n^(1/3),     M_(h1)<=1. (US12)

The second inequality uses (4/3)M^3<C(M,3)<=n.
The actual maximum-depth singleton O_q (or empty set for empty I)
contains all h1-deep indices. All remaining depths are below h1.
The full two-range inequality from OC therefore gives

    sum_(k in I\O_q)(v_q(T_k)-3)_+log q
       <=(6M_4+2rM_(h0))L
       <=5sqrt(n)L+2n^(5/6)L<=7n^(5/6)L.         (US13)

Here 6/sqrt(2)<5. Adding back the one whole-depth cap gives
(n+7n^(5/6))L. The normalized remainder is at most
14 n^(-1/6)/B per prime, without claiming that the unrestricted
sum of these bounds is small.

If log q>=(r/2)L, then h0=h1=4, so at most one actual root
has depth at least four. If the stronger inequality log q>=2rL
holds, US8 applies with e=1,nu=r and shows that q divides T_k
for at most one actual root of I at ANY positive depth.
These two support statements have different thresholds.
The first allows other roots to have depths one, two or three.
Neither forbids many different prime labels on one root.

## US4. Exact implications and remaining interfaces

Every supported q>8B has rank n and q=1 or -1 modulo 3n as in AP.
Thus the same primary Brun--Titchmarsh estimate and US11 give,
for real Z>8B,

    (1/B)sum_(k in I)
      [sum_(8B<q<=Z)(v_q(T_k)-3)_+log q]/t_k
       <=10Z/[B(n-1)log(Z/(3n))]
       <=11Z/[Bnlog(Z/(3n))].                   (US14)

For AP's actual finite far deep-prime set D_Z(I), the complete
far positive mean is at most 5|D_Z(I)|/B. The hypothesis
|D_Z(I)|=o(B) is still unproved. The estimate changes constants
and the height threshold at which a prime has one actual owner;
it does not by itself enlarge the known useful asymptotic window.

In the strongest support region just described, a prime cannot
provide both a high-depth debit at one root of I and a depth-one
or depth-two credit at another root of I: its entire support there
is a singleton. Credits at different primes and at roots outside I
remain possible, and have not been controlled here. This is an
actual support boundary, not a negative conclusion about the
global signed target.

The normalized beta ratios may differ with the prime, and repeating
the fixed-prime moment proof does not create one common finite target
for all primes. The exact full prime-power packets in VG, further
cross-prime relations, private-label cardinality or weight bounds,
pointwise exceptions and the independent-domain complement remain
separate unresolved interfaces. No statistical distribution for the
actual primes or roots is assumed.

All ingredients beyond the stated new construction are the already
proved primitive-power/unit identities, Gram identity, actual
height bounds, split/inert simple lifting and multiplicative
independence of the chosen domain. No new analytic citation or
finite experiment is needed for US1--US13; US14 uses the same
reviewed primary Brun--Titchmarsh theorem as AP.
