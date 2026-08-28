# Low-radical neighbour exponent budget

**Author:** ChatGPT  
**Status:** unconditional deterministic transfer; no existence theorem for the
required neighbour families is asserted.

## 1. Three-factor threshold

Let `b<c` be positive coprime integers and put `a=c-b`.  Suppose

```text
a <= H,
rad(b) <= B,
rad(c) <= R.
```

Then the existing low-radical neighbour theorem gives

```text
rad(abc) <= H B R.
```

Assume, relative to the true endpoint height `log c`, that

```text
log H <= theta log c,
log B <= beta  log c,
log R <= sigma log c.
```

Since all three factors are positive,

```text
log(H B R)
 = log H + log B + log R
 <= (theta+beta+sigma) log c.
```

Therefore an unbounded family with

```text
theta+beta+sigma < 1
```

contradicts the abc conjecture.  The Lean theorem
`not_abc_of_unbounded_heightExponentBudgets` proves this conclusion directly
from the repository's exact logarithmic definition of `ABCConjecture`.

## 2. Reciprocal radical compression

A useful way to produce the endpoint exponents is

```text
r log B <= log c,
s log R <= log c.
```

For positive integers `r,s`, division gives

```text
log B <= (1/r) log c,
log R <= (1/s) log c.
```

Thus the decisive threshold is

```text
theta + 1/r + 1/s < 1.                     (2.1)
```

This is formalized by
`not_abc_of_unbounded_reciprocalRadicalBudgets`.

The theorem is one-way: satisfying (2.1) makes an unbounded family fatal to
abc, but the file does not claim that such a family exists.

## 3. Exact perfect powers

For every positive integer `u` and every `r>=1`,

```text
rad(u^r)=rad(u) <= u,
```

and hence

```text
r log rad(u) <= log(u^r).
```

Consequently, for coprime exact powers

```text
b=u^r < c=v^s,
```

the endpoint radical costs are automatically `1/r` and `1/s`.  If their gap
satisfies

```text
c-b <= c^(theta+o(1))
```

along an unbounded family, then (2.1) disproves abc.  The exact finite
certificate and the family-level disproof theorem are:

```text
PerfectPowerPairGapBudget.toReciprocalRadicalBudget
not_abc_of_unbounded_coprimePerfectPowerNeighbours
```

## 4. Route triage

Equation (2.1) sharply separates useful and insufficient constructions.

### Two squarefull-type endpoints

Taking only the trivial squarefull radical costs `1/2` at both endpoints gives

```text
theta + 1/2 + 1/2 >= 1.
```

Thus squarefullness alone can never cross the abc-disproof threshold for a
positive gap exponent.  A squarefull/Pell construction remains useful only if
it supplies additional radical saving beyond the generic squarefull bound.

### One prime-power centre and one full endpoint

At the current short-interval exponent `theta>17/30`, the inequality

```text
theta + 1/k + 1/s < 1
```

requires, at the limiting value `theta=17/30`, at least:

| endpoint compression `s` | least centre exponent `k` |
|---:|---:|
| 3 | 11 |
| 4 | 6 |
| 5 | 5 |
| 6 | 4 |

The inequalities are strict, so a theorem available only exactly at a
critical endpoint must leave explicit slack.

### Hall-type square/cube neighbours

For a square and a cube, the reciprocal endpoint cost is

```text
1/2 + 1/3 = 5/6.
```

Such a family would disprove abc only with a gap exponent strictly below
`1/6`.  The usual square--cube proximity scale is therefore not automatically
strong enough; the exact exponent matters.

## 5. What remains open

The deterministic theorem reduces the negative route to distribution or
Diophantine existence questions such as:

1. constructing unbounded coprime perfect-power neighbours satisfying (2.1);
2. finding short intervals containing endpoints whose radical is much smaller
   than the generic full-number estimate;
3. proving joint short-interval estimates for the gap, endpoint radical and
   coprimality rather than inferring them from a total smooth-number count;
4. proving a stronger-than-squarefull radical saving in Pell or powerful-number
   families.

No one of these existence statements is stored as a Lean structure field or
axiom in this module.

## 6. Lean files

- `IUTThreeClosures/LowRadicalExponentBudget.lean`
- `IUTThreeClosures/LowRadicalExponentBudgetAxiomAudit.lean`
