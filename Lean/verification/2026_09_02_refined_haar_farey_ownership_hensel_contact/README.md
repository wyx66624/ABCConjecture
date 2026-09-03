# Refined Haar, Farey, ownership, Hensel, and contact verification

This directory is the reproducibility package for the September 2, 2026
eight-module checkpoint.  It certifies the exact component theorems,
counterexample scopes, deterministic finite evidence, and integrated paper
artifact described below.  It does **not** contain a proof or disproof of the
standard abc conjecture, a verification of IUT, or an asymptotic conclusion
drawn from a bounded search.

## Formal inventory

| Lean module | Theorems | Definitions | Other named declarations | Total |
|---|---:|---:|---:|---:|
| `IUTRefinedTensorHaarThetaSamePilot20260902` | 38 | 12 | 1 structure, 2 instances | 53 |
| `MersenneFareyDenominatorEntropy20260902` | 16 | 7 | 0 | 23 |
| `AffineOwnershipMaximalIntersectionAggregation20260902` | 24 | 1 | 0 | 25 |
| `PellPolynomialHenselSpecialization20260902` | 21 | 9 | 0 | 30 |
| `PellPolynomialAllIndexFormalization20260902` | 43 | 8 | 1 structure | 52 |
| `SteinbergValuationContactSurface20260902` | 45 | 23 | 1 abbreviation | 69 |
| `SteinbergIntegerFiniteChain20260902` | 57 | 25 | 4 abbreviations, 2 structures | 88 |
| `QuadraticVeronesePeeling20260902` | 53 | 28 | 0 | 81 |
| **Total** | **297** | **113** | **5 abbreviations, 4 structures, 2 instances** | **421** |

`validate.py` strips comments and literals, inventories these declarations,
and rejects `sorry`, `admit`, `native_decide`, `sorryAx`, declaration-style
axioms, custom opaque declarations, unsafe/partial/extern declarations,
private declarations, anonymous instances, and declaration forms outside the
scanner's explicitly supported grammar.  Exact per-module and aggregate
declaration counts are fixed as an additional guard.  It generates exactly one
`#print axioms` command for every named declaration, including definitions,
abbreviations, structures, and instances.  The 421 reports must have union
exactly within `propext`, `Classical.choice`, and `Quot.sound`; every expected
name must occur exactly once.

The umbrella target is built first so that subsequent checks cannot consume
stale local dependency objects.  Every module and the generated audit is then
compiled with `-DwarningAsError=true`.  The aggregate build must both report
success and report exactly the recorded 9,255 jobs.

## Evidence replay and source boundary

The validator reruns the refined tensor-normalization checks, the Mersenne
Farey certificate verifier, the independent sigma-one witness verifier, the
IUT source-metadata and exact-patch verifier, two independent affine ownership
checks, the Pell producer/verifier/bounded scan, and the quadratic Veronese
producer/verifier.  File-producing replays must leave every frozen input byte
identical.  Eight designated producer/verifier stdout streams are also compared
with their frozen files after strict UTF-8 decoding and newline normalization.
The affine grid is run before its independent consumer; its 2,208-case JSON
payload must explicitly say `PASS` and contain no errors.  Every SHA-256
manifest inside the included source and computation archives is checked.

The input manifest freezes the eight modules and their hand-written audit
companions, the umbrella import, research status and route registry, all ten
checkpoint reports, the integrated TeX source and eight fragments, the final
PDF, all version-controlled local Lean source dependencies, the IUT patch/source bundle, the full
sigma-one scan bundle, the Mersenne source archive, and the other designated
source/computation bundles.  UTF-8 decoding, isolated carriage returns,
unexpected control characters outside hash-frozen PDF-to-text source
extractions, direct trailing-whitespace checks on authored files, and
`git diff --check` are additional gates.

Ignored `Scratch`, `Tmp`, and `Check` experiments in the local Lean directory
are not imported checkpoint sources and are deliberately excluded from the
manifest.

The surviving mathematical obligations remain explicit: source-level IUT
transport and same-object pointed comparison; the critical Mersenne counting
estimate; canonical affine catalogue sparsity; fixed-`D=2` Pell
transversality/rank and simultaneous zero-displacement exclusion; the
five-term-generated chain relation and its boundary theorem; and the two
uniform Gate VF cost estimates.  None is introduced as an axiom.

## Replay

From this directory, or from any working directory, run:

```powershell
.\validate.ps1 -Check
```

Maintainers regenerate the inventory and input manifest with `-Prepare`, then
run `-Record` only after the paper and PDF are final.  `-Record` writes
`validation-run.json`, the command logs, and `SHA256SUMS`.  A subsequent
`-Check` verifies the immutable package seal before independently rerunning all
checks in `tmp/verification/`, then compares all stable validation fields and
command exit statuses with the sealed record.  `SHA256SUMS` is an internal
integrity root; it is not a digital signature or an externally timestamped
attestation, so its digest must be obtained from a trusted copy when provenance
against a hostile repository is required.
