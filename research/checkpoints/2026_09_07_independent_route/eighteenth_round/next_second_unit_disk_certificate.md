# SU1--SU3. Complete exclusion of the second unit disk

Next-only complete ordinary candidate, 2026-09-07. The fixed curve,
minimal quotient models, exact alpha constants, and function f=F0-Omega
are those of ZS and UD. This result concerns analytic QC zeros, and
does not alone classify the rational points of the curve.

Take the disk

    z=2+5s, s in Z5,       W(2)=sqrt(19)=2 mod5.      (SU1)

Its square-root branch is unique. We prove that **f has no zero
anywhere on this disk**. The DS involutions then exclude the full
four-disk orbit above z=+/-2 modulo five.

## SU1. The whole-function first reduction

As in UD, put A=Z5<s>. Then g=f/5 belongs to A and satisfies

    g(s)=4(s+1)^2 mod5A.                              (SU2)

Proof of analytic scope. With u=z-2, Hensel's equation gives
W in W(2)+u Z5[[u]]. Both quotient ordinates are units. All normalized
division-polynomial recurrences therefore have integral coefficients
in u, and substitution u=5s is restricted. For the same actual
functions phi,omega9,psi9,delta=-phi/omega9 and T=delta psi9 as UD,
the center reduction is

|function|E1|E2|
|---|---|---|
|psi9|0|0|
|phi|4|1|
|omega9|3|4|

Thus phi and omega9 are units over the entire disk, psi9 belongs
to 5A, and T_i belongs to 5A. Every logarithm and sigma argument
in the proof of UD1 applies verbatim: log Xi lies in 5A, the
composed R0 terms lie in 25A, the elliptic logarithms lie in 5A,
and the constants alpha_i have valuation -1. Consequently g is
an integral restricted series, with termwise differentiated tails
controlled in the same Gauss norm. No coordinate denominator is
being assumed nonzero merely because of a numerical center check:
its integral u-series has unit constant, hence a unit inverse.

Here the finite center calculation is at z=2 and W=12 modulo25.
The square-root congruence is exact: 12^2=19 mod25. The derivative
W'=-138/W is 1 modulo25. Evaluation of the complete normalized
division recurrences yields

|function, modulo25|E1|E2|
|---|---|---|
|psi9|15|15|
|phi|24|1|
|omega9|18|24|
|delta|7|1|
|T|5|15|

The derivative computation in F5[e]/(e^2), where z=2+e and
W=2+e, gives

|function (constant,derivative)|E1|E2|
|---|---|---|
|phi|(4,0)|(1,3)|
|omega9|(3,0)|(4,3)|
|delta|(2,0)|(1,1)|
|(d/dz)log delta|0|1|

Thus beta=(d/dz)log Xi=81/2+0-1=2 mod5. The local-height
linear contribution to g is -2 beta/81=1 modulo5. The exact
center values and logarithms are

    Xi=14 mod25,       log5 Xi=10 mod25,
    log5 3=20 mod25,
    ell_1/5=4 mod5,    ell_2/5=2 mod5.

Here ell_i=L_i(T_i)/9; since L(t)=t+O(t^5), with the coefficient
bound specified below, its reduction follows from T=(5,15).
The pullback differentials are still 2z dz/W and -2 dz/W.
Their values at this center are 2 and 4 modulo five. Their entire
integral-primitive tails, as in UD2, give

    ell_1(s)/5=4+2s mod5A,
    ell_2(s)/5=2+4s mod5A.

With 5alpha_i=(1,3) mod5 and Omega/5=3 mod5, direct substitution
in ZS9 now gives the constant 4, linear coefficient 3 and
quadratic coefficient 4. Equivalently g=4+3s+4s^2=4(s+1)^2
modulo5A, proving SU2. Unlike the UD center, this center is not
assumed to be rational or an exact zero.

## SU2. A second-precision obstruction on the only remaining subdisk

The only possible root residue of SU2 is s=4. At its exact
5-adic center z=22, with the branch W=2 mod5, one has

    g(4)=15 mod25.                                   (SU3)

Here is the complete precision justification and finite certificate.
At z=22 the square-root lift is W=32 modulo125; it satisfies the
actual sextic congruence, and the derivative 2W is a unit. The
quotient maps and delta/T rational functions have integral
coefficients and unit denominators, as proved in SU1. Therefore
these residues determine their true values modulo125 exactly.
The normalized division recurrences give

    Xi=24 mod125,
    T1=90 mod125,       T2=10 mod125,
    log5 Xi=100 mod125, log5 3=95 mod125.             (SU4)

For clarity the logarithm computation uses only units. If h=q^4-1
in 5Z5, then

    log5 q=(1/4)(h-h^2/2) mod125,

because for every j>=3 the j-th remaining term has valuation
at least j-v5(j)>=3, tending to infinity. Changing the chosen unit
representative by a multiple of125 also changes its logarithm only
by a multiple of125. Thus SU4 is an all-tail result, not an evaluation
of a double-precision logarithm.

The exact zero-slope coefficient bounds further imply, for any
T in 5A,

    R0(T) in 5^4 A,       L(T)-T in 5^4 A.           (SU5)

Indeed R0 is even and starts at degree4. For degree4 its valuation
bound is 4; degree5 is absent; degrees6 and7 have lower bounds4
and5; and for all degrees>=8 ZS's bound ceil(j/2) is at least4.
For L-T only degrees>=5 occur, and j-floor(log5 j)>=4 for all
j>=5. The Gauss valuations of these terms tend to infinity.
This proves SU5 for the entire compositions.

Consequently R0 contributes nothing modulo125 to f. In the squared
logarithms, replacing L(T)/9 by T/9 makes an error in 5^5 A before
multiplication by alpha, hence in 5^4 A afterwards. Thus it also
does not affect f modulo125, or g modulo25.

The already audited exact rational ZS calculation supplies

    5alpha_1=16 mod25,       5alpha_2=3 mod25.        (SU6)

One can recover these residues directly from its proved entries
H01=105, H02=10 modulo125 and ell(P1)/5=9, ell(P2)/5=22 modulo25:
21/9^2=16 and 2/22^2=3 modulo25. Its all-tail error for alpha
was at least 19 absolute 5-adic digits; the use here asks only for
two digits of 5alpha. These are rigorously transported exact
constants, not a new fitted height normalization.

From SU4, ell_1/5=2 and ell_2/5=3 modulo25. Substitution gives

    g(4)=-(2/81)*20-16*2^2+3*3^2+(4/3)*19
         =15 mod25,

as claimed. Every denominator displayed in this congruence is a
5-adic unit. The factor +4/3 is the sign in f=F0-Omega.

## SU3. Exclusion of the entire disk, not just its center

If g(s)=0, SU2 forces s=4 modulo5. Write s=4+5t. Since g is in
the integral restricted ring A and g'(4)=0 modulo5, its full Taylor
expansion gives

    g(4+5t)=g(4)+5t g'(4) mod25 Z5<t>
            =15 mod25 Z5<t>.

The quadratic and all higher powers of5t lie in25Z5<t>. Termwise
Taylor expansion and the derivative are legitimate in the complete
restricted ring, so this congruence covers every t in Z5. Its
nonzero right-hand side rules out all roots in the only possible
residue class. The remaining four residue classes were already
excluded by SU2. Therefore f has no zero in SU1. By DS symmetry,
there are no zeros on any of the four disks above z=+/-2 mod5.

The finite input is reproducible by `next_replay_second_unit_disk.py`
and the canonical `next_second_unit_disk_exact.json`. The author
actually ran write and `--check`; both passed. The result SHA256 is
`9c41ff73fad3875408856ff49e32c340cd6e272819eb17db8889dcf037f06dfa`.
The code includes all intermediate dual-number division recurrences,
Hensel square-root residues, exact unit logarithm fractions, and the
previously audited rational alpha computation. The analytic proof
above supplies what a finite table alone cannot: entire composition
tails, derivative control, and exclusion on a complete residue disk.

Together with UD, eight of the twelve residue disks are now handled
at the ordinary-candidate level: four have eight simple zeros in total,
and four have none. The two zero-fiber disks and two infinity disks
remain for separate analysis; no central simple-root hypothesis is
made there. Rationality of the additional UD zeros and all uniform
moving-curve questions remain open.
