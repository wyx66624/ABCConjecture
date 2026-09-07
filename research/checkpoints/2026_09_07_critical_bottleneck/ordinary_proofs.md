# Shared exponent generators: a positive extension of the norm-profile route

Author: ChatGPT. Research date: 2026-09-07.

Status: ordinary mathematical proofs using the two established logarithmic-form
inputs already used in the exponent-profile checkpoint. These are restricted
results, not a proof or disproof of ABC. The algebraic compression core is suitable
for Lean; the external analytic inputs and real asymptotics are not thereby
kernel-checked. Independent review is recorded separately when received.

## 1. The remaining gate and what changes here

Set T=abc, R=rad(T), t=log c for positive coprime a,b with c=a+b. Work with
z=a+b*zeta in Z[zeta], where zeta^2-zeta+1=0. Write its actual oriented
factorization as

    z = u*(1+zeta)^e0 * product_i pi_i^e_i,
    M = N(z) = 3^e0 * product_i q_i^e_i,

where e0 is 0 or 1, q_i=N(pi_i)>=7 are distinct split primes, and no conjugate
pair occurs. We use the existing proved identities

    gcd(M,T)=1,       3*c^2/4 <= M <= c^2,
    z^3-bar(z)^3 = 3*sqrt(-3)*T.

The existing disjoint partition theorem provides two-place bounds whenever its
partition penalty is small. Its final unrestricted arithmetic gap is the signed
large-prime ratio

    W_Y(T) = E_3^{>Y}(T)/C_3^{>Y}(T),
    E_3(T)=product_{p|T} p^max(v_p(T)-3,0),
    C_3(T)=product_{p|T} p^max(3-v_p(T),0).

The exact identity T*C_3(T)=R^3*E_3(T) retains all low-depth credit. We do not
assert any global bound on W_Y. The change below is an independently justified
enlargement of the allowed algebraic representations, followed by a new
unconditional balance theorem and a precisely conditional ABC class.

## 2. Nonnegative exponent matrices

**Definition.** A shared exponent representation has m>=1 columns and consists
of a nonnegative integer matrix f_ij and positive integers k_j such that

    e_i = sum_j k_j*f_ij,

and each column contains a positive entry. Put

    w_j = product_i pi_i^f_ij,   Q_j=N(w_j),   S=sum_j k_j.

The same oriented prime factor is allowed in several columns. No conjugate
factor is added.

The case with no split factors is the already isolated triple (1,1,2), which
directly satisfies c<=R. It is not fed to the m+1>=2 logarithmic-form argument.

**Lemma 1 (actual reconstruction and exact norm budget).**

    z = u*(1+zeta)^e0 * product_j w_j^k_j,
    sum_j k_j*log Q_j = log M-e0*log 3 <= 2t,
    Q_j >= 7.

**Proof.** Expand each w_j^k_j, commute the finite products, and collect each
pi_i with total exponent sum_j k_j*f_ij=e_i. Norm multiplicativity gives the
second identity before taking logarithms. A nonzero column contains a factor
of norm at least seven. These steps do not require pairwise disjoint columns.

**Theorem 2 (two-place shared-generator estimate).** There is an effective
absolute C>2 such that every representation with m columns has penalty

    B = C^(m+1)*log(3+S)*product_j log Q_j

and satisfies, for lambda=(z/bar(z))^3,

    |lambda-1| >= exp(-B),
    v_p(T) <= p^2*B                 for every p|T,
    log product_{p|T,p<=Y} p^v_p(T) <= B*Y^3*log Y     for Y>=2,
    c^3 <= 8*exp(B)*R^3*E_3(T)/C_3(T).

**Proof.** Put eta_j=(w_j/bar(w_j))^3. Every w_j remains an algebraic integer
with both complex conjugates of absolute value sqrt(Q_j), giving
h(w_j)=log(Q_j)/2 and h*(eta_j)<=3*log Q_j. The latter uses standard Weil
height inequalities and log Q_j>=log 7. No eta_j equals one: equality would
force equality of the prime-ideal factorizations of w_j^3 and bar(w_j)^3,
whereas one of the selected split prime ideals occurs only on the first side.
This argument excludes conjugate factors within each column; it never requires
different columns to be coprime.

The unit disappears after cubing the quotient, while the ramified factor gives
(-1)^e0, so

    lambda=(-1)^e0 * product_j eta_j^k_j != 1.

The last nonvanishing follows directly from T>0 and the cubic identity. Choose
principal arguments for the eta_j, and choose an integer v for which

    Lambda=sum_j k_j*log eta_j + (e0-2v)*log(-1)

has imaginary part in [-pi,pi]. Then Lambda!=0 and |e0-2v|<=S+1. Apply
Theorem 1.1, equation (1.2), of Bugeaud, B', arXiv:2209.00275v1, to the at most
m+1 logarithms. Zero coefficients can be deleted and a nonzero last coefficient
chosen. Its effective base constant depends only on the field degree, at most
two. The inequality |exp(ix)-1|>=2|x|/pi for |x|<=pi, followed by enlargement
of one absolute C, proves the first bound.

For p|T, gcd(M,T)=1 shows that all w_j,bar(w_j),z,bar(z) are units at every
place over p, even when the w_j overlap. Normalize valuations by v_p(p)=1.
The cubic identity gives

    v_p(lambda-1)=v_p(T)+v_p(3*sqrt(-3)) >= v_p(T).

Apply the FIRST inequality of Bugeaud's Theorem 1.3 to the m+1>=2 numbers
eta_1,...,eta_m,-1, with coefficients k_1,...,k_m,e0. That inequality allows
zero coefficients; it is not the conditional refinement later in that theorem.
It yields p^2*B after the same constant enlargement. Summing over p<=Y and
using sum_{p<=Y}p^2 log p<=Y^3 log Y proves the small-prime bound.

Finally, the cubic identity and M>=3c^2/4 give
T>=c^3*exp(-B)/8. Combine this with T*C_3=R^3*E_3. This completes the proof.

The cited primary source was checked directly at
https://arxiv.org/html/2209.00275v1, Theorem 1.1 (1.2) and the first displayed
inequality of Theorem 1.3. No multiplicative independence is required in either
of the two inequalities used here.

## 3. Quotient and remainder compression

Choose g>=1 and nonnegative integer profiles f_i,r_i with e_i=g*f_i+r_i,
with some f_i positive. Set

    w=product_i pi_i^f_i,  v=product_i pi_i^r_i,
    Q=N(w)>=7, V=N(v)>=1, h=max(1,log V),
    rho = h*log(4+g)/g.

These are actual algebraic integers. The representation is z=u*(1+zeta)^e0*v*w^g.
When v is a unit, omit its column. The parameter g need not divide the original
exponents; in particular it need not equal their common gcd.

**Corollary 3 (a uniform quantitative compression bound).** There is an
effective absolute A>=1 such that the bounds of Theorem 2 hold with a penalty
B satisfying

    B <= A*rho*t.

If 0<rho<=1/64 and Y=rho^(-1/6), then

    log product_{p|T,p<=Y}p^v_p(T)
      <= (A/6)*sqrt(rho)*log(1/rho)*t.

**Proof.** When V>1, Theorem 2 gives
B=C^3*log(4+g)*log V*log Q. The exact norm budget gives g*log Q<=2t,
so A=2C^3 suffices. If V=1, use its one-column bound
C^2*log(3+g)*log Q and the same A. For the second assertion, Y>=2 and
Y^3=rho^(-1/2), log Y=log(1/rho)/6. Substitute in Theorem 2.

**Theorem 4 (unconditional balance for near-common exponents).** For every
0<eta<1 there is an effective rho_eta>0 such that every primitive triple
admitting this representation with rho<=rho_eta satisfies

    min(a,b) > c^(1-eta).

This assertion has no hypothesis on W_Y, on the boundary radical, on the
individual norm primes, or on their number.

**Proof.** If min(a,b)<=c^(1-eta), then T<=c^(3-eta). Theorem 2 implies

    eta*t <= log 8+B <= log 8+A*rho*t.

Since M>=Q^g>=7^g and M<=c^2, t>=g*log 7/2. Also rho>=1/g. Therefore

    (log 8)/t <= (2*log 8/log 7)*rho.

Choose rho_eta so that (A+2*log 8/log 7)*rho_eta<eta. The preceding two
inequalities contradict one another.

**Theorem 5 (a uniform ABC class with an explicit remaining tail).** For every
B0>=0 and epsilon>0 there is an effective rho_{B0,epsilon}>0 such that every
primitive triple with a quotient-remainder representation satisfying

    0<rho<=rho_{B0,epsilon},
    W_{rho^(-1/6)}(T) <= g^B0

obeys c<=R^(1+epsilon). In particular no hidden dependence on the norm primes
or on their number enters this constant.

**Proof.** Make the threshold at most 1/64. The small-prime contribution to
log(E_3/C_3) is at most the full small-prime bound in Corollary 3; the large-prime
contribution is at most B0*log g. Furthermore

    (log 8+B0*log g)/t
       <= (2/log 7)*(log 8+B0)*rho,

using log g<=log(4+g), h>=1, and t>=g log 7/2. After taking logarithms in
the cubic inequality, its total remainder divided by t is at most

    A*rho + (A/6)*sqrt(rho)*log(1/rho)
           + (2/log 7)*(log 8+B0)*rho.

This tends to zero as rho tends to zero. Choose the threshold to make it at
most 3*epsilon/(1+epsilon). Then 3t<=3 log R+3epsilon*t/(1+epsilon), and
rearrangement gives t<=(1+epsilon)log R.

This theorem is conditional on its displayed arithmetic tail. It does not
assert that all triples, or the infinite family below, satisfy that tail.

## 4. Actual unbounded content-one families

Let q_1,q_2,... be any sequence of distinct primes congruent to 1 modulo 3,
and choose one oriented prime pi_i of norm q_i. Their existence and the
primitive-coordinate and unit-rotation facts are the same elementary
Eisenstein inputs as in the preceding checkpoint. Put

    L_r=sum_{i=1}^r log q_i,  D_r=r+L_r,
    g_r=ceil(exp(D_r^2)),
    z_r=product_{i=1}^r pi_i^(g_r+i)              (r>=2).

After unit rotation this gives an actual positive primitive triple. Primitivity
follows because a rational prime dividing both coordinates would force the
conjugate prime factor to occur too; no such conjugate is present. The boundary
cannot vanish: a primitive zero-boundary element is a unit, while its norm is
greater than one. The exponents g_r+1 and g_r+2 have gcd one, so the total
split exponent gcd is exactly one.

Take w_r=product_i pi_i and v_r=product_i pi_i^i. Then

    log N(w_r)=L_r,   log N(v_r)<=r*L_r,
    log c_r = (g_r*L_r + sum_i i*log q_i)/2 + O(1).

The O(1) is absolute, from the norm-height comparison. Also

    rho_r <= r*L_r*log(4+g_r)/g_r -> 0.

Indeed r*L_r<=D_r^2 and log(4+g_r)<=D_r^2+log 6, while
g_r>=exp(D_r^2) and D_r tends to infinity. Thus Theorem 4 proves
unconditionally that these actual content-one triples satisfy

    min(a_r,b_r)>c_r^(1-eta)

eventually for each fixed eta>0. Corollary 3 also controls their small-prime
part without any separate boundary multiplicity assumption.

**Precise comparison with the preceding sufficient classes.** For each fixed
d>=1 and delta>0, these profiles eventually fail EVERY old partition condition

    m<=d,    product_j gcd{e_i:i in I_j} >= (log c_r)^(m-1+delta).

To prove this, suppose r>d. A partition into m<=d blocks has a block with two
distinct indices. The gcd of their exponents divides their difference, so the
content of that block is at most r. Each other block content is at most g_r+r.
Thus the product of contents is at most r*(g_r+r)^(m-1). Meanwhile
t_r>=g_r*L_r/2 and g_r>=r. The ratio of these bounds is at most

    2^(2*m-2+delta) * r/(g_r^delta * L_r^(m-1+delta)),

which tends to zero uniformly for 1<=m<=d. This proves the asserted failure
of the previously stated bounded-block sufficient hypothesis.

This does NOT say the minimum over all old partitions is large: a partition
whose number of columns grows with r may also have a small penalty in this
very rapidly growing family. The accurate novelty here is the explicit
two-generator compression, the uniform criterion rho->0, and the unconditional
content-one consequence, not an asserted lower bound on every older envelope.

## 4b. Strict improvement over every disjoint partition on a second family

The preceding caveat can be overcome by a different, slower choice of exponents
on norm primes of comparable sizes. This provides an actual separation between
the best old disjoint representation and a new shared representation.

**Theorem 6 (strict envelope separation).** There is an infinite sequence of
actual primitive positive triples with split-exponent gcd one for which

    inf_{old disjoint partitions P} B_P >= kappa*log M,
    B_shared/log c -> 0,

where kappa>0 is an absolute constant and B_shared uses just two columns. The
first assertion concerns the old explicit penalty, not the true angular defect.
The triples are unconditionally balanced as in Theorem 4, and their full
small-prime masses satisfy Corollary 3. Their high-prime tail remains unproved.

**Construction.** Choose r distinct primes q_i congruent to 1 modulo 3 in
[X,2X], where X>=7, and set L=log X. Put

    g=ceil(r^4*L^2),   e_i=g+i,   z=product_{i=1}^r pi_i^e_i.

Rotate z to a positive triple. Its primitive-coordinate and nonzero-boundary
checks are those in Section 4, and gcd(e_1,...,e_r)=1 for r>=2. Write
Vtot=log M. The inequalities g>=r and log(2X)<=2L give

    g*r*L <= Vtot <= 4*g*r*L <= 8*r^5*L^3.                 (S1)

The final inequality follows from ceil(r^4 L^2)<=2r^4 L^2.

For the shared representation take w=product_i pi_i and v=product_i pi_i^i.
Then log N(v)<=2r^2 L, so

    rho <= 2*log(4+g)/(r^2*L) -> 0                        (S2)

uniformly in L>=log 7 as r tends to infinity. For explicit uniformity,
log(4+g)<=log 6+4log r+2log L; divide by r^2 L, use L>=log 7 and boundedness
of (log L)/L. Corollary 3 therefore gives B_shared/log c->0.

**Proof of the old-partition lower bound.** For any disjoint partition into m
blocks, write h_j for a block's size, k_j for the gcd of its exponents, and
L_j=log Q_j for its old reduced norm. Always L_j>=L. If h_j>=2, all the
distinct indices in that block are congruent modulo k_j. Their smallest and
largest differ by at least (h_j-1)k_j and at most r-1. Hence

    k_j <= (r-1)/(h_j-1),
    L_j >= g*h_j*(h_j-1)*L/r.                            (S3)

First suppose m<=r/2. A largest block has h>=r/m>=2, and
h(h-1)>=h^2/2>=r^2/(2m^2). By (S3), its reduced logarithmic norm is at least
g*r*L/(2m^2). Use L for each other block, and divide the old penalty by the
first upper bound in (S1). This gives

    B_P/Vtot >= C^(m+1)*log 4*L^(m-1)/(8m^2)
             >= log 4/8.                                (S4)

Here C>2, L>1 and 2^(m+1)>=m^2 for every m>=1. For completeness the last
elementary inequality holds directly for m=1,2,3; for m>=3 it propagates
because (m+1)^2<=2m^2.

If m>r/2, simply use L_j>=L in every block and the final upper bound in (S1):

    B_P/Vtot >= C^(m+1)*log 4*L^(m-3)/(8r^5).             (S5)

For r>=8, m>=5, so L^(m-3)>=(log 7)^(m-3). The right side is at least

    [log 4/(4*(log 7)^3)] * (2*log 7)^(r/2)/r^5,

which tends to infinity. This convergence is independent of X and of the
chosen primes. Consequently (S4) holds for all partitions once r is large,
with kappa=log 4/8. The cases m growing with r have been included, not omitted.

**Infinitude input, separately identified.** Such prime lists exist with
r->infinity. One may use the established fixed-modulus prime number theorem.
For a directly checked quantitative primary source, Bennett--Martin--O'Bryant--
Rechnitzer, arXiv:1802.00085v3, prove for x>=8*10^9 the inequality

    |theta(x;3,1)-x/2| < x/(160*log x).

Subtracting the bounds at 2X and X gives
theta(2X;3,1)-theta(X;3,1)>=X/3 for all sufficiently large X. Since each
summand is at most log(2X), the number r of these primes is at least
X/(3log(2X)), and tends to infinity. This input supplies prime availability
only; all reconstruction and envelope comparisons above are separate proofs.
Primary source: https://arxiv.org/pdf/1802.00085v3.

This separation is positive progress: sharing the factors gives a sublinear
two-place bound on actual profiles where the entire old partition family cannot
give one. It does not create a new unconditional bound on the remaining W_Y.

## 5. Dependency chain and next exact gate

Unconditional/source-established chain:

    actual oriented factorization
      -> nonnegative matrix reconstruction
      -> two established logarithmic-form estimates
      -> rho-sensitive angle and small-prime control
      -> unconditional balance for near-common exponents.

Conditional chain:

    previous chain + W_{rho^(-1/6)}(T)<=g^B0
      -> uniform c<=R^(1+epsilon) on the displayed class.

The next unresolved arithmetic node is precisely the signed tail on this new
class. The global prime-norm terminal cases e=(1) remain outside rho->0. The
known counterexamples to raw positive excess smallness do not refute this
signed or restricted tail. No old parent route is retired.

## 6. Finite-list Lean target, after the ordinary proof

For a commutative monoid and a finite list of triples (p_i,f_i,r_i), prove

    product_i p_i^(g*f_i+r_i)
      = (product_i p_i^r_i) * (product_i p_i^f_i)^g.

The proof is induction on the list, using pow_add, pow_mul, and commutation.
Under a multiplicative norm, prove the corresponding equality of norms.
No disjointness or coprimality hypothesis belongs in this finite algebraic
statement. The universal factorization/classification and external analytic
bounds remain separate ordinary-mathematics dependencies.
