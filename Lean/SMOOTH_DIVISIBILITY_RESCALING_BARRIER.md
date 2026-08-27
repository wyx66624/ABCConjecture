# Critical short-interval divisibility rescaling barrier

## Status

This note records a proved deterministic obstruction.  It does not assert that
low-radical neighbours of prime powers do not exist; it identifies a specific
invalid reuse of a critical-scale short-interval theorem after imposing a
prime-divisibility condition.

The accompanying Lean module is
`IUTThreeClosures/SmoothDivisibilityRescalingBarrier.lean`.

## Theorem

Let `x,h,q` be positive real numbers and let `0 <= m < n`.  Assume

```text
h^n = x^m,      q > 1.
```

Then

```text
(h/q)^n < (x/q)^m.
```

### Proof

Since `q > 1` and `m < n`,

```text
q^m < q^n.
```

The common numerator `x^m` is positive, hence

```text
x^m/q^n < x^m/q^m.
```

Using `h^n=x^m` and the identity `(u/q)^r=u^r/q^r` gives the result.

For the exponent `3/5`, this is

```text
h^5=x^3  ==>  (h/q)^5 < (x/q)^3.
```

## Consequence for divisibility extraction

Suppose an all-interval theorem can be invoked only when an interval with centre
`Y` and length `L` satisfies

```text
L^n >= Y^m.
```

At the critical original scale `h^n=x^m`, restricting to integers divisible by
`q` replaces the interval by one with centre `x/q` and length `h/q`.  The theorem
above proves that its required hypothesis fails strictly for every `q>1`.

Therefore a proof may not obtain a first moment over prime divisors merely by
writing

```text
sum_{q <= y} ( count of y-smooth multiples of q in [x,x+h] )
```

and applying the same critical-scale all-interval theorem independently to the
quotient intervals `[x/q,(x+h)/q]`.  A valid replacement needs at least one of:

1. a theorem uniform below the critical exponent after quotienting;
2. a short-interval estimate already carrying arithmetic-progression or
   divisibility information;
3. an averaged theorem strong enough for the complete prime sum;
4. additional slack, for example an original interval exponent strictly larger
   than the theorem's threshold, with the loss tracked uniformly in `q`.

## Relation to the current abc-disproof route

Khalid Younis, *Asymptotics for smooth numbers in short intervals*,
arXiv:2409.05761, proves an asymptotic for smooth numbers in intervals
`[X,X+X^theta]` for `theta>17/30` in a specified smoothness range.  The theorem
controls the total smooth-number count.  It does not by itself supply a uniform
prime-divisibility first moment at the same critical scale.

N. A. Carella, *Note on the Exceptional Set in the ABC Conjecture*,
arXiv:2608.16764, attempts to derive low-radical smooth neighbours through such
moments.  Independently of the separate Dickman-error audit, the quotient
intervals must satisfy the hypotheses of the invoked short-interval theorem.
The rescaling theorem above shows why equality at a rational critical exponent
is insufficient.

Jacques Benatar, *A short-interval Hildebrand--Tenenbaum theorem*,
arXiv:2408.16576v3, supplies strong exact-`omega` counts in intervals of length
at least `x^(17/30+epsilon)`.  A prospective repair should investigate a joint
estimate for smoothness, small radical and divisibility rather than infer these
properties from a total smooth count.

## Research target left open

The deterministic disproof transfer in
`PrimePowerSmoothNeighbour.lean` would close abc negatively if one could prove
an unbounded family satisfying a strict logarithmic radical budget.  The present
barrier says that this existence theorem needs genuinely new distributional
input; it cannot be obtained by a scale-blind division of a critical short
interval.
