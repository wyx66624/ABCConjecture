# Reproduction commands

Run every command below from the repository root in PowerShell. The wrapper
selects a non-WindowsApps Python 3.10 or newer interpreter, invokes Python with
bytecode generation disabled, and propagates a failing exit code.

## Preconditions

Finish all checkpoint source edits and the final PDF QA before freezing. In
particular, these paths must already exist and contain their final artifacts:

```powershell
Test-Path -LiteralPath output/pdf/ChatGPT_ABC_Uniformity_2026.pdf
Test-Path -LiteralPath output/pdf/ChatGPT_ABC_Source_Multiplier_Catalogue_Lucas_2026_09_01_QA
Test-Path -LiteralPath research/computation/2026_09_01_pell_lucas_all_order
Test-Path -LiteralPath research/sources/mersenne_balanced_multiplier_depth_2026_09_01
Test-Path -LiteralPath research/sources/pell_fourth_order_lucas_2026_09_01
Test-Path -LiteralPath research/sources/iut_rational_degree_one_source_realization_2026_09_01
```

All six commands should print `True`. `lake` must be on `PATH`, and every
checkout in `Lean/.lake/packages` must be clean at the revision pinned by
`Lean/lake-manifest.json`.

Set a short variable for the wrapper:

```powershell
$validator = 'Lean/verification/2026_09_01_source_multiplier_catalogue_lucas/validate.ps1'
```

## Maintainer sequence

Freeze the exact current inputs and generate the deterministic axiom audit:

```powershell
& $validator -FreezeInputs
```

This creates `input-manifest.json` and `axiom-audit.lean`. It also removes any
old recorded logs, declaration inventory, and validation result. It refuses to
modify a directory that already contains `SHA256SUMS`.

Run an ordinary live validation first. Its output is written only under the
ignored `tmp/verification/2026_09_01_source_multiplier_catalogue_lucas`
directory:

```powershell
& $validator
```

The expected summary is:

```text
PASS
modules=4
theorems=67
lemmas=0
proof_declarations=67
private_proof_declarations=0
axiom_reports=67
counted_declarations=86
axiom_union=Classical.choice,Quot.sound,propext
lucas_local_rows=5
lucas_target_residues=0,1,2,3,4
lucas_sample_indices=3,5,7,11
aggregate_jobs=9229
standard_abc_closed=false
```

Review that summary, `declaration-inventory.json`, the compiler logs, and the
independent Pell--Lucas replay. Then record the same validation inside the
package:

```powershell
& $validator -Record
```

Do not change a frozen input, `validate.py`, or `validate.ps1` between freeze
and record. The record run checks those states both before and after the four
direct compilations, the 67-query axiom audit, the independent Pell replay,
and the 9,229-job aggregate build. It also hard-checks every per-module
declaration count, the totals of 67 proofs and 86 counted declarations, zero
private proofs, and exact target-residue coverage `{0,1,2,3,4}` in the Pell
packet.

After reviewing the recorded artifacts, create the immutable hash list and
verify it:

```powershell
& $validator -SealPackage
& $validator -VerifyPackage
```

`-SealPackage` requires a complete successful record and refuses to overwrite
an existing `SHA256SUMS`. `-VerifyPackage` checks the exact sorted file set,
every recorded SHA-256 digest, all zero exit-code sidecars and log trailers,
the fixed declaration inventory, the one-for-one axiom coverage, the Pell
replay object and target-residue set, and the 9,229-job aggregate count.

After sealing, do not edit any file in this directory. An ordinary validation
may still be replayed into `tmp/verification`, followed by a sealed-package
check:

```powershell
& $validator
& $validator -VerifyPackage
```

The ordinary replay recompiles and reruns the computation. The package check
itself verifies the sealed record and does not replace a fresh live replay.
