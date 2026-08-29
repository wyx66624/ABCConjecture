# ABC core interface v12: coefficient three, balance defect, and the endpoint core

## 1. Purpose

This note concentrates the proof search on one actual arithmetic obstruction.
It does not introduce a structure whose field is `ABCConjecture`, a Frey
height bound, a Vojta inequality, or the desired conclusion.  The theorems in
Sections 2--4 are elementary consequences of a primitive positive equation

```text
a + b = c.
```

Their Lean formalization is in
`IUTThreeClosures/BalanceDefectCoefficientTransfer.lean`.

The main conclusion is that a coefficient-three estimate for
`log(a*b*c)` already gives the coefficient-one abc estimate on every
logarithmically balanced triple.  The entire coefficient loss is exactly the
endpoint quantity

```text
log(c / min(a,b))
```

up to the absolute additive constant `log 2`.

## 2. Exact balance-defect corridor

Put

```text
h = log c,
p = log(a*b*c),
m = min(a,b),
D = 3h - p.
```

Since the other summand is at most `c`,

```text
a*b*c <= m*c^2.                                      (2.1)
```

Since the other summand is at least `c/2`,

```text
m*c^2 <= 2*a*b*c.                                    (2.2)
```

Both inequalities are sharp up to the factor two.  Taking logarithms gives

```text
p <= log m + 2h,
log m + 2h - log 2 <= p.
```

After subtracting from `3h`,

```text
h - log m <= D <= h - log m + log 2.                 (2.3)
```

Thus `D` is not an opaque IUT or Frey error term.  It is, within `log 2`, the
ordinary endpoint imbalance of the triple.

## 3. General coefficient transfer

Assume pointwise estimates

```text
p <= lambda*q + E,
D <= delta*h + K,
q = log rad(a*b*c),
delta < 3.
```

The identity `3h=p+D` gives

```text
(3-delta)h <= lambda*q + E + K,
```

hence

```text
h <= (lambda*q + E + K)/(3-delta).                   (3.1)
```

Using (2.3), it is enough to control the endpoint defect:

```text
h - log m <= delta*h + K.
```

The resulting bound is

```text
h <= (lambda*q + E + K + log 2)/(3-delta).           (3.2)
```

No conjectural arithmetic statement is used in this transfer.

## 4. Exact coefficient-three specialization

Fix a target `epsilon>0` and choose

```text
delta  = 3*epsilon/(2*(1+epsilon)),
lambda = 3*(1+epsilon/2).
```

A direct calculation gives

```text
lambda/(3-delta) = 1+epsilon.                         (4.1)
```

Consequently, if a point satisfies

```text
p <= 3*(1+epsilon/2)*q + E                            (4.2)
```

and

```text
log m >= (1-delta)h-K,                                (4.3)
```

then

```text
h <= (1+epsilon)q
     +(E+K+log 2)/(3-delta).                          (4.4)
```

This proves the coefficient-one abc inequality on the balanced region without
requiring a coefficient-two estimate for `p`.

## 5. The remaining arithmetic core

After (4.4), a coefficient-three product theorem leaves only triples with

```text
min(a,b) < exp(-K)*c^(1-delta).                       (5.1)
```

After interchanging `a` and `b`, this is the small-summand regime

```text
a << c^(1-delta),
b = c-a.
```

The endpoint family `(1,n,n+1)` shows that this regime cannot be removed by a
better universal algebraic comparison between `log(a*b*c)` and `log c`.
The missing information has to control repeated prime powers in the two nearby
integers `n` and `n+1`, or supply an equivalent pointwise Frey/Vojta estimate.

This is also why a bounded shear does not finish the argument by itself.  For
fixed `u`, the fourth form

```text
d_u = c-u*a
```

has pairwise gcd with `a,b,c` bounded by the fixed resultants `u` and `u-1`,
but its radical can still be as large as its full size.  A uniform level-one
truncated estimate for

```text
a, b, c, d_u
```

would prove abc, but the required truncation is precisely new arithmetic
content rather than a consequence of the gcd identities.

## 6. Relation to current unconditional results

Current one-parameter modular methods give subexponential Szpiro/abc estimates
in families, including an endpoint-shaped Frey regime, but not the linear
coefficient-one logarithmic bound required in (5.1).  See Cuevas Barrientos and
Pasten, arXiv:2504.15971.

The best current exceptional-set estimates show that abc failures are sparse,
but do not turn this into a pointwise theorem without an amplifier whose orbit
beats the exceptional exponent and has controlled overlap.  See Browning,
Lichtman, and Teräväinen, arXiv:2410.12234, and Lichtman's exposition
arXiv:2505.13991.

Average Szpiro theorems for elliptic curves with prescribed rational torsion
and average prime-divisor results for polynomial sequences likewise do not
supply a worst-case bound on the Frey locus or on every pair of nearby
integers.  Relevant primary sources include Chan, arXiv:2407.13850, and Tao,
arXiv:2603.12112.

## 7. Research decision

The next proof search should not attempt to replace the endpoint core by a new
abstract certificate.  It should attack one of the following concrete forms
of the same arithmetic statement:

1. a varying-support, level-one four-linear-form truncation for
   `a,b,c,c-u*a`;
2. a pointwise modified-Szpiro/Frey-j estimate on the small-summand locus;
3. a direct radical estimate for nearby integers strong enough to control
   (5.1);
4. an explicit amplifier producing sufficiently many further bad triples from
   one endpoint counterexample while preserving radical slope.

The v12 theorem is a genuine narrowing: the balanced half is closed at the
correct coefficient, and no coefficient-two symmetric-product theorem is
needed there.  It is not yet an unconditional proof of abc.
