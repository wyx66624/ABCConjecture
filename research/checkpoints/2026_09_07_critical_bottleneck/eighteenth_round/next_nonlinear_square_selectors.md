# NP1--NP4. Root-parameter selectors that retain an actual pure square

Next-only complete ordinary candidate, 2026-09-07. The map is nonlinear
in the output coordinates: impose the different-owner congruences on
the root parameter first, and then square the actual root. This retains
the exact pure-power representation lost by the affine output map LM.
It concerns exponent two, not the moving prime-index US domain. All
marked data are fixed in its density assertion.

## NP1. The primitive power and its complete linear factorization

For an integer k>=1 set w_k=3k+zeta, zeta^2-zeta+1=0. Its actual
square is Z_k=w_k^2=A_k+C_k zeta, where

    A_k=9k^2-1,       C_k=6k+1,
    c_k=A_k+C_k=3k(3k+2).

All three integers are positive, and A_k+C_k=c_k is primitive. Its
entire boundary, without an omitted cofactor, is

    T(k)=A_k C_k c_k
        =(3k-1)(3k+1)(6k+1)(3k)(3k+2).                (NP1)

The root is unramified, with N(w_k)=9k^2+3k+1=1 modulo 3. For EVERY
prime q dividing T(k), the root norm is a q-unit.

Proof. Squaring with zeta^2=zeta-1 gives the formulas. A common divisor
of A_k and C_k divides both 4A_k-C_k^2 and 2C_k, and hence divides
3, because 4A_k-C_k^2=-2C_k-3. But A_k=-1 modulo 3, so their gcd
is one. The other pairwise gcds are also one by c_k=A_k+C_k.

Norm multiplicativity gives

    N(w_k)^2=A_k^2+A_k C_k+C_k^2.

If q divides one of the three pairwise coprime arms, this right side
modulo q is the square of a unit (also when q divides their sum).
Thus q cannot divide N(w_k). This argument requires no factorization
of unmarked primes. The displayed congruence at three proves
nonramification directly. QED.

## NP2. Simultaneous exact packets with arbitrarily many owners

Fix a finite nonempty set S of primes q>5. For each q in S fix a
positive integer owner k(q), and its actual positive depth

    e_q=v_q(T(k(q)))>=1.

Different primes may have different owners; no common-hit condition
is imposed. Put M=product_(q in S) q^(e_q+1). The integer CRT gives
a positive integer k0 satisfying

    k0=k(q) mod q^(e_q+1) for every q in S.             (NP2)

Let E=S union {2,3,5}. For p in E define

    F_p=v_p(T(k0)),
    H=product_(p in E) p^(F_p+1),
    K=product_(p in E) p^F_p.

Then M divides H. For every integer j>=1 let

    k_j=k0+Hj,          Z_j=(3k_j+zeta)^2.

Each Z_j is an actual primitive unramified pure square. For every
p in E the complete boundary has exact depth F_p. In particular
v_q(T(k_j))=e_q for every marked q, its root norm remains a q-unit,
and its complete selected signed cost is exactly

    sum_(q in S)(e_q-3)log q.                          (NP3)

Proof. Use the polynomial identity (NP1), not a putative independent
prime assignment. The congruence (NP2) gives exact valuation e_q,
since one more digit than the valuation was fixed. Thus F_q=e_q
and M divides H. For each p in E, k_j=k0 modulo p^(F_p+1), so the
same polynomial congruence preserves the exact depth F_p. NP1
supplies primitive positivity and all the norm-unit conclusions.
Equation (NP3) retains the terms at depths one and two as well as
the positive costs at larger depths. QED.

## NP3. A complete squarefree sieve on the unchanged pure-power family

With all data above FIXED, there is a set G of positive integers of
natural density

    d(G)=product_(p not in E)(1-5/p^2) >= 1/6            (NP4)

such that every j in G has

    T(k_j)=K R_j,
    R_j squarefree, gcd(K,R_j)=1,
    every prime of R_j lies outside E.                 (NP5)

Consequently the ENTIRE signed cost, including all negative terms, is

    J(Z_j)=sum_(p|T(k_j))(v_p(T(k_j))-3)log p
          =-2log T(k_j)+3log(K/rad(K)).                 (NP6)

As j in G tends to infinity,

    J(Z_j)/log c_(k_j) -> -5,
    log rad(T(k_j))/log c_(k_j) -> 5/2.                (NP7)

One can take the explicit all-good-index bound

    c_(k_j) <= [15/324^(2/5)](K/rad(K))^(2/5)
                         rad(T(k_j))^(2/5).           (NP8)

Proof. At every p outside E, the five factors in NP1 become affine
integer polynomials in j, all with p-unit slopes. In the variable
a=3k their roots are

    1, -1, -1/2, 0, -2.

These are distinct modulo p for p>3: after multiplication by two,
all nonzero differences between 2,-2,-1,0,-4 have prime divisors
only two or three. The change a=3k0+3Hj is invertible modulo p^2.
Thus there are exactly five simple forbidden roots modulo p^2,
distinct already modulo p. In particular p^2 dividing the product
forces p^2 to divide a single factor; two different factors cannot
each contribute one power of p.

For a fixed finite cutoff Y, the CRT density for excluding these
five classes at every p<=Y outside E is the corresponding finite
product. To treat all omitted primes, let X>=1 be real. For
1<=j<=X every positive linear factor is at most C0 X, where

    C0=6(k0+H)+1.

If p^2 divides a factor, then p<=sqrt(C0 X). Counting its five
possible residue classes therefore proves the complete tail bound

    #{1<=j<=X: some p>Y, p not in E, p^2|T(k_j)}
      <=5X sum_(p>Y)1/p^2+5sqrt(C0 X).                 (NP9)

Divide by X and let X tend to infinity, then let Y tend to infinity.
The finite-CRT upper and lower bounds yield the exact natural density
in NP4. Every prime outside E is at least seven. Hence

    sum_(p>=7)5/p^2 <=5 sum_(m>=7)1/m^2
                     <5 integral_6^infinity x^-2 dx=5/6.

The elementary finite inequality product(1-u_i)>=1-sum u_i, passed
to the convergent product, proves the lower bound 1/6. No assertion
about squarefree values of irreducible high-degree polynomials, no
prime-density heuristic, and no omitted large-prime range enters
this proof. The exceptional primes 2,3,5 and all marked primes are
already completely frozen rather than discarded.

The exact finite depths in E and depth zero or one outside it prove
NP5. Thus rad(T)=T/(K/rad(K)), which proves NP6. The five positive
linear factors give log T=5log j+O(1), whereas c=9k_j^2+6k_j gives
log c=2log j+O(1). These prove NP7.

Finally for every k>=1,

    T(k)>=324 k^5,       c_k<=15k^2.

The first inequality uses the five lower bounds 2k,3k,6k,3k,3k
in NP1. Eliminating k and using the radical identity gives NP8
with the stated explicit constant. QED.

This is positive density in the parameter j; as a set of all positive
root indices k it has density d(G)/H>0. It contains infinitely many
actual pure squares satisfying the exact arbitrary finite marked
packets, not just formal local assignments or newly uncompressed
affine outputs.

## NP4. Positive-cost nonrectangular inputs and precise scope

A concrete two-owner positive-cost packet is

    k(19)=4973918=21720+2*19^5,
    k(13)=4888691=61882+13^6.

Their second coordinates in NP1 are 19^4*229 and 13^5*79. At a
prime q>3 dividing 6k+1, the other coordinate 9k^2-1 is -3/4
modulo q. Thus the whole boundary depths are exactly four and
five. The marked norm is 3/4 modulo q, also a unit. The other
owner has no hit at the marked prime: k(19)=1 modulo 13 and
k(13)=10 modulo 19, and substitution in the five factors verifies
the unit condition. The selected cost is log(19)+2log(13)>0.

NP2 now uses these ACTUAL root-parameter residues modulo 19^5
and 13^6; NP3 proves infinitely many resulting pure-square outputs
with that same positive packet and enough new negative credit to
satisfy the exact full identity NP6. The owner roots and exact
depths were already checked in LM's finite certificate. This note
does not claim a new full factorization of the infinitely many
output boundaries or an extra software run.

The nonlinear map is essential to the stated correction: CRT acts
on k before the square, so the output retains residual coefficient
one and exponent two. In the previously used unit-residual convention
lambda=1/n, its parameter is fixed at 1/2. It does not tend to zero.
The outputs are not elements of the original n>324 prime, B=n^4
moving family; here k ranges in one fixed arithmetic progression.

All marked primes and depths, k0,H,K and C0 are fixed when taking
the density limit. Although the lower density and the prefactor in
NP8 are explicit, K/rad(K), H and the useful tail threshold may be
large and depend on the full packet. No uniform moving-packet cost
bound follows. Arbitrary original roots outside the good set, changing
exponents, general residual profiles, and the original far signed
tail remain open.

For a different exponent the analogous true boundary factorization
must be determined before using a squarefree-value theorem. In
particular, the linear-factor proof NP9 cannot simply be applied to
the degree-3n boundary as a single polynomial: it relies on every
individual factor having degree one and on their distinct roots
outside the frozen finite set.
