# PC arithmetic core: ordinary statements before an Int.gcd formalization

Date: 2026-09-07. This list isolates the elementary integer content core
of the independently reviewed PC proof. It proposes signatures for the
root researcher; it is not a claim that these declarations already exist
or have compiled. It requires no new Mathlib-dependent analytic module.

For integers r,s,u,v define

    N(x,y)=x*x+x*y+y*y,
    A=r*u-s*v,
    B=s*u+(r+s)*v,
    c=Int.gcd A B, a natural number,
    C=(c : Int).

Here Int.gcd is the actual nonnegative gcd of the integer coordinates.
The primitive input condition is Int.gcd u v=1. Do not replace it by
assumed Bezout coefficients in the final main statement, and do not
assume the desired content divisibility as an interface hypothesis.

## Seven bounded target statements

**PCF1, first adjugate identity.** For all integer inputs,

    (r+s)*A+s*B=N(r,s)*u.

Expand A,B; the uv terms cancel and the coefficient of u is
r*r+r*s+s*s. This is a polynomial identity with no hypotheses.

**PCF2, second adjugate identity.** For all integer inputs,

    -s*A+r*B=N(r,s)*v.

The same direct expansion proves it. No nonzero or primality condition
is used in either adjugate identity.

**PCF3, actual multiplicative norm.** For all integer inputs,

    N(A,B)=N(r,s)*N(u,v).

Expand the two sides. This is the actual multiplication formula in
Z[zeta], with no quotient, norm-root or content premise.

**PCF4, content divides the multiplier norm.** If Int.gcd u v=1, then

    (Int.gcd A B : Int) divides N(r,s).

The actual gcd divides A and B, hence both linear combinations PCF1
and PCF2. The integer Bezout identity for the primitive pair u,v
then makes it divide N(r,s). This also holds when r=s=0, because
both the content and the norm are zero and 0 divides 0. Allowing that
case makes the core divisibility signature simpler; it must not be
confused with positive content in the following quotient statement.

**PCF5, positive actual content.** Under Int.gcd u v=1 and
(r!=0 or s!=0), one has c>0, equivalently C>0.

Indeed the primitive pair (u,v) is nonzero. The identity
4N(x,y)=(2x+y)^2+3y^2 proves N(x,y)>0 for each nonzero integer pair.
By PCF3, (A,B) cannot be zero. Its actual gcd is therefore positive.

**PCF6, the cleared norm of the primitive quotient.** Under the same
hypotheses as PCF5, put a=A/C and b=B/C using integer division.
Then

    C*a=A, C*b=B,
    C^2*N(a,b)=N(r,s)*N(u,v).

The first two equalities use the actual gcd divisibility and C!=0,
so these divisions are exact, not rounded. Substitute them into PCF3
and expand the homogeneous norm. If convenient, the actual quotient
primitivity statement Int.gcd a b=1 can be proved separately; it is
not needed to certify the displayed cleared norm identity.

**PCF7, the concrete positive n=5 instance.** Exact integer evaluation
certifies the bundled data

    mul((-3,2),(62,-149))=(112,273),
    Int.gcd 62 (-149)=1,
    Int.gcd 112 273=7,
    (112/7,273/7)=(16,39),
    Int.gcd 16 39=1,
    N(-3,2)=7, N(62,-149)=7^5, N(16,39)=7^4.

Every assertion here is an actual integer equality. The first input
pair is tau_5 and the second is w^5 in PC2. The connection to the
power w^5 may be included as a direct computed equality if the reused
Eisenstein power definition is in scope; it is not necessary for the
generic content theorem PCF4.

## Scope and excluded stronger statements

This finite arithmetic core proves a genuine gcd/Bezout statement,
not only a conditional identity with content divisibility supplied.
It does not formalize every primitive unramified power, the infinite
norm-seven family, positive-sector unit selection, or the rational
fiber-product inverse. Those ordinary results remain separately
reviewed inputs unless additional declarations are actually proved.

For example, even a proof of c|N(tau) and the cleared identity PCF6
does not show N(tau)/c^2 is integral. PC2 has c=7 and N(tau)=7, and
the resulting rational residual is 1/7. Nor should c^n|V*Vprime be
substituted for the distinct rad(c)^n theorem in IL2. These are
material arithmetic distinctions, not omitted formal hypotheses.

## Additional finite depth core for the distinct IL residual bill

The following optional target is separate from the seven content targets
above. It uses only nonnegative integer depths and their exact relation.
Let n,a,f be positive natural numbers and b,r natural numbers. If

    |(a : Int)-(n*f : Int)|=(b+n*r : Nat),

with the right side coerced to Int, then n<=a+b.

Proof. If a>=n, the result is immediate. Otherwise 0<a<n and f>=1
give n*f>a. The absolute-value equality becomes n*f-a=b+n*r,
so a+b=n*(f-r) in the integers. The left side is positive, so f-r
is a positive integer, hence at least one. Thus a+b>=n.

This is exactly the primewise lower bound used in IL2, with a the
initial residual depth, f the original root depth, b the desired
output residual depth, and r the changed numerical root depth. It
does not assume the original root survives cancellation. The conditions
a>0 and f>0 represent an actual opposite-orientation overlap and are
both material. Without a>0, take a=b=0 and f=r=1. Without f>0,
take n=5, a=b=1 and f=r=0. In each case the displayed depth relation
holds but the desired lower bound fails.

This scalar theorem alone does not formalize prime allocation, exact
content valuations, the radical of C, or the product rad(C)^n|VVprime.
Those are additional ordinary inputs unless the corresponding formal
connections are actually proved.
