# A uniform excess-mass gate for an abc counterexample family

## 1. Scope

This note does not claim a counterexample to the abc conjecture.  It isolates
the exact uniform estimate that would turn an adjacent-integer family into a
disproof.  In particular, finitely many high-quality triples do not suffice.

Let `b_n >= 1`, and consider the primitive abc triples

```text
(a_n,b_n,c_n) = (1,b_n,b_n+1).
```

Put

```text
H_n = log(b_n+1),
R_n = log rad(b_n*(b_n+1)),
E_n = log(b_n*(b_n+1)) - R_n.
```

The quantity `E_n` is the logarithmic mass contributed by repeated prime
factors.  Equivalently,

```text
E_n = sum_{ell | b_n*(b_n+1)} (v_ell(b_n*(b_n+1))-1)*log ell.
```

The valuation formula is explanatory only; the formal criterion uses the
first exact definition and therefore needs no infinite or support-indexed
sum.

## 2. Sufficient criterion for disproving abc

Assume that `H_n` is unbounded and that there are constants
`0 < delta < 1` and `K` such that, for every `n`,

```text
E_n >= (1+delta)*H_n - K.                 (2.1)
```

Then the abc conjecture is false.

### Proof

Because `b_n*(b_n+1) <= (b_n+1)^2`,

```text
log(b_n*(b_n+1)) <= 2*H_n.
```

Subtracting (2.1) gives

```text
R_n <= (1-delta)*H_n + K.                (2.2)
```

Choose

```text
epsilon = delta / (2*(1-delta)) > 0.
```

The coefficient is exact:

```text
(1+epsilon)*(1-delta) = 1-delta/2.
```

If abc held, its constant `C_epsilon` applied to every primitive triple
`(1,b_n,b_n+1)` would give

```text
H_n <= (1+epsilon)*R_n + C_epsilon.
```

Using (2.2),

```text
(delta/2)*H_n <= (1+epsilon)*K + C_epsilon.
```

The right side is independent of `n`, contradicting the assumed
unboundedness of `H_n`.  Therefore abc is false.  QED.

## 3. Consequence for the Pell route

For the repository's adjacent Pell sequence one already has

```text
H_n = n*log(97+56*sqrt(3)) + O(1),
```

so the height tends to infinity.  The sole counterexample gate is therefore
a fixed positive excess above the critical coefficient one.  In asymptotic
language, if

```text
limsup E_n/H_n > 1
```

then one may choose a fixed `delta` strictly below the limsup excess, pass to
an infinite subsequence on which `E_n/H_n >= 1+delta`, discard any finite
initial segment, and reindex that subsequence as the family in Section 2.
Because the Pell heights tend to infinity, the reindexed heights remain
unbounded, and (2.1) holds there (even with `K=0`).  This subsequence and
reindexing step is essential: a limsup assertion does not make (2.1) true for
every index of the original sequence.

All presently audited squarebase, four-consecutive-product and moving-`D`
estimates stop at coefficient one.  They may reorganize `E_n`, but none proves
the fixed positive margin in (2.1).  Future computations count as progress on
the disproof route only if they aggregate into this linear total-multiplicity
estimate; isolated primes or isolated high-quality triples do not.

## 4. Trust ledger

The companion Lean theorem formalizes the implication from the displayed
real inequalities and the exact definition of `ABCConjecture`.  Establishing
(2.1) for a concrete infinite arithmetic sequence remains a new,
unconditional number-theoretic input.  No such input is assumed or hidden in
the repository.
