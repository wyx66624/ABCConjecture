# Prime 37 fixed-index feasibility scout

## 0. Decision and trust boundary

This note records a bounded feasibility scout for the fixed-index curve

```text
y^2 = 4*T_37(X)+5,       X>1,       X=23 (mod 24).
```

The arithmetic and finite-field statements explicitly labelled exact below
were replayed with exact integer, polynomial, or finite-field arithmetic.  The
class group returned by exploratory PARI `bnfinit`, the provisional global
squareclass basis, the Stoll precision run, and the Coleman estimates are
discovery data rather than proof interfaces.  In particular, this note does
not close index 37 and is not imported by Lean.

The operational decision is negative: do **not** clone the existing p29/p31
full BDF factor-base pipeline at p37.  Its projected factor base has billions
of ideals.  The smallest missing global input is instead the compact statement

```text
Cl_S(Q(2^(1/37)))[2] = 0.
```

Until that input has an unconditional proof or frozen exact certificate, no
discovered 24-dimensional squareclass list may be called complete.

## 1. Exact field and bad-place arithmetic

Put `K=Q(a)`, `a^37=2`.  The exact congruence

```text
2^36 = 38 (mod 37^2)
```

excludes the pure-field index obstruction at 37; together with the
2-Eisenstein calculation it gives the expected integral basis and invariants

```text
O_K = Z[a],
signature(K) = (1,18),
|disc(K)| = 2^36 * 37^37.
```

The primes 2 and 37 are totally ramified.  The exact factorization degrees of
`x^37-2` modulo 3 are

```text
(1,18,18).
```

Thus the set above `{2,3,37}` has `|S|=5`.  Conditional on
`Cl_S(K)[2]=0`, the standard S-unit exact sequence would give

```text
dim_F2 K(S,2) = 1 + 18 + 5 = 24.
```

PARI found a candidate trivial class group quickly.  This is not a proof:
`bnfcertify` did not finish in a 30-second probe and reported a Zimmert bound
of about `2.72e21`.

## 2. Why the full BDF route is not presently viable

The exact Belabas--Diaz y Diaz--Friedman Corollary 5.2 triangle-kernel scout
gave the following full margins:

| strict cutoff `T` | full margin |
|---:|---:|
| `40,000,000` | `-16.8621...` |
| `80,000,000` | `-15.2806...` |
| `160,000,000` | `-13.7134...` |
| `320,000,000` | `-12.1591...` |

At `T=320,000,000`, the exact factor-base counts are

```text
rational primes:       17,275,206
degree-one ideals:     17,279,007
all prime ideals:      17,280,127
degree counts:         {1:17279007, 2:1008, 3:84, 4:18, 6:6, 9:4}.
```

Successive doublings improve the margin by about `1.55`, tending toward the
asymptotic increment `2*log(2)`.  A planning extrapolation places the first
positive cutoff around `0.7e11` to `1.5e11`; this is not a certified cutoff.
It corresponds to roughly three to six billion prime ideals.  Linear scaling
from the p31 certificate predicts several weeks on 16 workers and roughly
`130--260 GB` of compressed output.  The scout therefore rules out this
implementation strategy, not the class-group statement itself.

## 3. Conditional descent dimensions and the missing local plane

Using the 24 exact algebraic elements discovered by PARI only as candidates,
exact norm and 3-adic Hilbert-symbol linear algebra gives

```text
norm matrix:                    24 x 4,   rank 4
three 3-adic detection blocks: 24 x 72,  rank 6
3-adic image of the norm kernel:            rank 4
span of the two endpoint classes:        dimension 1.
```

The last line exposes a genuine difference from p31.  Since
`x^37-2 (mod 3)` has three irreducible factors,

```text
dim_F2 J(Q_3)/2J(Q_3) = 2.
```

Hence the endpoint line cannot be identified with the complete local Kummer
image.  A formal p37 descent must construct a full two-dimensional 3-adic
Kummer plane.  If that plane supplies the expected two independent conditions,
the global over-approximation is predicted to have dimension 18.  This
prediction is not used as a theorem.

The unique dyadic completion has degree 37 and squareclass dimension 39.  The
natural finite certificate would therefore consist of a `24 x 39` global
matrix, an `18 x 39` restricted matrix, and an invertible `18 x 18` pivot
minor.  A preliminary computation did not finish within 2.5 minutes; scaling
from p31 suggests tens of minutes to roughly one hour, so this is not the main
bottleneck.

## 4. Stoll and Coleman scouts

The exact endpoint Cantor composition needs nine reductions and ends with
Mumford `A` of degree 18.  Because the genus is even, the endpoint descent
sign differs from the p31 computation.

A discovery-only 2400-bit Stoll recursion visited all 48 shell nodes and gave

| shell | maximum depth | minimum identity valuation |
|---:|---:|---:|
| `m=3` | 5 | 1315 |
| `m=4` | 6 | 888 |
| `m=5` | 7 | 1200 |

The shell depths remain `(5,6,7)` and the tail equality `2*5-3=7` survives.
No terminal membership test in the actual global image was performed, so this
is not a Stoll certificate.  If the class-group gate closes, 5000-bit
precision is the first sensible formal run; 6000 bits should be used only if
the certified valuation margin requires it.

At the Coleman prime 5, exact finite-field checks give good reduction and

```text
C(F_5) = {infinity, (0,0), (1,+/-1), (4,2), (4,3)}.
```

The reduction has one simple Weierstrass root, at `x=0`.  A formal diskwise
Coleman certificate must still check a rank-two endpoint logarithm matrix, a
unit `2 x 2` minor, and a common annihilating differential nonzero at all six
residue points.  The small-prime global point-count inequality is unavailable
because `5 <= 2g`; the p29/p31 diskwise difference-quotient argument is the
relevant interface.  No such terminal certificate has yet been computed.

## 5. Interaction with the modulo-five and Frobenius routes

For p37, the exact function identity over `F_5` is

```text
T_37(X) = X.
```

The shifted-square equation modulo five therefore leaves precisely
`X=0,+/-1 (mod 5)`.  Combining this with `X=23 (mod 24)` leaves

```text
X = 71, 95, or 119 (mod 120).
```

Thus the modulo-five sieve is useful but does not close p37.  The exact base
`X=239=119 (mod 120)` is especially instructive: the quotient `H_18(239)`
has four prime factors, all congruent to `+/-1 (mod 5)` and all occurring to
valuation one.  It passes the base sieve while refuting any pure assertion
that every p37 quotient has an inert primitive divisor.  Its shifted-square
right side is `6 (mod 13)`, so it is not a point on the curve and does not
help the Stoll--Coleman terminal calculation.

## 6. Archived reactivation conditions

This is not part of the current prime-by-prime program.  The following list
only records what a future fixed-index certificate would require if a compact
class-group proof made the route unexpectedly cheap:

1. Find a compact unconditional proof or exact certificate for
   `Cl_S(K)[2]=0`; do not produce the multi-billion-row BDF table first.
2. Construct the complete two-dimensional 3-adic Kummer image and recompute
   the actual global space `W`.
3. Freeze the dyadic injectivity matrix and terminal membership test.
4. Run the complete 5000-bit Stoll computation, increasing precision only if
   a strict margin check requires it.
5. Scout the Coleman rank and unit values at low precision before committing
   to the estimated five-to-eight-hour formal run.

Closing these five steps would remove only the fixed index 37 and move the
uniform residual to p at least 41.  It would not by itself prove the uniform
prime-index exclusion or `abc`.
