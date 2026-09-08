# LH1--LH3. The complete away-from-five height-value set for the fixed curve

Status: complete ordinary candidate, submitted for two independent reviews.
This contains an exhaustive valuation argument, not a residue sampling
claim. It uses the global normalization fixed in HT and the local Neron
height formula stated below. Analytic zeros at five are not yet computed.

## Definitions, maps, and local normalizations

Let C be the smooth projective model of

    W^2=z^6-27z^4+99z^2-9.                              (LH1)

The standard BD elliptic curves F1,F2 and maps are

    F1: Y^2=X^3-27X^2+99X-9,
    F2: Y^2=X^3+99X^2+243X+81,
    f1(z,W)=(z^2,W),
    f2(z,W)=(-9/z^2,-9W/z^3).                           (LH2)

These maps extend to the smooth projective curves. Their minimal models
and the pulled-back points on them are

    E: y^2=x^3-9x-9,
    E': y^2=x^3-189x+999,
    R1=((z^2-9)/4,W/8),
    R2=((33-9/z^2)/4,-9W/(8z^3)).                      (LH3)

Both changes have scale u=2; their translations r=9,-33 differ.
Their integral discriminants are 2^4*3^6 and 2^4*3^10, with every
valuation below12, so these are globally minimal models.

For a finite prime l!=5 let chi_l(a)=-v_l(a)log_5(l), with
log_5(5)=0. Write h_{E,l},h_{E',l} for the ordinary local Neron heights
in twice-Silverman's normalization, using the minimal models. Thus at
a nonsingular point, h_{E,l}(R)=max(0,-v_l(x(R)))log_5(l).
At bad reduction use precisely the formula in LH1 below; it is the
usual real local-height coefficient multiplied by log_5(l).

For the standard F models use the Neron functions with the corresponding
Weierstrass tangential normalization. The change-of-variables rule is

    h_{F_i,l}(f_i(P))=h_{E_i,l}(R_i(P))+2chi_l(2).       (LH4)

Here E1=E, E2=E'. Indeed a normalized local height for the divisor 2O
has principal term -2chi_l(t), where t=-x/y. Under X=u^2x+r,Y=u^3y,
t_F=t_E/u+O(t_E^3), so the normalization changes by 2chi_l(u).
Uniqueness of the local Neron function with this normalization proves
LH4. This is also compatible with the local addition identity in BD
Lemma7.4: x_F(P)-x_F(Q)=u^2(x_E(P)-x_E(Q)). This rule concerns the
normalized LOCAL functions; the global scalar has no change because
sum_v chi_v(u)=0, as in HT.

The two constants in LH4 are equal. Consequently the exact local
combination used in BD Theorem1.4 is, without a model correction,

    J_l(P)=h_{F1,l}(f1(P))-h_{F2,l}(f2(P))-2chi_l(z)
          =h_{E,l}(R1(P))-h_{E',l}(R2(P))-2chi_l(z).     (LH5)

Initially this is on the chart z nonzero and finite; the locally
constant extension at z=0 and infinity is included below. No separate
height of the elliptic origin is substituted into a singular expression.

## LH1. The full three-adic calculation

For every P in C(Q3), the extended function satisfies

    J_3(P)=(4/3)log_5(3).                              (LH6)

Proof. First consider a finite point with z!=0 and put m=v_3(z).
If m>0, the right side of LH1 has valuation exactly2, with unit part
-1 modulo3. Indeed the other three terms have valuations 6m,3+4m,
2+2m, all greater than2. This is not a square in Q3. At z=0 the
same obstruction is W^2=-9. Hence all finite points have m<=0.

If m=0 then W is a unit, since the right side modulo3 is z^6.
If m<0 the z^6 term is uniquely dominant, giving v_3(W)=3m.
In either case the second minimal point (x,y)=R2 satisfies

    v_3(x)=1,  v_3(y)=2,  X:=x/3=11/4-3/(4z^2)=2 mod3. (LH7)

We now use the local height theorem, without inferring it from a
Kodaira type or a software table. For a minimal Weierstrass model set

    A=v_l(3x^2+2a2*x+a4-a1*y),
    B=v_l(2y+a1*x+a3),
    C0=v_l(3x^4+b2*x^3+3b4*x^2+3b6*x+b8).

If A<=0 or B<=0 the coefficient of log_5(l) is max(0,-v_l(x)).
Otherwise, if v_l(c4)>0 and C0>=3B, it is -2B/3.
These are cases (a) and (c) of Cremona Proposition3.4.1, printed
page72, which explicitly applies to all Q_l-points, and reproduces
Silverman Theorem5.2 in twice his normalization. Only those cases are
needed here; the convention v_l(0)=+infinity covers zeros.

For E' the needed division polynomial is

    psi3(x)=3x^4-1134x^2+11988x-35721,
    psi3(3X)=3^5(X^4+148X)-3^6(14X^2+49).              (LH8)

Since X=2 mod3, X^4+148X=0 mod3. Therefore C0>=6.
Also B=2, A=v_3(27(X^2-7))>0, and v_3(c4(E'))=4>0.
The indicated case gives h_{E',3}(R2)=-(4/3)log_5(3).

For E, if m=0 its ordinate W/8 is a unit; case (a) gives height0.
If m<0 its x-coordinate has valuation2m, and
v_3(3x^2-9)=1+4m<0. The same case gives height -2m log_5(3).
Thus h_{E,3}(R1)=-2m log_5(3) in both cases. Since
-2chi_3(z)=2m log_5(3), the m terms cancel, proving LH6 on
the finite chart.

There are two rational points at infinity, since the sextic is monic.
Every sufficiently close punctured Q3-neighborhood has m<0, where
the combination is the constant in LH6. It therefore extends with
that value at each infinity point. No z=0 Q3-point exists. This
exhausts the smooth projective Q3-points. The set is nonempty, for
example (z,W)=(1,8), so its value set is exactly the displayed singleton.
QED.

## LH2. The full two-adic and all good-prime calculations

For every finite prime l!=3,5 and every P in C(Q_l),

    J_l(P)=0,                                         (LH9)

with the same locally constant extension convention.

Proof at two. Put m=v_2(z) on the finite nonzero chart.
If m<0, the two x-coordinates in LH3 have valuations
2m-2 and -2 respectively. If m>0 their valuations are -2 and -2m-2.
For either curve and any negative x-valuation, the derivative
3x^2+a4 has valuation 2v_2(x)<0, so case (a) of the local theorem
gives height -v_2(x)log_5(2). Subtracting the two heights and adding
2m log_5(2) yields zero in both ranges.

If m=0, z^2=1 mod8 in Z2. Thus both x-coordinates are integral and
even: z^2-9=0 mod8 and 33-9/z^2=0 mod8. The equations of E,E'
then force their ordinates to be integral odd units. In either case
3x^2+a4 is odd, so the local coefficient is zero. This includes an
x-coordinate equal to zero. The character term is zero as well.
Thus all three valuation ranges give J2=0. There is no point with
z=0 since -1 is not a square in Q2; infinity is covered by the
constant punctured neighborhoods m<0.

Proof at l>3, l!=5. Both minimal elliptic curves have good reduction,
so the local height of an integral point is zero. If m=v_l(z)<0,
R1 has x-valuation 2m and R2 is integral; if m>0, R1 is integral
and R2 has x-valuation -2m. If m=0 both are integral. The constants
2,3 and33 occurring in LH3 do not cause an exception: when the term
-9/z^2 is dominant its leading coefficient is a unit, while in the
other ranges possible extra cancellation merely leaves an integral
x-coordinate. The same cancellation with 2m log_5(l) proves LH9.

At any Q_l-point with z=0 or z=infinity, every sufficiently close
point off that fiber has respectively m>0 or m<0. The combination
therefore extends as zero. This covers all projective chart exceptions.
Nonemptiness at every prime follows from (1,8). QED.

## LH3. The singleton Omega and a concrete remaining five-adic equation

BD Theorem1.4 defines Omega as the possible values of MINUS the sum
of J_l at the primes away from p=5. With exactly the character and
normalization above, LH1--LH2 prove

    Omega={-(4/3)log_5(3)}.                            (LH10)

There is no unfinished infinite-prime scan in this conclusion: all
l>3,l!=5 were dealt with together, and both bad primes individually.
The two exact local value sets and all stated extensions were proved
on the full local curve, not just on its rational global points.

For clarity, use the minimal functions to write a prospective analytic
expression on the five-adic finite nonzero chart:

    F(P)=h_{E,5}(R1)-h_{E',5}(R2)-2log_5(z)
          -alpha_E log_E(R1)^2+alpha_E' log_E'(R2)^2,

where the alphas are computed on the minimal models. HT's scale
formulas make this exactly the standard BD expression: the equal
local model constants cancel, while alpha_F log_F^2=alpha_E log_E^2.
Every rational point in this chart must satisfy

    F(P)=-(4/3)log_5(3).                               (LH11)

This follows also by summing local heights and using the global
rank-one identities, making the sign independently checkable.
With b=(1,8), it is equivalently F(P)-F(b)=0. This relative version
cancels any remaining uniform local additive convention, provided the
same conventions are used at P and b.

LH11 has not been solved, and no finite root list or root multiplicity
claim is made. The next work is to compute its Coleman/sigma local
terms, establish rigorous truncation errors on each required Q5 chart,
certify all analytic zeros, and carry out the rational sieve. The z=0
fiber is over Q(i), contains Q5-points but no Q-points, and the two
infinity points are rational and must be recorded separately if the
chosen expression omits them. The corollary involving translated
Q1=(0,3i) on F1 cannot assume Q1 is rational over Q; the direct
Theorem1.4 expression is being used. Finally the second square and
positive source condition for D remain additional tests after H=C is
classified. The moving-exponent and residual problems remain open.

## Primary inputs actually read

* Cremona, Algorithms for Modular Elliptic Curves, author chapter3,
  printed pp.72--73: twice-Silverman normalization, Proposition3.4.1
  explicitly over Q_l, and the complete finite local algorithm:
  https://johncremona.github.io/book/fulltext/chapter3.pdf .
  No Tate-algorithm output is an input to the proof here.
* Balakrishnan--Dogra arXiv1601.00388, Theorem1.4, Lemmas7.4/7.7,
  Algorithm8.3 and printed p.35 character convention:
  https://arxiv.org/pdf/1601.00388 .
* The standard normalized Neron-function uniqueness/change-of-parameter
  input is made explicit in LH4; HT gives the sigma calculation at five
  and the distinction between local constants and invariant global height.

There is currently no new Lean claim or numerical sampling certificate
for these universal local-value statements.
