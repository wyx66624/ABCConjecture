# UD1--UD3. Two certified zeros on the unit representative disk

Next-only complete ordinary candidate, 2026-09-07. This concerns the fixed
genus-two QC function, not its complete rational locus or a moving family.
It uses the audited HT/LH/ZS results. All series errors below are bounds
for the entire omitted tail in a Banach algebra, not numerical agreement.

Write

    C: W^2=z^6-27z^4+99z^2-9,
    E1: y^2=x^3-9x-9,       E2: y^2=x^3-189x+999,
    R1=((z^2-9)/4,W/8),
    R2=((33-9/z^2)/4,-9W/(8z^3)).

Let F0 be ZS9, Omega=-(4/3)log5(3), and f=F0-Omega. On the disk

    z=1+5s,  s in Z5,       W(1)=8,                 (UD1)

the ordinate is the unique analytic branch congruent to 8 modulo 5.
The coefficient constants alpha_i mean the exact zero-slope constants
of ZS, not approximations. Define A=Z5<s>, the ring of restricted power
series, and v_A(sum c_j s^j)=inf_j v5(c_j). A series in A has coefficients
tending to zero. It converges at every s in Z5, and its derivative lies
in A. We use the complete Gauss valuation on Q5<s>.

## UD1. Integral analytic functions and a uniform error budget

On this disk f/5 belongs to A. More precisely, put

    psi=psi_9,
    phi=x psi_9^2-psi_10 psi_8,
    omega9=(psi_11 psi_8^2-psi_7 psi_10^2)/(4y).

These are the normalized division polynomials, with
[9](x,y)=(phi/psi^2,omega9/psi^3). Therefore the rational functions

    delta=-phi/omega9,       T=-phi psi/omega9         (UD2)

are respectively ZS's delta and formal parameter t([9]Q), with no
division by psi at a nine-torsion point. For both actual maps on UD1,
phi and omega9 are units in A and psi is in 5A. Hence

    T_i in 5A,   delta_i in A^*,
    Xi=z^81 delta_1/delta_2 in A^*.                   (UD3)

Proof of the unit assertions. First use u=z-1 as a formal parameter.
The square-root equation and 2W(0)=16 being a 5-adic unit give
W(u) in 8+u Z5[[u]], with W'(0)=6. All quotient coordinates lie in
Z5[[u]], with both ordinates units. The division recurrences divide
only by 2y or 4y, which are units in this ring. The complete finite
calculation in UD2 gives, for each quotient at u=0 modulo 5,

    psi_9=0,       phi=1,       omega9=1.

Substituting u=5s sends every integral formal series to A, with the
degree-j coefficient divisible by 5^j. An integral formal series
with unit constant has an integral inverse. Thus phi and omega9
are units on the entire disk, not just the center. The assertion
psi in 5A follows from its divisible constant and the substitution.
This proves UD3 and removes every apparent nine-torsion denominator.

All coefficients of the logarithmic derivative of Xi with respect
to u are integral. In particular, with beta=Xi'(0)/Xi(0) in Z5,

    log5 Xi(s)-log5 Xi(0) = 5 beta s mod 25A.          (UD4)

For a direct full-tail proof, Xi(s)/Xi(0) lies in 1+5sA and is
1+5 beta s modulo 25A. In log(1+h), h in 5A, every term h^j/j
with j>=2 has Gauss valuation at least j-v5(j)>=2, tending to
infinity. Thus the entire logarithm tail is in 25A. Its constant
log5 Xi(0) is in 5Z5 because Xi(0) is a rational 5-adic unit.

ZS's coefficient bounds hold in the same Banach algebra:

    v_A(r_j T_i^j)>=j-2 floor(log5 j),
    v_A(l_j T_i^j)>=j-floor(log5 j).

Both bounds tend to infinity. Consequently the compositions converge
in Q5<s>, and the entire tails beyond degree N in T have Gauss
valuation at least ceil((N+1)/2). Since R0 starts in degree 4,
R0i(T_i) belongs to 25A. Also L_i(T_i)/9 belongs to 5A.
The exact constants alpha_i have valuation -1; hence each
alpha_i (L_i(T_i)/9)^2 belongs to 5A. Together with log5 Xi in 5A
and Omega in 5Z5 this proves f/5 in A. This reasoning also controls
derivatives: termwise differentiation on A does not decrease its
Gauss valuation. It therefore applies to the Hensel argument below.

For completeness the ordinary infinite tail used here is ZS5--6,
deduced from canonical sigma integrality and the exact splitting
identity. Finite inspection of the coefficients through degree 40
is not being used as a proof of that bound.

## UD2. The exact reduction of the full function

The exact coefficient congruence is

    f(s)/5 = 2s(s+1) mod 5A.                         (UD5)

Here is a complete finite calculation of the only new local constant.
Work in F5[e]/(e^2), with z=1+e and W=8+6e, so e represents the
unscaled derivative d/dz. The quotient coordinates are

    (x1,y1)=(3+3e,1+2e),
    (x2,y2)=(1+2e,1+4e).

Use the standard initial values

    psi_0=0, psi_1=1, psi_2=2y,
    psi_3=3x^4+6ax^2+12bx-a^2,
    psi_4=4y(x^6+5ax^4+20bx^3-5a^2x^2-4abx-8b^2-a^3)

and, for all larger indices in the calculation,

    psi_(2m+1)=psi_(m+2) psi_m^3-psi_(m-1) psi_(m+1)^3,
    psi_(2m)=psi_m/(2y)
              *(psi_(m+2) psi_(m-1)^2-psi_(m-2) psi_(m+1)^2).

Every division here has nonzero constant modulo 5. The complete
table lists (constant,e coefficient), for indices 0 through 11:

| n | psi_n on E1 | psi_n on E2 |
|---|-------------|-------------|
|0|(0,0)|(0,0)|
|1|(1,0)|(1,0)|
|2|(2,4)|(2,3)|
|3|(2,1)|(1,4)|
|4|(2,2)|(4,1)|
|5|(3,0)|(1,0)|
|6|(3,3)|(4,2)|
|7|(3,1)|(3,4)|
|8|(4,4)|(4,2)|
|9|(0,4)|(0,1)|
|10|(1,0)|(1,0)|
|11|(2,1)|(2,1)|

It follows by the displayed formulas, with no division by psi_9,
that

| function | E1 | E2 |
|----------|----|----|
|phi|(1,1)|(1,3)|
|omega9|(1,4)|(1,2)|
|delta|(4,3)|(4,4)|
|(d/dz)log delta|2|1|

Since Xi=z^81 delta_1/delta_2,

    beta=81+2-1=2 mod5.

Thus the contribution of the logarithm of Xi to
(f(s)-f(0))/5 is -2 beta s/81=s modulo 5A, by UD4.
The two R0 terms make no contribution, by UD1.

Let ell_i(s)=log_(E_i)(R_i(s))=L_i(T_i(s))/9. Direct pullback of
the invariant differentials gives

    d ell_1/dz=2z/W,       d ell_2/dz=-2/W.

At the center these are 1/4 and -1/4, respectively. The established
exact HT/QL leading digits are

    log_E(P)/5=4 mod5,       log_E'(P')/5=2 mod5,
    H_01(P)=5 mod25,         H_02(P')=10 mod25.

These came from full-tail estimates in HT/ZS; no floating-point
rank or height input is used. Since R1(0)=P and R2(0)=-P', they give

    ell_1(s)/5=4+4s mod5A,
    ell_2(s)/5=3+s mod5A,
    5 alpha_1=1 mod5,       5 alpha_2=3 mod5.          (UD6)

To justify that the linear differential computation controls the
entire ell_i tail, its pullback has coefficients in Z5[[u]].
Integrating a degree-j coefficient and substituting u=5s gives
valuation at least j+1-v5(j+1). For every j>=1 this is at least 2
and tends to infinity. Therefore all higher terms lie in 25A.

The squared-log contribution, after subtracting its value at s=0
and dividing by 5, is consequently

    -(4+4s)^2+3(3+s)^2-(-4^2+3*3^2)
       =s+2s^2 mod5A.

Finally f(0)=0 exactly: the center (1,8) is an actual rational point
of C, so the already proved global-height identity and LH's complete
away-from-five value set give F0(1,8)=Omega. This is a necessary
rational-point identity, not an assumption about any other zero.
Adding the logarithmic slope s proves UD5.

The division-polynomial conventions and rational multiplication
formulas used above can also be checked in Andrew Sutherland's
MIT 18.783 Lecture 5 (2023), section 5.5, printed pages 10--12:
https://math.mit.edu/classes/18.783/2023/LectureNotes5.pdf .
The integer recurrences and our complete dual-number table are
included to make the finite computation directly reproducible.

## UD3. A complete zero certificate on this disk

On the disk UD1, f has exactly two zeros, both simple. They are:

* the rational point (z,W)=(1,8), corresponding to s=0;
* one uniquely specified Q5 point with s=4 modulo 5, equivalently
  z=21 modulo 25 and W=3 modulo 25.

This does not assert that the second point is rational over Q.

Proof. Set g=f/5 in A. Its reduction is the polynomial 2s(s+1).
Its only roots in F5 are 0 and 4, and its derivatives at them are
2 and 3. On any residue disk a+5Z5 with either a, integral restricted
power series obey the usual Taylor estimate

    g(x+h)=g(x)+h g'(x) mod h^2 Z5,

and the derivative is a unit throughout the disk. Newton iteration
therefore converges to a root, with precision at least doubling at
each step. If x,y are two roots in that disk, the difference formula
g(x)-g(y)=(x-y)(g'(y)+(x-y)H), with H in Z5, forces x=y.
The Taylor and difference statements follow termwise for polynomials
and extend to restricted series by completeness. Thus there is
exactly one root above each of 0 and 4. All other residue classes
are excluded by UD5. The root above 0 is the known exact center.
At both roots g' is a unit; f'=5g' with respect to s is nonzero,
so the zeros are simple. The first-order square-root expansion
W=8+30s mod25 gives W=3 mod25 at the second root. QED.

Combining with the independently checked DS symmetry gives exactly
eight zeros on the four disks with z=+/-1 modulo 5. Four are the
known points (+/-1,+/-8). The other four form one symmetry orbit
of the second point above. Every zero in these four disks is simple.
The zero, infinity, and +/-2 disk orbits have not been certified by
this result. In particular their possibly even central multiplicities
have not been bypassed.

The work still needed for a full rational-point computation includes
the other three representative disks and a rational/Mordell--Weil
sieve to decide which additional analytic zeros are rational. Even a
complete fixed-curve answer would not supply uniform bounds for the
varying exponents, residuals, integral reconstructions, or point heights
required by the parent ABC problem.
