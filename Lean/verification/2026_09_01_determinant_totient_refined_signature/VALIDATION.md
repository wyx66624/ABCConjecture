# Validation record

The recorded run completed successfully on September 1, 2026. The exact
machine-readable evidence is in `validation-run.json`,
`declaration-inventory.json`, and `logs/`.

## Source and declaration inventory

The frozen input manifest contains 469 files: every Git-tracked local Lean
source outside verification directories, the three checkpoint modules, and
the Lake configuration. The dependency audit also requires every Lake Git
checkout to be clean at the revision pinned by `lake-manifest.json`.

| Module | Theorems | Lemmas | Definitions | Private proofs | Proof reports |
|---|---:|---:|---:|---:|---:|
| `AffineDeterminantLayerEntropy20260901` | 30 | 0 | 1 | 13 | 30 |
| `MersenneTotientDivisorConcentration20260901` | 68 | 20 | 17 | 0 | 88 |
| `IUTRefinedFactorZeroAwareSignature20260901` | 7 | 0 | 8 | 0 | 7 |
| **Total** | **105** | **20** | **26** | **13** | **125** |

There are 151 counted declarations. Every one of the 125 theorem or lemma
declarations has exactly one generated `#print axioms` report. The independent
audit compiles with zero warnings. Its SHA-256 digest is
`4b85bba7b0294f5c20a13aab58c12e0645645853106f18f75957dd0d81f1c1c8`.

The axiom union is exactly:

- `Classical.choice`;
- `Quot.sound`;
- `propext`.

No target source contains `sorry`, `admit`, `native_decide`, `sorryAx`, a
custom `axiom` declaration, `opaque`, `unsafe`, `partial`, or `extern`.

## Compiler runs

All three direct module compilations exited zero and emitted zero warnings.
The generated axiom audit also exited zero and emitted zero warnings.
`lake build IUTThreeClosures` completed successfully with exactly 9,212 jobs.
Its 300 warnings are pre-existing aggregate-project warnings retained verbatim
in `logs/aggregate-lake-build.log`; none arises in a direct checkpoint-module
or generated-audit compilation.

The declaration inventory digest is
`8aafd3d9fb4e9b0bd90ef77b61010460c2e0ff65661632027dd08d980412044f`.

This validation certifies source-placeholder exclusion, direct compilation,
one-for-one theorem-level kernel-dependency reporting, frozen local inputs,
and the aggregate build at this checkpoint. It does not claim that the three
modules prove or disprove the standard abc conjecture.
