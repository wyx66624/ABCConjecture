# Holonomy, density, and depth continuation verification

This directory records a reproducible verification run for the four Lean modules added in the 2026-09-01 holonomy, density, and depth continuation:

- `AffineDensityAttack20260901.lean`
- `PellFourPrimeCoupling20260901.lean`
- `DanilovWSSEscape20260901.lean`
- `IUTCorrectedVolumeHolonomy20260901.lean`

The driver resolves repository paths from its own location and verifies the 24 principal inputs frozen in `input-manifest.json` both before and after the run. It compiles every module directly, requires zero warnings in those four direct compilations, confirms that the aggregate imports all four modules, and runs `lake build IUTThreeClosures`.

Before source scanning and declaration counting, the driver removes line comments and arbitrarily nested Lean block comments while preserving line numbers. It rejects declarations beginning with `axiom`/`axioms`, `opaque`, or `unsafe`, including the usual declaration modifiers, and rejects the proof tokens `sorry`, `admit`, `native_decide`, and `sorryAx`. The exact baseline is 65 theorems/lemmas, 18 definitions, 4 abbreviations, 5 structures/classes/inductives, no instances, and 92 counted top-level declarations. All 58 `#print axioms` reports are parsed. Only `propext`, `Classical.choice`, and `Quot.sound` are permitted.

The same run checks exact file membership and SHA-256 manifests for three computation bundles:

- `research/computation/2026_09_01_affine_density_attack`
- `research/computation/2026_09_01_pell_four_prime_coupling`
- `research/computation/2026_09_01_danilov_wss_escape`

The affine replay recomputes the finite 20-seed conic search and confirms 49,671 admissible rows, zero exceptions, and the explicit `finite_no_hit_only` scope. The Pell replay verifies its strict manifest, independently recomputes the three recorded exact-depth-two rows with arbitrary-precision arithmetic, and recomputes 13 coupling examples. It does **not** rerun either C++ scan through `q <= 10^9`; instead it verifies the frozen dual implementations and outputs by exact manifest, checks that both record 50,847,533 tested odd primes and the same three hits `13,31,1546463`, and records zero valuation-at-least-three hits. The Danilov replay verifies both manifests, all eight upstream hashes, the exact 4,398-digit squarefree state with 638 prime factors, the `2^638-622` factor-bound count, and the bounded `Q <= 1000` audit. These finite results are evidence within their stated ranges; a no-hit is not treated as a counterexample to an asymptotic or global route.

Before and after replay, the driver explicitly fails if any evidence root contains an `.exe` file or a directory named `__pycache__`. Such artifacts are rejected rather than silently omitted from manifest membership.

Three source ledgers are also checked. The affine and Pell ledgers freeze two papers each. The corrected IUT volume/holonomy ledger is checked by its own verifier against five referenced primary-source files and Project LANA commit `ddaddc274281adb5674d647e24fa478745ac6d40`, using the metadata field `projectLana.mainCommit`.

Run from any working directory with PowerShell:

    & '<repository>/Lean/verification/2026_09_01_holonomy_depth_continuation/validate.ps1'

Then verify the immutable package file set:

    & '<repository>/Lean/verification/2026_09_01_holonomy_depth_continuation/verify-package.ps1'

`validation-run.json` is the structured result. `input-manifest.json` freezes the principal Lean, report, paper, computation-manifest, and source-ledger inputs. The `logs` directory contains command transcripts, exit codes, source scans, declaration counts, replay audits, and the human-readable summary. `SHA256SUMS` covers every package file except itself and is checked against the exact package file set.

This package verifies the formal statements and finite computations actually present in the continuation. It does not turn the route hypotheses into unconditional theorems, and it neither proves nor disproves the standard abc conjecture.
