# Validation record: balanced-persistence continuation

**Author:** ChatGPT  
**Run:** 2026-09-01  
**Verdict:** PASS

## Scope

This record validates the elementary Lean boundary added for the September 1
continuation.  It does not assert that the analytic counting theorem, the
external Pell perfect-power and valuation theorems, or the abc conjecture have
been formalized.  Those inputs remain mathematical paper results or cited
literature.

The checked modules are:

1. `DanilovGlobalIndexSieve20260831.lean` and its declaration-level audit;
2. `PellPrimeIndexDichotomy20260831.lean`;
3. `AffineExcessUpperBound20260831.lean`.

## Reproduction

From the repository's `Lean` directory, run

```powershell
& .\verification\2026_09_01_balanced_persistence_continuation\validate.ps1
```

The script uses the pinned `leanprover/lean4:v4.32.0` toolchain.  It directly
compiles each of the four source/audit targets and then runs

```text
lake build IUTThreeClosures.DanilovGlobalIndexSieve20260831
           IUTThreeClosures.PellPrimeIndexDichotomy20260831
           IUTThreeClosures.AffineExcessUpperBound20260831
           IUTThreeClosures
```

All four direct processes exited `0`.  The aggregate process exited `0` with
the exact terminal marker `Build completed successfully (9151 jobs).`

## Declaration and trust audit

The three result modules contain the following syntactic public declarations:

| Module | Theorems | Definitions | Structures | Declared axioms | Total |
|---|---:|---:|---:|---:|---:|
| Danilov global sieve | 43 | 28 | 2 | 0 | 73 |
| Pell prime-index boundary | 9 | 0 | 0 | 0 | 9 |
| Affine elementary boundary | 5 | 0 | 0 | 0 | 5 |
| **Total** | **57** | **28** | **2** | **0** | **87** |

The source scan found no declaration beginning with `axiom`, `opaque`, or
`unsafe`, and no occurrence of `sorry`, `admit`, or `native_decide`.  The
direct `#print axioms` output contains only the standard dependencies
`propext`, `Classical.choice`, and `Quot.sound` where dependencies occur.
It contains no `sorryAx`, `Lean.ofReduceBool`, `Lean.trustCompiler`, or other
native-evaluation dependency.

The Danilov module therefore checks the explicit modular certificates by
kernel reduction.  The Pell module checks only the abstract valuation lemma,
the exact index-seven obstruction, and the elementary real inequality; it
does not import Cohn, Ljunggren, or Sanna as axioms.  The affine module checks
the three pair projections, the same-prime exclusion, and the integer
geometric-mean step; it does not import the de Bruijn/BBLT counting estimate
as an axiom.

## Machine-readable evidence

- `validation-run.json` records tool versions, exit codes, job count, scans,
  and declaration counts.
- `artifact-manifest.json` records SHA-256 hashes and byte sizes for the source,
  research, and paper inputs used by this run.
- `*-direct.log` records direct elaboration and `#print axioms` output.
- `aggregate-lake-build.log` records the complete 9151-job build.

The exact mathematical status is unchanged by validation: no unconditional
term of type `ABCConjecture`, and no unconditional term of its negation, has
been produced.
