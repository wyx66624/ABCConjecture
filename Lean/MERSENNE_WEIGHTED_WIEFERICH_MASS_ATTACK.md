# Weighted Wieferich Mass in Mersenne Values: Four Offline Attacks and Exact Barriers

**Author:** ChatGPT  
**Status:** research note; unconditional reductions and counterexamples, not a
proof of the abc conjecture or of the Mersenne endpoint estimate.

## Abstract

For `M_m = 2^m - 1`, write `Q_m = M_m / rad(M_m)`.  The preceding exact LTE
analysis gives `Q_m = W_m I_m`, where `I_m | m` and

```text
W_m = product_{p | M_m} p^(v_p(2^(ord_p(2)) - 1) - 1).
```

Thus the endpoint triples `(1, M_m, 2^m)` require
`log W_m = o(m)`.  This note attacks that estimate in four directions:
cyclotomic order blocks, varying-prime p-adic logarithms,
resultants/discriminants and primitive multiplicity, and average-to-pointwise
upgrading.  No route currently proves the desired estimate.  We do obtain an
exact order-block decomposition and two clean sufficient criteria.  We also
give strict counterexamples to three common shortcuts: primitive factors need
not be squarefree, a simple polynomial root modulo `p` does not prevent a
fixed evaluation from vanishing modulo `p^2`, and even a
divisibility-monotone sequence can have normalized Cesaro mean zero while
having full-size values on an infinite subsequence.

## 1. Exact first-order blocks

For an odd prime `p`, put

```text
d_p = ord_p(2),
w_p = v_p(2^d_p - 1) = v_p(2^(p-1) - 1).
```

For every positive integer `d`, define the finite products

```text
E_d = product_{d_p=d} p^(w_p-1),
R_d = product_{d_p=d} p.
```

They are finite because `p | 2^d-1` implies `p <= 2^d-1`.  Every prime
dividing `M_m` has a unique order `d_p | m`, and conversely `d_p | m` implies
`p | M_m`.  Partitioning the prime factors by this unique order proves the
exact identity

```text
W_m = product_{d | m} E_d,                         (1.1)
log W_m = sum_{d | m} e_d,   e_d := log E_d >= 0. (1.2)
```

This is the correct non-redundant form of the problem.  A prime is recorded
once, at its first order, rather than once at every multiple of that order.

Since `d_p | p-1`, one has `p` not dividing `d_p`.  The standard cyclotomic
valuation formula then gives

```text
v_p(Phi_d(2)) = v_p(2^d-1) = w_p  when d_p=d.
```

Consequently

```text
R_d E_d | Phi_d(2).                                 (1.3)
```

There is a uniform archimedean estimate

```text
log Phi_d(2) = phi(d) log 2 + O(1).                 (1.4)
```

Indeed, Mobius inversion gives

```text
Phi_d(2) = 2^phi(d) product_{r|d}(1-2^(-r))^mu(d/r),
```

and the absolute logarithmic error is bounded by the convergent constant

```text
C_0 = sum_{r>=1} -log(1-2^(-r)).
```

Equations (1.3)--(1.4) prove only

```text
e_d <= phi(d) log 2 + C_0.                           (1.5)
```

Summing (1.5) over `d | m` and using
`sum_{d|m} phi(d)=m` returns a linear bound.  It does not approach `o(m)`.

### 1.1 What Zsigmondy does and does not buy

Apart from its standard small exception, Zsigmondy supplies at least one
primitive prime at level `d`; it is at least `d+1`.  Thus it removes at least
`log(d+1)` from the right side of the size budget for that block.  For prime
`m`, however, there is only the nontrivial level `d=m`.  The resulting bound
still permits

```text
e_m <= m log 2 - log(m+1) + O(1),                   (1.6)
```

which has the full exponential rate.  This is a quantitative obstruction,
not a claim that (1.6) is attained.  It proves that one-new-prime existence
and the congruence `p=1 mod d`, by themselves, cannot yield the required
subexponential upper bound.

### 1.2 Two surviving positive targets

The first clean sufficient condition is

```text
sum_{d<=X} e_d = o(X).                               (1.7)
```

Because all `e_d` are nonnegative, (1.2) immediately gives

```text
log W_m <= sum_{d<=m} e_d = o(m).
```

This is a genuine average-to-uniform upgrade because it averages the mass at
its first order, without repeated counting.

A different sufficient condition is a uniform power saving in each block:
for some fixed `0<delta<=1`,

```text
e_d = O(d^(1-delta)).                                (1.8)
```

Then

```text
log W_m
  = sum_{d|m} e_d
 <= C tau(m) m^(1-delta)
  = m^(1-delta+o(1))
  = o(m),                                            (1.9)
```

using the standard divisor bound `tau(m)=m^o(1)`.  Neither (1.7) nor (1.8)
is presently proved for the values `Phi_d(2)`.  They are explicit new
number-theoretic targets, not assumptions hidden inside the Lean model.

The companion Lean module proves the finite certificate underlying (1.9):
if every mass on `d | m` is at most `B` and
`tau(m) B <= epsilon m`, then the divisor-restricted mass is at most
`epsilon m`.

## 2. Varying-prime p-adic logarithms

At a first order `d=d_p`, divisibility gives the exact elementary size bound

```text
p^w_p <= 2^d-1,             p >= d+1.                (2.1)
```

Equivalently,

```text
w_p log p <= d log 2.                                (2.2)
```

The Lean theorem `orderLowerBound_pow_le_twoPow_sub_one` records (2.1)
without logarithms.  Summing (2.2) over exact-order primes merely recovers
the cyclotomic budget (1.5).  It has the wrong scale.

Even a hypothetical uniform constant bound `w_p <= B` would not be enough.
For `1 <= w <= B`,

```text
(w-1) log p <= (1-1/B) w log p.
```

Thus such a hypothesis gives at best

```text
e_d <= (1-1/B) log Phi_d(2) + O(1),                  (2.3)
```

still a positive linear multiple of `phi(d)` when `B>1`.  The case `B=1`
would solve the block by declaring it squarefree, but it is false: `1093`
already has `w_1093=2`.

General p-adic linear-form bounds with constants depending strongly on `p`
do not close the sum, because here `p` varies through primes as large as the
cyclotomic value.  A surviving p-adic route must produce genuinely uniform
*weighted distribution* information, for example (1.7), (1.8), or another
estimate that bounds

```text
sum_{d_p=d} (w_p-1) log p
```

with a sublinear saving.  No strict counterexample rules out such a new
varying-prime theorem, so this route remains open.  What is retired is the
claim that an individual valuation ceiling or a fixed constant ceiling alone
implies the required aggregate estimate.

## 3. Resultants, discriminants, and primitive multiplicity

Cyclotomic resultants are effective for separating different levels.  Once
the factors are grouped by exact order, that job has already been completed
in (1.1).  A resultant does not control repeated powers within one fixed
integer value `Phi_d(2)`.

The discriminant also answers a different question.  Let

```text
f(X)=X^364-1,  p=1093.
```

Direct certified arithmetic gives

```text
p^2 | f(2),
p does not divide f'(2)=364*2^363.                   (3.1)
```

Thus `2 mod p` is a simple root, while the particular integer lift `2` still
hits that root modulo `p^2`.  This is a strict counterexample to the proposed
inference

```text
simple root modulo p  ==>  p^2 does not divide f(2).
```

There is no conflict with Hensel's lemma: a simple root has a unique lift,
and in this instance the fixed integer is congruent to that lift.

Furthermore,

```text
ord_1093(2)=364,
1093^2 | 2^364-1,
1093 does not divide 364.                            (3.2)
```

Hence the square is genuinely at the primitive/order level.  It is neither a
common factor imported from a lower cyclotomic level nor an LTE contribution
from the index.  This strictly retires both “primitive factors are
squarefree” and “the cyclotomic discriminant controls the valuation of the
fixed evaluation.”

No example in (3.1)--(3.2) rules out a deep upper bound for the *total* mass
over many levels.  Product-formula or determinant methods remain alive only
if they add a new estimate for fixed-lift p-adic closeness; their standard
separation and ramification statements are already exhausted by (1.1)--(1.3).

## 4. Why an ordinary average does not upgrade to every `m`

From (1.2), finite double counting gives the exact incidence identity

```text
sum_{n<=X} log W_n
  = sum_{d<=X} floor(X/d) e_d.                        (4.1)
```

This shows two opposite problems.  First, an estimate
`sum_{n<=X} log W_n=o(X)` is impossible: the single order-level square at
`d=364` contributes at least

```text
floor(X/364) log 1093
```

to (4.1).  Second, a natural quadratic-scale average such as `o(X^2)` is too
weak to exclude isolated linear-size spikes.

Divisibility monotonicity does not repair the second problem.  Here is a
strict infinite counterexample.  For `n>=1`, define

```text
A(n)=2^v_2(n).
```

If `a | b`, then `v_2(a)<=v_2(b)`, so `A(a)<=A(b)`.  Nevertheless

```text
A(2^j)=2^j
```

for every `j`; hence `A(n)/n` does not tend to zero pointwise.

Its normalized Cesaro mean does tend to zero.  Every positive integer has a
unique expression `n=2^j q` with `q` odd, and then `A(n)/n=1/q`.  Therefore

```text
sum_{n<=X} A(n)/n
  = sum_{0<=j<=log_2 X} sum_{q<=X/2^j, q odd} 1/q
 <= (1+floor(log_2 X)) (1+log X).                    (4.2)
```

The last inequality uses the elementary harmonic bound
`sum_{q<=Y}1/q <= 1+log Y <= 1+log X`.  Dividing (4.2) by `X` gives

```text
(1/X) sum_{n<=X} A(n)/n = O((log X)^2/X) -> 0.        (4.3)
```

Thus even nonnegativity, persistence along multiples, and a vanishing
Cesaro mean of the normalized values do not imply a pointwise `o(n)` bound.
The Lean module proves `A(a)<=A(b)` for `a|b`, its exact value on powers of
two, and the odd-part decomposition.  The harmonic estimate (4.2)--(4.3)
is currently paper-only.

The average route that survives this counterexample is (1.7), an average of
the non-repeated first-order masses `e_d`, or another estimate strong enough
to bound every divisor-restricted sum in (1.2).

## 5. Exact boundary after the four attacks

No unconditional proof of `log W_m=o(m)` has been obtained.  The following
specific shortcuts are now closed by proof or strict counterexample:

1. one primitive prime per order plus `p=1 mod d` gives only the
   quantitatively inadequate bound (1.6);
2. a uniform bound `w_p<=B>1` leaves a positive linear exponent in (2.3);
3. primitive/order-level squarefreeness is false by (3.2);
4. discriminant or simple-root tests do not control a fixed evaluation, by
   (3.1);
5. ordinary Cesaro averaging plus divisibility monotonicity does not upgrade
   to a pointwise bound, by (4.2)--(4.3).

The following routes remain mathematically open because no strict
counterexample rules them out:

1. a uniform power saving (1.8) for powerful parts of the exact-order portion
   of `Phi_d(2)`;
2. the first-order cumulative estimate (1.7);
3. a new varying-prime p-adic logarithm theorem controlling the weighted sum,
   rather than each valuation separately;
4. a product-formula argument that quantitatively controls the fixed-lift
   closeness missing from resultants and discriminants.

Any one of the first two would settle the complete Mersenne endpoint family
after the already-proved harmless factor `I_m | m`.  At present they should
be treated as precise research targets, not as established lemmas.

## 6. Lean coverage

`IUTThreeClosures/MersenneWeightedWieferichMass.lean` proves:

1. arbitrary-prime-power persistence from exponent `d` to `d*k` when
   `p` does not divide `k`;
2. the exact elementary size budget `p^e <= 2^d-1` and its order-congruence
   consequence `(d+1)^e <= 2^d-1`;
3. the certified simple-root/square-lift counterexample at `1093`;
4. an explicit divisibility-monotone delayed-spike family;
5. divisibility monotonicity and exact odd-part values of the infinite
   two-adic spike model;
6. the finite nonnegative order-block mass certificate used by the positive
   target (1.9).

The cyclotomic product identity (1.1), the analytic estimate (1.4), the
divisor-function asymptotic used in (1.9), and the harmonic/Cesaro proof
(4.2)--(4.3) remain paper-level.  No theorem assumes abc, `log W_m=o(m)`, a
Wieferich sparsity conjecture, or a target estimate as a structure field.
