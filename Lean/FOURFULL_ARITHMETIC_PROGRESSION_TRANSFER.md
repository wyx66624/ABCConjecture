# Four-full three-term arithmetic progressions and the abc conjecture

**Author:** ChatGPT  
**Status:** unconditional deterministic transfer theorem.  No infinite family
of four-full arithmetic progressions is asserted.

## 1. Motivation and scope

Recent constructions of three-term arithmetic progressions of powerful
integers naturally suggest the primitive equation

```text
x + z = 2y.
```

A positive integer is called `r`-full when every prime in its support occurs
with exponent at least `r`.  Such an integer satisfies

```text
rad(n)^r <= n.                                      (1.1)
```

The purpose of this note is to determine exactly when an unbounded family of
`r`-full arithmetic progressions would cross the abc threshold.  The answer is
sharp at the elementary exponent level:

```text
3/r < 1.
```

Thus powerful (`2`-full) progressions do not suffice, `3`-full progressions are
critical but still insufficient, and `4`-full progressions would disprove abc
provided the resulting triples are primitive and unbounded.

The companion Lean development formalizes the radical-compression statement
that is actually used.  It does not assume the existence of an infinite
four-full family.

## 2. Primitive abc point attached to an arithmetic progression

Let `x,y,z` be positive integers satisfying

```text
x + z = 2y                                             (2.1)
```

and assume

```text
gcd(x,2y)=1.                                           (2.2)
```

Define

```text
a=z,     b=x,     c=2y.
```

Then `a+b=c`.  Moreover, from `z=2y-x`, Euclid's algorithm gives

```text
gcd(z,x)  = gcd(2y,x) = 1,
gcd(z,2y) = gcd(x,2y) = 1.
```

Together with (2.2), this proves that `(z,x,2y)` is a primitive abc triple.
The condition `gcd(x,2y)=1` in particular forces `x` and `z` to be odd, but no
parity assumption on `y` is needed.

## 3. The fixed coefficient two is harmless

For all positive integers `y`, radical submultiplicativity gives

```text
rad(2y) <= rad(2) rad(y) = 2 rad(y).                   (3.1)
```

The factor `2` therefore contributes only the additive constant `log 2` after
taking logarithms.  It must not be silently discarded in a finite statement,
but it is harmless in an unbounded family.

## 4. The four-full transfer theorem

Assume in addition that

```text
rad(x)^4 <= x,
rad(y)^4 <= y,
rad(z)^4 <= z.                                        (4.1)
```

Every positive four-full integer satisfies (4.1) prime by prime.  By radical
submultiplicativity and (3.1),

```text
rad(z*x*2y)
  <= rad(z) rad(x) rad(2y)
  <= 2 rad(z) rad(x) rad(y).                           (4.2)
```

Since `x,z<c=2y` and `y<=c`, (4.1) implies

```text
rad(x) <= c^(1/4),
rad(y) <= c^(1/4),
rad(z) <= c^(1/4).
```

Consequently

```text
rad(z*x*2y) <= 2 c^(3/4),                              (4.3)
```

or in logarithmic form,

```text
log rad(z*x*2y) <= (3/4) log c + log 2.                (4.4)
```

### Theorem 4.1

Suppose there is an unbounded sequence of positive triples `(x_n,y_n,z_n)`
satisfying (2.1), (2.2), and (4.1).  Then the abc conjecture is false.

### Proof

Assume abc.  Apply it with `epsilon=1/6` to the primitive triple
`(z_n,x_n,2y_n)`.  There is a constant `C` independent of `n` such that

```text
log(2y_n)
 <= (7/6) log rad(z_n*x_n*2y_n) + C.
```

Using (4.4),

```text
log(2y_n)
 <= (7/6) ((3/4) log(2y_n) + log 2) + C
  = (7/8) log(2y_n) + (7/6) log 2 + C.
```

Hence

```text
(1/8) log(2y_n) <= (7/6) log 2 + C,
```

contradicting unboundedness.  Therefore abc cannot hold.  QED.

## 5. General `r`-full threshold

The same proof with

```text
rad(x)^r <= x,
rad(y)^r <= y,
rad(z)^r <= z
```

gives

```text
log rad(z*x*2y) <= (3/r) log c + log 2.                (5.1)
```

An abc parameter `epsilon>0` can leave a strict positive gap precisely when

```text
(1+epsilon) 3/r < 1,
```

which is possible exactly when

```text
r>3.                                                   (5.2)
```

Therefore:

- `r=2` (ordinary powerful numbers): exponent `3/2`, far above the threshold;
- `r=3`: exponent `1`, a critical equality that cannot absorb the abc factor
  `1+epsilon`;
- `r=4`: exponent `3/4`, the first uniform full-power level that crosses the
  threshold;
- every `r>=4`: sufficient at the deterministic exponent level.

This explains why an explicit infinite family of powerful three-term
progressions, while arithmetically interesting, is not by itself an abc
counterexample.  A surviving negative route must strengthen the multiplicity
from two-full to at least four-full, or obtain additional radical saving not
captured by generic powerfulness.

## 6. Exact logical boundary

The theorem proved here is an implication:

```text
unbounded primitive four-full three-term AP family  ==>  not ABC.
```

It does not prove the antecedent.  In particular, it does not claim that any
published powerful-number family is four-full, primitive in the required
sense, or unbounded after all three conditions are imposed simultaneously.

The active Diophantine target is now precise:

> Construct or rule out an unbounded family of positive solutions
> `x+z=2y`, `gcd(x,2y)=1`, for which all three of `x,y,z` satisfy
> `rad(n)^4<=n`.

A strict impossibility theorem for this target would retire this particular
route; absent such a theorem or a counterexample to its defining claim, the
route remains active.

## 7. Lean coverage

The companion module will formalize:

1. the primitive abc point `(z,x,2y)`;
2. the exact radical bound with the visible factor `2`;
3. the affine logarithmic certificate
   `conductor <= (3/4) log c + log 2`;
4. the family-level implication to `not ABCConjecture`;
5. the elementary no-go thresholds at `r=2` and `r=3`, and the strict
   threshold at `r=4`.
