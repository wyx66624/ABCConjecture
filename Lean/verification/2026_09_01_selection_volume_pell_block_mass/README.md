# Selection, admissible-volume, Pell-residue, and block-mass verification

This package validates four Lean modules from the September 1, 2026 abc
research checkpoint:

- `AffineCommonKernelTripleSelection20260901.lean`;
- `IUTAdmissibleVolumeIntegerBridge20260901.lean`;
- `MersenneFixedPolylogBlockMassTriage20260901.lean`;
- `PellResidueParityLocalization20260901.lean`.

The validator strips comments, strings, and attributes before scanning for
proof placeholders, custom axiom declarations, native evaluation, opaque or
unsafe declarations, partial definitions, and external declarations. It
parses every theorem and lemma with its exact namespace and generates one
independent `#print axioms` query per proof declaration.

Because Lean hides private declarations after import, `axiom-audit.lean`
deterministically amalgamates the exact four source bodies and runs all 94
queries in their original scopes. The package also compiles each module with
warnings treated as errors, checks every pinned Lake dependency, freezes all
local Lean inputs, and rebuilds the aggregate `IUTThreeClosures` target.

The frozen evidence additionally includes the exhaustive base-two Wieferich
scan through ten million, its independent segmented-sieve verifier, the four
mathematical reports, the journal paper sources, and the final PDF. The finite
scan is used only to refute stated finite strengthenings; it is not treated as
evidence for an asymptotic assertion.

These checks establish the stated finite algebra, conditional transfer
theorems, and full-premise counterexamples to narrow strengthenings. They do
not prove or disprove the standard abc conjecture, and they do not retire any
of the four surviving broad routes.
