# Audit record

## Mathematical boundary

The computation establishes an exact finite theorem only: every actual
prime-index packet through `ell=271` has an exponent-one divisor.  It does
not infer an unbounded theorem from bounded search.  In particular, the zero
depth-three count below two million is recorded as a no-hit result and is not
used to abandon the route.

## Independence checks

The verifier:

1. regenerates all prime indices with its own sieve;
2. repeats all 527,352 necessary-class candidate tests;
3. recomputes each exponent-one claim modulo `q^2`;
4. proves every witness prime, using deterministic 64-bit Miller--Rabin or
   the stored Pocklington certificate;
5. rebuilds every first-sequence coefficient from the defining
   product/factorial formula, independently computes the companion binomial
   coefficient, checks all 138,675 correlations, and recomputes their digest;
6. recomputes the norm-one Lucas orbit and both polynomial identities in
   228 independent modular evaluations, using the product-derived first
   coefficients;
7. multiplies and proves every complete factorization used in the incidence
   sample, then rebuilds every Legendre edge;
8. checks the row and column parity laws, the quartic-two specialization,
   the global sign, and the mixed-sign row at index eleven.

The direct Lean log has exit code zero under `-DwarningAsError=true`.  The
formal core now derives the closed binomial first coefficient from the
original odd-factor product/factorial formula before proving the correlation.
The log contains no `sorryAx`, error, or warning diagnostic.  The only
reported kernel axioms are the standard Mathlib foundations `propext`,
`Classical.choice`, and `Quot.sound`.

## Counterexample boundary

The index-eleven edge signs refute only the stronger assertion that every
edge of a negative row must be negative.  That packet is not squarefull.
No example in this bundle satisfies the complete squarefull, opposite-depth,
rank, all-order, splitter, character, and third-order premises.
