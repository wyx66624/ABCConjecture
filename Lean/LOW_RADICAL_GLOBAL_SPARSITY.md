# Global sparsity of integers with a small radical

## Status

This note gives a complete elementary proof of a global counting theorem that
is relevant to the low-radical-neighbour disproof route.  Its exact arithmetic
core is formalized in
`IUTThreeClosures/LowRadicalSquarefreeCore.lean`.

The full asymptotic cardinality estimate is not yet represented as a Lean
`IsBigO` theorem; the remaining work is finite-set bookkeeping and the standard
summation bound for `sum 1/t^2`.  No part of this note is used as an axiom by a
terminal abc theorem.

## Theorem

Fix a real number `sigma` with

```text
0 <= sigma < 1.
```

Let

```text
L_sigma(X) = #{1 <= n <= X : rad(n) <= n^sigma}.
```

Then

```text
L_sigma(X) = O_sigma(X^((1+sigma)/2)).
```

In particular, for every fixed `sigma<1`, low-radical integers have density
zero.

## Squarefree-square decomposition

Every positive integer has a unique decomposition

```text
n = s t^2,
```

where `s` is squarefree.  Prime by prime, if

```text
n = product_p p^(e_p),
```

then

```text
s = product_p p^(e_p mod 2),

t = product_p p^(floor(e_p/2)).
```

The squarefree factor divides the radical:

```text
s | rad(n),
```

and hence `s <= rad(n)`.

The companion Lean theorem uses the rational-power form.  If

```text
rad(n)^d <= n^e,     e <= d,
```

then

```text
s^(d-e) <= t^(2e).
```

Indeed,

```text
s^d <= rad(n)^d <= n^e
    = (s t^2)^e
    = s^e t^(2e),
```

and the positive factor `s^e` cancels.

## Real-exponent consequence

Assume now

```text
rad(n) <= n^sigma.
```

Since `s <= rad(n)` and `n=s t^2`,

```text
s <= (s t^2)^sigma.
```

Because `s>0` and `sigma<1`, this is equivalent to

```text
s^(1-sigma) <= t^(2 sigma),
```

so, with

```text
alpha = 2 sigma/(1-sigma),
```

we obtain

```text
s <= t^alpha.                                      (1)
```

The size condition `n<=X` also gives

```text
s <= X/t^2.                                        (2)
```

Consequently, for each fixed `t`, the number of possible positive squarefree
values of `s` is at most

```text
min(t^alpha, X/t^2).
```

Dropping squarefreeness only enlarges this upper bound.

## Splitting at the exact crossover

Put

```text
Y = X^((1-sigma)/2).
```

This is the solution of

```text
t^alpha = X/t^2.
```

For `t<=Y`, use (1).  Since `alpha>=0`,

```text
sum_{t<=Y} t^alpha <= Y^(alpha+1)
                    = X^((1+sigma)/2).             (3)
```

For `t>Y`, use (2):

```text
sum_{t>Y} X/t^2
  <= C X/Y
  = C X^((1+sigma)/2),                              (4)
```

where the absolute constant `C` follows from the integral estimate

```text
sum_{t>M} 1/t^2 <= 1/M.
```

Combining (3) and (4) proves

```text
L_sigma(X) = O_sigma(X^((1+sigma)/2)).
```

The exponent is obtained without smoothness assumptions and without any
probabilistic model.

## Consequences for the abc search

The deterministic neighbour transfer requires a strict budget

```text
gap exponent + centre-radical exponent + endpoint-radical exponent < 1.
```

The theorem above shows that endpoint candidates with radical exponent
`sigma<1` form a globally sparse set of size at most
`X^((1+sigma)/2)` up to `X`.  Therefore a short-interval proof must establish a
genuine correlation between these sparse integers and the chosen low-radical
centres.  A lower bound for the total number of smooth integers in an interval
does not provide this correlation.

The estimate does not prove that low-radical neighbours of perfect powers are
finite.  It is a global sparsity theorem, not a local gap theorem.  The local
existence or nonexistence problem remains the decisive analytic target.
