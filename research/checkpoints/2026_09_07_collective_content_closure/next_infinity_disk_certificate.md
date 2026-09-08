# IF1--IF3. The infinity disks contain only their rational double zeros

Next-only complete ordinary candidate. It uses the fixed HT/LH/ZS models,
the independently reviewed RD identities and DS symmetries. It is not a
Lean theorem, a complete rational-point classification, or an ABC result.

Put q=1/z and v=Wq^3. On the positive infinity disk one has

    v^2=1-27q^2+99q^4-9q^6,       v(0)=1,
    R1=((q^-2-9)/4, v/(8q^3)),
    R2=((33-9q^2)/4,-9v/8).

As usual let f=F0+(4/3)log_5(3), using ZS's locally analytic extension.
Set q=5s, s in Z5, and A=Z5<s> with its complete Gauss valuation.

## IF1. Unit denominators after cancelling the infinity factor

On this entire disk T_i=t([9]R_i) belongs to 5A. The cancelled

    Xi=q^-81 delta_1(R1)/delta_2(R2)

is an analytic unit. Before substituting q=5s, it has the stronger form

    Xi(q)=Xi(0)(1+q^2 B(q^2)),       B in Z5[[q^2]].       (IF1)

Proof. Hensel coefficient recursion gives v in 1+q^2 Z5[[q^2]],
and v is a unit as a formal series. The formal parameter of R1 is

    t1=-2q(1-9q^2)/v.

For the first elliptic curve write w=t^3 U(t), where the exact ZS
recursion gives U in 1+t^4 Z5[[t^2]], x=t^-2 U^-1 and
y=-t^-3 U^-1. The standard leading terms of division polynomials
are psi_9=9x^40+lower terms and phi_9=x^81+lower terms.
They can also be obtained directly from the recurrences in UD.
Hence D=phi' psi-2phi psi' has leading term 9x^120.
All these polynomials have integral coefficients. Consequently

    t^80 psi in 9+t^2 Z5[[t^2]],
    t^162 phi in 1+t^2 Z5[[t^2]],
    t^240 D in 9+t^2 Z5[[t^2]].

RD1 now proves, by inversion of the last integral unit,

    delta_1(t)=t^81 V(t^2),       V in 1+t^2 Z5[[t^2]],
    t([9]Q)=t(9+t^2 Z5[[t^2]]).                         (IF2)

Thus q^-81 delta_1(R1)=(-2)^81 times an even integral formal unit,
and T1 lies in q Z5[[q^2]]. No evaluation of an uncancelled pole
at q=0 is involved.

The second quotient is an integral even formal curve point with
center (33/4,-9/8). Its ordinate is a unit. At that center the
division recurrences give modulo five

    psi_9=0,       phi_9=4,       omega_9=2.

These are finite integer calculations, recorded with the complete
recursion output by `next_replay_infinity_inputs.py`. The actual
first jets in q^2 are (x,y)=(2+4e,2+3e), and the resulting jets are
psi_9=(0,3), phi_9=(4,3), omega_9=(2,1). In particular both required
denominators are units as formal integral series in q^2. Therefore
delta_2=-phi_9/omega_9 is an even integral unit, while
T2=-phi_9 psi_9/omega_9 has constant in 5Z5 and all other terms
in q^2 Z5[[q^2]]. Combining these conclusions proves IF1.

Substitution q=5s turns every integral formal series here into a
restricted series with coefficient decay. It gives T_i in 5A and
Xi/Xi(0) in 1+25A. The full logarithm expansion consequently yields

    log_5 Xi(q)-log_5 Xi(0) in 25A.                     (IF3)

Indeed its j-th term has Gauss valuation at least 2j-v5(j), tending
to infinity. This proves IF3 for the entire series. QED.

For the leading polynomial degrees used above, the external source is
[Sutherland, MIT 18.783 Lecture 5 (2023)](https://math.mit.edu/classes/18.783/2023/LectureNotes5.pdf),
Lemma 5.22, printed pages 12--13. The constant nine in D follows by
differentiating the stated leading terms, since 9(81-80)=9.

## IF2. The exact central height value, including all other primes

One has f(0)=0 exactly. This is proved directly here rather than
inferred by approximating the infinity point by global rational points.

Proof. The usual doubling law on E' gives

    2P'=(33/4,9/8),       R2(0)=-2P',       P'=(6,9).

As q tends to zero, the two singular terms from the first quotient
and the base coordinate combine as

    lambda_01(R1)-2log_5(z)
      =-2log_5(t1/q)-2R_01(t1) -> -2log_5(2).

Here t1/q tends to -2, log_5(-1)=0, and the whole R0 tail tends
to zero. Also log_E(R1) tends to zero. Local heights are even, and
the rank-one quadratic identity at 2P' gives

    F0(0)=-2log_5(2)-lambda_02(2P')+H_02(2P').        (IF4)

At two the point 2P' has x-valuation -2, and the derivative
3x^2-189 has negative valuation. Cremona case (a), in the already
audited twice-Silverman convention, gives local height 2log_5(2).
At three the exact values of the valuation tests from LH are

    v3(x)=1, v3(y)=2, A=5, B=2, C=6, v3(c4)=4.

Thus C>=3B, and case (c) gives local height -(4/3)log_5(3).
All other primes different from five have good reduction and integral
coordinates at this point, so their local heights vanish. Changing
the splitting to zero affects only the place five. Summing the
local heights of this actual rational point therefore gives

    H_02(2P')-lambda_02(2P')
       =2log_5(2)-(4/3)log_5(3).

Substitution in IF4 proves F0(0)=-(4/3)log_5(3) and f(0)=0.
The doubling coordinates and all the finite valuation tests are
independently reproducible by the accompanying exact verifier. QED.

## IF3. An exact even factor and a complete zero count

There exists U_infty in 1+5A such that on the positive infinity disk

    f(5s)=5 s^2 U_infty(s).                            (IF5)

Thus its only zero is the central rational infinity point, of
multiplicity exactly two. The negative infinity disk has the same
conclusion by DS. There are exactly two zeros on the two infinity
disks, both rational and both of multiplicity two.

Proof. Write ell_i=log_(E_i)(R_i). The actual differential pullbacks
in the q coordinate give

    d ell_1/dq=-2/v,       d ell_2/dq=2q/v,
    ell_1(0)=0,           ell_2(0)=-2log_(E')(P').

Termwise integration of the integral even series 1/v, followed by
q=5s, gives the full congruences

    ell_1(5s)/5=-2s mod5A,
    ell_2(5s)-ell_2(0) in25A.                         (IF6)

For clarity the integration denominators are controlled at every
degree: a term of degree j after integration and substitution has
valuation at least j-v5(j), tending to infinity. The first omitted
degree is three for ell_1, and the first degree is two for the change
in ell_2. These facts imply precisely IF6, including all tails.

By IF1, both T_i belong to 5A. The complete ZS coefficient bounds
then put R_0i(T_i) in 25A, as in UD; the same holds for their
differences from their values at the center. IF3 puts the change in
log Xi in 25A. The second logarithm square changes by an element of
125A, since ell_2(0) is in 5Z5 and its change is in 25A. Its alpha
has valuation -1, so that height term changes by an element of 25A.

Subtract f(0)=0 from ZS9. These complete error bounds show that
g(s)=f(5s)/5 lies in A and that only the first squared logarithm
contributes to its reduction modulo five. The established exact
height digit is 5alpha_1^0=1 modulo five. Therefore

    g(s)=-(5alpha_1^0)(ell_1(5s)/5)^2
         =-4s^2=s^2 mod5A.                            (IF7)

DS proves that this series is exactly even. Its constant term is
zero by IF2, so g(s)=s^2 U_infty(s) with U_infty in A. Shifting
coefficients in IF7 gives U_infty in 1+5A. Its value at every s
in Z5 is a unit. Thus s=0 is the only zero and has exactly order
two. The involution exchanging infinity signs preserves f and is
an analytic isomorphism, so the other disk has the identical count.
QED.

The finite input verifier does not prove the complete Gauss-norm bounds,
the global/local height identity or the analytic factorization IF5.
Those are ordinary arguments above. No numerical root search is used.
The other disk orbits and a rational sieve remain separate obligations.
