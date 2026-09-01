# An unbounded Frey-Legendre existence family with prescribed local level data

Author: ChatGPT. Date: 2026-08-30.

This note proves an unconditional existence theorem about a family of rational
elliptic curves. It does not construct an abc counterexample family, estimate
its abc quality from below by a fixed exponent greater than one, or claim
that every item of a published initial-theta construction has been checked.
The useful new point is that the specified local conditions and the numerical
level window occur at unbounded global height, within one fixed compactly
bounded domain in the original sense of Mochizuki.

There is a separate, explicit distinction between that original definition
and the literal topological wording in Joshi IV v2. This distinction is
necessary when applying a statement about a fixed finite exceptional set.

## 1. The precise existence statement

For every sufficiently large prime ell congruent to 43 modulo 60, choose the
least prime

    p = p(ell) congruent to -1 modulo 30*ell.

There is an effectively computable absolute constant C such that

    30*ell - 1 <= p <= C*(30*ell)^(26/5).                 (1.1)

Put

    M = 10*ell*p^2,          X = exp(ell^2/16).

Let r modulo M be the unique Chinese-remainder class satisfying

    r = 1 mod 2,       r = 1 mod 5*ell,       r = p mod p^2.  (1.2)

**Theorem 1.** For all sufficiently large such ell, the interval [X,2X]
contains at least X/(2M) integers A in the class r for which all three integers

    A,       A^2+1,       2*A^2+1                         (1.3)

are ell-power-free: no prime to the ell-th power divides any of them.
Every such A gives a positive primitive triple and rational curve

    a=A^2,   b=A^2+1,   c=2*A^2+1,
    D_A : y^2 = x(x-a)(x+b).                             (1.4)

They have the following properties.

1. D_A is rationally isomorphic to the Legendre curve with
   lambda_A = -1-A^(-2); no quadratic twist is introduced.
2. At p the curve is split multiplicative and its native Tate parameter
   q satisfies v_p(q)=4.
3. For L_A=Q(i,D_A[30]), the mod-ell image over both Q and L_A contains
   SL(2,F_ell). The curve has good reduction at ell.
4. Every nonzero integral Tate order over L_A is prime to ell.
5. The normalized Tate quantity is exactly

       Q_A = 2 log[A^2(A^2+1)(2*A^2+1)/2],              (1.5)

   and satisfies

       (3/4)*ell^2 < Q_A < ell^2.                       (1.6)

   In particular the specified ell satisfies both endpoints of the numerical
   window in Joshi IV v2, Theorem 5.7.1, with d_mod=1.
6. The parameters lambda_A belong to one fixed domain supported at
   {infinity,2} in Mochizuki's original compactly bounded sense. Their
   rational heights, and the heights of their j-invariants, tend to infinity
   as ell tends to infinity. Thus any *fixed* finite set of parameters or
   moduli points is eventually avoided.

The threshold in this theorem is effective in terms of the effective
constant C in (1.1). A numerical value for C, hence a numerical value of the
threshold, is not extracted here. Existence of A is given by an explicit
finite sieve with a proved positive lower bound, not a claim that a particular
large integer has already been factored.

## 2. Primary least-prime input and its uniformity

The primary input used in (1.1) is Xylouris's author manuscript,
[On Linnik's constant, arXiv:0906.2749v1](https://arxiv.org/pdf/0906.2749v1).
On PDF page 6 he defines P(q) as the maximum of the least primes over all
reduced classes modulo q. Theorem 1.1 on PDF page 9 proves
P(q) << q^5.2 with an effective absolute constant. Thus the constant is
independent of our growing modulus and of the class -1.

The later original journal version, Acta Arithmetica 150 (2011), 65--91,
[DOI 10.4064/aa150-1-4](https://doi.org/10.4064/aa150-1-4), Theorem 1.1,
printed page 66, improves the exponent to 5.18. Its
[publisher PDF](https://www.impan.pl/shop/en/publication/transaction/download/product/83078)
was opened and its theorem statement checked. We deliberately use the weaker
26/5 throughout, which is also supported by the locally archived author
manuscript. No claim about the optimal present Linnik exponent is needed.

These statements also supply infinitude of primes ell=43 mod 60, without an
additional distribution estimate. If this progression contained only the
finite primes ell_1,...,ell_s, apply the least-prime theorem to a reduced CRT
class equal to 43 mod 60 and to 1 mod each ell_i. The resulting prime is in
the required progression and differs from every ell_i, a contradiction.

The size bound for the sieve modulus is consequently uniform:

    M <= C_0*ell^(57/5),       C_0 = 10*C^2*30^(52/5).  (2.1)

The constants in the next section do not depend on ell, p, or the chosen
CRT representative. An effective enlargement of C handles any finite initial
range in the source theorem.

## 3. A finite, uniform power-free sieve in the CRT progression

We give all of the root counts and the large-prime error, since omission of
the latter would invalidate an existence proof in a growing modulus.

Let k>=5 be an integer, M>=1, X>=1, and suppose a CRT progression modulo M
already excludes k-th prime powers at the primes dividing M. For the three
polynomials

    f_0(T)=T,       f_1(T)=T^2+1,       f_2(T)=2*T^2+1,

assume 2 divides M. Let N_good count integers A in [X,2X] in this progression
such that each f_i(A) is k-power-free. Then

    N_good >= (X/M)*(1 - 5*sum_(q prime) q^(-k))
                    - 1 - 5*(9*X^2)^(1/k).           (3.1)

**Proof of (3.1).** There are at least X/M-1 integers in the progression
and interval. For a prime q not dividing M, q is odd. The equation T=0
mod q^k has one root. The other two polynomials have at most two roots
each modulo q. At every such root their derivatives 2T and 4T, respectively,
are nonzero modulo q. To see the lifting count directly, if x is a root
modulo q^h, its possible lifts are x+t*q^h. Modulo q^(h+1), their values
are f_i(x)+t*q^h*f_i'(x); the nonzero derivative gives exactly one admissible
t modulo q. Thus each quadratic has at most two roots modulo q^k.

Because gcd(q,M)=1, each of these at most five roots combines with the
fixed progression to give one residue class modulo M*q^k. Such a class
contributes at most X/(M*q^k)+1 integers to the interval. If q^k divides
one of the three positive values, then

    q^k <= max(2X,4X^2+1,8X^2+1) <= 9X^2.

Put Y=(9X^2)^(1/k). Summing only over q<=Y, the number of excluded integers
is at most

    5*(X/M)*sum_(q<=Y, q not dividing M) q^(-k) + 5*pi(Y)
      <= 5*(X/M)*sum_(q prime) q^(-k) + 5Y.

Subtract this union bound from X/M-1. No independence assumption, density
heuristic, or interchange with an infinite error sum is used. QED.

The remaining tail is elementary and uniform for k>=5:

    sum_(q prime) q^(-k)
      <= sum_(n>=2) n^(-k)
      <= 2^(-k) + 2^(1-k)/(k-1)
      <= (3/2)*2^(-k).

Consequently 5 times this sum is at most 15/64 < 1/4, and

    N_good >= (3/4)*(X/M) - 1 - 5Y.                   (3.2)

For the specific progression (1.2), all primes dividing M have indeed
already been checked, as follows.

| Fixed prime | A | A^2+1 | 2*A^2+1 |
| --- | --- | --- | --- |
| 2 | odd | valuation exactly 1, since A^2=1 mod 8 | odd |
| 5 | 1 mod 5 | 2 mod 5 | 3 mod 5 |
| ell | 1 mod ell | 2 mod ell | 3 mod ell |
| p | valuation exactly 1 from A=p mod p^2 | 1 mod p | 1 mod p |

These are distinct primes, since ell>=43 and p>=30ell-1. Thus no ell-th
prime power occurs at a prime dividing M.

With k=ell and X=exp(ell^2/16),

    Y = 9^(1/ell)*exp(ell/8).

The condition 1+5Y <= X/(4M) makes (3.2) at least X/(2M). By (2.1), a
sufficient, completely explicit condition in terms of C_0 is

    ell^2/16 - ell/8 - (57/5)*log ell >= log(184*C_0).  (3.3)

Indeed 1+5Y <= 46*exp(ell/8). The left side of (3.3) tends to infinity
and is strictly increasing for ell>=43, as its derivative
ell/8-1/8-57/(5ell) is positive there. Choosing the first sufficiently
large integer satisfying (3.3) gives an effective threshold valid for all
larger primes in the progression. This proves the existence part of
Theorem 1, with a lower bound uniform in every parameter allowed above.

The condition (1.3) does **not** say that A^2 itself is ell-power-free.
That stronger condition is unnecessary: if 0<v_q(A)<ell, then the odd
prime ell cannot divide 2*v_q(A) or 4*v_q(A). The exact distinction is used
in Section 6.

## 4. The rational Legendre model and reduction

Fix one of the good integers A. Pairwise coprimality of (a,b,c) in (1.4)
follows from consecutive integers and
2(A^2+1)-(2A^2+1)=1. The coordinate change

    x=A^2*X_1,         y=A^3*Y_1

gives

    Y_1^2=X_1(X_1-1)(X_1+1+A^(-2)).                  (4.1)

This is a Q-isomorphism. In particular it retains the torsion fields and
the reduction type, even at primes where the chosen coordinates are not
integral. For local reduction we use the original integral equation D_A.

The visible roots give full rational 2-torsion. Put

    S_A=a^2+a*b+b^2=3*A^4+3*A^2+1.

Direct Weierstrass invariant computations give

    Delta=16*(abc)^2,       c4=16*S_A,
    j=256*S_A^3/(abc)^2.                              (4.2)

One has gcd(S_A,abc)=1, since reducing S_A modulo a,b,c gives b^2,a^2,a^2,
respectively. At an odd prime q dividing abc, c4 is a unit, so the displayed
model is minimal and multiplicative, with

    -v_q(j)=v_q(Delta)=2*v_q(abc).                    (4.3)

Unit c4 also proves minimality directly: lowering an integral discriminant
by a nonunit change of scale would require c4 to be divisible by the fourth
power of that scale. Every odd prime not dividing abc is good.

All the odd multiplicative places are split. If q divides a or b, reduction
gives y^2=x^2(x+1), whose two tangent slopes are +1 and -1. If q divides c,
the node is at x=a; translation gives y^2=X_1^2(X_1+a), with tangent slopes
+A and -A, distinct and nonzero modulo q. At the chosen p,

    v_p(a)=2,       v_p(b)=v_p(c)=0,

so the native Tate parameter has v_p(q)=4. At ell, the three endpoints
are (1,2,3) modulo ell, giving good reduction.

The reduction criterion is [Silverman, *The Arithmetic of Elliptic Curves*,
second edition](https://www.pdmi.ras.ru/~lowdimma/BSD/Silverman-Arithmetic_of_EC.pdf),
VII.5.1, printed page 196. The split Tate interpretation and its Galois
description are also given in
[Kedlaya's author notes, Theorems 1--2 and Proposition 3](https://kskedlaya.org/18.727/tate-curve.pdf),
PDF pages 3--5. These are classical external inputs; no new formal axiom is
being postulated.

## 5. The mod-ell image and the level-30 base field

At 5, A=1 and the reduced curve is y^2=x(x-1)(x+2). Its points over F_5
are the three points with y=0 and x=0,1,3, and the point at infinity.
The other x-coordinates, 2 and 4, give the nonsquares 3 and 2.
Thus the Frobenius trace is 5+1-4=2 and the mod-ell Frobenius polynomial is

    T^2-2T+5.                                        (5.1)

Its discriminant is -16. Since ell=3 mod 4, this is a nonzero nonsquare
in F_ell, so Frobenius fixes no F_ell-line.

The split Tate curve at p has v_p(q)=4, not divisible by ell. Since p and
ell differ, the ell-th roots of unity are unramified locally. The extension
obtained by adjoining an ell-th root of q has ramification index ell.
Tate uniformization therefore supplies a nonidentity inertia transvection
T of order ell on D_A[ell]. If F is its fixed line and g is the Frobenius
element from (5.1), then gF differs from F. In the common basis supplied by
these two lines, T and gTg^(-1) are U(s) and L(t) with s,t nonzero.
Their powers generate both complete root groups over F_ell, hence SL(2,F_ell).

This group-theoretic proof is written in full in
`SL2_TRANSVECTION_GENERATION_2026_08_30.md`, Sections 1--3. Its actual
standard-matrix and coprime-index portions were independently formalized
in `SL2TransvectionGeneration20260830.lean`; the present arithmetic
representation is not claimed to be formalized by that module.

The extension L_A=Q(i,D_A[30]) is Galois and

    [L_A:Q] divides 2*|GL_2(Z/30Z)|
       = 2*6*48*480 = 276480 = 2^11*3^3*5.            (5.2)

This deliberately conservative bound suffices and is prime to ell.
The image over L_A is normal in the image over Q and its index divides
[L_A:Q]. The order-ell transvection T has trivial image in this quotient,
as its quotient order divides both ell and the prime-to-ell index.
Normality then retains gTg^(-1). The same root-group proof gives

    image(G_(L_A) on D_A[ell]) contains SL(2,F_ell).    (5.3)

For the Frobenius statement, the classical input is the good-reduction
Tate-module theorem, with trace determined by the finite point count;
Silverman V.2 and VII.4 give this description. The local transvection
calculation is Kedlaya, Proposition 3, cited above. No classification of
finite subgroups or unspecified large-image threshold is used.

## 6. Good reduction at 2 and every nonzero Tate order over L_A

Since A is odd, v_2(abc)=1 and S_A is odd. Thus v_2(j)=8-2=6.
The curve has potentially good reduction at 2. It has good reduction over
every completion of L_A at 2; here is a precise justification of the
torsion-field step.

By potential good reduction, the image of inertia on T_3(D_A) is finite.
After adjoining all 3-torsion, that finite image is contained in
1+3*M_2(Z_3), which has no nonidentity torsion. To verify the last claim,
write a nonidentity element as 1+3^h B, with h>=1 and B nonzero modulo 3.
Raising it to an integer prime to 3 preserves h. Cubing increases h by
exactly one, because

    (1+3^h B)^3
      = 1+3^(h+1)*(B+3^h B^2+3^(2h-1)B^3)

and the matrix in parentheses is B modulo 3. No finite positive power
can therefore be the identity. Inertia on T_3 is trivial over L_A, and
the Neron--Ogg--Shafarevich criterion gives good reduction.

The two classical inputs in this argument are Silverman VII.5.5 (integral
j iff potentially good reduction, printed page 197) and VII.7.1
(Neron--Ogg--Shafarevich, printed page 201). They were checked in the
archived book, PDF pages 213 and 217. This argument specifies why the
particular field L_A suffices, instead of choosing an unspecified further
semistable extension.

For an odd rational prime q dividing abc, write w for a place of L_A
above q and e_w for its ramification index. The integral Tate order is

    ord_w(q_w)=2*e_w*v_q(abc).                        (6.1)

If q divides A, this is 4*e_w*v_q(A), with 1<=v_q(A)<ell by (1.3).
If q divides either quadratic factor, it is twice e_w times an integer
strictly between zero and ell. Equation (5.2) implies ell does not divide
e_w. Since ell is odd, each value in (6.1) is prime to ell. There is no
Tate order at 2 or at ell, because reduction is good there.

This conclusion concerns the stated field L_A. It is not asserted over
L_A(D_A[ell]), whose ramification at p contains an additional factor ell.

Normalize the Tate degree by 1/[L_A:Q]. For each rational q, summing e_w*f_w
over w above q gives [L_A:Q]. Therefore (4.3), good reduction at 2, and
v_2(abc)=1 give exactly (1.5), rather than an unspecified bounded error.

## 7. Height, window, and the exact local level field

For A>1,

    A^6 < A^2(A^2+1)(2*A^2+1)/2 < 3*A^6.

As A is in [X,2X], this yields

    (3/4)*ell^2 < Q_A
      < (3/4)*ell^2 + 12*log 2 + 2*log 3
      < (3/4)*ell^2 + 16 < ell^2                      (7.1)

for ell>=43. Put delta=2^12*3^3*5=552960, the d_mod=1 constant in the
printed window. Then

    sqrt(Q_A) < ell
      < 10*delta*sqrt(Q_A)*log(2*delta*log(Q_A)).       (7.2)

For the second inequality it suffices that sqrt(Q_A)>ell/2 and that the
logarithm on the right exceeds one, both immediate from (7.1), ell>=43,
and delta>=1. This is a direct check for our selected ell; it does not
identify it with an unspecified existential choice in another theorem.

The exact local level field can also be determined without replacing the
Tate unit by one. Set N=30ell and e=15ell. Full rational 2-torsion makes
a chosen square root b_0 of the Tate parameter q rational over Q_p:
the Tate class of sqrt(q) is rational, and a Galois multiplier that is
both a sign and a power of q must be 1, by valuation. Thus v_p(b_0)=2.

Let K_0=Q_p(mu_N), choose pi with pi^e=b_0, and put E=K_0(pi).
Because p=-1 mod N, K_0 is unramified quadratic. Write u_0=b_0/p^2.
The correct uniformizer is

    beta=pi^((e+1)/2)/p,
    beta^e=p*u_0^((e+1)/2),          pi=u_0^(-1)*beta^2. (7.3)

The equation for beta is Eisenstein over K_0. Hence E/K_0 is totally
ramified of degree e, and

    [E:Q_p]=30ell,      e(E/Q_p)=15ell,      f(E/Q_p)=2.  (7.4)

Tate uniformization identifies Q_p(D_A[N]) with
Q_p(mu_N,q^(1/N))=E: fixing the two Tate torsion classes forces their
root-of-unity multipliers to be 1. Also K_0 contains i, so the completion
of Q(i,D_A[N]) at p is E. It is Galois: K_0/Q_p is cyclotomic,
and E is obtained by adjoining all roots of T^e-b_0, whose coefficients
are rational over Q_p, since K_0 contains mu_e.
The ramification is tame and

    15ell <= p-2,      gcd(15ell,p-1)=1.               (7.5)

These follow from p>=30ell-1 and p-1=-2 mod 15ell. Thus the small-tame
local range in the earlier local calculations really occurs throughout
this unbounded global family. Neither b_0=p^2 nor q=p^4 was assumed.

## 8. A fixed domain in the original sense, and finite exceptional sets

Take U=P^1 minus {0,1,infinity}. Define fixed local subsets

    K_infinity = {z in C : |z+1| <= 1/2},
    K_2 = {z in Qbar_2 : |z+2|_2 <= 1/8}.             (8.1)

They avoid all three cusps. The first is conjugation-stable and a compact
domain. The second is Galois-stable, and for every finite extension
K/Q_2 its intersection with K is precisely the compact open ball
-2+8*O_K; it is its own interior and closure within K. Thus (8.1)
satisfies Mochizuki's *original* definition of a compactly bounded domain
with support {infinity,2}; see Example 1.3(ii), PDF pages 5--6 of the
[February 2009 author version](https://www.kurims.kyoto-u.ac.jp/~motizuki/Arithmetic%20Elliptic%20Curves%20in%20General%20Position.pdf)
of *Arithmetic Elliptic Curves in General Position*, published in 2010.
Crucially the nonarchimedean requirement is compactness of the intersections
with each finite local extension, not compactness of K_2 in Qbar_2.

For A>=2, |lambda_A+1|=A^(-2)<=1/4. At 2, an odd square and its inverse
are both 1 mod 8, so lambda_A=-2 mod 8. Therefore every member of the
constructed family lies in the same domain (8.1), independent of ell and p.
On all of K_2 one has

    v_2(z)=1,    v_2(1-z)=0,    v_2(1-z+z^2)=0,

and the Legendre j-formula gives v_2(j(z))=6. In particular the fixed
2-adic j-bound required in (5.6.2) of Joshi IV holds numerically with
N_jinv=6. If a bounding set is expressed on the j-line instead, the fixed
domains |j|<=50000 at infinity and j in 2^6*O_Qbar_2 suffice. Indeed on
K_infinity, |z| is between 1/2 and 3/2 and |1-z|>=3/2, giving

    |j(z)| <= 256*(19/4)^3 / [(1/2)^2*(3/2)^2]
             = 438976/9 < 50000.

Every embedding of the rational parameters into a local algebraic closure
has the same value. The bounded-degree condition is fixed at degree one.

The exact rational height of the parameter is

    h(lambda_A)=log(A^2+1) -> infinity.               (8.2)

This uses gcd(A^2,A^2+1)=1. The j-invariant also has unbounded rational
height: since abc/2 is odd and gcd(S_A,abc)=1, (4.2) in reduced form is

    j=64*S_A^3/(abc/2)^2.

Its denominator has logarithm Q_A. Thus h(j)>=Q_A -> infinity, even
though its archimedean absolute value remains bounded. Each A gives a
distinct lambda_A; a finite set of j-values likewise cannot account for
the family because of this unbounded height.

It follows that for any finite F in U(Qbar), there is ell_F such that
every constructed lambda_A with ell>=ell_F lies outside F. The same is
true for any fixed finite set of moduli points. This is the appropriate
finite-exception conclusion: **F is fixed before ell and A vary**. A new
exceptional set depending on each member, or on a growing additional
domain, would not satisfy this quantifier.

## 9. The printed Joshi wording is a different, unclosed source interface

[Joshi IV v2](https://arxiv.org/pdf/2403.10430v2), PDF page 50, defines its
bounding domain as a nonempty compact subset of the product of the
X(Qbar_p), with the displayed valuation topology, and requires it to equal
the closure of its interior there. This is stronger than the finite-local-
extension condition just verified in Mochizuki's definition.

For U(Qbar_2) the literal ambient-topology requirement cannot hold. Here
is the elementary obstruction. Every nonempty open ball contains, after
translation and scaling, infinitely many algebraic 2-adic units whose
residues in Fbar_2 are distinct. Their pairwise distances are the same
positive constant. Hence the ball is not totally bounded and cannot be
contained in a compact subset. It follows that every compact subset of
U(Qbar_2) has empty ambient interior. A nonempty compact subset therefore
cannot be the closure of its ambient interior. A product domain with
such a nonarchimedean factor has the same obstruction.

Consequently (8.1) must not be reported as satisfying that literal
wording. It does satisfy the original Mochizuki definition. A repair by
using finite-extension sections or another explicitly declared topology
would be a change requiring its own source comparison. We do not silently
make it, and this observation is not a disproof of Mochizuki's original
IUT statements or of abc.

There is also a quantifier distinction on PDF page 53, Theorem 5.7.1:
its finite exceptional set depends on a fixed domain and a degree bound,
and its conclusion supplies *some* level prime in a window. The height
argument in Section 8 eventually avoids any such fixed finite set; it
does not itself prove that the existentially selected level is our
specified ell. Equations (5.3), (6.1), and (7.2) directly verify the listed
arithmetic properties for our ell, but they are not a replacement for all
other definitions of initial data, global markings, or the possible-image
source. Those remaining source interfaces are left explicit.

## 10. Source verification and files

New locally archived primary sources are in
`research/sources/frey_powerfree_family_2026_08_30/`:

* `Xylouris_2009_0906_2749v1_author_preprint.pdf`, 822404 bytes,
  SHA256 `f9505f1dba1d4f3eca2b69f5f25e2395054fde875848a1c9026f10a53a99844c`.
  PDF pages 6 and 9 were extracted, rendered, and visually checked.
* `Mochizuki_2010_Arithmetic_Elliptic_Curves_General_Position_author.pdf`,
  February 2009 author version, 262332 bytes,
  SHA256 `b9dc115af61dca7fe434332ebafddf6a376a9e2926dad4e1ea2dcc0d2441f768`.
  PDF pages 5 and 6 were extracted, rendered, and visually checked.

The 2011 Xylouris publisher PDF was accessible to the web reader, but
direct archival downloads returned HTTP 502. No local file is falsely
presented as that journal version. The locally archived 2009 theorem is
sufficient for every estimate in this note.

Previously archived originals used here:

* `research/sources/iut_2026_08_30/Joshi_IV_2403.10430v2.pdf`,
  arXiv version dated 2025-02-24; pages 49--53 extracted, pages 50 and 53
  rendered and visually checked for the definition and quantifiers.
* `research/sources/galois_lift_2026_08_30/Kedlaya_2004_Tate_Curve.pdf`,
  author notes, Theorems 1--2 and Proposition 3.
* `research/sources/global_uniform_gate_2026_08_30/Silverman_2009_Arithmetic_of_Elliptic_Curves_2nd.pdf`,
  the reduction and good-reduction criteria specifically located above.

Source inspection images were placed only in
`tmp/pdfs/frey_powerfree_sources_2026_08_30/`. No Lean module was added for
this task, and the preceding twelve-theorem SL2 module, existing TeX,
PDFs, aggregate imports, and shared manifests were not changed.
