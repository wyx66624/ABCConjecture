# IL1--IL4. An integral inverse gate and a sharp residual cost of cancellation

Status: complete ordinary proof; root, critical_bottleneck, and
adversarial_audit independently reviewed IL1--IL4 and passed. Both peers
also passed the final self-contained TeX transcription. This is an
eleventh-round note; the tenth-round MX/DC/RD mathematical files are frozen.
No point-height upper bound, simultaneous small-residual family, or ABC
conclusion is asserted. The distinction between a rational map and an
integral profile is essential here.

Let O=Z[zeta], zeta^2-zeta+1=0, gamma=1+zeta. The content of a
nonzero Eisenstein integer A+B*zeta is gcd(|A|,|B|), taken positive.
Let n>=2 be an integer and suppose

    tau=u*gamma^e*v, e in {0,1}, V=N(v),
    w primitive unramified, R=N(w)>1,                 (IL1)

where v is primitive oriented unramified and u is a unit. In particular
tau is primitive, N(tau)=3^e V, and 3 does not divide V R. Put

    z=tau*w^n=A+B*zeta, C=content(z),
    zred=z/C, Mred=N(zred)=3^e V R^n/C^2.             (IL2)

The reduced pair is primitive but is not assumed positive in the
single-profile assertions. Signs and units do not affect the norm.

## IL1. Exact content from the opposite orientations

The integer C is prime to 3 and divides V. Its prime divisors are
exactly the rational split primes at which tau and w have opposite
orientations. If such a prime p has depths

    a_p=v_p(V)>0, f_p=v_p(R)>0,

then

    v_p(C)=min(a_p,n*f_p),
    v_p(Mred)=|a_p-n*f_p|.                            (IL3)

At a shared prime with the same orientation there is no content.

Proof. Both tau and w are primitive. In the Eisenstein UFD this
means that at each split rational prime they contain at most one
orientation. No inert prime occurs in their norms. At the ramified
prime gamma, w is a unit and tau has depth e<=1. Divisibility of
both coordinates by three would require gamma-depth at least two,
so 3 does not divide C.

At a split prime p, rational divisibility by p is divisibility by
both conjugate Eisenstein prime factors. If the two elements have
the same orientation, their product still has only one orientation.
If their orientations are opposite, the product has depths a_p and
n*f_p at the two conjugate factors. Its rational content at p has
depth their minimum, and after dividing by that content the remaining
norm exponent is their absolute difference. This proves IL3 and all
the support assertions. Finally min(a_p,n*f_p)<=a_p at every prime,
so C|V. The primitivity of tau is used in this argument; a general
nonprimitive multiplier does not satisfy the subsequent residual bill.

This also follows for C|N(tau) from the independent PC1 adjugate
identity, but the exact minimum in IL3 uses the oriented factors.

## IL2. A residual bill for any prescribed-exponent representation

Suppose the primitive reduced norm has any representation

    Mred=3^e Vprime Rprime^n,
    Vprime,Rprime positive integers.                 (IL4)

The root Rprime may differ from R and may be one. Then

    rad(C)^n divides V*Vprime,                        (IL5)

where rad(1)=1. In particular, if C>1, then

    log V/n + log Vprime/n >= log 7.                 (IL6)

Proof. Every p|C is split, so p>=7. Put a=a_p and f=f_p. If
a>=n, its contribution to V alone is at least p^n. If 1<=a<n,
then n*f>=n>a, and IL3 gives v_p(Mred)=n*f-a. In IL4 the p-depth
of Vprime is congruent to -a modulo n and is nonnegative. It must
therefore be at least n-a. In either case

    v_p(V)+v_p(Vprime)>=n.

Multiply the resulting divisibilities for the distinct p|C to get
IL5. Taking logarithms gives (log V+log Vprime)/n>=log rad(C),
which is at least log seven if C>1.

There is always a canonical n-free representation IL4: at each
prime different from three take the norm exponent modulo n into
Vprime, and the quotient into Rprime. At three the exponent of
Mred is exactly e because R,V,C are prime to three. Every other
integral residual at exponent n is at least the canonical one at
each prime modulo n. Thus IL5 in particular gives a computable
lower bound on the smallest possible residual after cancellation.

Equivalently, an input residual and an output residual satisfying
(log V+log Vprime)/n<log seven force C=1. This does not assume
that the prescribed root norm is preserved.

The threshold is sharp. The independently proved PC2 family takes
pi=2+zeta, w=bar(pi), tau=u_n*pi, giving C=7, V=7, and primitive
reduced norm 7^(n-1). Its canonical residual is Vprime=7^(n-1),
so equality holds in both IL5 and IL6. The unit u_n can make both
reduced coordinates positive. This is a single-map boundary example,
not a point on the full two-map fiber product.

## IL3. An explicit integral inverse for the rational fiber product

Fix tau0=u0*gamma^e*v0 and tau1=u1*v1 as in RD, with each v_i
primitive oriented unramified, V_i=N(v_i), and h,g>=2. Let
(t0,t1) be a rational point of the full RD curve with

    x=L_tau0,h(t0)>0 finite,
    L_tau1,g(t1)=x/(x^2+x+1).                        (IL7)

Choose primitive integral homogeneous coordinates for t_i and write
w_i=r_i+s_i*zeta. Assume the roots w_i are unramified and nonunits,
with R=N(w0), Q=N(w1). Put

    C0=content(tau0*w0^h),
    C1=content(tau1*w1^g).

Let x=a/b be its unique reduced expression with a,b>0. Then

    M=a^2+ab+b^2=3^e V0 R^h/C0^2,
    F(a,b)=V1 Q^g/C1^2.                             (IL8)

In particular, if C0=C1=1, the point gives actual integer norm
profiles with the original residuals and exponents. The underlying
oriented identities hold up to harmless signs of their units. More
generally, the two numerical profiles with the same R,Q,h,g and
integral residuals at most V0,V1 are obtained exactly when

    C0^2 divides V0 and C1^2 divides V1.             (IL9)

Proof. The first output tau0*w0^h has ratio a/b. Dividing its
coordinates by their content and then changing their common sign
gives exactly (a,b). Taking norms proves the first equation IL8.

Also gcd(ab,M)=1. The second output has ratio ab/M>0 by IL7,
so after dividing by its content and changing the common sign its
coordinates are exactly (ab,M). Its norm is F(a,b), proving the
second equation IL8. All actual denominators are nonzero because
a,b,M>0. If an input homogeneous coordinate s_i were zero, the
primitive root would be a unit, which has already been excluded.

If each content is one, this is already the required oriented
factorization, with at most unit sign changes. For general content,
IL8 determines the residuals with the same fixed root norms uniquely
as V_i/C_i^2. They are positive integers precisely under IL9, and
then are at most the initial V_i. This does not say that the same
orientations w_i survive after division; the numerical profiles can
be given actual oriented liftings by the Eisenstein factorization
used in DC. Nor does failure of IL9 exclude a representation using
a different root norm.

## IL4. The low-residual point domain has a finite local description

For either side of IL7, retain its exponent n and initial residual V.
Its output has some chosen residual Vprime at the same exponent.
If (log V+log Vprime)/n<log seven, IL2 forces content one. Thus in
the range where the sum of initial and desired output residual
proportions is below log seven, the nonzero-content points cannot
produce the desired profiles, even after changing the numerical root.

Content one is directly testable by finitely many local conditions.
At each p|V, tau is divisible by one of the two split prime factors.
Its product with w^n has no content at p if and only if w is not
divisible by the opposite prime factor. In terms of primitive
homogeneous coordinates [r:s] for w, this excludes one point of
P1(F_p), namely the root r/s=-theta where theta is the image of
zeta for that opposite factor. A norm-zero primitive residue has
s nonzero, so this description misses no point at infinity.
There are no content conditions at other primes; the root's
unramifiedness at three was assumed separately.

Accordingly the actual-forward DC/RD map has a sufficient integral
inverse on the open arithmetic domain defined by these finite local
exclusions on both sides. Within the joint low-residual budget, those
exclusions are necessary as well for a point to yield a low-residual
profile at the prescribed exponents. This statement concerns the
particular rational point and its chosen root coordinates, not the
uniqueness of all profile representations of the same seed.

The sufficient direction reconstructs the original residuals V0,V1.
It does not promise an arbitrarily specified smaller output-residual
budget: those original residuals might exceed that separate target.
The claim for a smaller chosen target is the stated necessary exclusion
of nonzero content under the joint input/output budget.

The new bill rad(C)^n|V Vprime and the explicit integral inverse
do not bound point heights or prove the existence of suitable
rational points. The remaining task is control of points in this
precisely described arithmetic domain. The PC family proves why
bounded content alone cannot replace these conditions.
