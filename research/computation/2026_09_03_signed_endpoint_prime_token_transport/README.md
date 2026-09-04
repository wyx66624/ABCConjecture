# Signed endpoint prime-token transport audit

Run from the repository root:

```powershell
python research/computation/2026_09_03_signed_endpoint_prime_token_transport/search_endpoint_token_transport.py `
  --limit 5000 --lte-k-limit 12 `
  --output research/computation/2026_09_03_signed_endpoint_prime_token_transport/OUTPUT.json
```

The normalized finite search includes every primitive nonunit triple
`2 <= a <= b`, `a+b=c`, through `c=5000`.  Exact integer arithmetic checks
the endpoint-core identity, gcd conditions, radicals, valuations, and named
counterexamples.  Floating-point logarithms are used only to display and rank
weights.

The fractional-flow routine constructs one deterministic feasible monotone
flow.  The zero-unmatched headline count uses the exact nested-Hall criterion:
at every source-prime cutoff it compares the integer products whose logarithms
are the two upper-tail masses.  The floating flow is asserted to agree with
that exact classification.  The report and Lean implication use only
feasibility and exact flow accounting.

`OUTPUT.json` is written as UTF-8 bytes with explicit LF line endings.  This
removes platform newline translation.  The recorded logarithmic display
fields can still differ in their final bits across `libm` implementations;
portable certification of the headline counts therefore uses the independent
exact-integer Hall audit rather than byte identity of those display fields.
