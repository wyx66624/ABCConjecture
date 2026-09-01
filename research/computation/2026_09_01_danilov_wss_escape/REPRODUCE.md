# Reproducing the Danilov WSS-escape finite audit

Run from the repository root with Python 3.11 or later:

```text
python research/computation/2026_09_01_danilov_wss_escape/analyze_final_branch_primes.py
python research/computation/2026_09_01_danilov_wss_escape/verify_wss_escape_claims.py
```

The analyzer reads the immutable saved endpoint
`research/computation/2026_09_01_danilov_recursive_lift/search_stage13_100m.json`
and rewrites `final_branch_prime_analysis.json`.  `UPSTREAM_INPUTS.json`
pins every cross-bundle JSON/CSV/PDF input by SHA-256. The verifier checks
those hashes before doing arithmetic. It then checks the
saved state relation; hashes all 14 source stage files; reconstructs the
4398-digit squarefree modulus by multiplying twelve initial factors and 626
packet primes; deterministically checks all 638 factors for primality,
distinctness, and coprimality to 30; checks the seven complete local zero
sets described by the two-point norm argument; checks every recorded unique
lift modulo `p^2`; and checks the exact cyclotomic derivative counterexample
and Fibonacci value `C_110`.  It additionally restricts the existing
`Q <= 1000` simple-primitive certificates to the actual top indices
`Q = 1 (mod 3)`: 105 of 121 are rigorously ruled out as squarefull Danilov
terms, while the remaining 16 are reported as unresolved rather than
counterexamples.

The verifier also enumerates, by truncated subset-product dynamic
programming, every divisor `e | Q_*` with
`10e <= 99,966,059`.  There are exactly 622.  This is the finite input for
the strengthened lower bound `2^638 - 622`; it does not enumerate the full
`2^638` divisor set.

This bundle certifies only the seven primes already saved by the bounded
`p <= 10^8` source search.  It does not certify that there are no further
primes and does not assert a cover of the full parameter line.
