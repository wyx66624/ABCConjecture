# NC1--NC5. Explicit coloring of actual norm support and uniform-moment windows

Status: complete ordinary proof for the thirteenth continuation, awaiting
final independent review of this expanded presentation. The NC1--NC3
predecessor received full ordinary reviews from root and critical_bottleneck.
Its untracked twelfth-round next-candidate is preserved unchanged. No
published twelfth-round source is changed here. This note includes the
separately reviewed UM uniform-moment argument and makes the dependence
of the small-prime endpoint on the support cutoff explicit.

Write zeta=(1+sqrt(-3))/2, so zeta^2=zeta-1. For an integer B>=1 let

    I_B={k in Z:B<=k<2B}, a_k=3k, w_k=a_k+zeta,
    Q_k=N(w_k)=a_k^2+a_k+1, alpha_k=w_k/bar(w_k).

All these are actual primitive unramified Eisenstein roots. They satisfy
9B^2<=Q_k<49B^2. For a real x>=3 define the actual subset

    S(B,x)={k in I_B: some rational prime p>x divides Q_k}.

The norm condition defines the subset before any later boundary prime,
depth, tuple length or exceptional set is chosen. Factorization is used
in its proof; no random-norm or independence hypothesis defines membership.

## NC1. A finite graph with an exact color budget

For every B>=1 integral and x>=3 real put

    m=floor(log(49B^2)/log x),
    D=1+m(2 floor(B/x)+1).                                      (NC1)

The actual set S(B,x) is a disjoint union of at most D classes. The
ratios alpha_k in each class are multiplicatively independent over Z.
The empty case is allowed, including the case m=0.

Proof. If p divides Q_k then p is neither 2 nor 3. Also a_k^3=1
modulo p while a_k is not 1 modulo p, so p=1 modulo 3. The polynomial
9X^2+3X+1 has exactly two roots modulo such a p. Both are simple since
its discriminant is -27. These observations also prove there are
exactly two residue classes at every prime-power depth.

Join two distinct vertices k,l of S(B,x) when some prime p>x divides
both Q_k and Q_l. If r distinct such primes divide Q_k, then
x^r<their product<=Q_k<49B^2, whence r<=m. For a fixed supported p,
the two residue classes meet I_B in at most

    2 floor((B-1)/p)+2

indices. Remove k itself. At most 2 floor((B-1)/p)+1 neighbors of k
arise from this p. Since p>x,

    degree(k)<=m(2 floor(B/x)+1)=D-1.                           (NC2)

Repeated neighbors in the sum only decrease the actual degree. List
the finite vertices in increasing order and give each the first of
D colors unused by its previously colored neighbors. At most D-1
colors are forbidden, so this elementary algorithm colors every
vertex. No matroid partition or graph-coloring black box is an input.

In a fixed color, choose for each k any p_k>x dividing Q_k. The chosen
prime divides no other norm of that color. At one of its two prime
ideals in Z[zeta], w_k has positive valuation and bar(w_k) has zero
valuation, or conversely after choosing the conjugate ideal. Indeed
a common divisor would divide w_k-bar(w_k)=sqrt(-3), impossible
above p_k>3. Thus alpha_k has a nonzero integer ideal valuation d_k
at a chosen prime ideal, and every other ratio in the color has
valuation zero there. Apply this valuation to a multiplicative
relation to obtain c_k d_k=0, hence c_k=0. This works for each k.
The depth d_k need not be one, and the norms may share small primes.
This proves actual independence in each color. QED.

This argument does not color the norm-smooth complement with independent
classes. In particular, it proves no bounded-color theorem for I_B as
a whole. Its colors and private valuation witnesses are fixed independently
of every boundary-prime calculation below.

## NC2. Full-block mass and a uniform cutoff error

There is an absolute constant C such that, for every integer B>=3
and every real 3<=x<=B, the complete small-norm-prime mass obeys

    sum_(k in I_B) sum_(p<=x) v_p(Q_k) log p
      <= B log x + C B log log(3x)
                      + C x log(49B^2)/log x.                 (NC3)

All prime valuations, not merely first occurrences, are included.
Consequently, with L_B=log(49B^2),

    |S(B,x)| >= max(0,
      [2B log B-B log x-C B log log(3x)-C x L_B/log x]/L_B).     (NC4)

Proof. For a supported prime p put H_p=floor(L_B/log p). At depth e
there are exactly two root classes and hence at most 2(B/p^e+1)
actual indices. Summing every level up to H_p gives

    sum_k v_p(Q_k) log p
          <= 2B log p/(p-1)+2H_p log p.                        (NC5)

Only p=1 modulo 3 occur. The fixed-progression prime theorem gives

    sum_(p<=x,p=1 mod3) log p/(p-1)
                       = (1/2)log x+O(log log(3x)),             (NC6)

with an absolute constant for all x>=3. To make the source dependence
precise, Bennett--Martin--O'Bryant--Rechnitzer, Theorem 1.2, printed
page 5, equation (1.12), specialized to modulus 3, gives
theta(x;3,1)=x/2+O(x/log x). Partial summation against 1/x integrates
the error to O(log log(3x)); replacing 1/p by 1/(p-1) costs the
convergent sum of log p/[p(p-1)]. Enlarging an absolute constant
covers the finite initial interval. The paper was independently
reopened for this note: [primary theorem](https://arxiv.org/pdf/1802.00085).

The elementary bound pi(x)=O(x/log x), or the same fixed-progression
bound after partial summation, gives

    sum_(p<=x,p=1 mod3) 2H_p log p
                  <= 2L_B pi(x) <= C x L_B/log x.              (NC7)

Thus the endpoint is explicitly retained even when x is much smaller
than B. Combining (NC5)--(NC7) proves (NC3). The actual total norm
mass is at least 2B log B. Its mass above x is supported on S(B,x),
and each member contributes at most L_B. Subtract (NC3), divide by
L_B, and combine with nonnegativity to obtain (NC4). QED.

Fix 0<theta_0<=1. Uniformly for theta in [theta_0,1], as B tends to
infinity through integers and x=B^theta,

    |S(B,B^theta)| >= (1-theta/2)B
                        -O_(theta_0)(B log log B/log B),        (NC8)
    D <= (1+9/theta_0) B^(1-theta)                              (NC9)

for sufficiently large B, with the latter already valid when B>=49
and B^theta>=3. Indeed L_B<=3log B then gives m<=3/theta_0, while
2floor(B/x)+1<=3B^(1-theta). The endpoint in (NC7) is bounded by
3C B^theta/theta_0. This proves the uniform statement without taking
an uncontrolled theta->0 limit. For a single fixed theta>0 the same
conclusions are written O_theta. No argument is reapplied to an
arbitrary previously discarded subset of the block.

## NC3. Complete positive-depth budgets on colored actual roots

Now let n>324 be prime, B=n^4. If w_k^n=A+B' zeta, define

    T_n(k)=|A B'(A+B')|,
    c_n(k)=max(|A|,|B'|,|A+B'|), t_k=log c_n(k).

Here B' is the second coefficient, not the block length B. Primitive
unramified powers have no zero boundary coordinate. A unit rotation
to the positive sector gives the same c and T. Elementary norm and
boundary-height bounds give

    t_k>=n log(3B),
    log T_n(k)<=3n log(6B+1).                                  (NC10)

For a real 8B<Z<=B^2 put

    F_(8B,Z)(k)=sum_(8B<q<=Z) (v_q(T_n(k))-3)_+ log q.

Then for every real x>=3, using the exact D of (NC1),

    (1/B) sum_(k in S(B,x)) F_(8B,Z)(k)/t_k
                   <= 80 D Z/[B n log(Z/(3n))].                (NC11)

The statement includes every positive excess layer in the interval.
It places no cap on any prime up to 8B or above Z.

Proof of uniform tuple rigidity. This is the UM argument, reproduced
to specify the scope of applying it to colors. For any finite nu>=1,
two nu-fold products of block elements have coordinates R,S and R',S'
satisfying

    |R|,|R'|<=2(7B)^nu,
    |S|,|S'|<=2nu(7B)^(nu-1).

The second estimate follows by telescoping the difference from the
real product of the a_k's; it does not require signs of the product
coordinates. Hence their integer determinant has absolute value at
most 8nu 7^(2nu-1)B^(2nu-1). For q>8B, division by q^(2nu) makes
this strictly smaller than

    [8/(7B)] nu(49/64)^nu < 512/(105B) < 1.                   (NC12)

The middle inequality follows from the finite geometric sum:
nu z^nu<sum_(j=0)^(nu-1)z^j<1/(1-z), z=49/64. All constants
are independent of nu. If ratio products agree modulo q^(2nu),
with unit denominators, their conjugate cross difference makes that
integer determinant divisible by q^(2nu). It is therefore zero, and
the actual number-field ratio products agree.

For k with q^(2nu)|T_n(k), q>8B, the norm is a q-unit and alpha_k
belongs modulo q^(2nu) to the norm-one 3n-torsion subgroup. Norm-unit
follows also directly: a norm-zero boundary arm would make both
coordinates zero modulo q, contradicting primitivity. The standard
split/inert norm-one calculation gives at most 3n such torsion
elements at every depth, since q>n and q>3. More explicitly, the
prime-to-q torsion is already determined modulo q; each such simple
torsion solution lifts uniquely. These are the actual finite-ring
inputs proved in MC and used in UM.

Restrict to any one color and its M_nu(q) deep indices. Distinct
multisets of length nu have distinct actual ratio products by NC1.
By (NC12), they also have distinct images in this finite group.
Stars and bars gives

    choose(M_nu(q)+nu-1,nu)<=3n.                              (NC13)

For an empty set and positive nu the multiset count is zero; this
case need not use a binomial expression with a negative integer.
For nu=2, (NC13) gives M_2<=sqrt(6n). Set r=ceil(sqrt n). If M_r>=4,
then 3n>=choose(r+3,3)>r^3/6>=n^(3/2)/6>3n, impossible since n>324.
Thus each color has at most three roots at depth 2r.

Pay every layer using (e-3)_+=sum_(j>=4)1_(e>=j). Layers 4<=j<2r
in one color cost at most 4sqrt(6)n log q<10n log q. Layers j>=2r
have at most three indices and the height cap in (NC10) gives total
cost at most 9nL, where L=log(6B+1). Thus summing at most D colors,

    sum_(k in S(B,x)) (v_q(T_n(k))-3)_+ log q
                              <=D(10n log q+9nL).              (NC14)

For q<=Z<=B^2, log q<=2log B and L<=2log B. After division by
B n log B, the complete per-prime normalized budget is at most 38D/B.

A contributing prime has homogeneous rank exactly n. Rank divides
the prime n. Rank one, since q>n permits no exponent lifting, would
force q^2 into one of the coprime factors a_k,a_k+1 of T_1(k), both
smaller than q^2. This is impossible. The cube of alpha_k has order n,
so n divides the norm-one group order q-chi(q), where
chi(q)=(-3/q) is the quadratic splitting character. For q>3 this order
is also divisible by 3; since gcd(n,3)=1, it is divisible by 3n.
Equivalently n|(q-chi(q))/3. The order of alpha_k itself may be n
or 3n; it need not always be 3n. Thus q is 1 or -1 modulo 3n.

The through-Z Brun--Titchmarsh bound for these two reduced classes is

    #{q<=Z:q=+/-1 mod3n}<=2Z/[(n-1)log(Z/(3n))].               (NC15)

It follows from Montgomery--Vaughan, Theorem 2, printed page 121,
equation (1.10), using phi(3n)=2(n-1). The primary paper was
independently reopened: [The large sieve](https://personal.science.psu.edu/rcv4/personal/Publications/large_sieve.pdf).
It is a uniform progression upper bound, not a prime number theorem
for the moving modulus. Multiplication by 38D/B yields (NC11), since
76n/(n-1)<80. QED.

## NC4. The density-window tradeoff, including the logarithmic factor

Fix real theta in (3/4,1] and delta>0. For sufficiently large prime n
put B=n^4, kappa=4theta-3, and

    Z_n=floor(B n^kappa (log n)^(1-delta)).                    (NC16)

Then 8B<Z_n<=B^2 and

    (1/B) sum_(k in S(B,B^theta)) F_(8B,Z_n)(k)/t_k
                                 =O_(theta,delta)(log n)^(-delta).
                                                                    (NC17)

Indeed kappa>0 is fixed, so n^kappa(log n)^(1-delta) tends to infinity,
while kappa<=1 makes Z_n/B=o(n^4). The floor changes the leading
logarithm only by o(1), and

    log(Z_n/(3n))=(3+kappa)log n
                         +(1-delta)log log n-log3+o(1).

Use D=O_theta(n^(4(1-theta))) in (NC11). The power of n cancels
exactly because 4(1-theta)+kappa-1=0, leaving (NC17). The constants
can be made uniform for theta in [theta_0,1] with fixed theta_0>3/4
and fixed delta. This is a fixed lower endpoint, not a theta tending
to 3/4 or 0 assertion.

By NC2 and Markov there is an actual subset P_(n,theta,delta) of I_B
with relative size at least

    1-theta/2
      -O_(theta,delta)(log log n/log n
                        +(log n)^(-delta/2)+(log n)^(-1/2)),    (NC18)

on which

    k in S(B,B^theta),
    F_(8B,Z_n)(k)/t_k <= (log n)^(-delta/2),
    L_(8B)(T_n(k))/t_k <= (log n)^(-1/2).                       (NC19)

Here L_X(T)=sum_(q<=X)v_q(T)log q is the full small-prime mass.
For the last condition we used the published prime-index FM estimate
with the elementary EA inputs at X=8B: its whole-block mean is
O(1/log n). Its Markov exceptional set may be removed from S because
the mean is taken on the full actual block. No claim of a depth cap
on (B,8B] is made. The two exceptional sets may overlap; a union
bound suffices, and all normalizations remain by B.

## NC5. The remaining signed gate and the comparison with MC

For a positive integer T define

    J(T)=log T-3log rad(T),
    W_Z(T)=sum_(q>Z,q|T)(v_q(T)-3)log q.

On the actual set (NC18)--(NC19), exact disjoint prime decomposition
gives, with eps_n=(log n)^(-delta/2)+(log n)^(-1/2),

    J(T_n(k))/t_k <= W_(Z_n)(T_n(k))/t_k+eps_n.                (NC20)

The middle interval's signed terms are bounded above by their
positive parts, and the terms up to 8B by the full mass. This retains
the far signed term with its negative credit. The independently
proved elementary block angle bound, valid here since B>=n, is
log T_n(k)/t_k>=3-4/n. Hence

    log rad(T_n(k))/t_k
      >=1-4/(3n)-eps_n/3-(W_(Z_n)(T_n(k)))_+/(3t_k).           (NC21)

The positive far cost remains a substantive unproved membership
condition. A small average on the finite interval is not a bound
for that farther tail, nor a theorem for every root in the block.

The power exponent kappa=4theta-3 lies in (0,1], and the proved
domain fraction is exactly 1-theta/2=(5-kappa)/8. Thus kappa=1
retains the one-half limit while reaching Bn times the logarithmic
factor; 1/2<kappa<1 gives a larger fraction than one half at a
smaller power cutoff beyond the former MC range. For kappa<1/2,
MC already gives a domain of fraction tending to one over the
corresponding intermediate interval. In that range the colored
structure is additional information, not an improved coverage
theorem. At the exponent 1/2 boundary no comparison with an
unproved endpoint of MC is inferred. For example theta=15/16 gives
kappa=3/4 and domain fraction 17/32, at the cutoff
floor(B n^(3/4)(log n)^(1-delta)).

No bounded-color theorem for all actual ratios is proved. The
remaining norm-smooth set, its possible rank deficiency, and the
unbounded signed tail are separate open targets. The known exact
pair-product collisions disprove universal one-color independence;
they do not disprove a stronger multi-color theorem for all roots.
The full-block mass argument above cannot simply be iterated on
an arbitrary smooth complement.

## Verification and dependency scope

NC1 is an explicit finite ordinary graph proof and ideal-valuation
argument. NC2 uses only the fixed modulus-three prime theorem and
complete valuation-layer counts; (NC3) records its actual endpoint.
NC3 reproduces the separately reviewed uniform UM finite-moment and
layer arguments on each proved independent color. The finite-ring
rank and norm-one statements come from MC, and the analytic upper
bound is Brun--Titchmarsh. NC4--NC5 use the published elementary EA
and full-mass FM results at 8B, followed by ordinary Markov.

This note contains no new Lean proof or finite computation claim.
Root's separate actual-private-valuation multiset module may verify
the finite interface once its arithmetic witnesses and rigidity are
supplied; it does not formalize the coloring, ideal construction,
density or whole signed theorem. No arbitrary tuple-injectivity or
global tail-membership premise is silently discharged.
