# Reproducing the affine matching-gate checks

Run the commands from the bundle directory.  From the repository root:

```powershell
Set-Location (Resolve-Path
  'research/computation/2026_09_01_affine_matching_lower_gate')
```

No network access or nonstandard Python package is used.

## 1. Exact Python checks

Any Python 3 interpreter with the standard library is sufficient:

```powershell
python .\verify.py
```

The script exits nonzero if an assertion fails. It checks finite instances of
the generalized shear, all three projection injectivities, nesting of
`Q=s*rad(abc)` in the minimal-step fibre, the exact local square counts, one
high-power CRT template, the exponent ledgers, and three explicit all-square
nonexceptional rows.

## 2. Exhaustive minimal-step search

Compile with a C++20 compiler and run:

```powershell
g++ -O3 -std=c++20 .\full_minimal_search.cpp -o .\full_minimal_search.exe
& .\full_minimal_search.exe
```

The original audit used MinGW GCC 15.1.0. The program has no external
library dependency.

The program exhausts the full canonical `K=8` box for

```text
(a,b,c)=(1,8,9), Q=rad(abc)=6, M=22143.
```

Its radical sieve stores `rad(n)` for every cofactor value that can occur.
For each fixed `h`, exact Möbius inclusion-exclusion counts all
`1<=k<=M` with `gcd(1+6h,k)=1`. This independently gives the total
admissible count without iterating every admissibility gcd.

For the exceptional search, `H<9^8` implies the necessary exact cutoff

```text
rad(U) rad(V) rad(W) <= floor((9^6-1)/6) = 88573.
```

The program evaluates only candidates passing that necessary condition and
then applies `gcd(U,k)=1`. It decides exceptionality using the exact strict
integer comparison

```text
(6 rad(U) rad(V) rad(W))^4 < H^3.
```

The filtered values fit well inside unsigned 128-bit arithmetic. The
hard-coded regression totals make the executable exit nonzero if the exact
enumeration changes unexpectedly.

## 3. Compare captured output

The expected transcript is in `OUTPUT.txt`. Whitespace and the compiler
copyright line may vary; all mathematical count lines should agree exactly.

## 4. Verify deliverable hashes

After removing any locally compiled executable, run:

```powershell
Get-Content .\SHA256SUMS | ForEach-Object {
  $parts = $_ -split '  ', 2
  $actual = (Get-FileHash -Algorithm SHA256 -LiteralPath $parts[1]).Hash.ToLowerInvariant()
  if ($actual -ne $parts[0]) { throw "hash mismatch: $($parts[1])" }
}
```

`INPUT_SHA256SUMS.txt` separately freezes the repository reports, paper, and
Lean modules audited in `REPORT.md`.
