# Quantitative covers for small residuals in a fixed degree-eight field

Date: 2026-09-07. Fifth-round ordinary proofs, submitted for independent
review. Completed fourth-round files remain unchanged.

Let F(a,b)=a^4+3a^3b+5a^2b^2+3ab^3+b^4. We study actual primitive
positive integer seeds satisfying

    F(a,b)=V Q^g,       V,Q positive integers,       Q>=7.             (C1)

The exponent g need not have a fixed divisor. The application parameter is
lambda=max(1,log V)/g. The conclusions below bound the number and coefficient
heights of arithmetic covers uniformly as g changes. They do NOT bound the
heights of rational points on those covers.

## 1. A fixed splitting field, independent of g

**QC1.** Put zeta^2-zeta+1=0, K0=Q(zeta), d0=-1-3zeta, and

    K=K0(sqrt(d0),sqrt(13)).                                        (C2)

Then K is the splitting field of F(x)=F(x,1), has degree eight over Q,
is totally imaginary, and has unit rank three. It is unramified outside
the rational primes 3 and 13. No g-th roots of unity need to be adjoined
to this field when constructing the arithmetic covers below.

Proof. Set t=x+1/x. Then F(x)/x^2=t^2+3t+3. The two possible t-values
are zeta-2 and -1-zeta; the discriminants of x^2-tx+1 are respectively
d0 and bar(d0). Their product is 13. Thus (C2) is precisely the splitting
field. The norm of d0 from K0 to Q is 13, so d0 is not a square in K0.
The positive real number sqrt(13) is not in K0, whose real elements are
rational. Also 13/d0=bar(d0) is not a square in K0, again by its norm 13.
In a quadratic extension K0(sqrt(d0)), an element t of K0 becomes a
square only if t or t/d0 is already a square in K0: expand
(u+v sqrt(d0))^2=t and use 2uv=0. Therefore sqrt(13) is not in the
first quadratic extension. This proves [K:Q]=2*2*2=8.
Every embedding sends zeta to a nonreal number, so the signature is
(r1,r2)=(0,4), and Dirichlet's unit theorem gives rank 3.

The discriminant of F is 117. At a rational prime p not dividing 117,
its reduction is separable. Its splitting field over Q_p is then contained
in an unramified extension: each distinct irreducible residual factor
splits over a finite residue-field extension, and its simple roots lift
by Hensel's lemma in the corresponding unramified extension. Hence the
global splitting field K is unramified at p. This also shows that each
root difference alpha_i-alpha_j is a unit at primes outside 3 and 13.
Geometric Kummer arguments can be made after passing to an algebraic
closure; they do not require replacing the fixed arithmetic field K by
K(mu_g).

Fix an ordering alpha_1,...,alpha_4 of the roots. Write H for the class
number of K, w for the number of its roots of unity, and O_K^* for its
unit group. These are fixed constants; their numerical values are not
assumed or computed here.

## 2. The small bad-prime contribution

**QC2.** For primitive positive a,b,

    F(a,b)=1 mod 3,
    13|F(a,b) implies v_13(F(a,b))=1.                               (C3)

Proof. Modulo three, F(a,b)=(a^2+b^2)^2=1, since a,b are not both zero
modulo three. Modulo thirteen one has

    F(a,b)=(a-b)^2(a^2+5ab+b^2) mod 13.

The quadratic factor has discriminant 21=8 modulo thirteen, a nonsquare.
If thirteen divides F, primitivity first shows that b is nonzero modulo
thirteen, and the factorization gives a=b modulo thirteen. Write a=b+13t.
Since F(1,1)=13 and F_x(1,1)=26, expansion gives

    F(b+13t,b)=13 b^4 mod 169.

As b is a unit modulo thirteen, the valuation is exactly one. This
reproves the earlier two-step thirteen-adic result in the required scope.

## 3. Fixed-residual cover count

**QC3 (uniform count for each fixed pair g,V).** There is a constant
C_K>=1 such that the following holds. Let g>8 and let V be a positive
g-free integer, meaning every prime valuation of V is less than g.
All primitive positive solutions of (C1), with this fixed g,V and any Q,
lift to one of at most

    C_K * 4^(8 omega(V)) * g^9                                    (C4)

curves over the fixed field K. Each curve has equations

    y_i^g=(x-alpha_i)/(xi_i(x-alpha_4)),   i=1,2,3,                   (C5)

for constants xi_i in K^*. Its smooth projective normalization is
geometrically connected, of degree g^3 over P1 and genus

    G_g=1+g^2(g-2).                                                (C6)

The same C_K works for all g,V,Q. For example one may take

    C_K=9^32 * H^4 * w^3.                                         (C7)

The count concerns a constructed list; repetitions or isomorphic curves
may be retained. If there are no seeds, an empty list is allowed.

Proof. Put L_i=a-alpha_i b. Factor its principal ideal as

    (L_i)=A_i B_i^g,                                               (C8)

where A_i and B_i are integral ideals and every valuation of A_i is in
{0,...,g-1}. At a prime P over p not in {3,13}, at most one L_i is
divisible by P. Otherwise subtracting the two factors and using the
unit root difference would force P to divide both a and b, contradicting
their integer Bezout identity. The field is unramified at p. Since

    product_i L_i=V Q^g,

the nonzero remainder valuation, if any, is exactly v_p(V). For each
prime P over a prime dividing V it is assigned to one of four A_i.
There are at most eight primes of K over a rational prime, so the
choices at that rational prime number at most 4^8. This is an upper
bound; the Galois compatibility constraints may reduce the number.

At primes over three every L_i is a unit by (C3). At a prime P over
thirteen, the total valuation of product_i L_i is at most e(P/13)<=8.
Because g>8, none of this contribution is removed modulo g. A very
coarse bound for the four allocations at each such P is 9^4. There
are at most eight primes over thirteen, so all bad-prime choices
number at most 9^32. Thus the possible ordered quadruples (A_i) number
at most

    9^32 * 4^(8 omega(V)).                                        (C9)

The factor at thirteen is included in this bound even if thirteen
does not divide V; overcounting is harmless. Moreover, at every prime
the sum of the four remainder valuations is the valuation of (V), so

    product_i A_i=(V),       N(A_i)<=V^8.                          (C10)

For each fixed A_i, the class [B_i] must solve [B_i]^g=[A_i]^{-1}
in the class group. There are at most H choices. For each such class
choose a fixed integral ideal C_i representing it. The ideal A_i C_i^g
is principal; choose a generator delta_i. Any B_i in that class has
B_i=(t_i)C_i for t_i in K^*, and (C8) then yields

    L_i=delta_i epsilon_i t_i^g,       epsilon_i in O_K^*.           (C11)

There are at most H^4 choices of the four ideal classes. Their generators
delta_i are fixed once these choices, g, and the A_i have been fixed.
Dirichlet's theorem gives

    |O_K^*/(O_K^*)^g|=gcd(g,w)*g^3<=w*g^3.

The three ratios L_i/L_4 require only the three unit classes of
epsilon_i/epsilon_4. Consequently they admit at most w^3 g^9 choices,
not four independent unit-class factors. Combining with (C9) and H^4
proves (C4). Choosing representatives of these ratio classes in (C11)
gives actual K-points on (C5), with x=a/b. Positive x avoids every root
of F, so the lift lies in the smooth unbranched open part of the cover.

Over an algebraic closure, valuation at alpha_i proves the three
Kummer classes independent modulo g, also for composite g. Thus the
geometric degree is g^3. At alpha_1,alpha_2,alpha_3 the inertia order
is g. At alpha_4 all three functions have a simple pole, so their
extensions adjoin the same g-th root of a local uniformizer; local
units have g-th roots in characteristic zero. This inertia is the
diagonal cyclic subgroup of order g. Infinity is unramified. The
four branch points each contribute g^2(g-1). Hence

    2G_g-2=-2g^3+4g^2(g-1),

which is (C6). These are ordinary geometric arguments, not Lean results.

## 4. A direct connection to lambda, including varying residuals

**QC4.** In an actual profile (C1) with

    g>8,     lambda=max(1,log V)/g<log 2,

the residual V is g-free, and the list in QC3 satisfies

    log(max(1,N_{g,V}))/g
       <=16 lambda+(9 log g+log C_K)/g.                            (C12)

More generally let 0<L<log 2. All primitive positive seeds at exponent
g>8 with residual 1<=V<=exp(Lg) lift to a combined list of at most

    C_K g^9 exp(17 Lg)                                             (C13)

of the covers (C5). Thus if L=L_g tends to zero and g tends to infinity,
the logarithm of this combined list size divided by g tends to zero.

Proof. For each prime p,
v_p(V)<=log V/log 2<g, proving the g-free condition. Also
omega(V)<=log V/log 2. Applying this to (C4) gives
8 log4*omega(V)<=16 log V and proves (C12).
For (C13) there are at most exp(Lg) positive integer choices of V.
Each individual list has size at most C_K g^9 exp(16 Lg).
Summing proves (C13). The displayed bounds are deliberately distinguished:
(C12) holds for a fixed V, while (C13) accounts for the additional choice
of the moving residual.

These conclusions are uniform in prime g, twice a large prime, and
general g>8. They do not use or imply a uniform version of Faltings.

## 5. Coefficient height and the unit contribution

Use the absolute logarithmic Weil height h_K on K; it is independent
of the containing number field. For a positive rational number a/b in
lowest terms it equals log max(a,b).

**QC5 (controlled coefficients).** The lists in QC3 may be chosen so
that every constant xi_i in (C5) satisfies

    h_K(xi_i)<=2 log V+C'_K g.                                     (C14)

In particular, after fixed root constants are included, the coefficient
heights of the three equations in (C5) are O_K(log V+g). The constant
does not depend on V,Q,g. The term of order g is retained explicitly.

Proof. Choose once and for all an integral ideal representative for each
ideal class of K; their norms have a fixed upper bound M_K. By (C10),

    log N(A_i C_i^g)<=8 log V+g log M_K.                            (C15)

We use the following elementary consequence of the logarithmic unit
lattice. A nonzero principal integral ideal J has a generator delta
with

    h_K(delta)<= (log N J)/8+B_K.                                  (C16)

Indeed start with an integral generator. At the four complex places,
its logarithmic absolute values have average (log N J)/8. Subtract
this average and reduce the resulting sum-zero vector modulo the
logarithmic lattice of units into a fixed bounded fundamental domain.
Multiplication by the corresponding unit does not change the ideal.
The resulting generator has every logarithmic absolute value at most
(log N J)/8+B_K. As it is integral and N J>=1, summing the positive
parts in the formula for Weil height proves (C16).

Apply this to J=A_i C_i^g. It gives generators delta_i satisfying

    h_K(delta_i)<=log V+(g/8)log M_K+B_K.                           (C17)

Choose fundamental units epsilon_1,epsilon_2,epsilon_3 of K. Every unit
class modulo g-th powers has a representative
rho=omega product_j epsilon_j^{e_j}, 0<=e_j<g, with omega a root of
unity. Thus h_K(rho)<=g sum_j h_K(epsilon_j). Take
xi_i=(delta_i/delta_4)rho for each of the three required unit classes.
The standard height inequalities for multiplication and inversion,
together with (C17), prove (C14), after absorbing fixed constants in
C'_K g. This choice changes no class and loses none of the actual lifts.

The unit-class residues and fixed ideal-class representatives account
for the possible order-g term in (C14). Our proof does not reduce that
term to O(log V), and lambda tending to zero does not make it disappear.
The following strict boundary explains why a blanket normalization of
all unit classes cannot remove this term.

**QC6 (some unit classes require linear representative height).** Choose
a fundamental unit epsilon_1 as part of a fixed basis of the rank-three
unit group. There is a constant c_K>0 such that, for every g>=3, every
element xi of K^* in the class

    [epsilon_1^floor(g/2)] in K^*/K^{*g}

has absolute logarithmic Weil height at least c_K g.

Proof. Write k=floor(g/2) and xi=epsilon_1^k t^g. If t is not a unit
of O_K, some finite prime P has v_P(t) nonzero, so |v_P(xi)|>=g. If
this valuation is negative, its contribution to h_K(xi) is at least
g log N(P)/8>=g log2/8. If it is positive, apply the same argument to
xi^{-1}, whose Weil height equals that of xi.

If t is a unit, write it as a root of unity times
product_j epsilon_j^{n_j}. The exponent vector of xi in the fixed
unit basis has first coordinate k+g n_1 and other coordinates g n_j.
The absolute value of the first coordinate is at least floor(g/2),
and hence at least g/3. On the real span of the logarithmic unit lattice,
Weil height is a norm: the logarithmic coordinates have weighted sum
zero, so the sum of their positive parts is half the sum of their
absolute values. The logarithms of the fundamental units are linearly
independent. Equivalence with the maximum norm in these fixed coordinates
therefore gives h_K(xi)>=c'_K max_j |exponent_j|>=c'_K g/3.
Taking the smaller of the constants from these two cases proves the claim.

QC6 disproves the assertion that all unit classes modulo g-th powers
can be represented with height o(g) in this fixed field. These unit
classes already occur in the unrestricted class list with trivial
residual ideals. It does not assert that any of these particular
large-height classes has a positive primitive seed on its cover.
Eliminating their possible contribution would require an additional
argument using the compatibility of actual points, rather than merely
changing class representatives.

Likewise, the subexponential cover count in QC4 supplies no bound on
the height of a rational point on even a single cover. A uniform
point-height estimate at this stage is an additional unproved input.

## 6. What remains between these estimates and the two-step gate

The actual quartic satisfies

    (13/16)(a+b)^4<=F(a,b)<(a+b)^4,

because, on putting u=ab/(a+b)^2 in (0,1/4], its ratio to (a+b)^4 is
1-u+u^2. Hence every seed in (C1) obeys the genuine height lower bound

    h_K(a/b)>= (g log Q+log V)/4-log 2
              >= (g log 7)/4-log 2.                               (C18)

The first inequality follows from F(a,b)<(a+b)^4 and
max(a,b)>=(a+b)/2. A family with lambda tending to zero would therefore
require points of height at least linear in g, although QC4 gives
subexponentially many possible covers and QC5 gives coefficient heights
at most linear in g. This makes the unresolved issue precise without
supplying an estimate that is not known: the count of covers and the
height of their individual points are distinct problems.

No bound uniform in g for those point heights has been proved. No
nonexistence of large-prime exponent profiles follows from these results.
The moving-support and large-prime branches of PL5 remain open, as does
the small-lambda two-step compatibility threshold. The present result
is a quantitative arithmetic-geometric reduction of that branch.

## 7. Sources and verification scope

The fixed-exponent descent and its genus calculation are developed in
the completed fourth-round PL note. Here the factor allocation, fixed
field, explicit cover count, and coefficient normalization are proved
above. Standard external inputs are ideal factorization and class-group
finiteness, Dirichlet's unit lattice theorem, Hensel's unramified lifting,
Kummer theory over an algebraic closure, and Riemann--Hurwitz.

For the algebraic-number-theory inputs, the author-hosted primary notes
J. S. Milne, *Algebraic Number Theory*, version 3.08 (2020), Chapters 3--5,
were actually opened: https://www.jmilne.org/math/CourseNotes/ANT.pdf.
The fixed-exponent Darmon--Granville source is recorded in the PL note.
No new uniform Faltings theorem is cited or assumed. None of these
geometric or number-field conclusions is claimed to have been formally
verified in Lean here.
