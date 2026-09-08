# Independent review: infinity certificate and the mixed 5/13 sieve bridge

2026-09-07. Next-only review; no publication source is changed.

## IF1--IF3: complete ordinary PASS

I read the complete root `next_infinity_disk_certificate.md`, SHA256
`3aa6ee04f3751bd2107852f058b6cf904bf5109e18bd4dd96b1a0ddea6a4269a`.
I also read the actual RD1 derivative identity and rechecked the relevant
LH local-height cases. The whole analytic and central-height proof passes.

The formal powers t^80 psi, t^162 phi and t^240 D have integral even unit
parts, with constants 9,1,9 respectively. In RD1, delta=-9phi/(yD), so
its leading coefficient after dividing by t^81 is exactly 1; the ninefold
formal parameter has leading coefficient 9. Thus the first quotient's
infinity pole cancels integrally, including its sign and coefficient.
The second quotient has unit phi/omega denominators at its actual even
center. Their inverses remain integral on the full disk, giving the
claimed even integral unit Xi and both T_i in 5A. The complete logarithm
tail of Xi/Xi(0) is in 25A.

At the center, R2=-2P' exactly. The local-height combination for the first
quotient tends to -2log5(2). At the rational point 2P'=(33/4,9/8),
the local tests give the case-(a) height 2log5(2) at two and the case-(c)
height -(4/3)log5(3) at three. Other away-from-five heights vanish.
The global quadratic identity therefore yields f(0)=0 exactly. This
does not approximate the central height using hypothetical nearby
rational points and includes both bad primes and the zero-slope change.

The actual differential pullbacks give ell1/5=-2s modulo 5A and an
ell2 change in 25A. All integrated tails are controlled by j-v5(j).
The second squared log consequently changes in 125A before its alpha
factor and in 25A afterwards. The complete R0 and Xi errors also lie
in 25A. Thus g=f(5s)/5 is integral with reduction s^2. Its exact evenness
and exact zero constant imply g=s^2 U with U in 1+5A. This proves the
unique central zero of multiplicity exactly two on each infinity disk,
including the absence of any additional zero throughout either disk.

I read the full `next_replay_infinity_inputs.py`, SHA256
`2c05c2a77bbd7600340d5221807cd9a970afff46d7e847b80f7b48178ffacc96`,
and independently ran `--check`. It passed with canonical SHA256
`9671a4f70cd70faf3ffa41e9dcca440d246ad7f824ac38fbe92f587ab6c63c95`.
This checks exact doubling, the finite local-height tests, division jets
and the leading alpha digit. The full analytic factorization remains
ordinary mathematics, not a claim supplied by those finite checks.

## The prime-to-five-index bridge: independent ordinary verification

I re-read the complete published QL2 argument, rather than assuming P
or P' is a global generator. It proves that each rational elliptic group
is torsion-free of rank one and that the index of its displayed cyclic
subgroup is finite and prime to five.

For either curve let d be that index and take any rational Q. There is
an integer a with dQ=aP. Since log(P) is nonzero,

    m(Q)=log(Q)/log(P)=a/d in Z_(5).

At the good prime 13 the reduced elliptic group has order 15. Therefore
chi(Q)=[3] red13(Q) lies in its subgroup killed by 5. Reducing dQ=aP and
inverting d modulo 5 in this subgroup gives

    [3] red13(Q) = (m(Q) modulo 5) [3] red13(P).

This is a valid relation between the rational-point subgroup, its 5-adic
logarithm and its good reduction at another prime. It does not identify
the local groups over Q5 and Q13, and it does not assume a global basis.

On the additional UD zero in its representative disk, s=4 modulo 5,
the already proved logarithm expansions give m1=0, m2=1 modulo 5.
The DS orbit gives (0,+/-1). Hence a rational point in this extra orbit
would reduce at 13 to a projective curve point satisfying

    [3]R1=O,       [3]R2=+/-(11,2).

I independently implemented all projective points and quotient images
over F13, without importing the root probe. The script is
`next_replay_log_reduction_sieve.py`; its write and `--check` runs passed
with canonical `next_log_reduction_sieve_exact.json` SHA256
`81a170b59dc2fe57e7cce97a67f66087449bfba80798d140b95ca62388895edb`.
It checks both elliptic point counts 15, the full 16 projective points
of C, and gcd(f,f')=1 over F13. It includes the genuine projective images
at z=0 and both infinities. No row satisfies either forbidden pair.

The quotient formulas have denominators prime to 13 on the nonzero
finite chart. Their projective extensions at zero and infinity are the
listed O/finite values, so the reduction argument omits no rational point
whose abscissa has nonzero 13-adic valuation. Together with a complete
local zero inventory, the relation therefore excludes all extra UD zeros
from C(Q). This review verifies the bridge and its finite table; the
root's final combined ordinary classification text is to be read
separately when available. No varying-family or ABC conclusion is drawn.

## Final combined SM1--SM3 review

I subsequently read the complete root `next_fixed_curve_rational_points.md`,
SHA256 `d74cdd8f7da9261b17e40cb8e76e13e38645a2b370216d74e49fc32fd09b3fab`.
**Full combined ordinary PASS.** The fixed conclusion is exactly

    C(Q)={(1,8),(1,-8),(-1,8),(-1,-8),infinity+,infinity-}.

The integer relation dQ=aP is used only through the rational group and
the subgroup killed by five after multiplication by three in E(F13).
The proof neither reduces an arbitrary Q5 number modulo 13 nor assumes
that P is a global generator. Both forbidden signs from the DS orbit
are included. I checked the printed polynomial Bezout identity for
smoothness coefficient by coefficient and all 16 projected rows against
my separately constructed table. The separate valuation discussion
covers every rational point reducing to z=0 or to infinity, so no
affine chart denominator restricts the sieve domain.

The local inventory is complete because the previously fully reviewed
UD/SU/ZD/IF certificates handle all four DS orbits: eight simple unit
zeros, none in the second unit or zero-fiber orbits, and two rational
double zeros at infinity. The necessity of the height condition for
rational finite nonzero points is the audited LH/QL identity. Zero
abscissa is already impossible over Q; infinity has been handled
directly. The four extra unit zeros have (m1,m2)=(0,+/-1) modulo five,
and the complete F13 obstruction excludes them. Conversely all six
listed rational points visibly lie on the projective curve. This closes
the fixed rational-point classification as an ordinary proof chain.

I also read the root's complete `next_replay_thirteen_sieve.py` and
independently ran its `--check`, which passed with canonical SHA256
`46adefa954c349500510973f452e551ab82125bfc3d5ade6a6ab0efba65515da`.
This is in addition to, and distinct from, my own earlier implementation
with SHA256 `81a170b5...895edb`. The root script checks the smoothness
Bezout coefficients, complete elliptic lists, group orders/projections,
all projective curve rows and both forbidden signs.

The conclusion remains limited to the displayed fixed genus-two curve.
The same-source inverse, second square, real inequalities and every
varying-exponent/residual or uniform ABC bridge are outside SM. The
analytic/rank/height dependency chain is ordinary, not a completed Lean
formalization. No broader conclusion is assigned to the finite table.
