# Effective escape from fixed affine slices of the second norm

Status: ordinary proof, 2026-09-07. All of AS1--AS4, including the
simultaneous three-chart consequence, passed independent final review
by `adversarial_audit`, who independently opened both cited primary
theorems. No earlier round is modified. This is an
application of established effective Diophantine theorems to the actual
quartic, not a new proof of those theorems or a solution of ABC.

Let

    F(a,b)=a^4+3a^3b+5a^2b^2+3ab^3+b^4.

Consider positive coprime integers a,b and positive integers V,Q,g with

    F(a,b)=V Q^g,  Q>1,  g>=2.                               (AS1)

There is no disjoint-support assumption. V need not be g-free for the
theorems here, though that canonical choice is allowed.

## AS1. The three exact polynomial charts

For a nonzero integer c define

    P_c(T)=F(T+c,T)
          =13T^4+26cT^3+20c^2T^2+7c^3T+c^4,
    R_c(T)=F(T,c)
          =T^4+3cT^3+5c^2T^2+3c^3T+c^4.                   (AS2)

Both have degree four and four distinct roots over the algebraic
closure. Indeed, if alpha_1,...,alpha_4 are the distinct roots of
F(X,1), then the roots of R_c are c alpha_i, and those of P_c are
c/(alpha_i-1). None of the denominators vanishes, since F(1,1)=13.
The maps are injective on these four roots when c is nonzero.
Equivalently both discriminants are `117 c^12`, by the homogeneous
binary-discriminant transformation. Their coefficient heights obey

    log max(1, absolute coefficients)
       <= log 26+4 log(1+|c|).                               (AS3)

Each actual equation (AS1) has one of these charts with c=b, c=a,
or c=a-b, using the symmetry of F in a,b. The last c is nonzero:
if a=b, primitivity forces a=b=1 and F=13, which is divisible by
no Q^g with Q>1 and g>=2. Thus all three charts are available.

## AS2. A universal effective exponent bound

There is an effectively computable constant C>=1, depending only on
the fixed quartic, such that every equation (AS1) satisfies

    log g <= C[1+log V+log(1+M)],
    M=min(a,b,|a-b|).                                        (AS4)

In particular, for delta=1/C>0,

    1+M >= exp(-1) g^delta/V.                                (AS5)

Proof. We use Berczes--Evertse--Gyory, *Effective results for
Diophantine equations over finitely generated domains*, Theorem 2.3,
whose primary paper was actually opened:

https://arxiv.org/pdf/1301.7175

Their equation (2.4) is `H(t)=delta_0 y^m`. Their Theorem 2.3 gives
an effective upper bound on m when H has nonzero discriminant and
y is nonzero and is not a root of unity. Specialize their finitely
generated domain to `A=Z[0]=Z`, represented by `Z[U]/(U)`. The
presentation has r=d=1, the polynomial degree is n=4, and the
coefficient representatives are constant integers. Thus their
bound (2.7) becomes

    log m <= C_0(h+1),                                      (AS6)

with an absolute effective C_0 for this fixed presentation and degree.
Here h can be taken to be the maximum of one, the logarithmic
coefficient height of H, and log|delta_0|. Take H=P_c or R_c,
delta_0=V, y=Q, m=g. Their root-of-unity exception is absent because
Q>1. The coefficient estimate (AS3) and an increase of the fixed
constant yield

    log g <= C[1+log V+log(1+|c|)].                           (AS7)

Apply this separately at c=a,b,a-b and choose the smallest absolute
value. The same C works in all three charts. This proves (AS4).
Rearrangement gives (AS5).

The cited theorem is the effective Schinzel--Tijdeman mechanism.
The estimate is a direct specialization of its degree/height bound;
no numerical value of its large constant C is claimed to have been
computed here.

## AS3. Fixed slices contain only finitely many power points

Fix nonzero c and positive V. There are only finitely many integers
t,Q,g with Q>1, g>=2 satisfying either

    P_c(t)=VQ^g  or  R_c(t)=VQ^g.                            (AS8)

These solutions are effectively determinable in principle.

Proof. AS2's chart argument bounds g effectively for these fixed
data even without a primitive restriction. For each of the finitely
many g, Theorem 2.2 of the same primary paper gives an effective
finite list for the hyperelliptic or superelliptic equation. Its
conditions hold: degree four and nonzero discriminant, including
the exponent-two case. The finite union proves the assertion.

Consequently, for fixed V and fixed H, only finitely many actual
primitive seeds (AS1) have

    min(a,b,|a-b|) <= H.                                     (AS9)

There are finitely many choices of a chart and of its nonzero
integer parameter c with |c|<=H; use AS3 on each. The omitted
zero-difference case was already excluded exactly in AS1.

## AS4. Relation to compression and to finite local shadows

For the pure branch V=1, any hypothetical family with g tending to
infinity must have all of a,b,|a-b| tending to infinity at least
at the polynomial rate in (AS5). The same lower bound is
`M>=g^(delta-o(1))` if V=g^o(1). More generally, (AS4) excludes any
g-to-infinity family with

    log V+log(1+min(a,b,|a-b|))=o(log g).                     (AS10)

This is a verified necessary arithmetic condition. It is much narrower
than lambda=max(1,log V)/g tending to zero: a residual of size
exp(sqrt(g)) can have small lambda while exceeding every fixed
power of g. No such residual is excluded by (AS4).

The actual local-shadow family `a=Lk,b=Lk+1` lies on the single
global slice a-b=-1, even when L varies. AS3 with V=1 therefore
proves that only finitely many of these positive primitive seeds
can satisfy an actual pure-power equation at any exponent g>=2.
This does not contradict their simultaneous compatibility with every
prescribed finite collection of local power tests. It supplies a
global restriction not captured by that specific finite-state Mazur
product. It neither identifies a boundary eigenform nor excludes
global pure powers on moving affine slices.

## Proof dependencies and scope

Internal inputs: the exact quartic F and its discriminant 117; the
explicit expansions and root transformations in AS1. External inputs:
the effective exponent bound (Theorem 2.3) and effective finite lists
at fixed exponent (Theorem 2.2) in the cited primary paper.
All integer domains and exceptions are stated above. No finite scan
is used as evidence for the universal exponent estimate, and no
full Lean formalization of these transcendence inputs is claimed.
