# Ordinary proof before the finite density formalization

The complete DG1--DG4 ordinary proof has root, adversarial and independent
full reviews, including the primary Selberg theorem. The selected finite
core below is intended for PrivateDensityMass.lean. It does not formalize
the full sieve, asymptotics, ideal valuations or prime-value distribution.

## Actual cofactor polynomial

For integers b,m,c satisfying 9b^2+3b+1=mc, the actual cofactor
polynomial is 9m t^2+(18b+3)t+c. Multiplication by m gives
Q(b+mt), and its discriminant is exactly -27. Both conclusions follow
by expansion and the displayed equality. They do not assert the local
prime-root counts or invertibility when m is zero.

## A finite mass cut with actual exceptional indices

Let s be a finite index set, e an actual exceptional subset of s, and
w_i nonnegative real weights on s. Suppose every weight is at most U,
and every weight outside e is at most U-epsilon, with epsilon>=0.
Then, term by term on s,

    w_i <= U-epsilon+epsilon*1_(i in e).

Summing gives total mass at most (U-epsilon)|s|+epsilon|e|.
No independence or probabilistic distribution is used. In the actual
DG application s is private norm support, e its intersection with the
extreme-prime set, U=2logB+log49; harmless additive height terms may be
paid separately. This is an actual finite sum, not a mass number whose
connection to indices is silently assumed.

More generally, if s is contained in an ambient finite set and the
complete supported mass has lower bound B*l-error, while nonexceptional
weights are at most (2-epsilon)l and exceptional weights at most
2l+c, its total is at most

    (2-epsilon)|s|l+epsilon|e|l+c|s|,

provided l,c,epsilon are nonnegative. Combining the lower bound with
|e|<=C0*epsilon*B+remainder and |s|<=B gives the corresponding finite
density inequality. Taking limits is a separate ordinary step.

The numerical strict-gain step is exact algebra: if 0<epsilon<=1/10,
C0>=0 and C0*epsilon<=1/4, then

    (1-C0*epsilon^2)/(2-epsilon)
      >=1/2+epsilon/(4*(2-epsilon))>1/2.

The eventual lower bound used in DG is obtained by spending half this
strict gain on the explicit o(1) errors. A formal finite version can
retain that error and assume it is at most epsilon/8, yielding
at least 1/2+epsilon/(8*(2-epsilon)). No eventual estimate for the
actual arithmetic errors is assumed discharged by that lemma.

## A finite weighted cutoff lemma

Let a finite set of actual positive natural integers carry nonnegative
weights. If the sum of weight times log(index) is at most half log(z)
times total weight, with z>1, then the total weight on indices at most z
is at least half the total. Indeed each index above z contributes at
least log(z) times its weight to the moment, while all other terms are
nonnegative. Divide by positive log(z) and use the exact partition of
the finite set. This is the deterministic finite weighted inequality
used for the auxiliary Selberg denominator. It does not construct the
Euler-product weights or prove their analytic moment estimates.

Only the listed algebraic, actual finite-index and finite weighted
statements are proposed here. Every arithmetic and analytic input
remains explicit and will be described that way in the final paper.
