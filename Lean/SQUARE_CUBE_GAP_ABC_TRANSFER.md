# Square--cube gap transfer to an abc counterexample

## Status

This note records a deterministic implication, not a proof that the required
square--cube gaps exist.  The complete implication is formalized in
`IUTThreeClosures/SquareCubeGapTransfer.lean`.

## Primitive abc point

Let `x,y` be positive coprime integers and assume

```text
y^2 < x^3.
```

Set

```text
a = x^3-y^2,
b = y^2,
c = x^3.
```

Then `a+b=c`.  Since `gcd(x,y)=1`,

```text
gcd(y^2,x^3)=1.
```

Subtracting one member of a coprime pair from the other preserves the relevant
coprimalities, so `(a,b,c)` is a primitive abc triple.

## Radical transfer

Radical is submultiplicative and unchanged by a positive power.  Hence

```text
rad(a b c)
  <= rad(a) rad(y^2) rad(x^3)
  <= a rad(y) rad(x)
  <= a y x.                                         (1)
```

This is the exact deterministic transfer proved in Lean.

## The `1/6` exponent ledger

Use the height scale

```text
X = x^3.
```

The cube base costs exactly

```text
log x = (1/3) log X.
```

The strict inequality `y^2<x^3` gives

```text
log y < (1/2) log X.
```

Suppose the gap satisfies, for some fixed real `theta`,

```text
log a <= theta log X + O(1).
```

Taking logarithms in (1) gives the total radical exponent budget

```text
theta + 1/2 + 1/3 = theta + 5/6.                    (2)
```

Therefore every fixed saving

```text
theta < 1/6                                         (3)
```

makes the exponent in (2) strictly smaller than one.  An unbounded family with
(3), with a uniform constant absorbed in the usual abc constant, would produce
infinitely many primitive abc triples whose quality is bounded away from one.
It would therefore disprove the abc conjecture.

The Lean file states this without asymptotic ambiguity.  It uses explicit
natural gap bounds `H`, an inequality

```text
log H <= theta log(x^3),
```

and an explicit positive `epsilon` satisfying

```text
(1+epsilon)(theta+5/6) < 1.
```

No existence field is hidden in the resulting theorem.

## Relation to Hall's conjecture

Marshall Hall's problem concerns nonzero values of

```text
|x^3-y^2|.
```

The weak Hall conjecture predicts that, for every positive `eta`, these gaps
are bounded below by a constant times `x^(1/2-eta)`.  The abc conjecture implies
that prediction.  Noam Elkies' computational and lattice-reduction work records
that Hall's original constant-times-`sqrt(x)` formulation is too strong as a
uniform heuristic target, while the exponent-`1/2-o(1)` form is the natural abc
consequence.

Our transfer uses the converse direction only at the level of a counterexample:
an unbounded family with

```text
0 < x^3-y^2 <= (x^3)^(1/6-eta)
              = x^(1/2-3 eta)
```

would violate the weak Hall lower bound and, by the formalized radical ledger,
would also violate abc.

Reference:

- N. D. Elkies, *Rational points near curves and small nonzero
  |x^3-y^2| via lattice reduction*, arXiv:math/0005139, together with the
  maintained Hall-search tables at Harvard.

## What remains open

The deterministic implication is complete.  The missing theorem is one of the
following mutually exclusive outcomes:

1. construct an unbounded coprime family with a fixed exponent below `1/2` in
   `x`, which would disprove abc through this file; or
2. prove the weak Hall lower bound with the full `1/2-o(1)` exponent, which is
   itself an abc-level Diophantine estimate.

Known parametric families at the `sqrt(x)` scale do not cross the strict
exponent threshold.  Finite exceptional examples do not yield an unbounded
fixed-saving family.
