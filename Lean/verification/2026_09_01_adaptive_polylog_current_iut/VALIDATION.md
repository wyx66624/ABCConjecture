# Validation record

The recorded run completed successfully on September 1, 2026. The exact
machine-readable evidence is in `validation-run.json`,
`declaration-inventory.json`, `input-manifest.json`, and `logs/`.

## Main pinned checkpoint

The frozen input manifest contains 473 files. It includes every Git-tracked
local Lean source outside verification directories, the four checkpoint
modules, and the Lake configuration. Every Lake Git dependency is required to
be clean at the revision in `lake-manifest.json`.

| Module | Theorems | Lemmas | Definitions | Private proofs |
|---|---:|---:|---:|---:|
| `AffineAdaptiveCommonKernel20260901` | 29 | 0 | 10 | 3 |
| `MersennePolylogCodivisorGate20260901` | 10 | 4 | 4 | 0 |
| `MersenneNearDiagonalGlobalTriage20260901` | 8 | 0 | 1 | 0 |
| `IUTLanaCurrentConcreteImplicationAudit20260901` | 5 | 0 | 1 | 0 |
| **Total** | **52** | **4** | **16** | **3** |

There are 72 counted declarations and 56 theorem-or-lemma declarations. The
generated same-scope audit issues exactly 56 `#print axioms` commands, including
the three private affine proofs. Its axiom union is exactly:

- `Classical.choice`;
- `Quot.sound`;
- `propext`.

All four direct compilations and the generated audit exited zero with zero
warnings. `lake build IUTThreeClosures` completed 9,216 jobs with no error. Its
300 warnings are inherited aggregate-project diagnostics; none occurs in a
direct checkpoint-module or generated-audit run.

The code-only scan finds no proof placeholder, custom axiom declaration,
`native_decide`, opaque declaration, unsafe definition, partial definition, or
external declaration in the four target sources.

## Detached public LANA snapshot

Public commit `6e963070c73c5defd1012320deccc777e2555d22` was checked in an isolated
worktree with the copied exact manifest. `lake build Iut` completed all 8,758
jobs. The separate source `detached-current-iut-audit.lean` then compiled and
proved `LocalTheory K -> False` by applying the unrestricted scaling field to
the empty set at the prime two. Both detached proof declarations report only
the same three standard axioms. See `DETACHED_CURRENT_IUT.md` for exact hashes.

The detached result retires only that total-real-valued specification. The
main build deliberately retains its reproducible older pin, and neither audit
is an unconditional proof or disproof of the standard `ABCConjecture`.

