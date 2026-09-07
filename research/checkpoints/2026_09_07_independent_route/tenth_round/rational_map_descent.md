# RD1--RD3. A rational-map descent of the two actual profiles

Status: complete ordinary proof independently reviewed by
critical_bottleneck and adversarial_audit; root review is pending.
This is separate from the reviewed DC manuscript; no claim below is silently
inserted into that manuscript. The expanded rational model has a
different coefficient-height budget from the sparse quadratic model.

Retain the actual DC hypotheses, including h,g>=2, R,Q>1, and no
g-free condition on the given second residual. Put

    tau0=u0*gamma^e*v0, tau1=u1*v1 in Z[zeta],
    rho(T)=(T+zeta)/(T+bar(zeta)),
    r(X)=X/(X^2+X+1).

## RD1. Exact rational maps and all projective exceptional points

For any nonzero Eisenstein integer tau and integer n>=1, define
homogeneous integer polynomials A_tau,n, B_tau,n by

    tau*(T+S*zeta)^n=A_tau,n(T,S)+B_tau,n(T,S)*zeta.

Then L_tau,n=[A_tau,n:B_tau,n] is a morphism P1_Q->P1_Q of degree n.
Over K0 it satisfies the identity of projective maps

    rho(L_tau,n(t))=(tau/bar(tau))*rho(t)^n.       (RD1)

For n>=2 its only critical points and branch values are beta_+=-zeta
and beta_-=-bar(zeta), with ramification index n at each.

Proof. A common projective zero of A and B over an algebraic closure
would make both tau*(T+S*zeta)^n and its coefficient conjugate
bar(tau)*(T+S*bar(zeta))^n zero. Since tau and bar(tau) are nonzero,
this forces T+S*zeta=T+S*bar(zeta)=0, hence T=S=0. Thus A and B
have no common projective zero. Conjugating the identity and dividing
proves RD1 as an identity of rational functions, hence of projective
maps. The map rho is a projective linear automorphism, and RD1 is
a power map followed by a nonzero scaling. Its degree is n, and its
two critical points/values are as claimed because rho(beta_+)=0,
rho(beta_-)=infinity. This handles poles of A/B by projective maps,
rather than discarding them as exceptional affine coordinates.

The degree-two map r is the morphism

    [X:Y] |-> [XY:X^2+XY+Y^2].

Its only critical points are X/Y=1,-1, of index two, with values
1/3,-1. Indeed r'(x)=(1-x^2)/(x^2+x+1)^2. The two poles beta_+,
beta_- are simple, and infinity maps to zero without ramification,
as seen in the local coordinate r(1/t)=t/(1+t+t^2).

It follows that F_h=r o L_tau0,h has degree 2h and has precisely
the three branch values infinity,1/3,-1. Above infinity its two
ramified points are beta_+,beta_-, of index h. Above either 1/3
or -1, the h inverse images under L_tau0,h of 1 or -1 are distinct
and have index two. These exhaust the ramification, since the total
contribution is 2(h-1)+2h=4h-2, the required total for degree 2h.

## RD2. A smooth rational fiber product

Let D be the full projective fiber product over the s-line defined by

    L_tau1,g(t1)=r(L_tau0,h(t0)).                  (RD2)

It is a smooth geometrically connected curve over Q. Its equation in
P1_t0 x P1_t1 has bidegree (2h,g), and its genus is

    genus(D)=(2h-1)*(g-1)=1+2hg-g-2h.            (RD3)

After base extension to K0, D is isomorphic to the smooth projective
curve DC2. All actual profiles give Q-points of D.

Proof. The branch values of L_tau1,g are beta_+,beta_-; they are
disjoint from infinity,1/3,-1, the branch values of F_h. At every
geometric point in the fiber product, at least one of these two maps
is unramified. In local parameters, the relation between the two maps
therefore has a nonzero derivative in at least one variable. This
proves smoothness at every projective point, including the points
above infinity. A homogeneous equation is

    A_tau1,g(t1)*(A_tau0,h(t0)^2+A_tau0,h(t0)*B_tau0,h(t0)
                       +B_tau0,h(t0)^2)
       -B_tau1,g(t1)*A_tau0,h(t0)*B_tau0,h(t0)=0.        (RD4)

Each pair has no common zero, and the two maps have their asserted
degrees, giving bidegree (2h,g).

On a dense open set put x=L_tau0,h(t0), Y=rho(t0), Z=rho(t1).
RD1 and the identities

    tau0/bar(tau0)=eta0^(-1),
    tau1/bar(tau1)=eta1^(-1),
    rho(r(x))=G(x)/Gbar(x)

identify the equations exactly with DC6. Conversely, invert the
projective linear map rho to recover t0 and t1 from Y,Z. Thus the
generic function field is the geometrically connected field of DC2.
There cannot be an additional component confined to the removed
finite set of base values: every fiber of these finite maps is finite,
whereas each smooth component of the fiber product is a curve.
This proves geometric connectedness. Since both projective curves
are smooth, the birational identification extends to an isomorphism
over K0. It also gives the asserted Q-descent without assuming that
arbitrary individual choices of extensions are compatible.

For a direct genus calculation, project to t0. This map has degree g.
The 2h preimages of each beta value under F_h are distinct, since
F_h is unramified there. They give 4h branch points, each of inertia
g. Riemann--Hurwitz yields

    2genus(D)-2=-2g+4h(g-1),

which is RD3.

For the actual rational point, write w_i=r_i+s_i*zeta. Primitivity
and N(w_i)>1 force s_i!=0: otherwise gcd(r_i,0)=1 would give a
unit. Hence t_i=r_i/s_i is rational. Substituting into the exact
power identities gives

    L_tau0,h(t0)=a/b=x,
    L_tau1,g(t1)=ab/M=r(x).

The displayed actual denominators are nonzero because b,M>0. Thus
these are actual Q-points of the full projective curve. No arbitrary
rational point is asserted to come from a primitive positive seed.

## RD3. Coefficient-height accounting under expansion

The expanded integral equation RD4 has individual and projective
coefficient height bounded by

    C*(h+g+log V0+log V1+1).                     (RD5)

Proof. Powers of zeta have integral coordinates in {0,1,-1}. The
binomial expansion of (T+S*zeta)^n therefore bounds every coordinate
coefficient in absolute value by 2^n. The coordinates of tau0 have
absolute value at most 2*sqrt(V0), since N(tau0)=3^e V0 and e<=1;
those of tau1 are at most 2*sqrt(V1). Multiplication by tau only
changes this bound by an absolute factor. Thus the coefficients of
the first A,B are bounded by C*sqrt(V0)*2^h, and those of the
second pair by C*sqrt(V1)*2^g. Products of two degree-h binary forms
add at most h+1 terms per coefficient. Equation RD4 consequently
has coefficients bounded by

    C*(h+1)*V0*sqrt(V1)*2^(2h+g).

Taking logarithms, and using log(h+1)<=h, proves RD5. For an integral
coefficient vector, its projective height cannot exceed the logarithm
of its largest absolute coefficient, since removing the coefficient
gcd only decreases that bound.

The sparse equations over K0 in DC have height O(1+log V0+log V1).
The expanded rational equation has the valid larger bound RD5. These
are different models, related by exponent-dependent expansions; no
exponent-free bound is asserted for the latter. Neither budget is an
upper bound for an actual point. The explicit rational maps now give
a concrete compatibility problem for the two actual norm profiles,
with all rational-map poles and branch fibers accounted for.

## Standard geometric inputs, directly checked

The rational-map calculations and the local smoothness argument above
are given explicitly. The extension of the birational map between
smooth projective curves uses the standard uniqueness of their smooth
projective function-field models. This was checked directly in the
Stacks Project, Lemma 53.2.2 and Theorem 53.2.6:
https://stacks.math.columbia.edu/tag/0BXX .
Its Lemma 53.2.3 also records flatness for nonconstant maps to a normal
curve, consistent with the finite-fiber component argument used above.

The characteristic-zero ramification formula was directly checked in
the Stacks Project, Section 53.12:
https://stacks.math.columbia.edu/tag/0C1B .
These are established geometric inputs, not new claims of this note.
