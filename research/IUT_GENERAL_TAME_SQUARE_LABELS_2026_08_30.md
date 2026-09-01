# All square labels in a tame Tate field with valuation-four parameter

Author: ChatGPT. Research date: 2026-08-30.

Status: the mathematical proof preceded the limited arithmetic companion
described below. This is a local
theorem about specified native fields, actual integral Galois-group
automorphism actions, and precisely defined source families. It is not a
verification of global initial theta data or an ABC theorem.

## 1. Statement and assumptions

Let ell>=7 and p be primes satisfying

    p=-1 modulo 30*ell.

No congruence ell=3 modulo 4 is required for this local theorem. That
extra condition was useful only for the global Frobenius calculation
in the explicit rational-curve construction.

Take any b0 in Q_p with v_p(b0)=2, set q=b0^2, and put

    e=15*ell,  d=2e=30*ell,  h=(ell-1)/2,
    K0=Q_p(mu_(30*ell)),
    pi^e=b0,  E=K0(pi),
    beta=pi^((e+1)/2)/p,
    r=pi^15=q^(1/(2*ell)),
    kappa=(e-1)/e,  I=beta^(1-e)*O_E.

The letter pi denotes the chosen e-th root, not the uniformizer; beta
is the uniformizer. All valuations below are native, with v_p(p)=1.
For each 1<=j<=h, write s=j^2 and define

    z_j=r^s,  n_j=floor(2s/ell),  k_j=n_j+1,
    u=log(1+p)/p,
    tau_j=log(1+p*z_j)/p,
    T_j=tau_j/p^k_j,
    X_j=z_j*beta^(1-e)/p^n_j.                       (1.1)

Let Gamma be the actual integral Kummer arrows arising from the
verified full-Galois-group automorphism construction, allowing an
integral identification of the Tate module. They are Z_p-linear
automorphisms of I, extended Q_p-linearly to E. Gamma is not assumed
to be all GL_Zp(I). The precise original-source inputs and the actual
lift mechanism are stated in section 4.

**Theorem.** There is one F in Gamma for which

    v_p(Fu)=v_p(FT_j)=v_p(FX_j)=-kappa
    simultaneously for every j=1,...,h.             (1.2)

For m=j+1, let B_m be the integral closure of O_E tensor ... tensor O_E
inside E tensor ... tensor E over Q_p. Define the point hull P_j by
varying the same F in every factor of

    F(tau_j) tensor F(u) tensor ... tensor F(u),

and define the whole-product hull S_j by varying the same F on inputs
from z_j*I times I^(m-1). In both cases take the B_m-span and its closure.
Then

    P_j=beta^[e*k_j-(e-1)m]*B_m,
    S_j=beta^[e*n_j-(e-1)m]*B_m=p^(-1)*P_j.         (1.3)

The same F in (1.2) witnesses all of these equalities. The distinct
pre-transport ideal source has an exact hull as well:

    M_j=P_j properly contained in S_j=p^(-1)*P_j.   (1.4)

where M_j is the closed B_m-span of F^(tensor m)(z_j*B_m), with
z_j embedded in the first tensor factor. The stronger upper bound
uses the trace dual of B_m itself, as proved in section 8.

All exponents in (1.3) are strictly negative. When every one of the
m input coordinates and its source is consistently rescaled from
rho=p^(-1)*log_BK^std to log_BK^std, the two hulls become

    P_j^std=beta^[e*k_j+m]*B_m,
    S_j^std=beta^[e*n_j+m]*B_m,                     (1.5)

with strictly positive valuation exponents. The corresponding
pre-transport ideal hull is p^m*M_j=P_j^std. This is
a statement about explicit coordinate scaling, not a permission
to change only one side of a source comparison.

## 2. The field, the genuine uniformizer, and the logarithmic lattice

The integer e is odd, so (e+1)/2 is an integer. Let

    eta=p^2/b0 in Z_p^*.

Then direct algebra gives

    beta^e=p*(b0/p^2)^((e+1)/2)
          =p*eta^(-(e+1)/2),
    pi=eta*beta^2,
    r=eta^15*beta^30,
    r^ell=b0.                                      (2.1)

The multiplicative order of p modulo 30*ell is exactly two, so
K0/Q_p is unramified quadratic. The first equation of (2.1) is
Eisenstein over K0, while the second shows K0(beta)=K0(pi).
Consequently E/Q_p is Galois with

    [E:Q_p]=2e,  ramification index e,
    residue degree 2,  v_p(beta)=1/e.               (2.2)

Galoisness follows since K0 contains mu_e and E splits the
polynomial X^e-b0, as well as X^(2e)-q. The unramified quadratic
field also contains i; no extra local extension is needed to
include that usual level-field factor.

This is the actual full torsion field of the split Tate curve
with parameter q at level 30*ell. More generally any split elliptic
curve over Q_p with full rational 2-torsion and Tate valuation 4
provides such a b0: the class of sqrt(q) is rational in the Tate
quotient, and its Galois ratio belongs to q^Z with valuation zero,
so that ratio is 1. Fixing the two Tate torsion generators similarly
shows exactly, not just by inclusion, that

    Q_p(D[30*ell])=Q_p(mu_(30*ell),q^(1/(30*ell)))=E.

The classical input is the Galois-equivariant split Tate
uniformization theorem; see
[Kedlaya, Introduction: the Tate curve, Theorems 1--2, PDF pp.3--4](https://kskedlaya.org/18.727/tate-curve.pdf).

Since p is a positive prime in the indicated residue class,
p>=2e-1. In particular e<=p-2, because e>=105. Thus log and exp
are inverse and valuation-preserving on beta*O_E and 1+beta*O_E:
their valuation threshold 1/e is strictly greater than 1/(p-1).
It follows that

    p^(-1)*log(O_E^*)=p^(-1)*beta*O_E
                    =beta^(1-e)*O_E=I.             (2.3)

The unit in (2.1) is retained; beta^e=p is not assumed.

The extension is tame, so its different is beta^(e-1)*O_E. Hence
I is the inverse different and Tr(I) is contained in Z_p. Since
p does not divide d=2e, the element 1/d lies in O_E and has
trace 1. Therefore

    Tr(I)=Tr(O_E)=Tr(beta*I)=Z_p.                   (2.4)

Here O_E is contained in beta*I because e>=2. The kernel of
trace surjects onto I/beta I: for any x in I, subtract
Tr(x)/d in O_E, which preserves the residue class and kills its
trace. This elementary argument supplies the quotient surjectivity
needed later without identifying unrelated trace kernels.

## 3. Contents, leading terms, and exact trace formulas

Since ell is prime and 1<=j<ell, ell does not divide s=j^2.
Write

    2s=ell*n_j+t_j,  1<=t_j<=ell-1.

Then k_j=n_j+1=ceil(2s/ell). Moreover

    floor(2s/ell+kappa)=k_j,

because kappa=1-1/(15ell) and t_j/ell>1/(15ell). The first term
of the convergent logarithm gives v_p(tau_j)=2s/ell. Thus

    e*v_p(T_j)=15t_j-e,
    e*v_p(X_j)=15t_j-e+1.                          (3.1)

Both numbers are strictly between 2-e and 1, with the lower
endpoint 2-e being the valuation exponent of beta*I. In particular

    T_j,X_j in beta*I but not in p*I.               (3.2)

For clarity, the first strict inequality follows from t_j>=1:
15t_j-e>=15-e>2-e; the upper follows from t_j<=ell-1,
which gives 15t_j-e<=-15 and 15t_j-e+1<=-14.

The rational element u is a unit with

    u in beta*I,  Tr(u)=d*u in Z_p^* .             (3.3)

The pure leading term of T_j is z_j/p^k_j. Its logarithmic
remainder belongs to pI. Indeed, writing r_j=v_p(z_j)=2s/ell,
the expansion gives

    v_p(tau_j-z_j)>=1+2r_j,

and k_j<=r_j+kappa implies
1+2r_j-k_j>=1+r_j-kappa>=1/e. The latter is exactly the minimum
valuation of pI. Thus the leading projective coefficient used
in the inertia argument is justified even after division by p^k_j.

The norm over E/K0 is

    Norm_(E/K0)(1+p*r^s)=(1+p^ell*b0^s)^15.        (3.4)

To see this, the extension generated by r has degree ell, its
conjugates are zeta_ell*r, and raising those roots to s permutes
them. Since ell is odd their norm product is 1+(p*r^s)^ell.
The remaining multiplicity in degree e is 15. Taking logarithms
and then the degree-two trace gives

    Tr(T_j)=30*log(1+p^ell*b0^s)/p^(k_j+1),
    v_p(Tr(T_j))=ell-1+2s-k_j>=ell.                (3.5)

The coefficient 30 is a p-adic unit. The lower bound follows
from k_j<=s, valid for every positive integer s and ell>=3.

For X_j, (2.1) shows that its non-rational factor is
beta^(30s+1-e). The exponent is 1 modulo 15, hence is not
divisible by e=15ell. Summing its conjugates over E/K0 gives

    Tr(X_j)=0.                                     (3.6)

The geometric-sum identity applies equally to negative exponents.
No assumption that pi is a uniformizer, or that b0=p^2, occurs
in either trace calculation.

## 4. The actual full-Galois actions used in the proof

We use the integral normalized wild-generator basis supplied by
the same full relative presentation argument as in

    IUT_FULL_GALOIS_MINIMUM_LAYER_2026_08_30.md,
    IUT_TATE_210_MINIMUM_LAYER_ARITHMETIC_2026_08_30.md,
    FREY_43_1289_BALANCED_LEGENDRE_REALIZATION_2026_08_30.md.

Here all its parameter conditions hold: E/Q_p is Galois of even
degree d=30ell, p>=5, e<=p-2, and E contains no primitive p-th
root of unity. The last assertion follows since its ramification
index p-1 cannot divide e<p-1.

For completeness, the integral-basis strengthening is not assumed
from a statement giving only a Q_p-basis. The tame cyclotomic
character has a nontrivial residue h0 in F_p^*. In fact
gcd(e,p-1)=1 here. Abelianizing the Hoshi--Nishio extra-generator
word gives a coefficient

    C=1-g*(sum_(i=1)^(p-1) h0^i)/(p-1)

which is 1 modulo p. It is a Z_p-unit and eliminates the extra
generator from the integral span. The remaining independent
logarithmic generators therefore form a Z_p-basis of log(O_E^*);
dividing by p gives a Z_p-basis of I.

Write the two distinguished basis vectors as a_JW,b_JW, and let
W be the remaining rank-(d-2) summand. The even-degree trace-kernel
theorem identifies

    I=Z_p*a_JW plus Z_p*b_JW plus W,
    ker(Tr|I)=Z_p*a_JW plus W,
    Tr(b_JW) in Z_p^*.                              (4.1)

The final assertion follows from (2.4). If B(x) denotes the
b_JW-coordinate, then B(x)=Tr(x)/Tr(b_JW). Thus B(u) is a unit
and every B(T_j),B(X_j) is zero modulo p.

The actual lift construction supplies the central, cross, and
symplectic actions

    C_c: b_JW -> b_JW+c*a_JW,    a_JW,W fixed,
    N_w: b_JW -> b_JW+w,
         x -> x+omega(w,x)*a_JW for x in W,  a_JW fixed,
    S_w: x -> x+omega(w,x)*w for x in W,    a_JW,b_JW fixed.

All parameters used below have integer coordinates in the displayed
basis. A cross in an arbitrary such direction is obtained from
basis crosses by the canonical-image identities

    N_w*N_v=C_(omega(w,v))*N_(w+v),
    N_w^n=N_(n*w) for integer n.

Taking a fixed order of basis factors, the central correction is
the negative of the sum of their pairwise omega-products. These
are identities in the linear image, not asserted identities
between arbitrarily chosen lifts. The actual lifts themselves
are finite compositions of the already verified full-presentation
automorphisms. The symplectic transvections with integer
coordinates have individual boundary-preserving handle lifts.
No section from a symplectic group to Aut(G_E) is required.

The original inputs are the full Jannsen--Wingberg presentation
(printed pp.74--76), Hoshi--Nishio Proposition 1.1 and Lemma 1.3,
and Kondo's even-degree trace-kernel result and the even-degree
construction on PDF p.19 followed by Theorem 2.17 on p.20. The
odd-degree restriction occurring later in Kondo is not used.
The original versions and the noncommutative cross-word proof
were separately audited in the prior reports. This generalization
uses the same words with more unused handles, not a new assumed
lift of a pro-p action.

Finally a field automorphism of E over Q_p extends to an
automorphism of its algebraic closure and hence induces an actual
automorphism of G_E=Gal(E^alg/E). Its integral canonical action
can be composed with these lifts. The operators are automorphisms
of this absolute Galois group; they are not asserted to be
elements of G_E acting nontrivially on the field E.

## 5. A single inertia choice avoids every distinguished line

Let V=I/pI and V_0=beta*I/pI. The residue field of E has degree
two, so V has dimension d over F_p and V_0 has codimension two.
The 2h inputs T_j,X_j are nonzero in V_0 by (3.2), and all have
zero B-coordinate. We first put all of them off the one line
F_p*a_JW.

Choose sigma in Gal(E/K0) with sigma(beta)=zeta_e*beta. The
root-of-unity intersection is trivial:

    mu_e intersect F_p^* = {1},

because p=-1 modulo 2e and e is odd, giving gcd(e,p-1)=1.
All these roots reduce injectively, since e is prime to p.

The leading coefficient of T_j transforms by zeta_e^(30j^2).
Its order is ell, since gcd(e,30j^2)=15. Thus as t runs through
0,...,e-1, a fixed leading F_p-line can be hit at most e/ell=15
times. Equality of full vectors up to an F_p-scalar in V implies
this leading-line equality, so there are at most 15 bad inertia
exponents for each T_j. The point inputs forbid at most 15h
exponents in total.

For X_j the character exponent modulo e is

    30j^2+1.

It is 1 modulo 15, so its gcd with e is either 1 or ell. The
exception occurs only if

    30j^2+1=0 modulo ell.                           (5.1)

There is at most one j in the half range 1,...,h satisfying
(5.1). Indeed 30 is invertible modulo the prime ell>=7. A
nonzero quadratic residue has two roots j and -j modulo ell,
and exactly one of that pair lies in the half range. If it is
not a quadratic residue there is no such j.

For a nonexceptional j the projective orbit length is e and
there is at most one bad inertia exponent. For the possible
exceptional j the length is 15 and at most e/15=ell exponents
are bad. Therefore the whole inputs forbid at most h-1+ell
exponents. This remains a valid upper bound if the exception
does not occur, since then the sharper bound is h.

The total number of forbidden exponents is at most

    15h+(h-1+ell)=9ell-9<15ell=e.                  (5.2)

Choose one exponent t outside their union. Field inertia preserves
V_0, trace, and u. After applying sigma^t, every T_j and X_j has
the form A_i*a_JW+w_i with w_i nonzero in W/pW, and u retains
its nonzero B-coordinate. The same t is used for every label
and both types of inputs. Only necessary leading-line conditions
were counted; full-vector equality was not inferred from them.

## 6. A single parabolic composition reaches the minimum for every input

Let N=2h=ell-1 be the number of inputs after section 5 and put
g=d-2=30ell-2. Denote the projection V to V/V_0 by lambda_0.

If a_JW is not in V_0, choose w in W/pW such that
omega(w,w_i) is nonzero for every i. Nondegeneracy of omega and
w_i!=0 make the N forbidden sets proper hyperplanes. Their
union has at most N*p^(g-1)<p^g elements since N<p. Lift w with
integer coordinates and apply N_w. Because the initial inputs
are in V_0 and their B-coordinates are zero, their new projections
are exactly omega(w,w_i)*lambda_0(a_JW), all nonzero. If N_w(u)
is still in V_0, apply C_1; otherwise use C_0. The central change
moves u by its unit B-coordinate times lambda_0(a_JW) and
changes none of the other projections.

If a_JW is in V_0, lambda_0 restricted to W/pW is onto the
two-dimensional quotient. This follows from the trace-kernel
surjectivity in section 2 and (4.1). Choose w outside its kernel
and the N hyperplanes omega(w,w_i)=0. The excluded union has
at most

    p^(g-2)+N*p^(g-1)<p^g

elements: N+1=ell<p implies 1+Np<p^2. Apply the actual lift
of S_w. Each former W-projection was zero, so each new input
has nonzero projection omega(w,w_i)*lambda_0(w). If the
transformed u remains in V_0, choose a basis vector w' of W
with lambda_0(w') nonzero and apply N_(w'). It moves u out
of V_0 by B(u)*lambda_0(w') and leaves every other projection
unchanged, because their B-coordinates vanish and a_JW lies
in V_0. If u is already outside, no further cross is necessary.

Combining the one inertia action and this one parabolic
composition gives an actual canonical action M sending u and
all 2h inputs outside V_0, which is exactly valuation -kappa.
The integral Kummer action associated to an arrow is c*M^(-1)
with c in Z_p^*. Take the inverse actual Galois-group
automorphism. Its Kummer action is a unit times M and has all
the same valuations. This proves (1.2) for one actual F in
Gamma, simultaneously for all labels and both families.

Only ell<p and the integer-lift operators were used in the
finite-field step. In particular no unproved reachability of
all GL_Zp(I), no continuous section for arbitrary p-adic
symplectic parameters, and no change of arrow with j occurs.

## 7. The exact point and whole-product hulls

For m=j+1 set

    T_m=E^(tensor_Qp m),
    A_m=O_E^(tensor_Zp m),
    B_m=the integral closure of A_m in T_m.

Galoisness gives T_m as a product of d^(m-1) copies of E and
B_m as the product of their integer rings. It is B_m, not the
generally smaller tensor order A_m, that acts on the hulls.
Every conjugate has the same valuation. Hence a pure tensor
with factor valuations v_1,...,v_m generates the product ideal
with valuation sum(v_i) in every component.

For the point family, tau_j belongs to p^k_j*I and every
F in Gamma preserves all p-power sublattices of I. Thus every
point tensor has component valuation at least k_j-m*kappa.
The F in (1.2) attains that value in every component, since
F(tau_j)=p^k_j*F(T_j). One attaining tensor is a unit times
beta^[e*k_j-(e-1)m] in every component and generates precisely
the claimed B_m-ideal. This proves the first part of (1.3).

For the whole product, z_j*I is contained in p^n_j*I because
v_p(z_j)=n_j+t_j/ell. Every tensor from the larger input
therefore has component valuation at least n_j-m*kappa.
Choose z_j*beta^(1-e)=p^n_j*X_j as its first input and u in
every other position. The same F in (1.2) attains that bound.
This proves the second part of (1.3). Its ratio to the point
ideal is p^(-1), since k_j=n_j+1 and p is a unit times beta^e.

The upper ideals are closed fractional product lattices.
The inclusions and their single attaining generators therefore
prove equality for both the algebraic spans and their closures.
No assumption about the size or linearity over E of Gamma is
hidden in this conclusion.

The same conclusions survive first taking the closed Z_p-convex
hull of the tuple orbits in E^m: the containing product lattices
p^k_j*I times I^(m-1), or p^n_j*I times I^(m-1), are already
closed and convex, and the common attaining tuples remain.
This statement uses those explicit containers and witnesses;
it does not commute a general tensor map with convexification.

## 8. The root bridge and the exact B-pilot hull

We give the two extra arguments needed for the exact source
type in (1.4), rather than identifying a point with an entire
multiplication image.

First, for any nonzero integral z in E, put
r_z=v_p(z) and k=floor(r_z+kappa). The logarithmic tail satisfies

    v_p(log(1+pz)/p-z)>=1+2r_z>=k+1-kappa.

For example the n-th tail term has valuation
n-1+n*r_z-v_p(n)>=1+2r_z, since v_p(n)<=n-2 for p>2,n>=2.
Thus the tail belongs to p^(k+1)*I, while z belongs to
p^k*I but not p^(k+1)*I. Every integral arrow preserves these
two sublattices in both directions. The strict ultrametric
inequality therefore proves, separately for every F,

    v_p(F(log(1+pz)/p))=v_p(Fz),
    v_p(Fu)=v_p(F1).                               (8.1)

This is a principal-ideal equality after the arrow, not an
assertion that F is E-linear or multiplicative. Applied to
z_j, it says that the tensor of (tau_j,u,...,u) and the tensor
of (z_j,1,...,1), transported by the same F, generate the same
principal B_m-ideal. Their closed orbit hulls are therefore
identical.

Now embed z_j in the first tensor factor, denoting this element
by Z_j=z_j tensor 1 tensor ... tensor 1. Define precisely

    M_j=closure span_(B_m) {
          F^(tensor m)(b) : F in Gamma, b in Z_j*B_m }.
                                                            (8.2)

The ideal is formed before applying the Q_p-linear tensor
arrow. This differs from taking an ideal generated by the
transported point. Since Z_j belongs to Z_j*B_m, (8.1) proves
P_j subset M_j.

For the upper inclusion, let A_m^vee and B_m^vee be the integral
trace duals inside the finite etale Q_p-algebra T_m, using its
absolute algebra trace. Trace of a pure tensor is the product
of the field traces, as is seen from the tensor product of the
multiplication matrices. Taking a Z_p-basis of O_E and its
trace-dual basis in each factor yields

    A_m^vee=(different_(E/Qp)^(-1))^(tensor_Zp m)
           =I^(tensor_Zp m).                       (8.3)

On the product decomposition of T_m, the absolute algebra trace
is the sum of the component field traces. Since B_m contains
each component idempotent, its trace-dual condition may be
tested on each component separately. Thus

    B_m^vee=product_(d^(m-1) components) I,
    B_m^vee subset A_m^vee=I^(tensor_Zp m).         (8.4)

The inclusion reverses A_m subset B_m. There is no additional
degree factor in the first equality of (8.4); testing a single
component idempotent prevents such a factor.

Put R_j=v_p(z_j). The definition k_j=floor(R_j+kappa) gives
R_j-k_j>=-kappa. Every component of Z_j has valuation R_j,
so the following stronger pre-transport inclusion holds:

    p^(-k_j)*Z_j*B_m subset B_m^vee subset A_m^vee,
    Z_j*B_m subset p^k_j*A_m^vee.                  (8.5)

Every F in Gamma preserves I; hence its Q_p-linear tensor
extension Phi=F^(tensor m) preserves A_m^vee=I^(tensor m).
It commutes with the rational scalar p^k_j. Applying Phi to
(8.5), taking the B_m-span, and then its closure gives

    M_j subset p^k_j*Span_(B_m)(A_m^vee)
        =beta^[e*k_j-(e-1)m]*B_m=P_j.              (8.6)

The displayed B_m-span equality follows from factor valuations
at least -kappa, with equality attained by the pure tensor
beta^(1-e) tensor ... tensor beta^(1-e). The upper ideal is
closed, so the closure does not weaken (8.6). The lower inclusion
P_j subset M_j was proved above by the per-arrow point bridge
and Z_j in Z_j*B_m. Therefore M_j=P_j, proving (1.4).

Only preservation of A_m^vee and Q_p-linearity were used for
the upper bound. In particular it holds for every linear map
Phi with Phi(A_m^vee) subset A_m^vee, even if Phi is not a
decomposable tensor arrow and is not trace-preserving. The
exact equality remains valid if the allowed maps are enlarged
to any such family containing the already proved attaining
diagonal arrow. Attainment, rather than arbitrary linear
reachability, supplies the lower equality.

An equivalent trace check is useful. For any nonzero a in E
of valuation R and integer n,

    Tr_E(a*O_E) subset p^n*Z_p
       iff p^(-n)*a in I
       iff R-n>=-kappa.

Thus the exact trace ideal is p^floor(R+kappa)*Z_p, which in
this tame discretely valued setting is p^ceil(R)*Z_p. The
component idempotents then give
Tr_(T_m/Qp)(Z_j*B_m)=p^k_j*Z_p, with no multiplicity factor.
Since B_m*A_m=B_m, this is also the integral trace condition
for (8.5). This independent description does not require
the transported map Phi itself to preserve trace.

There is also an exact cohomological realization of the whole
input type, if that enlarged family is expressly selected.
Let rho=p^(-1)*log_BK^std and let Kum be the integral Kummer map.
Log and exp are inverse on the positive ideal p*z_j*I, giving

    rho(Kum(1+p*z_j*I))=z_j*I,
    rho(Kum(1+p*I))=I                              (8.7)

as actual sets. Hence the saturated principal-unit families
realize the whole product. The single class of 1+p*z_j does
not by itself realize (8.7), and this theorem does not claim
that a published source has already enlarged its family.

## 9. Signs, standard-coordinate scaling, and native Haar measure

Since j<=h=(ell-1)/2, one has 2j^2/ell<j and therefore k_j<=j.
Writing m=j+1, the point exponent satisfies

    e*k_j-(e-1)m <= j-(e-1) < 0.                  (9.1)

The whole exponent is smaller by e and is negative as well.
Thus both normalized hulls are nonintegral, and M_j=P_j is
nonintegral too. Their source definitions remain different.

Under the standard Bloch--Kato inverse, each of the m normalized
coordinates is multiplied by p, including every background entry.
Q_p-linearity of the arrows gives an overall factor p^m. The
exponents in (1.3) become

    e*k_j+m>0,   e*n_j+m>0,                         (9.2)

proving (1.5). If the pre-transport source is rescaled consistently
as well, its hull is p^m*M_j=P_j^std, the strictly integral
lattice beta^[e*k_j+m]*B_m. Keeping Z_j*B_m unchanged
while rescaling only the logarithmic entries would instead
describe a different comparison; it is not (1.5).

For an explicit measure statement, take additive Haar measure
on the entire Q_p-vector space T_m, normalized by mu(B_m)=1.
It is not a probability measure restricted to B_m. Put

    D_m=d^m,  V_B(H)=log(mu(H))/D_m.

There are d^(m-1) field components, each with residue degree 2.
Thus

    V_B(beta^t*B_m)=-(t/e)*log p.

The exact pre-transport ideal calculation gives

    V_B(M_j)=V_B(P_j)=(m*kappa-k_j)*log p>0,
    V_B(S_j)=V_B(M_j)+log p.                       (9.3)

The remaining one-log-p difference belongs to the larger whole
source, not to uncertainty in M_j. For the consistently
standard-scaled sources the exact values are

    V_B(p^m*M_j)=-(k_j+m/e)*log p,
    V_B(p^m*S_j)=-(n_j+m/e)*log p,                  (9.4)

both strictly negative. Thus a positive standard **valuation
exponent** is not a positive standard logarithmic volume.

Changing the reference order from B_m to A_m would add the
constant log[B_m:A_m]/D_m to both volumes measured with that
new reference. No such reference change is made on only one
side here.

## 10. Boundaries, original sources, and formalization status

The theorem is uniform for every prime ell>=7, every prime p
in the stated congruence class, every b0 of valuation 2, and
every choice of the displayed roots. The attaining arrow may
depend on these choices. The result does not claim one arrow
simultaneously works for every possible root choice or for a
union of differently marked global carriers.

The global Frobenius argument, rational-curve construction,
control of all global Tate orders, Linnik estimates, compact
bounding domains, and escape from a finite exceptional set
are not hypotheses silently supplied by this local theorem.
They are separate work. In particular a native square-power
family is not identified with a source that instead changes
marked absolute values while keeping its root element fixed.

The pre-transport source in (8.2), the whole-product family, and
the point family have distinct definitions. The equality M_j=P_j
identifies the specified native hulls, not the source objects.
These calculations do not identify additional Ind3
unions or the global cross-Frobenius comparison. The signs
in section 9 must travel with their explicit coordinate
and Haar normalizations. No ABC conclusion follows.

The original full-Galois sources are the unchanged versions:

- [Jannsen--Wingberg (1982), original presentation PDF](https://epub.uni-regensburg.de/26689/1/jannsen17.pdf),
  local `sources/galois_lift_2026_08_30/Jannsen_Wingberg_1982_Inventiones.pdf`.
- [Hoshi--Nishio, revised 2022 PDF](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1931revised.pdf),
  local `sources/galois_lift_2026_08_30/Hoshi_Nishio_2022_revised.pdf`.
- [Kondo, arXiv:2512.09231v2](https://arxiv.org/pdf/2512.09231v2),
  local `sources/galois_lift_2026_08_30/Kondo_2512.09231v2_Dec2025.pdf`.

The general point/root bridge and the two tensor trace-dual
calculations are independently written out above; their source-type
audit is also in `IUT_NATIVE_PILOT_DICTIONARY_2026_08_30.md`.
The sharper maximal-order trace-dual argument was proposed and
independently checked on 2026-08-31; its general formulation is
`TRACE_DUAL_PREIDEAL_EXACT_HULL_2026_08_31.md`. It strengthens the
previous valid sandwich for the same pre-transport ideal.
None of these cited mathematical inputs has been added as a
Lean axiom. The previous Lean module
`IUTThreeLabelMinimumLayer20260830.lean` proves generic linear
central laws and finite-field avoidance, but not the local field,
the full-Galois lift, or the analytic logarithm statements.
The new companion is
`Lean/IUTThreeClosures/IUTGeneralTameSquareLabels20260830.lean`.
It proves the actual half-range uniqueness for
`30*j^2+1=0` in `ZMod ell`, the prime nondivisibility of `2*j^2`,
the strict natural-number floor/ceiling bracket, the bad-index
budget and finite avoidance consequence, and the exponent identities
and signs. Direct `lake env lean` checking succeeded without warnings.
Five representative `#print axioms` commands reported only
`propext`, `Classical.choice`, and `Quot.sound`.
This is an arithmetic companion, not a formalization of (1.2),
the local field, or the trace-dual and Haar arguments from paper inputs.
