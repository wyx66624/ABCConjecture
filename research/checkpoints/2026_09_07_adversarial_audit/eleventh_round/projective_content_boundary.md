# PC1--PC2. Bounded projective content and a precise inverse boundary

Date: 2026-09-07. Complete ordinary proof independently reviewed in full
by independent_route, critical_bottleneck, and the root agent: PASS.
Publication is a separate pending stage.
This is separate from the reviewed double-cover construction. It does
not claim a counterexample to either simultaneous compatibility or ABC.

Let O=Z[zeta], zeta^2-zeta+1=0, and N(r+s*zeta)=r^2+rs+s^2.
An element u+v*zeta is primitive when gcd(|u|,|v|)=1.

## PC1. The content after multiplication divides the multiplier norm

Let tau=r+s*zeta be nonzero and W=u+v*zeta be primitive. Write

    tau W=A+B*zeta, C=gcd(|A|,|B|)>0.

Then

    C divides N(tau).                                  (PC1)

Proof. The multiplication matrix and its adjugate give the actual
integer identities

    A=r*u-s*v, B=s*u+(r+s)*v,
    (r+s)*A+s*B=N(tau)*u,
    -s*A+r*B=N(tau)*v.

Thus C divides both N(tau)*u and N(tau)*v. Bezout for the primitive
pair u,v gives C|N(tau). Nonzero tau and W ensure (A,B)!=(0,0).
This proof does not require tau to be primitive or coprime to W.

In the rational maps L_tau,n from RD, if the primitive input root w
is unramified, then its power w^n is primitive by the reviewed
Eisenstein power theorem. Applying PC1 to W=w^n proves that the
projective output content divides N(tau), independently of n.
The unramified power condition is material; PC1 itself is stated for
the already primitive W rather than assuming every primitive power
is primitive at the ramified prime.

If (a,b) is the primitive output after division by C, its norm is

    a^2+ab+b^2=N(tau)*N(w)^n/C^2.                       (PC2)

Although C is bounded by the residual norm, the displayed residual
N(tau)/C^2 is a positive rational number. It need not be an integer.

## PC2. A bounded-content counterexample to the single-map inverse

For every integer n>=2 there is a unit u_n in O such that, with

    pi=2+zeta, w=bar(pi)=3-zeta, tau_n=u_n*pi,

the primitive output of tau_n*w^n has positive coordinates a_n,b_n
and satisfies

    gcd(a_n,b_n)=1,
    a_n^2+a_n*b_n+b_n^2=7^(n-1),
    content(tau_n*w^n)=7,
    N(tau_n)=N(w)=7.                                  (PC3)

There are no positive integers V,R with R>1 and

    a_n^2+a_n*b_n+b_n^2=V*R^n.                        (PC4)

Proof. Since pi*bar(pi)=7, one has the exact equality

    pi*w^n=7*w^(n-1).

Every power w^m, m>=1, is primitive. Here is a direct proof for this
specific family. Its norm is 7^m, so any rational prime dividing both
coordinates would have to be seven. The evaluation homomorphism
O -> F_7 sending zeta to five is valid because 5^2-5+1=0 modulo seven.
It sends w to 3-5=-2, a nonzero element. Hence w^m is nonzero under
this map and cannot have both coordinates divisible by seven.

No boundary arm of this primitive power is zero. Otherwise one of
its coordinates, or their sum, is zero, and primitivity forces its
norm to be one, contradicting 7^m>1. A unit rotates any such element
into the open positive sector. Explicitly multiplication by zeta
sends (A,B) to (-B,A+B), and by zeta^2 to (-A-B,A). For opposite
signs, after negating if necessary, these two rotations cover the
cases A+B positive or negative; pairs of equal sign need only the
identity or negation. Choose u_n accordingly for w^(n-1).
Units preserve the norm and integral content. This proves all of PC3.

If PC4 held, every prime divisor of R would be seven. Thus R=7^j
for j>=1, so the valuation on its right side would be at least n,
whereas its left side has valuation n-1. This is impossible.

For an explicit positive instance, take n=5 and u_5=zeta^2. Then

    tau_5=-3+2*zeta,
    w^4=39-55*zeta,
    tau_5*w^5=112+273*zeta=7*(16+39*zeta),
    16^2+16*39+39^2=2401=7^4.

The root parameter in the rational power map is the fixed rational
number t=3/(-1)=-3. Replacing w by t+zeta multiplies it by minus one,
which does not change projective output. Thus these are genuine
single-map rational evaluations, with tau_n in a fixed set of at most
six multipliers. Their projective outputs are actual positive primitive
integer seeds and their contents are uniformly bounded by seven.

The canonical n-free residual of the reduced norm is nevertheless
7^(n-1), while the canonical n-th-power root is one. Its normalized
logarithmic residual tends to log seven, whereas the given multiplier
has normalized logarithmic norm log(7)/n tending to zero. This is the
specific failure mechanism: cancellation leaves the rational residual
1/7, and forcing it back into an integral n-free residual changes the
exponent by almost n.

This disproves an automatic converse from a single rational-map
evaluation with bounded content to an integral nonunit norm profile
with the same prescribed exponent. It does not assert that these
points satisfy the second rational-map equation in RD. They therefore
do not refute the full fiber-product compatibility condition, the
actual forward DC lift, an alternative extraction exponent, a signed
compensation condition, or ABC. In fact their norm has the evident
alternative exponent n-1; this is exactly why preserving the specified
exponent is a necessary part of the failed inference.

No finite-search absence, software certificate, or Lean proof is used
to justify the infinite statement. The proof is the displayed exact
family and valuation obstruction. Formalization and independent review
are separate verification stages. Both peer ordinary reviews have now
passed; no Lean verification of this family is claimed.
