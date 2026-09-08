# ZS1--ZS4. A rational-series expression after cancelling the splitting

Next-only complete ordinary candidate, 2026-09-07. Not a publication
input. No zero count or rational-point classification is claimed.
This continues the fixed HT/LH models and character conventions.

The aim is to remove the numerical Frobenius slope from the function
which must be zero-tested, while retaining a rigorous tail bound.
Only an existing integrality theorem for the canonical sigma is used
to prove that bound; its coefficients or slope need not be computed.

Write E_i:y^2=x^3+a_i x+b_i for E,E', with

    (a_1,b_1)=(-9,-9), (a_2,b_2)=(-189,999).

Use the invariant differential omega=dx/(2y) and parameter t=-x/y.
The canonical unit-root slope is c_i in Z5, as in HT. The local height
lambda_c is in twice-Silverman's normalization, with principal term
-2log5(t), and global diagonal H_c. Their zero-slope counterparts,
with complementary line spanned by x omega, are lambda_0,H_0.
An elliptic complementary line is isotropic, so this is an allowed
height splitting, even though it is not the unit-root line.

## ZS1. Exact cancellation of the splitting in the rank-one function

For an elliptic curve above and every local point away from the
height pole at O, the splitting change is exactly

    lambda_c(Q)=lambda_0(Q)+c log_E(Q)^2.               (ZS1)

For an infinite-order rational base point P it follows that

    H_c(P)=H_0(P)+c log_E(P)^2,
    alpha_c=alpha_0+c,
    lambda_c(Q)-alpha_c log_E(Q)^2
       =lambda_0(Q)-alpha_0 log_E(Q)^2.                (ZS2)

Here alpha_j=H_j(P)/log_E(P)^2. Neither P being a global generator
nor a numerical approximation to c is needed.

Proof. HT's defining differential equation gives on the formal group

    sigma_c(t)=sigma_0(t) exp(-c L(t)^2/2),
    L(t)=log_E(Q).

Thus -2log sigma_c=-2log sigma_0+cL^2, giving ZS1 there.
We use the normalized local multiplication law

    lambda_j([n]Q)=n^2 lambda_j(Q)-2log5(psi_n(Q)),       (ZS3)

where psi_n is the usual division polynomial with leading term
psi_n(t)=(-1)^(n-1)n t^(1-n^2)(1+O(t)). The sign for even n
comes from t=-x/y (in particular psi_2=2y); log5(-1)=0, so it
does not change the multiplication law. The law follows from the local
addition identity of BD Lemma7.4 and the division-polynomial
recurrences; its constant is fixed at O by that leading term.
In applying that lemma its divisor differences must first be
identified with group differences: translation preserves omega,
the chosen complementary cohomology line (translation acts trivially
on H1), and the invariant tangent vectors. Functoriality of the local
height therefore identifies h((Q1)-(Q2)) with lambda(Q1-Q2).
This identification is required; the lemma's divisor notation is
not by itself a notation for an elliptic group subtraction.
For clarity the recurrence step uses

    x([n]Q)-x(Q)=-psi_(n+1)(Q)psi_(n-1)(Q)/psi_n(Q)^2.

Substitution in the addition identity proves the n+1 law from
the n,n-1 laws. The initial doubling law follows from its tangent
limit with psi_2=2y. Continuity gives the law at any remaining
removable exceptional chart.

Because #E_i(F5)=9, take n=9 to put every local point in the formal
group. On the open set where [9]Q and psi_9(Q) are nonzero, subtract
ZS3 for the two splittings and divide by81 to obtain ZS1. It extends
across nonzero nine-torsion points by continuity of both local height
functions there. Away from five the chosen height is unchanged.
Summing local heights on a rational point proves the global formula,
and division by the nonzero squared logarithm gives ZS2. QED.

Consequently the entire LH five-adic expression can be evaluated
using the zero-slope height separately on each minimal quotient.
There is no residual c_1 or c_2 in that expression.

## ZS2. Exact rational recursions and an all-tail bound

For either pair of rational integers a,b, define w(t) by

    w=t^3+a t w^2+b w^3,       w in t^3 Z[[t]].

Coefficient induction gives its unique solution: the substitution
strictly raises the order of every unknown correction. It is the
actual formal coordinate w=-1/y, with x=t/w. Put

    A(t)=(t w'(t)/w(t)-1)/2,       L(t)=integral A(t)dt,
    R_0(t)=-integral[1/t+
                   A(t) integral (x(t)A(t))dt]dt.      (ZS4)

Every integral has zero constant term, including the Laurent
primitive. These recursions are exact over Q.
Indeed omega=A(t)dt, xA=t^-2+O(t^2), and A=1+O(t^4);
the apparent 1/t terms in the outer integral cancel. Thus

    L in t Q[[t^2]], L=t+O(t^5),
    R_0 in t^4 Q[[t^2]].

The differential equation is

    -d[(d log sigma_0)/omega]=x omega,
    R_0=log(sigma_0(t)/t).

Equation ZS4 follows by integrating this equation once, using
oddness to fix the inner integration constant, and then removing
log(t). Hence these are the actual zero-slope logarithmic sigma
and invariant logarithm, not a fitted formal series.

Write R_0=sum r_j t^j and L=sum l_j t^j. For j>=1 their coefficients
satisfy

    v5(r_j)>=-2 floor(log_5(j)),
    v5(l_j)>=-floor(log_5(j)).                         (ZS5)

Consequently, if L_N,R_N retain all degrees at most N, then for
every t in 5Z5 and every integer N>=1,

    v5(R_0(t)-R_N(t)) >= ceil((N+1)/2),
    v5(L(t)-L_N(t))   >= ceil((N+1)/2).                (ZS6)

Proof. The invariant differential has coefficients in Z5, so termwise
integration gives the bound for l_j. By MST Theorem1.3 the canonical
odd integral sigma has sigma_c/t in 1+t^2 Z5[[t]], and c in Z5.
The identity from ZS1 gives

    R_0=log(sigma_c/t)+(c/2)L^2.

In the coefficient of degree j of the first term, logarithm
denominators are integers k<=j/2; its valuation is at least
-floor(log_5 j). A coefficient of L^2 is a sum of products with
indices i,j-i, and the bound on l_i gives valuation at least
-2 floor(log_5 j). As c/2 is integral, ZS5 follows.
This use of existence and integrality of sigma_c does not require
computing c or any of its coefficients.

If k=floor(log_5 j)>=1, then j>=5^k>=4k, by induction on k.
Therefore j-2floor(log_5 j)>=ceil(j/2). The k=0 case is immediate.
Every degree j>N evaluated at t in5Z5 consequently has valuation
at least ceil((N+1)/2), and its valuation tends to infinity.
Completeness and the ultrametric inequality prove ZS6 for the
entire omitted tail. The logarithm bound is even stronger.
In particular these rational recursions converge on the full
formal group disk, with an explicit uniform absolute error. QED.

## ZS3. A concrete expression with removable exceptional factors

Let psi=psi_9, and introduce the rational function on E_i

    delta_i(Q)=t([9]Q)/psi_9(Q),                       (ZS7)

first away from its displayed zeros and poles, and then as a
rational function after cancellation. Near O it satisfies

    delta_i(Q)=t(Q)^81(1+O(t(Q))).

At every other Q5 point it is finite and nonzero. To verify this,
[9]Q is in the formal group. There, t has no zero except O and
no poles. At a nonzero nine-torsion point, t([9]Q) and psi_9(Q)
both have simple zeros, since [9] is etale in characteristic zero.
They cancel to a nonzero value. At any other nonzero local point
neither numerator nor denominator vanishes. Their leading terms
at O give the stated order81 and coefficient one.

For P=(z,W) on C use the actual projective quotient maps R_1,R_2
from LH, and put

    T_i(P)=t([9]R_i(P)),
    Xi(P)=z^81 delta_1(R_1(P))/delta_2(R_2(P)).          (ZS8)

The T_i are locally analytic on C(Q5), with values in5Z5.
The rational function Xi has a finite, nonzero value at every
Q5-point, including the zero and infinity fibers.
Indeed away from those fibers neither R_i is O. At z=0,
W_0^2=-9 and t(R_2)/z tends to -2/W_0, a nonzero value;
delta_2 has order81 and the factor z^81 cancels it. At infinity,
with q=1/z and W/z^3 tending to epsilon=+1 or -1,
t(R_1)/q tends to -2/epsilon. Thus delta_1's order81 cancels
z^81. The other quotient point remains finite in both cases.
These arguments also show the removable local extension, without
assuming that the zero-fiber points are rational over Q.

Set alpha_i^0=H_0(P_i)/log_(E_i)(P_i)^2, where P_1=P and P_2=P'
are the fixed infinite points. On the whole local curve the
extended LH function is the locally analytic expression

    F_0(P)=-2/81[log5 Xi(P)+R_01(T_1(P))-R_02(T_2(P))]
           -alpha_1^0 (L_1(T_1(P))/9)^2
           +alpha_2^0 (L_2(T_2(P))/9)^2.               (ZS9)

Proof. Off the finite exceptional fibers, use ZS3 with n9 and
lambda_0([9]Q)=-2log sigma_0(T_i). Then

    lambda_0(Q)=-2/81[log delta_i(Q)+R_0i(T_i)].

Combine the two formulas with -2log z to obtain ZS9, and use
log_E(Q)=L(T_i)/9. The cancellations proved above extend the
right side across the exceptional points. ZS1 identifies it with
the canonical-splitting expression of LH. QED.

All rational functions in this formula come from the given rational
curves and the integer multiplication map; all series in it have
exact rational coefficients from ZS4. The constants alpha_i^0 can
also be obtained without Frobenius: using the exact ninefold points
(A_i/d_i^2,B_i/d_i^3), write t_i=t(9P_i) and q_i=-A_i/B_i.
The already checked identity-component conditions give

    H_0(P_i)=-2/81[log5(q_i)+R_0i(t_i)],
    log_E(P_i)=L_i(t_i)/9.                             (ZS10)

This follows from the canonical formula in HT and ZS1, or directly
by substituting sigma_0 in the formula and using the splitting change.
Here q_i is a rational 5-adic unit, so its logarithm is evaluated
as (1/4)log(q_i^4) with a convergent rational-coefficient series.
HT's leading-digit theorem shows v5(H_0(P_i))=1, because changing
the slope changes the height by c_i log_E(P_i)^2 in25Z5.
Thus v5(alpha_i^0)=-1 exactly.

For an error budget K=ceil((N+1)/2), truncating the R_0i,L_i
series at N in ZS9 changes their combined contribution by at least
5^K in absolute precision, if the alpha constants are exact.
For the squared-log terms this uses v5(L_i),v5(L_{i,N})>=1,
so the squaring error has valuation at least K+1 and the factor
alpha of valuation -1 loses only one digit.
An alpha approximation of absolute error at least K-2 suffices
as well, since it is multiplied by a logarithm square in25Z5.
Errors in evaluating the rational functions and log Xi must still
be propagated separately; this estimate does not suppress them.

## ZS4. The exact twelve charts and what remains

Modulo five, the sextic takes value1 at z=0 and value4 at each of
z=1,-1,2,-2. There are exactly two simple ordinates above each of
these five residues, plus the two points at infinity. All ordinates
are nonzero modulo five. Hence the full local curve is covered by
twelve smooth residue disks: the ten finite disks use z-a in5Z5;
the infinity disks use q=1/z in5Z5.
Exact base lifts may be chosen as

    (0,+/-sqrt(-9)), (+/-1,+/-8), (+/-2,+/-sqrt(19)),

and infinity signs +/-1. The indicated square roots exist in Q5
with the chosen residue signs. Hensel's lemma and the nonzero
ordinate derivative 2W give the unique analytic square-root branch
on each corresponding disk. This is a complete disk inventory,
not an enumeration of rational points.

The remaining work is still real computation and proof: implement
the rational multiplication functions with removable factors, certify
their local expansions and the logarithm of Xi on each disk (with
subdivision if required), apply the tail budget above, isolate every
zero and multiplicity of F_0+4/3log5(3), and perform a rational sieve.
No zero list, no derivative nonvanishing assertion, and no claim
that one truncated polynomial already captures all zeros is made.
The full same-source second square and the changing-exponent,
residual and uniform-height problems remain open.

Primary input chain: MST Theorem1.3 and its defining sigma equation;
BD Lemma7.4 and Theorem1.4 with the previously audited character
convention; the exact normalized division-polynomial recurrences
and their tangent initial case as explained in ZS1. Existing HT/LH
proofs supply the minimal models, identity-component checks and
global alpha leading digits. This note is an ordinary candidate,
not a new PARI experiment or Lean formalization.
