# Audit boundary

## Mathematical scope

For prime index `ell`, the previously proved channel theorem puts every odd
support prime in one of the classes `+/-1 mod 2*ell`.  The finite search
therefore covers every support prime inside its displayed rectangle.  It
uses no claim about primes beyond `10,000,000`.

A row with `q^2 | A_ell` or `q^2 | B_ell` is interpreted as zero first
Hensel displacement only together with the unconditional all-support
transversality theorem proved in the new Lean module.  A `q^3` row is zero
second displacement.  A no-hit is never extrapolated.

## Exact decisions

* The universal claim that no individual fixed support displacement is zero
  is refuted by the full-premise row `(7,13,B)`.
* The all-support simultaneous-zero exclusion is not refuted by that row,
  because `A_7=239` has exponent one.
* The absence of an opposite-channel pair in the finite rectangle is a
  bounded result only.
* No standard-abc conclusion is present.

## Independent replay

The producer and verifier share only the mathematical specification and the
finite bounds.  Their arithmetic engines are separate:

1. quadratic-pair multiplication for the producer;
2. ordinary 2-by-2 matrix multiplication for the verifier.

The verifier regenerates the prime sets, every candidate pair, every modular
coordinate, the repeated-hit list, the unresolved-index list, and all
reported counts.  It exits nonzero on any mismatch.
