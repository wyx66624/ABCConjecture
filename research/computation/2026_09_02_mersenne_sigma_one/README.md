# Finite sigma-one Mersenne scan and exact witness certificates

This directory accompanies
`../../ABC_MERSENNE_SIGMA_ONE_EXACT_ORDER_COUPLING_2026_09_02.md`.
It contains two different kinds of evidence, which must not be conflated.

1. `scan.cpp` performs a complete Eratosthenes sieve through a supplied
   bound, tests the base-two Wieferich congruence modulo `p^2`, and computes
   the exact order for every hit.  `scan_1b.json` is the archived result for
   all 50,847,534 primes through `10^9`.  Exact-order LTE and
   `p` not dividing `(p-1)/ord_p(2)` make this Fermat-exponent congruence
   equivalent to canonical depth at least two.
2. `verify_witnesses.py` exactly verifies the arithmetic of the two hits and
   the complete factorization of `Phi_364(2)`.  It also gives exact rational
   Taylor/geometric-tail certificates for the logarithmic inequalities in
   the two sigma-one window witnesses.  The long Decimal values in the JSON
   are convenient displays; the Boolean window certificate does not depend
   on Decimal rounding.

`RUN_LOG.txt` records a fresh full replay whose output is byte-for-byte
identical to `scan_1b.json`, together with the Python and Lean checks.
`SHA256SUMS` freezes every stable file except itself.

## Reproduction

From this directory, with GCC 15.1 or another C++20 compiler:

```powershell
g++ -O3 -std=c++20 scan.cpp -o scan.exe
./scan.exe 1000000000 > scan_1b.replay.json
python verify_witnesses.py > verify_witnesses_stdout.replay.json
```

The archived full scan was built with MinGW-Builds `g++.exe 15.1.0`.  The
executable is intentionally not archived; it is rebuilt from `scan.cpp`.
The Python verifier uses only the standard library.

For a nonnegative rational `x`, the verifier writes `x=n*y` with
`0 <= y <= 1`, sums the exact rational Taylor series for `exp(y)` through
degree 48, and bounds the positive tail by a geometric series whose ratio is
at most `y/50`.  Raising both rational endpoints to `n` gives a certified
enclosure of `exp(x)`.  These enclosures prove, without floating-point
assumptions,

- for `(p,d,q,k)=(1093,364,10^12,8)`,
  `34.5 < log(3*d*q) < 35` and `3.54 < log(log(3*d*q)) < 3.56`;
- for `(p,d,q,k)=(3511,1755,10^71,32)`,
  `172 < log(3*d*q) < 172.1` and
  `5.14 < log(log(3*d*q)) < 5.15`.

Exact rational comparisons then certify the divisor windows, the strict
`B` inequalities `p*F>d^2`, and `H=3` and `H=5`, respectively.

## Exact local witnesses

The verifier recomputes

```text
Phi_364(2)
 = 1093^2 * 4733 * 8861085190774909 * 556338525912325157.
```

It verifies each factor by both the deterministic Miller--Rabin basis for
64-bit integers and a complete Lucas `p-1` certificate whose factor primes
are checked by trial division.  Exact-order residues prove that all four
factors have order 364.  Prime-power residues prove that only `1093` is
repeated and that its depth is exactly two.  Consequently the first witness
has `B_364=log(1093)` and `U_364=V_364=G_364=0`.

The second witness verifies that `3511` has exact order 1755, multiplier two,
and depth exactly two.  It lies in `B`, while its multiplier is below the
sigma-one threshold `H=5`.

These are full-premise counterexamples to the pointwise strengthenings
`B=0`, `B <= C*G`, `B-carrier implies r>=H`, and “high-multiplier repeated
implies depth at least three.”  They are not asymptotic counterexamples to
the actual targets `sum B=o(m)` or `sum G=o(m)`.

## Finite boundary

The full scan finds only `1093` and `3511` through `p<=10^9`; both have
depth two.  Thus this finite range contains no depth-three base-two carrier.
This is a bounded computational certificate only.  It neither proves
finiteness or density zero nor supplies a reason to abandon the high-depth
route.

The companion Lean module is checked separately from `Lean/`:

```powershell
lake env lean -DwarningAsError=true \
  IUTThreeClosures/MersenneSigmaOneExactOrderCoupling20260902.lean
```

Lean does not verify the `p<=10^9` exhaustive scan or any real asymptotic.
