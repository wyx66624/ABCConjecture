# Validation record

The recorded run completed successfully on September 1, 2026.  The exact
machine-readable evidence is in `validation-run.json`,
`declaration-inventory.json`,
`lucas-all-order-independent-verification.json`, and `logs/`.

## Frozen inputs and declarations

The input manifest freezes 561 files, including every configured local Lean
source outside verification directories, the four checkpoint modules, Lake
configuration, route registries and mathematical reports, literature-audit
notes, computation evidence, the integrated TeX manuscript, the final PDF,
and its complete QA directory.  Its SHA-256 digest is
`4f25c6d6b68ddc336c799d0295f26538078dadc5c0d577b0e6da9aace2d23090`.
All 14 Lake Git dependencies were clean at the revisions pinned by
`lake-manifest.json`.

| Module | Theorems | Definitions | Structures | Private proofs | Proof reports |
|---|---:|---:|---:|---:|---:|
| `AffineCatalogueWeightOverlap20260901` | 14 | 5 | 0 | 0 | 14 |
| `IUTRationalDegreeOneSourceRealization20260901` | 17 | 10 | 1 | 0 | 17 |
| `MersenneBalancedMultiplierDepthLocalization20260901` | 14 | 0 | 0 | 0 | 14 |
| `PellLucasAllOrderStaircase20260901` | 22 | 3 | 0 | 0 | 22 |
| **Total** | **67** | **18** | **1** | **0** | **67** |

There are 86 counted declarations.  The validator hard-checks every
per-module count and the totals during both live validation and sealed-record
verification.  Every theorem has exactly one generated `#print axioms`
report.  The deterministic same-scope audit digest is
`00a4dc3c0c02bbcdf74b581761929e504a8ca6c577289b167534da08a35ee0ce`;
the declaration inventory digest is
`ee2c30b6cbf2c8f902933f975f9278ac71abad3b27d100e8bc8e0a33739d5b5d`.
The axiom union is exactly:

- `Classical.choice`;
- `Quot.sound`;
- `propext`.

No target source contains `sorry`, `admit`, `native_decide`, `sorryAx`, a
custom `axiom` declaration, `opaque`, `unsafe`, `partial`, or `extern`.

## Compiler and computation replays

All four direct module compilations exited zero with warnings promoted to
errors.  The generated axiom audit also exited zero with no warnings.
`lake build IUTThreeClosures` completed successfully with exactly 9,229 jobs.
Its 301 warnings are retained pre-existing aggregate-project warnings; none
arises in a direct checkpoint-module or generated-audit compilation.

The independent Pell--Lucas output has SHA-256
`9abb1c35d3668ff5d8b7529faf33d846a6871b90c2969a41616a22bfa6e9c00d`.
It independently recomputes the local rows by binary powering in
`Z[T]/(T^2-6T+1)`, hard-checks that their target residues are exactly
`0,1,2,3,4` modulo five, and replays the all-order coefficient staircase,
normalized-tail coprimality, companion correction, and channel splitter for
indices `3,5,7,11` using binary Binet and Pell powering.

The frozen delivery PDF is the 182-page A4 manuscript by ChatGPT with SHA-256
`94168cdd83388ff58cf03008c120204debb21755b4be4f72c8914656456a1d15`.
Its QA record includes full-page rendering, ten contact sheets, 18 selected
high-resolution inspections, embedded-font and link checks, and a clean final
log apart from one cosmetic underfull page-break warning.

The finite counterexamples in this checkpoint retire only their exact
full-premise strengthenings: the affine `L_T >= D-T` bound, repeated
exact-order multiplier at least three, fixed-zero Pell local rigidity, and
weakened abstract IUT extraction claims.  They do not retire the corrected
affine, Mersenne, Pell/Lucas, or IUT routes.  This package certifies the local
theorems, source-placeholder exclusion, one-for-one axiom reporting, finite
computation replay, frozen inputs, and aggregate integration.  It does not
claim an unconditional proof or disproof of the standard abc conjecture.
