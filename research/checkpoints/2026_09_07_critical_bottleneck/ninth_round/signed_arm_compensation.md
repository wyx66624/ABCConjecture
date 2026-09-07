# SA1--SA4. Actual arm quotients and signed compensation of a private deep tail

Date: 2026-09-07. Ninth-round ordinary proof submitted for independent review.
All earlier round-eight mathematical sources remain frozen. This note retains
negative radical credits; it does not assume that the deepest owner has small
positive excess, or that an actual arithmetic orbit is uniformly distributed.

## SA1. Three actual integer quotients

Let O=Z[zeta], zeta^2-zeta+1=0. Let w=a+b*zeta be primitive and
unramified, with Q=N(w)>=7. Thus gcd(a,b)=1, 3 does not divide Q,
and P(w)=ab(a+b) is nonzero. Let n>=5 be an integer coprime to 6.
Define

    z_n = w^n             if n=1 mod 6,
          bar(w)^n        if n=5 mod 6,
    z_n=A+B*zeta,
    D_1=A/a, D_2=B/b, D_3=(A+B)/(a+b).                    (SA1)

The three D_i are evaluations of integer homogeneous polynomials of
degree n-1. They are nonzero, pairwise coprime rational integers, and

    a D_1+b D_2=(a+b)D_3,
    |D_1 D_2 D_3|=T_n/T_1,
    T_n=|P(w^n)|, T_1=|P(w)|.                             (SA2)

For prime n>=5, their signed product is the actual top cyclotomic
factor C_n, up to the sign caused by conjugation. For composite n
coprime to 6, it is the whole actual quotient product over d|n,d>1.

Proof. The normalized power map z_n fixes each of the three boundary
lines individually. At a=0 its value is b^n*zeta; at b=0 it is a^n;
and at a=-b it is b^n*zeta^2. These statements use n=1 modulo 6 in
the first case of the definition and -n=1 modulo 6 in the second.
Consequently its first coordinate is divisible by a in Z[a,b], its
second by b, and the coordinate sum by a+b. For the last divisibility,
substitute a=-b and use division by the monic linear polynomial a+b.
This also proves the asserted degrees and integrality before specialization.

The established oriented-factorization argument shows that w^n is
primitive and has no zero boundary arm; conjugation preserves both facts.
Thus A, B, A+B are pairwise coprime nonzero integers. Their respective
integer divisors D_1,D_2,D_3 are pairwise coprime. Substitution gives
the first identity in (SA2); multiplying the three quotient definitions
gives the second. Finally P(bar z)=-P(z), and the already established
actual cyclotomic identity T_n/T_1=|prod_{d|n,d>1}C_d| proves the last
assertions. There is no independence premise on the three quotient values:
they satisfy the displayed actual additive relation with small coefficients.

## SA2. A finite signed-credit inequality

Put

    c=max(|A|,|B|,|A+B|), t=log c,
    c_1=max(|a|,|b|,|a+b|), Delta=3t-log T_n.              (SA3)

All logarithms below are of positive integers or positive real numbers.
For a real cutoff Y>=5, define

    L(Y)=sum_{p<=Y} v_p(T_n) log p,
    S_i(Y)=sum_{p>Y} v_p(D_i) log p,
    R_i(Y)=sum_{p>Y,p|D_i} log p,
    E_i(Y)=sum_{p>Y} max(v_p(D_i)-2,0) log p.             (SA4)

Prime valuations of signed nonzero integers mean valuations of absolute
values. Empty sums are zero. Write

    log W_Y(M)=sum_{p>Y,p|M}(v_p(M)-3) log p.

**Theorem.** For every choice of distinct i,j,k in {1,2,3},

    log W_Y(T_n)
      <= Delta+log c_1+log T_1+L(Y)/2
         +(3/2)(E_i(Y)+E_j(Y))-3R_k(Y).                  (SA5)

Thus the third quotient may carry arbitrary private prime depths. Its
radical supplies negative credit in (SA5), and its entire multiplicity
has already been included in the inequality.

Proof. Each of the three output arms has absolute value at most c.
Since their logarithms sum to 3t-Delta, each individual arm has logarithm
at least t-Delta. The input arms are nonzero integers with absolute values
at most c_1. If M_i=log|D_i|, then

    t-Delta-log c_1 <= M_i <= t.                         (SA6)

Let L_i=M_i-S_i be the low-prime mass of D_i. Pairwise coprimality and
(SA2) give L_i+L_j<=L(Y). At each supported prime, writing e=v_p(D_i),

    e <= 2+max(e-2,0).

Consequently R_i>=(S_i-E_i)/2, and likewise for j. Since the D_i are
pairwise coprime, signed W is exactly additive on their product. Hence

    log W_Y(D_1 D_2 D_3)
      <= S_k-(S_i+S_j)/2+(3/2)(E_i+E_j)-3R_k.

By (SA6), S_k<=t and S_i>=t-Delta-log c_1-L_i; the analogous lower
bound holds for S_j. Their difference is at most Delta+log c_1+L(Y)/2.
Finally, for any two nonzero integers U,V, adding the U valuations to V
can increase log W_Y by at most log|U|. Indeed, at a prime already in V
it adds exactly v_p(U)log p; at a new prime it adds
(v_p(U)-3)log p<=v_p(U)log p. Apply this to T_n=T_1*|D_1 D_2 D_3|.
This proves (SA5), without requiring gcd(T_1,D_1 D_2 D_3)=1 and without
silently dropping negative credits at overlapping primes.

## SA3. Uniform control of the explicit error

Only at this step use the already independently reviewed logarithmic-form
input LR2 from `2026_09_07_independent_route/lambda_refinement.md`.
To meet LR2's positive-coordinate domain, first multiply z_n by a unit so that it lies in the open positive sector. Such a unit exists because no boundary arm is zero. Unit multiplication and conjugation only permute the absolute values of the three arms, so c, T_n, Delta and all prime valuations are unchanged. The rotated element still has an actual representation with ramified exponent zero, unit residual, and exponent g=n, using root w or bar(w), of the same norm Q. Thus its lambda is 1/n.
There are absolute effective constants A_1,A_2 such that

    Delta/t <= A_1 log(4n)/n,
    v_p(T_n)/t <= A_2 p^2 log^2(4n)/n.                  (SA7)

These bounds include all supported primes, including 2 and 3. They do
not depend on Q, on the moving root, or on its number of prime factors.
They are ordinary theorems using the previously stated external
logarithmic-form inputs, not new Lean theorems in this note.

The quadratic norm satisfies Q^n<=c^2 and Q>=(3/4)c_1^2, and the cubic
boundary satisfies T_1<=Q^(3/2). It follows that

    (log c_1+log T_1)/t <= 5/n.                          (SA8)

For completeness the numerator is at most 2log Q+log(2/sqrt(3)); divide
by t>=n log Q/2 and use Q>=7. The resulting constant
4+2log(2/sqrt(3))/log7 is strictly less than 5.
Also there are at most Y primes below Y and each p^2 log p<=Y^2 log Y,
so (SA7) gives

    L(Y)/t <= A_2 Y^3 log Y log^2(4n)/n.                 (SA9)

Combining (SA5)--(SA9), set

    epsilon(n,Y)=A_1 log(4n)/n+5/n
                 +(A_2/2)Y^3 log Y log^2(4n)/n.

Then

    log W_Y(T_n)/t
       <= epsilon(n,Y)
          +(3/(2t))(E_i+E_j-2R_k).                     (SA10)

For Y=n^(1/6), eventually Y>=5 and epsilon(n,Y) tends to zero,
uniformly in every actual moving root w of norm Q>=7.
This is a one-sided upper bound; it does not assert that the signed
quantity converges to zero from both sides.

## SA4. Two unrestricted-height cubefree arms suffice

**Corollary.** Along any sequence of actual roots and indices as above
with n tending to infinity, take Y=n^(1/6). Suppose that for each member
there exist two quotient arms D_i,D_j whose prime valuations are at most
two at every prime p>Y. No depth bound is imposed on the third quotient.
Then

    (log W_Y(T_n))_+/t -> 0                              (SA11)

uniformly within this class. Together with the previously proved low-prime
and archimedean absorption, this gives the required restricted ABC
estimate for this explicitly specified homogeneous subclass, uniformly for sufficiently large n for each fixed target epsilon. It does not settle the bounded-n domain with arbitrarily moving roots; finitely many indices do not mean finitely many seeds.

Proof. The hypothesis says E_i=E_j=0, so (SA10) is at most epsilon(n,Y),
even before using the additional nonpositive term -3R_k/t. The positive
part is bounded by that nonnegative error. The earlier absorption theorem
uses precisely this one-sided signed-tail conclusion.

More generally, the same conclusion follows under the strictly stated
sufficient condition

    (E_i+E_j-2R_k)_+/t -> 0.                            (SA12)

It permits positive excess in both of those arms if the private third-arm
radical pays for it. It does not require that the positive excess of the
third arm itself be sublinear. No general membership in (SA11)'s class
or (SA12) has been proved. In particular, a first-depth prime with an
arbitrarily large exponent in one actual arm does not by itself refute
this criterion; the other arms and their signed credits must be checked.

The criterion uses actual coupled integers, not independent sampled
factors. It is stronger than the desired general signed-tail theorem:
its proof discarded some shallow credits in the two selected arms.
Thus (SA12) is a sufficient target with additional arithmetic structure,
not an assertion that renaming the original unknown sum proves it.

## Dependencies and remaining work

SA1 uses only the actual Eisenstein ring, elementary polynomial divisibility,
and the previously established primitive-power and cyclotomic identities.
SA2 is an exact valuation and height inequality, valid before any asymptotic
or reference measure. SA3 uses the already reviewed LR2 theorem. SA4 gives
a rigorously proved class, with an open membership question.

The principal unresolved task is to constrain the actual three-arm excess
and radical jointly using their additive relation and common norm. We have
not proved that two arms are usually cubefree, have not removed exceptional
roots from earlier averaging windows, and have not controlled the general
private owner at primes larger than every such window. No global ABC proof
or disproof is claimed.

## Exact finite replay and an actual private-depth example

`replay.py` uses only Python integers, fractions, trial division and exact
polynomial coefficient operations. It checks six full polynomial quotient
identities (including composite indices 25 and 35), 113 actual primitive
unramified integer orbits, and 678 instances of (SA5). The latter are checked
after exponentiating twice, as an exact rational inequality; floating-point
logarithms are not used. The excluded ramified example w=1+zeta,n=5 has
D_1=D_2=D_3=-9 and confirms why the unramified hypothesis cannot be omitted.

One actual input is w=54345+zeta,n=5. Its three quotient values are

    D_1 = 8723250172224975295
        = 5 * 31^4 * 168541 * 11208719,
    D_2 = -43613843340380617649
        = -(571 * 640049 * 119336975731),
    D_3 = 8722287137346371431
        = 181 * 659 * 2131 * 263129 * 130411.

Every displayed factor is verified prime by complete trial division and
every product is checked exactly. Thus two actual quotient arms are
squarefree while the private prime 31 has depth four in the other arm.
This is a finite illustration of the retained compensation mechanism; it
is not an asymptotic family, does not prove generic cubefreeness, and does
not by itself settle a moving extreme-prime tail.

Canonical compact-payload SHA256:
`4292da9eb4d642cf99c5e7530e8d462f12da945887d96086d325c56a04d02e8f`.
Complete UTF-8 LF JSON byte SHA256:
`8e6a5da3fdc84d316ea2ef3cd98c74e6c111de04584e7e20a5706657f72f4132`.
The read-only `--check` mode recomputes every assertion and compares exact
canonical bytes. These finite checks corroborate the stated algebra and
inequality, not the separately invoked infinite logarithmic-form theorem.
