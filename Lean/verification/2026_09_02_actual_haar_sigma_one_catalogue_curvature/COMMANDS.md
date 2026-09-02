# Reproduction commands

Run these commands from the repository root in PowerShell. `lake`, a Python
3.10 or newer interpreter, and a C++20 `g++` must be on `PATH`. All Lake
dependency checkouts must be clean at their manifest-pinned revisions.

```powershell
$validator = 'Lean/verification/2026_09_02_actual_haar_sigma_one_catalogue_curvature/validate.ps1'
```

Before freezing, confirm the final delivery inputs exist:

```powershell
Test-Path -LiteralPath output/pdf/ChatGPT_ABC_Uniformity_2026.pdf
Test-Path -LiteralPath output/pdf/ChatGPT_ABC_ActualHaar_SigmaOne_Catalogue_Curvature_2026_09_02_QA
Test-Path -LiteralPath research/ABC_MULTI_ROUTE_ACTUAL_HAAR_SIGMA_ONE_CATALOGUE_CURVATURE_2026_09_02.md
Test-Path -LiteralPath research/computation/2026_09_02_iut_actual_haar_orbit
Test-Path -LiteralPath research/computation/2026_09_02_mersenne_sigma_one
Test-Path -LiteralPath research/computation/2026_09_02_affine_inverse_period_catalogue
Test-Path -LiteralPath research/computation/2026_09_02_pell_factor_quotient_coupling
```

All seven checks must print `True`.

Freeze inputs and generate the deterministic 102-query axiom audit:

```powershell
& $validator -FreezeInputs
```

Run a disposable live validation under the ignored `tmp/verification` tree:

```powershell
& $validator
```

The expected summary is:

```text
PASS
modules=4
theorems=102
lemmas=0
proof_declarations=102
private_proof_declarations=0
axiom_reports=102
counted_declarations=123
axiom_union=Classical.choice,Quot.sound,propext
evidence_hash_entries=43
iut_normalization_rows=20
mersenne_scan_primes=50847534
affine_script_runs=6
pell_endpoint_rows=57
git_diff_check=pass
git_cached_diff_check=pass
git_index_byte_matches=872
frozen_text_hygiene=pass
aggregate_jobs=9239
standard_abc_closed=false
```

After reviewing the live logs, record the same run in this package:

```powershell
& $validator -Record
```

The record run rechecks driver hashes, frozen inputs, generated audit, and
Lake dependency state before and after all compiler and computation runs.
It includes a freshly compiled exhaustive Mersenne scan through `10^9`.

Create the immutable package hash list and verify every recorded file:

```powershell
& $validator -SealPackage
& $validator -VerifyPackage
```

`-SealPackage` refuses to overwrite an existing `SHA256SUMS`. After sealing,
do not edit a file in this directory. A fresh computation replay may still be
run outside the package, followed by the immutable package check:

```powershell
& $validator
& $validator -VerifyPackage
```
