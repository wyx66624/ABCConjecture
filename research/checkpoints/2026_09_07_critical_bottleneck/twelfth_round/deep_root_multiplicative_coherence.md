# MC1--MC4. Actual deep-root coherence through multiplicative pair collisions

Date: 2026-09-07. Complete ordinary candidate for independent review.
This is separate from the frozen eleventh round. It proves a bound on
the actual number of roots at one deep prime, then a simultaneous
depth-at-most-three interval. It does not control all larger primes
or the exceptional roots and does not prove ABC.

Let n>=7 be prime and B=n^4. For integers B<=k<2B define

    a_k=3k, w_k=a_k+zeta, Q_k=a_k^2+a_k+1,
    T_n(k)=|P(w_k^n)|, t_k=log c_n(k).

The roots and all their powers are primitive and unramified. In the
pair-counting argument below, a,b,c,d denote four ROOT PARAMETERS
a_k, not the three entries of the resulting ABC triple.

Set Y=6n^3=6B^(3/4). Since n>=7, one has n<Y<B.
For a prime q>Y let

    A_q={k in [B,2B): q^4 divides T_n(k)}.

## MC1. A small torsion group at actual fourth depth

For every member of A_q, Q_k is a unit modulo q. In the quadratic
ring R_4=(Z/q^4 Z)[zeta], put

    alpha_k=(a_k+zeta)/(a_k+bar(zeta)).

All these elements belong to the same group

    H_q={x in R_4^*: x bar(x)=1, x^(3n)=1},

and |H_q|<=3n.

Proof. At q>3, the cubic boundary identity is

    z^3-bar(z)^3=3 sqrt(-3) P(z).

Its scalar factor is a unit modulo q^4. If q divided Q_k, the inert
case would imply w_k=0 modulo q, impossible since its second coordinate
is one. In the split case, exactly one component of w_k is zero,
the other nonzero. The cubes of w_k^n and bar(w_k)^n could not then
be equal modulo q. Thus q does not divide Q_k whenever q divides T_n.
The identity with z=w_k^n now proves alpha_k^(3n)=1 modulo q^4,
and alpha_k has norm one by definition.

For completeness, both unramified cases have the asserted small
group. If q splits, R_e is the product of two copies of Z/q^e Z,
with conjugation exchanging factors. A norm-one element is (u,u^-1).
There are at most 3n roots of u^(3n)=1 modulo q, each of which lifts
uniquely to every q^e because q does not divide 3n.
If q is inert, reduction is F_(q^2). Its norm-one group is cyclic
of order q+1, so it has at most 3n elements killed by 3n.
Every root of X^(3n)-1 has a unique lift in the unramified quadratic
ring at each step: substituting x+q^e y gives a linear equation in
y modulo q with invertible derivative 3n*x^(3n-1).
In either case reduction injects H_q into the corresponding set
modulo q. This proves |H_q|<=3n without treating actual roots as
uniformly distributed in that group. QED.

## MC2. Congruent pair products lift to exact rational phases

For two positive parameters a,b from the block,

    (a+zeta)(b+zeta)=r+s zeta,
    r=ab-1>0, s=a+b+1>0.

Here r<=36B^2 and s<=12B. If two ordered pairs from A_q satisfy

    alpha_a alpha_b=alpha_c alpha_d in H_q,

then their actual rational phases agree:

    (ab-1)/(a+b+1)=(cd-1)/(c+d+1).                 (MC1)

Proof. Multiplying by the unit conjugate denominators and using
zeta-bar(zeta)=sqrt(-3), which is a unit at q, shows that q^4 divides
the integer

    (ab-1)(c+d+1)-(cd-1)(a+b+1).

Its absolute value is at most 864B^3. But q>Y=6B^(3/4),
so q^4>1296B^3>864B^3. It must be zero. This is an actual integer
identity, not an equidistribution estimate. All divisions in (MC1)
have positive denominators. QED.

Fix one such actual phase u/v in lowest positive terms. It satisfies
u<=36B^2, v<=12B. For any ordered pair with that phase,

    (va-u)(vb-u)=u^2+uv+v^2=:K,                   (MC2)
    1<=K<=2500B^4.

Both factors on the left are positive: u/v=(ab-1)/(a+b+1)
is smaller than min(a,b). The first factor is a positive divisor
of K and determines a uniquely; it then determines b uniquely.
Consequently the number of ordered pairs having the fixed phase is
at most tau(K). Diagonal pairs and exchanged pairs are included in
this count. There is no zero-factor or infinite-phase exception.

The elementary divisor bound used below is: for every epsilon>0,

    tau(m)<=C_epsilon m^epsilon   (m>=1).

Indeed, for p>=2^(1/epsilon), j+1<=2^j<=p^(epsilon*j).
For each of the finitely many smaller primes, the supremum of
(j+1)/p^(epsilon*j) over j>=0 is finite. Multiplying these finitely
many constants and the prime-power estimates proves the assertion.
No ineffective or unverified analytic input is needed for this bound.

## MC3. An actual deep-root bound uniform in the prime

For every epsilon>0 there is a constant C_epsilon, independent of
n, q and the root block, such that

    |A_q|<=C_epsilon sqrt(n) B^(2epsilon).         (MC3)

Proof. Map all |A_q|^2 ordered pairs to their product in H_q.
There are at most 3n images. By MC2 each image class has a single
actual rational phase, and hence contains at most

    max_{1<=K<=2500B^4} tau(K)
       <=C_epsilon (2500B^4)^epsilon

ordered pairs. Thus |A_q|^2 is at most 3n times this quantity.
Taking square roots and absorbing the numerical factor gives (MC3).
The bound also holds when A_q is empty. It does not require the
parameters in a pair to be distinct.

This is stronger than the previous uniform 3phi(n) simple-root count
for deep actual roots in the short block. It uses the same prime
at all four entries of a collision and the actual small integer
parameters. It is not an estimate for all residue classes modulo q^4.

Every q with A_q nonempty has exact homogeneous rank n. Rank one
would give v_q(T_n)=v_q(T_1), as q>Y>n. But T_1=a(a+1) has coprime
factors both below 6B+1, whereas q^2>36n^6>6n^4+1=6B+1.
Thus rank one cannot even have depth two.
The norm-one rank condition therefore gives

    q=+1 or -1 modulo 3n.                         (MC4)

Here the two cases correspond respectively to split and inert q;
3n divides q-chi because n and 3 both divide it and n>=7 is prime.
QED.

## MC4. A joint cap-three interval with polynomial expansion

For Z>Y define the actual exceptional set

    E(n,Z)={k: some prime Y<q<=Z has v_q(T_n(k))>=4}.

The same two-progression Brun--Titchmarsh theorem already source-
checked in SW gives, together with MC3,

    |E(n,Z)|/B
       <= C_epsilon Z B^(2epsilon)
             /[B sqrt(n) log(Z/(3n))].             (MC5)

This holds for every real Z>Y>3n. Constants absorb n/(n-1), which
is uniformly bounded on n>=7. The bound is an ordinary union
bound on actual index sets; there is no independence assumption.

Fix 0<delta<1/2. For all sufficiently large prime n, put

    Z_delta(n)=floor(B n^(1/2-delta)).

Taking epsilon=delta/16 gives

    |E(n,Z_delta)|/B
       = O_delta(n^(-delta/2)/log n).              (MC6)

In particular Z=floor(B n^(1/4)) has exceptional fraction
O(n^(-1/8)/log n). For every root outside this single exceptional
set, every supported prime in the entire interval (Y,Z_delta]
has actual depth at most three simultaneously.

Proof of the calculation. The number of eligible primes up to Z
is at most

    4Z/[phi(3n) log(Z/(3n))]
       =2Z/[(n-1) log(Z/(3n))].

Multiply by MC3 and divide by B to get MC5. Since B=n^4,
B^(2epsilon)=n^(8epsilon). At Z_delta the power of n after
normalization is -delta+8epsilon=-delta/2, while
log(Z_delta/(3n)) is asymptotic to (7/2-delta)log n.
This proves MC6, including the harmless integer floor.

For such a root define the far signed cost

    W_delta(k)=sum_{q>Z_delta, q|T_n(k)}
                         (v_q(T_n(k))-3)log q.

The whole intervening window has nonpositive signed cost, exactly

    -2 sum_{Y<q<=Z_delta, v_q(T_n)=1}log q
     - sum_{Y<q<=Z_delta, v_q(T_n)=2}log q <=0.     (MC7)

Thus its global signed cost satisfies

    J(T_n(k))<=W_delta(k)+L_Y(T_n(k)).             (MC8)

No smallness of the intervening full mass is used in MC7 or MC8.
This is the difference from merely extending a negligible-mass window.

One may additionally use the already reviewed FM1 and elementary EA
bounds at cutoff Y. For prime n the actual mean L_Y/t is O(log n/n):
the harmonic term is O(log n/n), the endpoint term O(1/(n log n)),
and the lifting and primes two and three contribute O(1/n).
Markov at eta_n=sqrt(log n/n), intersected with MC6, therefore gives
one actual set K_(n,delta) of relative size at least

    1-C_delta[eta_n+n^(-delta/2)/log n].

On this set MC7 holds and L_Y/t<=eta_n. The second exceptional
fraction has not been absorbed into the smaller eta_n. On this set,

    J(T_n)/t<=W_delta/t+eta_n,                    (MC9)
    log rad(T_n)/t
       >=1-4/(3n)-eta_n/3-(W_delta)_+/(3t).       (MC10)

The last inequality uses the elementary actual angular bound
log T_n/t>=3-4/n. Hence a sequence in these sets with
(W_delta)_+/t ->0 satisfies the restricted ABC estimate for every
fixed positive tolerance at all sufficiently large indices.
That is a sufficient consequence, not an assertion that the far
condition holds for these roots.

## Exact remaining boundary and dependencies

The new input is a height-dependent coherence statement: finite
torsion pair-product collisions at fourth depth become actual
integer identities, whose fibers are counted by integer divisors.
Its dependencies are the elementary Eisenstein cubic identity,
unramified finite rings with simple lifting, the degree-three
determinant bound, and an elementary divisor estimate. Only after
that point is the previously reviewed Brun--Titchmarsh input used.
FM/EA are needed only for MC9--MC10. The lower cutoff Y=6n^3,
which is below B=n^4, follows from the degree-three determinant
bound and not from an assumption q>B.

The entire interval (Y,Z_delta] now has actual nonpositive signed
cost on the stated majority of roots, even if its full mass is not
small. We have not proved a lower bound for its negative credit or
for its full mass. In particular, the FM mean at this larger cutoff
does not imply a negligible full-mass assertion; no version of SQ3's
almost-full far-mass conclusion has been carried over here.

This does not bound W_delta, nor treat all the excluded roots.
The signed cost of the farther private top-rank primes remains the
central unresolved gate. The root-count bound at a fixed prime is
not a pointwise bound on every root's larger-prime tail. No Lean
formalization or finite computational evidence is claimed for this
new ordinary theorem at this stage.
