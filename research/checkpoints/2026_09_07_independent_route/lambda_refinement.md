# A remainder-proportion refinement for both places

Author: ChatGPT. Date: 2026-09-07.

Status: new ordinary proofs, submitted for independent review. No theorem in
this note asserts ABC or the existence of an unbounded family satisfying the
two-step radical gate. The previously reviewed rho-based notes remain intact.

## 1. Actual oriented representations and the source estimates

Let a,b be coprime positive integers, c=a+b, T=abc, t=log c, and
M=a^2+ab+b^2. Work in O=Z[zeta], zeta^2-zeta+1=0. Put gamma=1+zeta.
Consider an actual factorization

    z=a+b*zeta = u*gamma^e*v*w^g,
    e in {0,1}, g>=1, Q=N(w)>=7, V=N(v)>=1,                  (L1)

where u is a unit and v,w involve only split prime elements, with at most
one of each conjugate pair appearing anywhere in their combined support.
They may share prime factors. In particular, neither v nor w contains the
ramified prime gamma. Write

    h=max(1,log V), lambda=h/g, rho=lambda*log(4+g).

We always have gcd(M,T)=1 and

    3c^2/4 <= M <= c^2,  M=3^e*V*Q^g,  2t>=g*log Q.       (L2)

The restriction Q>=7 omits only the already isolated split-free triple.

Two precise established estimates are used. In Bugeaud, *B prime*,
arXiv:2209.00275v1, Theorem 1.1, equation (1.3), a nonzero complex logarithmic
form with last coefficient b_n nonzero has a lower bound with height product
times log B', where

    B'=max(3,max_{j<n} (|b_n|/h*(alpha_j)+|b_j|/h*(alpha_n))).

Here h*(alpha)=max(1,h_Weil(alpha)), and for fixed n and field degree the
constant is effective and absolute. Multiplicative independence is not needed.
Theorem 1.4 gives, for multiplicatively independent p-units alpha,beta and
positive integers k,l,

    v_p(alpha^k-beta^l)
      <= C*p^D*h*(alpha)*h*(beta)*(log B')^2,
    B'=max(3,k/h*(beta)+l/h*(alpha)),                       (L3)

where valuations extend v_p(p)=1 and D=[Q(alpha,beta):Q]. The constant is
absolute and effective. We use this unconditional two-logarithm theorem;
we do not select one conclusion from the disjunction in Theorem 1.3.
Primary source, checked 2026-09-07:
https://arxiv.org/html/2209.00275v1 (Theorems 1.1 and 1.4).

The already proved one-block estimate will also be used in its precise form:
for an actual z=u*gamma^e*x^H with x composed of oriented split primes,

    v_p(T) <= C_0*p^2*log N(x)*log(3+H),  p|T.             (L4)

The ramified exponent e is kept outside the split exponent H. This estimate
is the m=1 case of the repository exponent-profile theorem, proved with the
first inequality of Bugeaud Theorem 1.3 and the unit/ramified sign below.
More explicitly, put alpha_x=(x/bar(x))^3 and use n=2, the algebraic
numbers (alpha_x,-1), and the integer coefficients (H,e). Their product is
(z/bar(z))^3!=1. Theorem 1.3's first inequality needs no independence and
allows the second coefficient to be zero. Its height product is
(3/2)log N(x), its field degree is at most two, and
max(3,H)<=3+H. The boundary identity (L8) then proves (L4) directly.

## 2. Exact heights and the boundary identity

**Lemma LR1.** For any split oriented nonunit x of norm q,

    h_Weil(x/bar(x)) = (log q)/2,
    h*((x/bar(x))^3) = (3/2)*log q.                        (L5)

The ideals (x) and (bar(x)) are coprime. Both complex embeddings of
x/bar(x) have absolute value one. Its denominator ideal is (bar(x)), of
norm q. The defining normalized height formula over a degree-two field
therefore gives (log q)/2; heights multiply by three under cubing. Since
q>=7, taking max with one does not change the cubed height. Multiplication
by any root of unity leaves the Weil height unchanged.

Set

    eta=(w/bar(w))^3, xi=(-1)^e*(v/bar(v))^3,
    R=xi*eta^g=(z/bar(z))^3.

Indeed u/bar(u)=u^2 and u^6=1, while gamma/bar(gamma)=zeta and zeta^3=-1.
Consequently

    h*(eta)=(3/2)*log Q,   h <= h*(xi) <= (3/2)*h.         (L6)

When v is a unit, xi=(-1)^e and both h and h*(xi) are one; otherwise
h=log V and h*(xi)=(3/2)h. No ramified factor is included in V.

Direct expansion gives

    z^3-bar(z)^3 = 3*(zeta-bar(zeta))*T,
    |R-1|=3*sqrt(3)*T/M^(3/2).                            (L7)

In particular R!=1. For every p|T, all factors of v,w are p-units, and
at every place over p, the normalized valuation satisfies

    v_p(R-1)=v_p(T)+(3/2)*v_p(3) >= v_p(T).               (L8)

The same formula covers p=3 when e=0. If e=1, gcd(M,T)=1 excludes p=3
from the boundary. This is why the ramified sign causes no missing branch.

## 3. The refined two-place theorem

**Theorem LR2.** There exist absolute effective constants A_1,A_2 such that
every actual representation (L1) with 0<lambda<=1 satisfies

    3t-log T <= A_1*lambda*log(4/lambda)*t,                (L9)
    v_p(T) <= A_2*p^2*lambda*log^2(4/lambda)*t, p|T.       (L10)

The constants are independent of the supports, norms, number of split primes,
unit, ramified exponent, and multiplicative dependence between v and w.

**Archimedean proof, including unit v.** Take principal logarithms of eta
and xi. Choose an integer k such that

    Lambda=g*log eta-2k*log(-1)+log xi

has imaginary part in [-pi,pi]. Then |2k|<=g+2. Its exponential is R!=1,
so Lambda is nonzero. Apply Theorem 1.1 (1.3) with these three logarithms,
putting xi last with coefficient one. The degree is at most two, even if
xi=1 or -1; all three algebraic numbers are nonzero. By (L6),

    B' <= max(3,1+(g+2)/h) <= 4/lambda,
    h*(eta)*h*(-1)*h*(xi) <= (9/4)*h*log Q.               (L11)

The last upper bound for B' uses h>=1, g>=h, and
1+(g+2)/h <= (h+g+2)/h <=4g/h. Thus

    log|Lambda| >= -C*h*log Q*log(4/lambda).

For an imaginary Lambda of absolute value at most pi,
|exp(Lambda)-1|>=2|Lambda|/pi. Combining this with (L7) and
M>=3c^2/4 gives

    3t-log T <= C*h*log Q*log(4/lambda)+C'.

Here C' is an absolute constant. Since 2t>=g log Q and
lambda*t>=h log Q/2>=log 7/2, both terms are absorbed into (L9).
There is no independence hypothesis in this argument.

**Non-Archimedean proof: independent case.** Put alpha=eta and
beta=xi^(-1)=(-1)^e*(bar(v)/v)^3. If alpha,beta are multiplicatively
independent, v is a nonunit. They are p-units for p|T, both lie in the
fixed quadratic field, and alpha^g-beta differs from R-1 by the p-unit
xi. The positive coefficients g,1 meet all hypotheses of (L3). By (L6),

    B' <= max(3,g/h+1) <= 3/lambda,
    h*(alpha)*h*(beta)/t <= (9/2)*lambda.                 (L12)

Use (L8) and (L3) to obtain (L10), after enlarging A_2.

**Non-Archimedean proof: dependent case, including unit v.** Fix oriented
prime elements pi_i on the union of the two supports, and write the exponent
vectors of w and v as (f_i) and (r_i). Here f is a nonzero nonnegative integer
vector and r is nonnegative. A multiplicative relation alpha^m beta^n=1
implies, by taking the pi_i ideal valuations,

    m*f_i = n*r_i  for every i.                          (L13)

If r=0, let d=f/gcd(f_i), s=gcd(f_i), and ell=0. Otherwise a nontrivial
relation forces m,n nonzero with the same sign and forces proportionality.
Writing d for the primitive nonnegative integer direction of f, there are
integers s>=1 and ell>=1 such that f=s*d and r=ell*d. The integrality of ell
follows from gcd(d_i)=1 (or Bezout). Take x=product pi_i^d_i. Unique
factorization shows that, for suitable units,

    w=unit*x^s, v=unit*x^ell,
    z=unit*gamma^e*x^H, H=s*g+ell >= g.                  (L14)

All ramification remains in gamma^e; H is a split exponent, not the gcd of
every exponent in M when e=1. Also N(x)>=7 and 2t>=H log N(x). Apply (L4):

    v_p(T)/t <= 2*C_0*p^2*log(3+H)/H.

The function log(3+x)/x is decreasing for x>0. Since
H>=g>=1/lambda, this is at most

    2*C_0*p^2*lambda*log(3+1/lambda)
      <= 2*C_0*p^2*lambda*log(4/lambda).

For lambda<=1, log(4/lambda)>1, so this is bounded by (L10). The dependent
and independent cases exhaust all representations, proving the theorem.

## 4. Positive consequences and an unresolved tail

**Corollary LR3.** For every fixed delta>0 there is an effective lambda_delta>0
such that any (L1) with lambda<=lambda_delta has

    min(a,b) > c^(1-delta).

If min(a,b)<=c^(1-delta), then T<=c^(3-delta) and 3t-log T>=delta*t,
contradicting (L9) once A_1 lambda log(4/lambda)<delta. This is an
unconditional balance conclusion; it is not a lower bound q>1/2 on ABC quality.

For every actual (L1) with 0<lambda<=1 and Y>=2, (L10) also gives the
full small-prime boundary mass bound

    sum_{p<=Y,p|T} v_p(T)*log p
      <= A_2*lambda*log^2(4/lambda)*Y^3*log Y*t.          (L15)

Indeed sum over primes is at most the sum over at most floor(Y) integers,
each contributing at most Y^2 log Y. If lambda<=1/64 and
Y=lambda^(-1/6), the ratio of this mass to t is at most

    (A_2/6)*sqrt(lambda)*log^2(4/lambda)*log(1/lambda),

which tends to zero as lambda tends to zero. Thus the small-prime cutoff
tends to infinity uniformly even when rho=lambda log(4+g) does not tend
to zero. The complementary large-prime multiplicity excess remains unproved;
neither (L9) nor (L15) alone yields ABC or whole second-norm compression.

## 5. A second remainder floor for fixed first roots

**Corollary LR4.** Fix a nonunit oriented w_0 with Q_0=N(w_0). Consider first
representations (L1) with this w_0 and lambda_0<=L_0 for a fixed finite L_0.
Every actual two-column representation of the first mixed output

    (a_1,b_1,c_1)=(ab,M_0,c^2)

has its parameter lambda_1 bounded below by a positive effective constant
depending only on w_0 and L_0. This lower bound is uniform in g_0, v_0,
their supports, units, and all choices of the second representation.

Choose p|Q_0 and let d=v_p(Q_0)>0. Set T_1=a_1*b_1*c_1 and t_1=log c_1.
The exact inherited support gives v_p(T_1)>=g_0*d. Also (L2) gives

    t_1 <= log M_0+log(4/3)
        <= g_0*log Q_0 + log V_0 + log 4,

so

    v_p(T_1)/t_1 >= d/(log Q_0+L_0+log 4) = delta_0>0.   (L16)

If lambda_1<=1, Theorem LR2 gives

    delta_0 <= A_2*p^2*lambda_1*log^2(4/lambda_1).         (L17)

The right side tends to zero as lambda_1 tends to zero. Choose an effective
eta>0 so it is less than delta_0 throughout (0,eta); then lambda_1>=min(1,eta).
This also covers lambda_1>1 trivially. The actual second norm satisfies
M_1=1 mod 3, but LR2 does not require this specialization.

This strengthens the earlier fixed-root rho_1 floor to a lambda_1 floor,
closing the previously open asymptotic remainder window for bounded first
lambda and fixed w_0. The proof does not compare its effective floor to the
specific finite NT4 threshold 1/(5K), so it does not retire that finite gate.
Nor does it give a uniform floor when Q_0 and its prime divisors move without
bound. Both branches remain active.

For moving first roots there is nonetheless an exact necessary obstruction.
For each individual first representation define

    J_0=max_{p|Q_0}
      v_p(Q_0)/[p^2*(log Q_0+lambda_0+log 4/g_0)].         (L18a)

The same proof, without replacing lambda_0 or g_0 by uniform bounds, gives

    lambda_1*log^2(4/lambda_1) >= J_0/A_2
    whenever lambda_1<=1.                                (L18b)

Thus lambda_1 tending to zero requires J_0 tending to zero. Moving norms
whose fixed small prime retains a positive share of
log Q_0+lambda_0+log 4/g_0 still cannot enter that asymptotic regime.
This obstruction is computed from the first representation alone, with no
assumption about the radical or factorization depth of the second norm.

There is also a necessary escape of the complete small-prime part of the
first root, stronger than testing a single fixed prime. For Y>=2 define

    S_Y(Q_0)=sum_{p<=Y,p|Q_0} v_p(Q_0)*log p.

Using v_p(T_1)>=g_0*v_p(Q_0) in (L10), multiplying by log p and summing,

    S_Y(Q_0)/log Q_0
      <= A_2*lambda_1*log^2(4/lambda_1)*Y^3*log Y
         *[1+(lambda_0+log 4/g_0)/log Q_0].              (L18c)

If lambda_0<=L_0, the bracket is at most
1+(L_0+log 4)/log 7. Consequently lambda_1 tending to zero forces

    S_{lambda_1^(-1/6)}(Q_0)/log Q_0 -> 0.                (L18d)

This is a necessary condition on a growing interval of primes for any such
two-step compatibility family. It permits first roots supported on sufficiently
large moving primes, and therefore does not exclude that route.

## 6. A strict separation family beyond the older rho criterion

**Theorem LR5.** There are actual primitive positive triples and two-column
representations with lambda tending to zero but rho tending to infinity,
while every old disjoint-partition penalty is at least kappa*log M for an
absolute kappa>0. Consequently LR2 gives sublinear two-place bounds on a
family beyond both this displayed older rho criterion and the entire old
disjoint-partition penalty family. This compares explicit bounds, not their
optimal possible values or all mathematical methods.

Choose r>=3 distinct split primes q_i=1 mod 3 in [X,2X], X>=7, and put

    L=log X, j=ceil(sqrt(log r)),
    g=r^2*ceil(L)*j, e_i=g+i,
    z=product_{i=1}^r pi_i^e_i,
    w=product pi_i, v=product pi_i^i.                     (L18)

Rotate z by a unit to the positive sixty-degree sector. Its coordinates
are primitive because its prime support contains no conjugate pair. It is
not on a sector boundary: otherwise it would be a unit times a rational
integer, whose nonunit factorization includes conjugate pairs. Thus a,b>0.
Rotation changes only u in (L1). Consecutive e_i give split exponent gcd one.

Since L<=log q_i<=2L and r>=3, both ceil(L)<=2L and
sqrt(log r)<=j<=2sqrt(log r) hold. For h=log V, one has

    r*(r+1)*L/2 <= h <= r*(r+1)*L <= 2*r^2*L,
    r^2*L*sqrt(log r) <= g <= 4*r^2*L*sqrt(log r).

Consequently

    1/(8*sqrt(log r)) <= lambda <= 2/sqrt(log r),
    rho >= (1/4)*sqrt(log r) -> infinity.                (L19)

The last line uses log(4+g)>=2 log r. These bounds are uniform in L>=log 7.
Both lambda log(4/lambda) and lambda log^2(4/lambda) tend to zero. Thus LR2
and LR3 give actual balance and vanishing normalized small-prime mass.

For completeness, write S=log M and let P be any old disjoint partition
of the r prime factors into m blocks. Its explicit penalty is

    B_P=C^(m+1)*log(3+sum k_j)*product L_j,

where C>2 is the old absolute constant, k_j is the gcd of the exponents
in its block and L_j is the logarithmic norm after dividing by k_j.
The following bounds hold:

    g*r*L <= S <=4*g*r*L <=16*r^3*L^2*sqrt(log r),
    L_j>=L.                                              (L20)

If a block has size h_j>=2, its index range yields
k_j<= (r-1)/(h_j-1), hence

    L_j >= g*h_j*(h_j-1)*L/r.                            (L21)

If m<=r/2, a largest block has size at least r/m>=2, so
its L_j is at least g*r*L/(2m^2). Using L for all other blocks and the
first upper bound in (L20) gives

    B_P/S >= C^(m+1)*log 4*L^(m-1)/(8m^2) >= log 4/8.    (L22)

For the last inequality use L>1 and 2^(m+1)>=m^2 for all m>=1.
If m>r/2, the last bound in (L20) gives

    B_P/S >= C^(m+1)*log 4*L^(m-2)/(16*r^3*sqrt(log r)).   (L23)

For sufficiently large r the right side is bounded below by

    [log 4/(8*(log 7)^2)]
       *(2*log 7)^(r/2)/(r^3*sqrt(log r)),

which tends to infinity, independently of X and the selected split primes.
Therefore all partitions satisfy (L22) for sufficiently large r. The
fixed-modulus prime number theorem supplies dyadic lists with r tending to
infinity, exactly as in the independently reviewed shared-generator
separation theorem; it supplies only prime availability. One checked primary
source is Bennett--Martin--O'Bryant--Rechnitzer, arXiv:1802.00085v3,
https://arxiv.org/pdf/1802.00085v3, Theorem 1.2.

The conclusion is a separation from the displayed old rho sufficient test,
not an assertion that every conceivable shared representation has large rho.
No high-quality or small-radical assertion is made for these triples.

## 7. An explicit fixed-root separation family without factorization

**Theorem LR6.** For integers k>=1 define

    g_k=2^(k^2), m_k=floor(g_k/k),
    y_k=42+84*2^m_k, v_k=1+y_k*zeta, w=2+zeta,
    z_k=v_k*w^g_k.                                      (L24)

These are actual primitive elements which rotate to positive triples. Their
split exponent content is one, while for this specified representation

    lambda_k ~ 2*log(2)/k -> 0,
    rho_k ~ 2*(log 2)^2*k -> infinity.                   (L25)

Here no prime list, primality hypothesis, or complete factorization of the
growing norm is needed to define the family or prove the assertions.

Indeed v_k has coordinates 1,y_k and is primitive. Since y_k is divisible
by 3 and 7, its norm V_k=1+y_k+y_k^2 is coprime to 21. Hence it contains
no ramified factor and none of the prime factors over 7. Its split support
is internally oriented by primitivity and is disjoint from the support of
w and bar(w). The product z_k is therefore primitive and oriented, and
it rotates to strictly positive coordinates as in LR5.

Moreover y_k=2 mod 4, so V_k=3 mod 4. An odd positive integer congruent
to three modulo four has at least one prime factor with odd valuation.
The exponent of the prime seven in N(z_k) is exactly g_k, a power of two.
The indicated odd valuation is at another prime. Thus the gcd of all
split prime exponents of N(z_k) is one. This is an exact congruence proof,
not an inference from a partial factorization.

Finally

    log V_k=2*m_k*log 2+O(1), m_k=g_k/k+O(1).

The O(1) is absolute because y_k/2^m_k=84+42/2^m_k lies in a fixed positive
interval and V_k/y_k^2=1+1/y_k+1/y_k^2 does also. Division by g_k gives
lambda_k=2 log 2/k+O(1/g_k); multiplication by
log(4+g_k)=k^2 log 2+o(1) gives (L25). LR2 and LR3 apply eventually.

LR6 separates the specified old rho test from the new lambda test by a fully
explicit formula. LR5 supplies the additional all-disjoint-partitions penalty
separation. Neither theorem asserts that all alternate shared representations
have large rho, or that these triples have ABC quality exceeding one half.
Since w is fixed in LR6 and lambda_k is bounded, LR4 also proves a positive
floor for every second representation's lambda_1 on this particular family.

## 8. Dependencies, review, and formalization scope

LR1 uses the standard ideal formula for the absolute Weil height and actual
primitive oriented factorization. LR2 uses LR1, the elementary cubic boundary
identity, Bugeaud Theorem 1.1 (1.3), Theorem 1.4, and the existing one-block
estimate derived from the first inequality of Theorem 1.3. LR3--LR5 then
follow by explicit inequalities, actual exponent constructions, and the
identified prime availability input.

Critical_bottleneck independently read LR1--LR5 in full and approved their
ordinary proofs on 2026-09-07, then separately approved the direct proof
of (L4), moving invariants (L18a)--(L18d), and added LR6. Parent root also
independently reviewed LR1--LR5. Adversarial_audit independently approved
LR1--LR6, the moving-support formulas, and the completed TeX transcription.
Its sole requested scope clarification was to restate 0<lambda<=1 explicitly
in the small-prime corollary; that clarification is now included in both
this note and the TeX. The final ordinary proof review status is passed.
These are ordinary mathematical proofs. The transcendence estimates, heights,
and this combined theorem have not been formalized in Lean in this note.
Existing verified elementary and radical-transport Lean cores do not close
those formal dependencies or the missing large-prime tail.
