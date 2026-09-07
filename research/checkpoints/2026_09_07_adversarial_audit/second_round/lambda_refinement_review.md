# Independent review of the remainder-proportion refinement

Reviewer: ChatGPT, adversarial-audit agent. Date: 2026-09-07.

Reviewed the full ordinary proof `2026_09_07_independent_route/lambda_refinement.md`,
LR1--LR5, and cross-checked the independent critical-bottleneck review. The
statements pass this ordinary mathematical review. No corresponding global
Lean proof or unconditional ABC theorem is asserted.

## Source boundary checked directly

Reopened the primary source, Bugeaud, *B prime*,
[arXiv:2209.00275v1](https://arxiv.org/html/2209.00275v1), on 2026-09-07.
The complex argument uses Theorem 1.1, equation (1.3), with its explicit
height-normalized coefficient parameter. It needs a nonzero logarithmic form
but does not impose multiplicative independence. The independent p-adic
branch uses Theorem 1.4: positive integer coefficients, multiplicative
independence, local units, and the squared logarithm of its displayed B-prime.
The dependent branch uses only the first, unconditional estimate in Theorem
1.3. No conclusion was selected from the subsequent disjunction.

## Full arithmetic class and exact heights

The hypotheses are actual factorizations

    z = u gamma^e v w^g, gamma=1+zeta, e in {0,1},
    Q=N(w)>=7, V=N(v)>=1, h=max(1,log V), lambda=h/g<=1.

Both v and w have only split support, with one orientation per conjugate
pair across their combined support. They may share prime factors. The
ramified factor is kept separately. This ensures actual primitivity of each
factor and coprimality of each factor ideal with its conjugate.

For a nonunit such factor x, the denominator ideal of x/bar(x) has norm N(x),
and both archimedean absolute values are one. The degree-two normalization
therefore gives height log N(x)/2, exactly. Cubing multiplies it by three;
N(x)>=7 removes the max-with-one ambiguity. Roots of unity have height zero.
Consequently, for

    eta=(w/bar(w))^3, xi=(-1)^e(v/bar(v))^3,

one has h*(eta)=3 log Q/2 and h<=h*(xi)<=3h/2. The latter includes unit v:
then xi is 1 or -1 and both h and h*(xi) equal one. This is a genuine
two-sided height comparison, not merely an upper estimate.

The unit disappears after cubing the conjugate ratio, while
gamma/bar(gamma)=zeta produces exactly (-1)^e. The actual cubic identity is

    R=xi eta^g=(z/bar(z))^3 != 1,
    R-1 = 3(zeta-bar(zeta))abc/bar(z)^3.

Primitivity gives gcd(M,abc)=1. Hence every p dividing abc is a local unit
prime for v,w and z. With valuations normalized by v_p(p)=1, the identity
gives v_p(R-1)=v_p(abc)+(3/2)v_p(3). At p=3 the ramified exponent must be
zero; when e=1 that prime cannot divide the boundary. Thus neither the
ramified class nor the small boundary primes are silently omitted.

## Complex coefficient and winding check

Take principal logarithms and choose k so that

    Lambda=g log eta - 2k log(-1) + log xi

has imaginary part in [-pi,pi]. Then |2k|<=g+2 and exp(Lambda)=R!=1.
In Theorem 1.1(1.3), xi is last, with coefficient one. Keeping the winding
term contributes h*(-1)=1 and

    B' <= max(3,1+(g+2)/h) <= 4/lambda,
    height product / log c <= (9/2)lambda.

This remains valid for xi=1, xi=-1, repeated logarithms, and dependent v,w;
the source has no independence requirement. On this imaginary interval,
|exp(Lambda)-1|>=2|Lambda|/pi. The exact cubic identity and
3c^2/4<=M<=c^2 then give the asserted boundary-height loss. Its additive
absolute constant is absorbed because lambda log c>=log 7/2.

## P-adic case split

In the independent case use alpha=eta, beta=xi^(-1) and positive
coefficients g,1. Both numbers lie in the fixed quadratic field and are
local units at every boundary prime. The exact height comparison yields
B'<=3/lambda and height product/log c<=(9/2)lambda. Theorem 1.4 therefore
gives the claimed absolute p^2 lambda log^2(4/lambda) loss.

In the dependent case, ideal valuations in a nontrivial relation force the
nonnegative exponent vectors to be proportional. Writing their primitive
integer direction as d gives f=s d and r=ell d, where s>=1 and ell>=0;
the zero residual vector is explicitly allowed. Bezout for the entries of d
proves ell is integral. Actual unique factorization gives

    w=unit*x^s, v=unit*x^ell,
    z=unit*gamma^e*x^H, H=sg+ell>=g.

This is an identity of actual factors, rather than only a relation of
conjugate ratios. The ramified exponent remains exactly e outside H.
The one-block estimate can be obtained directly from Theorem 1.3's first
inequality with n=2, algebraic numbers ((x/bar(x))^3,-1), and integer
coefficients (H,e). Their product is R!=1, even when e=0, and the source
allows a zero second coefficient. No independent-log hypothesis is needed.
After normalization it gives Cp^2 log(3+H)/H. Since this function decreases
with H and H>=g>=1/lambda, it is bounded by Cp^2 lambda log(4/lambda).
This proves the remaining branch, including unit v.

## Consequences and separation audit

LR3 follows from the exact boundary-height comparison; its balance statement
does not imply ABC quality above one half. The full small-prime estimate
retains every prime power and includes two and three. At the proposed cutoff
Y=lambda^(-1/6), the displayed normalized upper bound tends to zero.

LR4 uses an inherited prime p|Q_0 with boundary valuation at least
g_0 v_p(Q_0), while the first output height is at most
g_0(log Q_0+L_0+log 4). Thus the new estimate supplies a positive effective
floor for lambda_1, uniform for fixed root and bounded lambda_0. This really
strengthens the previous rho_1 floor: the old asymptotic window lambda_1->0
is now excluded in that specific class. It does not compare the effective
floor with the finite two-step gate threshold, nor bound it for moving roots.

For LR5, checked every displayed inequality with
g=r^2 ceil(log X) ceil(sqrt(log r)) and exponents g+i. The actual primitive
positive sector construction is valid, lambda tends to zero, and rho tends
to infinity. For an old partition with m<=r/2, its largest block gives
L_j>=gr log X/(2m^2), and 2^(m+1)>=m^2 supplies the stated uniform lower
bound. For m>r/2 the exponential factor (2 log 7)^(r/2) dominates the
polynomial denominator uniformly in X. The fixed-modulus prime availability
input is explicit. The theorem separates the displayed explicit penalties;
it does not claim optimality over every alternative shared representation.

## Remaining mathematical and formal gaps

These estimates do not bound the complementary signed large-prime product,
construct an unbounded family satisfying the two-step radical gate, or prove
ABC. The appropriate tail target is an upper bound, equivalently vanishing
normalized positive part, rather than a required two-sided signed limit.
The external logarithmic-form theorems, Weil heights, and combined remainder
theorem are still ordinary mathematics here. Existing elementary Lean modules
do not discharge those dependencies.

## Final moving-window TeX transcription check

Also re-read `2026_09_07_critical_bottleneck/paper/shifted_rank_windows.tex`.
The exact tower and finite-set mean proofs match the reviewed ordinary notes.
The height cap allows H_p=0 and retains every endpoint error. Keeping the
full denominator (log V+N log Q)/2 proves the uniform mean 10 pi(Z)/N.
The box counts and union factors 250 and 6250 are correct. The elementary
prime-counting proof gives pi(x)<=8x/log x on its stated x>=2 range. The
exceptional-index, finite-family, and prime-range limitations remain explicit.

## Final LR6 and completed TeX review

The later LR6 addition and the complete `paper/lambda_refinement.tex` were
independently read in full. For LR6, put g=2^(k^2), m=floor(g/k), and
y=42+84*2^m. For every k>=1, y is divisible by 3 and 7 and is two modulo
four. The primitive factor v=1+y*zeta consequently has norm V coprime to
21 and congruent to three modulo four. Its unramified support is oriented
and disjoint from the two primes over seven. Multiplication by (2+zeta)^g
therefore preserves primitivity. The nonempty oriented split support excludes
a sector boundary, so a unit rotation gives strictly positive coordinates.

Some prime factor of V has odd valuation. Together with the exact seven
valuation g, which is a power of two, this forces gcd one for the complete
split exponent vector. This argument does not require factoring V. The
uniform estimates y/2^m in [84,126] and V/y^2 in a fixed positive interval
give log V=2m log 2+O(1). Consequently

    lambda=2 log 2/k+O(1/g),
    rho ~ 2(log 2)^2 k.

The asymptotic separation, actual content-one property, and applicability
of the fixed-first-root second-lambda floor all follow with their stated
scope. This explicit family does not itself establish the all-disjoint-
partition comparison; the distinct LR5 family supplies that result.

Also checked the added moving-support formulas L18a--L18d. The inequalities
v_p(T_1)>=g_0 v_p(Q_0) and
t_1/g_0<=log Q_0+lambda_0+(log 4)/g_0 directly give both the individual
maximum J_0 and the full small-prime root-mass estimate. Its parenthesis
is uniformly bounded for bounded lambda_0. Substitution Y=lambda_1^(-1/6)
gives the asserted vanishing proportion. These conditions leave moving
large-prime support possible and do not assume a factorization of M_1.

The completed TeX faithfully transcribes LR1--LR6, including the direct
source-safe two-log proof of the dependent branch, the ramified/unit cases,
all old-partition sizes, and the moving-support conditions. One domain
clarification was requested during review and is now present: the full
small-prime-mass corollary explicitly assumes 0<lambda<=1, rather than
leaving that range implicit through its reference to the previous theorem.
The final ordinary and TeX statements pass this review.
