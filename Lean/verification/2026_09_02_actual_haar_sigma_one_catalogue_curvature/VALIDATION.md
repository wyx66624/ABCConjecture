# Validation record

The recorded run completed successfully on September 2, 2026. The exact
machine-readable evidence is in `validation-run.json`,
`declaration-inventory.json`, `evidence-replay.json`, and `logs/`.

## Frozen inputs, Git index, and declarations

The input manifest freezes 872 files. It covers every configured local Lean
source, the four target modules and two author audits, Lake configuration,
research status and route registry, the four route reports, combined report
and adversarial audits, cited primary-source artifacts, all four computation
bundles, the complete 68-file TeX source tree, the final PDF, and its complete
QA directory. Its SHA-256 digest is
`fc62b6f7bf6a16a40ddf4aab811d27963e6afb60ea11cc8f245f93eed8d43dbd`.
The text-hygiene gate checked 629 UTF-8 files. All 14 Lake dependencies were
clean at the revisions pinned by `lake-manifest.json`.

The validator read the stage-zero Git blob for every one of the 872 manifest
paths with `git cat-file --batch`. All 872 paths existed in the index, and
each blob's raw byte length and SHA-256 exactly matched the corresponding
worktree input-manifest row. This covered 72,075,451 bytes. The ordered
path-and-object-ID ledger has SHA-256
`46945928dd05bb12a5c0a2fa09db6d9282ae083cfbb9355182c44123c74afa98`.
The same byte comparison passed both before and after the compiler and
computation runs. Both `git diff --check` and
`git diff --cached --check` exited zero with empty output.

| Module | Theorems | Definitions | Other | Private proofs | Axiom reports |
|---|---:|---:|---:|---:|---:|
| `IUTActualHaarAdmissibleOrbit20260902` | 33 | 8 | 1 structure | 0 | 33 |
| `MersenneSigmaOneExactOrderCoupling20260902` | 19 | 6 | 1 abbrev, 1 structure | 0 | 19 |
| `AffineInversePeriodCatalogueNovelty20260902` | 26 | 0 | 0 | 0 | 26 |
| `PellLucasFactorQuotientProjectiveCoupling20260902` | 24 | 4 | 0 | 0 | 24 |
| **Total** | **102** | **18** | **3** | **0** | **102** |

There are 123 counted declarations. The generated audit imports the exact
compiled modules and contains one `#print axioms` query for every public
theorem. Its digest is
`6f4891cf37de8bedc61cf2f80fd7e33581d0fc6a5add251ed026fc59d5dd73ee`.
The declaration inventory digest is
`38a5e55d77080d1a6fb19c438e5626815c4208776e7e12baaeaaeb72d0ae7c80`.
The axiom union is exactly:

- `Classical.choice`;
- `Quot.sound`;
- `propext`.

No target source contains `sorry`, `admit`, `native_decide`, `sorryAx`, a
custom `axiom` declaration, `opaque`, `unsafe`, `partial`, or `extern`.

## Compiler and computation replays

All four direct module compilations exited zero with warnings promoted to
errors; each had zero warnings. The 102-query generated audit also exited
zero with no warning. `lake build IUTThreeClosures` completed successfully
with exactly 9,239 jobs. Its 301 warnings are retained pre-existing aggregate
project warnings and do not arise in the direct target or audit compilations.

The independent evidence document has SHA-256
`5aac742593b5a20151c6e89d1561b551d34beb8df5fbeeb13671c1f02de12c1d`.
It verifies 43 manifest entries and regenerates:

- 20 actual-Haar normalization rows, the normalized packet identity, and the
  full residue-degree-two raw-volume counterexample;
- the exact Mersenne witness and rational logarithmic certificates, together
  with a fresh C++20 scan of all 50,847,534 primes through `10^9`, reproducing
  exactly the 1093 and 3511 rows;
- all six affine computations, including 755,322 selected points, 3,885
  kernel classes, 48,400 general Euler cases, 10,001 occupancy cases, and the
  exact `23392/23701` subcritical weight ratio;
- the Pell producer and independent verifier, including 57 endpoint rows
  through index 271, 13 factor-quotient rows, the local `(3,7,797)` witness,
  and the exact index-seven endpoint sharpness certificate.

The recorded validation JSON has SHA-256
`d3c706a85a8cb57c300b10138215ba959ae52e95a90c646eb047cfcb4d65a01e`.
The run used Lean 4.32.0, Lake 5.0.0, Python 3.13.5, and GCC 15.1.0; the full
version strings are recorded in that JSON.

## Paper and claim boundary

The frozen delivery is the 202-page A4 manuscript by ChatGPT with SHA-256
`cbe3693431fd9f969531fa8c7a0669e3afe1c8cd29aa36a2c1af497f1024451f`.
Its QA package records a successful Tectonic rebuild, exact equality of
extracted text and media boxes on all 202 published and recompiled pages,
all-font embedding, structural checks, all-page 105-dpi rendering, 17 contact
sheets, and 16 selected 180-dpi inspections. The published PDF was unchanged
by the final source-whitespace correction. The final visual and structural
verdict is PASS.

Exact counterexamples retire only the claims whose full premise lists they
satisfy. The raw-Haar residue-degree example does not retire the normalized
admissible IUT interface. The 1093 and 3511 certificates do not retire the
sigma-one average route. The affine period-one examples do not retire bounds
using cross-class geometry or catalogue sparsity. The Pell local and
index-seven examples do not retire the global squarefull-packet route. No
bounded no-hit search is upgraded to an asymptotic theorem.

This package certifies the checkpoint's local theorems, source-placeholder
exclusion, one-for-one axiom reporting, full finite-computation replay,
byte-identical Git-index coverage, frozen inputs, PDF delivery, and aggregate
integration. It does not claim an unconditional proof or disproof of the
standard abc conjecture.
