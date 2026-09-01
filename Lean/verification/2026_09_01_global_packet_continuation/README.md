# Global packet continuation verification

This directory records a reproducible verification run for the five Lean modules added in the 2026-09-01 global-packet continuation:

- `AffineRadicalStep20260901.lean`
- `DanilovRecursiveLift20260901.lean`
- `DanilovSimplePrimitiveNoGo20260901.lean`
- `IUTLanaSpecificationNoGo20260901.lean`
- `PellPrimeRankCounterexamples20260901.lean`

The driver resolves every repository path from its own location. It first verifies all 18 frozen inputs in `input-manifest.json`. It performs a direct Lean compilation of each module, checks that the aggregate imports all five modules, and runs the exact aggregate command `lake build IUTThreeClosures`. It scans these five source files for declarations beginning with `axiom`/`axioms`, `opaque`, or `unsafe`, including common declaration modifiers, and for the proof-placeholder tokens `sorry`, `admit`, `native_decide`, and `sorryAx`. It checks the explicit per-module declaration baseline, totaling 122 theorems/lemmas, 37 definitions/abbreviations, 5 structures/classes/inductives, and 164 counted top-level declarations. It parses all 83 expected `#print axioms` reports, allowing only `propext`, `Classical.choice`, and `Quot.sound`.

The same run validates the final manifests for these computation bundles:

- `research/computation/2026_09_01_affine_matching_lower_gate`
- `research/computation/2026_09_01_danilov_recursive_lift`
- `research/computation/2026_09_01_danilov_simple_primitive_divisor`
- `research/computation/2026_09_01_pell_packet_global_attack`

Manifest paths, byte lengths, hashes, declared counts, and the registered top-level evidence file sets are checked. Python interpreter cache directories named `__pycache__` and executable files with the `.exe` suffix are excluded because they are replay by-products rather than evidence artifacts.

It also checks the pinned IUT/Lana source snapshot at commit `ddaddc274281adb5674d647e24fa478745ac6d40`, its source metadata, and the earlier IUT specification-no-go replay package. The specialized package's own `replay.ps1` is executed, logged, and then checked again to ensure replay did not alter its frozen evidence.

Run from any working directory with PowerShell:

    & '<repository>/Lean/verification/2026_09_01_global_packet_continuation/validate.ps1'

Then verify the immutable output set:

    & '<repository>/Lean/verification/2026_09_01_global_packet_continuation/verify-package.ps1'

`validation-run.json` is the structured result. `input-manifest.json` freezes the principal Lean, computation-manifest, and IUT-snapshot inputs and is checked both before and after validation. The `logs` directory contains command transcripts, exit-code files, declaration counts, scans, and manifest audits. `SHA256SUMS` covers every package file except itself and is checked against the exact package file set.

This package verifies the formal statements actually present in the five modules. It does not formalize external analytic estimates, primitive-divisor existence hypotheses, Wall-Sun-Sun assertions, or the IUT claims represented by the pinned snapshot. It neither proves nor disproves the standard abc conjecture.
