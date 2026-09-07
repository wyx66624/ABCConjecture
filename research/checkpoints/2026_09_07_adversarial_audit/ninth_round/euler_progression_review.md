# Independent review of the general-exponent totient budget

Date: 2026-09-07. EP1--EP4 complete ordinary review: PASS.
No mathematical correction was required.

The complete reviewed source is
`2026_09_07_independent_route/ninth_round/euler_progression_compatibility.md`,
SHA256
`b1e56d81d9dfe9760911fe3c04c229cd2ddfde532253a7bd2159877014cd9d9a`.
Only this review was written by the reviewer. The CE, SA, AC and PP
dependencies have separately passed complete independent ordinary reviews.

## General cyclotomic valuations

The actual application assumes positive primitive a,b, positive integer
R,Q, n>1 and gcd(n,6)=1, hence odd n>=5. EP1 itself correctly allows
any odd n>1 and coprime positive X>Y. A prime dividing XY cannot divide
the top factor, by its extreme coefficients and coprimality.

For an odd prime q, the residue order d divides q-1 and is q-coprime.
The binomial proof of the valuation formula is valid even at q=3:
for u>=1, all terms after q(B-1) have valuation at least u+2.
The prime-to-q exponent multiplies by a geometric sum which is a unit.
Thus all positive indices m have the stated valuations of X^m-Y^m.

The proposed values for v_q(Phi_e) give exactly those divisor sums:
when d divides m, index d contributes u and each d*q^j dividing m
contributes one. Since q does not divide d, their count is v_q(m/d).
When d does not divide m none contributes. Induction on the index
therefore proves the complete list, including d=1. This argument does
not assume in advance that the supported index n is a prime power.

At a bad supported prime the n=d case is excluded because it would
give n dividing q-1. Hence n=d*q^j with j>=1, and the valuation is
one. Every prime divisor of d is less than q, because d divides q-1.
Consequently q is exactly the largest prime divisor P of n. There
cannot be two distinct exceptional primes. The conclusion is the full
bad part dividing P, retaining the exceptional depth instead of omitting it.

At q=2, opposite parity makes every X^m-Y^m odd. If both are odd,
every odd m has the same 2-adic depth as X-Y. Induction using only
the odd divisors of m gives zero depth at all odd indices n>1.
No even-index valuation formula is implicitly used here.

## Archimedean factor and kappa

For n>2 every primitive root has a distinct conjugate. The identity

    |X-Y*zeta|^2-Y^2|1-zeta|^2
      =(X-Y)^2+2Y(X-Y)(1-Re(zeta))

is exact and nonnegative for X>Y>0. Pairwise multiplication gives
Phi_n(X,Y)>=Phi_n(1)*Y^phi(n), with a positive left side.
The value at one follows by induction from the product over all
divisors greater than one. Proper prime-power indices account for
every prime-power part of a non-prime-power n, while at n=p^j they
contribute p^(j-1). Thus L=P for a prime power and L=1 otherwise.
In particular kappa=P/L is an integer, at least one and at most n.

## Actual full support and the rank-one branch

Actual primitivity and the norm-difference identity give gcd(Q,R)=1
and Q>R^2. The top factor T and complementary factor C are positive
integers, and T*C=ab*c^2. Complete bad-prime allocation gives
U=(ab*c^2)_bad(n) dividing P*C. The direct lower bound for T and
the four-ninths identity yield

    U<=4*kappa*R^(2(n-phi(n)))/9.

Because c_bad(n)^2 divides U, this proves the first squared bound.
There is no claim that the other factors forming C are radical-free
or supported only at bad primes.

The actual root exists because n is coprime to six and its pure first
norm excludes the ramified prime. The unit is absorbed into the root.
For n=1 modulo six the chosen arm is x+y; for n=5 modulo six it is
x after the specified conjugation. Thus c=ell*D_j and 3ell^2<=4R.

A new bad prime q=1 modulo n but not 1 modulo 6n is inert, greater
than n, and coprime to R. Its boundary rank divides both n and
(q+1)/3. Since q+1=2 modulo n and n is odd, gcd(n,q+1)=1. This
forces rank one for every allowed n, not just prime-power n. The
exact valuation formula gives v_q(T_n)=v_q(T_1), and the integral
quotient arms have nonnegative depths summing to zero. Therefore
v_q(c)=v_q(ell) at full depth, giving J dividing |ell|.

The disjoint prime supports give the exact product
c_bad(6n)=c_bad(n)*J. Multiplication yields

    27*c_bad(6n)^2<=16*kappa*R^(2(n-phi(n))+1).

In deriving the strict real estimate, the power of R in the
denominator is 2(n-phi(n))+1, which is always positive. Hence
substituting R<c^(2/n) gives the claimed strict lower bound even
when the resulting total exponent of c is nonpositive. Taking
logarithms preserves the full valuation sum and the kappa constant.

## Forced good support under the totient condition

With rho=2phi(n)-n-1, oddness of n makes rho even. If rho>0 it is
at least two. The actual common-exponent root budget gives
R^2>=9n/4>1. Combining c^2>R^n with the squared bad bound gives

    c_good(6n)^2 > 27*R^rho/(16*kappa)
                    >=243*n/(64*kappa)>=243/64>1.

All directions and constants are correct. There is consequently an
actual prime divisor of the good part, at least 6n+1. This is not an
assertion that every divisor of c lies in that progression. For n=p^k,
p>=5, rho=n(1-2/p)-1>=2, so the stated prime-power inclusion holds.
Any suitable divisor of two unequal exponents can be used by replacing
the bases with positive integer powers. Failure of the totient condition
does not invalidate the budgets; only this particular support-existence
argument is then unavailable.

## Scope retained

The cyclotomic and root-pair estimates are proved within the ordinary
argument. The imported rank/LTE and actual factorization ingredients
remain ordinary mathematical inputs, with no new formalization claimed
by this review. The surviving support may carry large valuations, and
the root budget is a lower height bound. No radical lower bound,
uniform point-height upper bound, existence theorem, or ABC contradiction
is obtained. Nonunit residuals, ramified first norms, and exponent pairs
without a suitable common divisor remain distinct open cases.
