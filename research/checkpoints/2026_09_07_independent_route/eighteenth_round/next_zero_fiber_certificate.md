# ZD1--ZD3. Complete exclusion of the two zero-fiber disks

Next-only complete ordinary candidate, 2026-09-07. We retain the fixed
curve, quotient models, exact height constants, and f=F0-Omega of ZS/UD.
This handles a removable quotient pole and a double residue root.
It does not assume that either zero-fiber center is rational or a zero.

Choose the representative disk

    z=5s, s in Z5,       W(0)=W0=sqrt(-9)=1 mod5.     (ZD1)

We prove that f has no zero on it. The hyperelliptic involution
then gives the same result on its companion disk.

## ZD1. The pole cancels to an integral even unit

As before let A=Z5<s>. All of the following are identities of the
actual analytic functions on ZD1, including their central values.

For a good integral short Weierstrass model at five, the parameter
t=-x/y and the formal multiplication map satisfy

    t([9]Q)/t=9+t Z5[[t]],
    t^80 psi_9(Q)=9+t Z5[[t]].

The first is the integral formal group law, whose multiplication
linear term is nine. For the second, psi_9 is an integral polynomial
in x of degree40 with leading coefficient9, and x=t^-2 times an
integral unit series with constant1. Both series on the right have
unit constant at five. Thus

    d(t):=delta(Q)/t^81
         =(t([9]Q)/t)/(t^80 psi_9(Q))
          belongs to 1+t Z5[[t]].                   (ZD2)

In fact d is even: delta is odd under Q->-Q, and t changes to -t.
No unproved assertion about integral sigma coefficients is needed
for this rational removable-factor calculation.

On C the original parameter of R2 is exactly

    tau(z)=t(R2)=2z(11z^2-3)/(3W(z)).                (ZD3)

W(z) is an even integral series with unit constant W0. Therefore
tau is odd, tau/z is an integral unit with constant -2/W0, and
R2 lies in the formal group throughout the disk, including O at
its center. It follows from ZD2 that

    Xi(z)=(z/tau(z))^81 delta_1(R1(z))/d_2(tau(z))    (ZD4)

is an integral unit series in z. It is even. Indeed R1(z) is even,
z/tau is even, and d_2 is even. The actual finite value is

    Xi(0)=delta_1(-9/4,W0/8)*(-W0/2)^81.             (ZD5)

For the first quotient the center's normalized division values
modulo five are psi9=0, phi=4, omega9=2. Hence its delta=-phi/omega9
is an integral unit and its T1=t([9]R1) belongs to 5A, by the
same integral-series inverse argument as UD1. For the second
quotient, tau belongs to 5A and the integral formal group law gives
T2=t([9]R2) in 5A. All R0/log composition bounds of UD1 therefore
apply to both maps, so g=f/5 belongs to A.

Evenness is particularly useful here. Since Xi(z)/Xi(0) belongs
to 1+z^2 Z5[[z]], its logarithmic change after z=5s belongs to
25s^2 A. Both this assertion and the R0 estimates are full-tail
statements: the logarithm is a Gauss-convergent sum with input
in25A, and the R0 compositions use the reviewed ZS coefficient
bounds. Thus the local-height part of g has no nonconstant term
modulo five. The whole g is even, either directly from the signs
of the two quotient logarithms or from DS3.

## ZD2. The exact first reduction and the central obstruction

The normalized full function satisfies

    g(s)=2s^2 mod5A,       g(0)=20 mod25.            (ZD6)

Here are the finite inputs and their exact precision justification.
The two Hensel lifts of the chosen central branch needed below are

    W0=21 mod25,       W0=46 mod125.

They satisfy W0^2=-9 in their respective rings and have 2W0 a unit.
Use the actual point (-9/4,W0/8) on E1 in the normalized division
recurrences of UD. The results are

|quantity|modulo25|modulo125|
|---|---|---|
|Xi(0), using ZD5|16|66|
|log5 Xi(0)|15|15|
|T1(0)|20|95|
|ell_1(0)/5|1 mod5|16 mod25|
|log5(3)|20|95|

All rational denominators here are units, including those in the
cancelled formula ZD5. Therefore substituting the indicated Hensel
residues gives the true function values at their stated precision.
Unit logarithms are evaluated as one fourth of log(q^4). Modulo125,
the first two terms h-h^2/2, h=q^4-1, suffice: every j>=3 tail term
has valuation j-v5(j)>=3 and these valuations tend to infinity.
This is the same exact argument as SU2, not an approximate real log.

SU5, proved from parity and the ZS coefficient bounds, gives

    R0(T) in 5^4 A,       L(T)-T in 5^4 A.

Hence at precision125 we may omit the R0 terms and replace
ell_1=L_1(T1)/9 by T1/9; their errors in f are in 5^4 A.
The second quotient at the center is O, so T2=ell_2=0 exactly.
The exact global constants remain 5alpha_1=16, 5alpha_2=3 modulo25.

At first precision the table yields

    g(0)=-(2/81)*3-1^2+(4/3)*4=0 mod5.

For variation on the disk, the pullback differentials are
2z dz/W and -2 dz/W. Their full integral-primitive tails imply

    ell_1(s)/5=1 mod5A,
    ell_2(s)/5=(-2/W0)s=3s mod5A.

For the first equation there is no linear term in z; all subsequent
terms after z=5s have valuation at least2. For the second, all terms
beyond the linear one likewise have valuation at least2. The
justification is the uniform bound j-v5(j) on the coefficients of
an integral differential after integration and substitution, as
in UD2. The squared-log part consequently contributes
(5alpha_2)(3s)^2=3*9s^2=2s^2 modulo five. The even integral-unit
Xi and the R0 tails have no nonconstant contribution at this
precision. This proves the first identity in ZD6.

At second precision the same exact table instead gives

    g(0)=-(2/81)*3-16*16^2+(4/3)*19=20 mod25,

proving the second identity. No rational-point height identity has
been applied to the algebraic central point. Its value has been
computed directly from the cancelled analytic expression.

## ZD3. The entire central subdisk is excluded

Every root of g would reduce to s=0 modulo5 by ZD6. Since g is
an even integral restricted series, writing s=5t gives

    g(5t)=g(0) mod25 Z5<t>=20 mod25 Z5<t>.

The constant is nonzero; all nonconstant even terms are multiples
of25. Completeness of A gives the congruence for the full infinite
series and every t in Z5. This excludes the only possible root
residue; the other residues were already excluded by g=2s^2 mod5.
Thus there is no zero in the whole disk ZD1. DS then excludes
the second zero-fiber disk as well.

The canonical finite input is `next_zero_fiber_exact.json`, replayed
by `next_replay_zero_fiber.py`. The author actually ran write and
`--check`, both PASS. It computes Hensel residues, every normalized
division recurrence, unit logarithm fractions, and the exact global
alpha residues. The ordinary proof above supplies the removable
formal-group factor, integrality, complete tails, and the entire
subdisk exclusion. No finite enumeration is used as a substitute
for any of those analytic assertions.

This removes two more disks from the fixed QC zero problem. The
infinity orbit is being handled independently; the remaining issue
after a complete local zero inventory is rationality of the extra
UD zeros, followed by the separate uniform varying-family bridges.
