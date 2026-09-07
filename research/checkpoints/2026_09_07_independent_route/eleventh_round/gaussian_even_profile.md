# GE1--GE4. A second quadratic domain for an even first exponent

Status: complete ordinary proof; root, critical_bottleneck, and
adversarial_audit independently reviewed GE1--GE4 and passed. This note is
separate from the frozen IL/CI proofs. It does not solve the odd second
exponent branch. No general result about powers of the twelfth cyclotomic
polynomial is assumed.

Let a,b be positive coprime integers and put

    c=a+b, A=ab, M=a^2+ab+b^2=c^2-A,
    F=a^4+3a^3b+5a^2b^2+3ab^3+b^4.

The basic primitive identities give gcd(A,c)=gcd(A,M)=gcd(M,c)=1.
In particular gcd(F,AMc)=1, since

    F=M^2+A c^2=A^2+M c^2.                         (GE1)

The integer F is odd, prime to 3, and at least 13. Every prime divisor of
F is 1 modulo 3: if q divides F, then q does not divide A and
(M/A)^2+(M/A)+1=0 in F_q. As q is not 3, M/A has exact order 3.

## GE1. A quadratic-character condition for all even first exponents

Suppose M=D U^2 for positive integers D,U; D need not be squarefree.
Then

    F=A^2+D(Uc)^2,      gcd(A,Uc)=1.                 (GE2)

For every prime q dividing F, q does not divide D U c and

    (-D/q)=1,                                       (GE3)

where the symbol is the Legendre symbol. Indeed (A/(Uc))^2=-D modulo q.
The denominator and numerator are nonzero by the primitive identities.

In particular, an actual first profile

    M=3^e V0 R^h,  e in {0,1}, h even,

has D=3^e V0 and U=R^(h/2). Since (-3/q)=1 for q|F,

    e=0: (-V0/q)=1;       e=1: (V0/q)=1.            (GE4)

These statements apply to every q dividing any second root Q in a
numerical profile F=V1 Q^g. They require neither common first and second
exponents nor that either residual be power-free. The first residual
determines a quadratic splitting condition on the whole second support.
The field discriminant divides 4D; thus the logarithm of its absolute
value is at most
log(12)+log(V0). This bound alone supplies no uniform prime-distribution
estimate as V0 varies.

## GE2. An actual Gaussian profile in the unramified square branch

Assume M=U^2 for a positive integer U. Define the Gaussian integer

    zG=A+i Uc.

It is primitive, its norm is F, and it is unramified at 2. The first
statement follows from gcd(A,Uc)=1 and the latter from F odd. Consequently
every prime q|F is 1 modulo 4, and hence

    q=1 mod 12.                                    (GE5)

If F=V1 Q^g for positive integers V1,Q and integer g>=2, with Q>1, there
are Gaussian integers vG,wG and a unit uG in {1,-1,i,-i} such that

    zG=uG vG wG^g,    N(vG)=V1,    N(wG)=Q.         (GE6)

Both vG and wG are primitive and have no factor over 2. Their supports
may overlap; neither contains a pair of conjugate Gaussian primes. No
power-free hypothesis on V1 is needed.

Proof. The Euclidean norm makes Z[i] a UFD: a nearest Gaussian integer
to a complex quotient leaves remainder norm at most half the divisor
norm. For every rational q|F, the factors pi and bar(pi) cannot both
divide zG, as that would make q divide both its coordinates. The Gaussian
prime above 2 is absent. An inert prime also cannot divide the primitive
zG, so every q splits. For its uniquely occurring orientation pi_q, the
exponent is exactly v_q(F)=v_q(V1)+g v_q(Q). Assign the two nonnegative
parts to vG and wG. Equality holds up to a Gaussian unit, proving (GE6).

For V1=1 this is the exact pure power zG=uG wG^g. The unit is retained
for every g; it can be absorbed into wG when g is odd, since raising to g
permutes the four Gaussian units. The norm support in (GE5) is stronger
than the general second-norm congruence 1 modulo 3.

The actual second Eisenstein element also exists simultaneously:

    zE=A+U^2 zeta=uE vE wE^g,
    N(vE)=V1,  N(wE)=Q.                            (GE7)

This is the previously proved DC oriented decomposition, applied to the
same actual seed. These two powers share the rational coordinate A, and
their other coordinates satisfy

    (Uc)^2=U^2(A+U^2).                             (GE8)

Thus (GE6) and (GE7) are actual powers in two different quadratic UFDs,
with the same root norm and residual norm. Arbitrary independently
chosen Gaussian and Eisenstein powers need not satisfy (GE8) or have
equal rational coordinates.

For the associated Gaussian Kummer ratio, set

    etaG=(uG^2 vG/bar(vG))^(-1).

Then (wG/bar(wG))^g=etaG*zG/bar(zG), and the absolute logarithmic Weil
height is exactly h(etaG)=log(V1)/2. Indeed conjugate prime cancellation
is absent and the unique complex absolute value of vG/bar(vG) is one;
the denominator ideal has norm V1. Roots of unity and inversion do not
change height. This supplies an actual small coefficient when the
residual is small, but supplies no point-height upper bound.

## GE3. A twelfth-cyclotomic equation with its full inverse condition

When M=U^2 for a positive integer U, the same integers satisfy

    F=U^4-U^2 c^2+c^4=Phi_12(U,c),
    d^2=4U^2-3c^2,    d=a-b,    |d|<c,             (GE9)
    gcd(U,c)=1,        sqrt(3)/2 < U/c < 1.

The left interval is strict because equality forces a=b, hence the
primitive seed (1,1), whose first norm 3 is not a square. The right
interval follows from A>0. Formula (GE9) follows from A=c^2-U^2 and
d^2=c^2-4A. In particular F=V1 Q^g becomes a homogeneous cyclotomic power
equation with an additional square constraint; the latter is essential
for reconstructing a seed.

Conversely, let U,c be positive integers with gcd(U,c)=1 and U<c, and
let d be an integer satisfying d^2=4U^2-3c^2 and |d|<c. Then d and c have
the same parity, since d^2=c^2 modulo 4. The integers

    a=(c+d)/2,    b=(c-d)/2                         (GE10)

are positive, coprime, and have M=U^2. To verify coprimality, an odd
prime dividing both a,b would divide c,d and then 4U^2, contradicting
gcd(U,c)=1. Direct substitution already gives a^2+ab+b^2=U^2.
If 2 divides both a,b, then 4 divides U^2, so U is even; c is also
even, again a contradiction. Substitution gives ab=c^2-U^2 and hence
(GE9) for F. This is an exact integer inverse, not a
claim about arbitrary rational points of y^g=Phi_12(x,1).

For a requested even exponent h, one must additionally impose U=R^(h/2)
with integer R>1. The inverse above gives the first exponent 2 without
silently imposing larger even exponents. The branch M=3U^2 instead gives

    F=9U^4-3U^2 c^2+c^4;

it has not been replaced by the same integral Phi_12 equation.

## GE4. What this leaves to prove

Together with CI, (GE2)--(GE10) apply to every finite positive rational
point on the pure-coefficient RD curves whose reconstructed first norm
is an unramified even power. They do not claim that the odd second
exponent locus is empty or infinite. Even/even emptiness is already
proved by CI2, and is not a new conclusion of this note.

One precise remaining problem is to control Gaussian powers (GE6) for
which the same seed simultaneously yields (GE7) and the integer square
gate (GE9). For the pure second branch, the earlier modular support
theorem at prime exponent p>7 additionally gives

    q >= (sqrt(2p)-1)^2 > p   for every prime q|Q,

now intersected with q=1 modulo 12. That intersection is a necessary
support condition, not an upper bound on the large-prime tail and not a
contradiction. Both the ramified first branch and moving nonunit
residuals remain active.

Repository search on this date found no previous actual Gaussian
decomposition (GE6); uses of the word Gaussian in the IUT-source material
concern a different monoid construction. The norm identity itself is
elementary and no general novelty claim is made. Searches for a general
Phi_12 perfect-power theorem did not produce a primary theorem with
checked matching premises, so none is invoked here.
