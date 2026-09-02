# Reproduction commands

Run every command below from the repository root in PowerShell. The wrapper
selects a non-WindowsApps Python 3.10 or newer interpreter, invokes Python with
bytecode generation disabled, and propagates a failing exit code.

## Preconditions

Finish all checkpoint source edits and final PDF QA before freezing. These
paths must already exist and contain their final artifacts:

```powershell
Test-Path -LiteralPath output/pdf/ChatGPT_ABC_Uniformity_2026.pdf
Test-Path -LiteralPath output/pdf/ChatGPT_ABC_Signed_SlowSlack_Correlated_Admissible_Index_2026_09_02_QA
Test-Path -LiteralPath research/computation/2026_09_01_affine_signed_ray_caps
Test-Path -LiteralPath research/computation/2026_09_01_mersenne_critical_slow_slack
Test-Path -LiteralPath research/computation/2026_09_01_pell_lucas_correlated_all_order
Test-Path -LiteralPath research/sources/iut_admissible_scaling_order_index_2026_09_02
Test-Path -LiteralPath research/sources/mersenne_critical_slow_slack_2026_09_01
```

All seven commands should print `True`. `lake` must be on `PATH`, and every
checkout in `Lean/.lake/packages` must be clean at the revision pinned by
`Lean/lake-manifest.json`.

Set a short variable for the wrapper:

```powershell
$validator = 'Lean/verification/2026_09_02_signed_slow_slack_correlated_admissible_index/validate.ps1'
```

## Maintainer sequence

Freeze the exact current inputs and generate the deterministic axiom audit:

```powershell
& $validator -FreezeInputs
```

This creates `input-manifest.json` and `axiom-audit.lean`. It also removes any
old recorded logs, declaration inventory, replay document, and validation
result. It refuses to modify a directory that already contains
`SHA256SUMS`.

Run an ordinary live validation first. Its output is written only under the
ignored `tmp/verification/2026_09_02_signed_slow_slack_correlated_admissible_index`
directory:

```powershell
& $validator
```

The expected summary is:

```text
PASS
modules=4
theorems=90
lemmas=0
proof_declarations=90
private_proof_declarations=0
axiom_reports=90
counted_declarations=106
axiom_union=Classical.choice,Quot.sound,propext
evidence_hash_entries=41
affine_cubic_ledgers=1776807
mersenne_odd_primes=9591
pell_prime_indices=57
iut_recorded_build_jobs=8767
aggregate_jobs=9233
standard_abc_closed=false
```

Review that summary, `declaration-inventory.json`, the compiler logs, and the
independent four-route replay. Then record the same validation inside the
package:

```powershell
& $validator -Record
```

Do not change a frozen input or any validation driver between freeze and
record. The record run checks those states both before and after the four
direct compilations, the 90-query axiom audit, the independent evidence
replay, and the 9,233-job aggregate build.

After reviewing the recorded artifacts, create the immutable hash list and
verify it:

```powershell
& $validator -SealPackage
& $validator -VerifyPackage
```

`-SealPackage` requires a complete successful record and refuses to overwrite
an existing `SHA256SUMS`. `-VerifyPackage` checks the exact sorted file set,
every recorded digest, all zero exit-code sidecars and log trailers, the fixed
declaration inventory, one-for-one axiom coverage, the exact four-route replay
object, and the 9,233-job aggregate count.

After sealing, do not edit any file in this directory. An ordinary validation
may still be replayed into `tmp/verification`, followed by a sealed-package
check:

```powershell
& $validator
& $validator -VerifyPackage
```

The ordinary replay recompiles and reruns the computation. The package check
verifies the sealed record and does not replace a fresh live replay.
