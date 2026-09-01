# Prime/unit, two-arm, and order-layer verification

This directory freezes the reproducible verification for the September 1,
2026 continuation joining eight Lean modules:

- `CarellaGlobalOmegaHypothesis20260901.lean`;
- `IUTPrimeUnitLabelVectorBridge20260901.lean`;
- `AffineTwoArmCRTPacket20260901.lean`;
- `MersennePrimeLayerRadical20260901.lean`;
- `MersenneOrderBlockDecomposition20260901.lean`;
- `MersenneOrderBlockAsymptotic20260901.lean`;
- `MersenneCanonicalBlockWitness20260901.lean`;
- `MersenneWieferichTailReduction20260901.lean`.

The driver freezes only stage-zero Git-indexed sources: all indexed local Lean
sources outside verification/build directories, together with the selected
paper and evidence inputs. Every input-manifest row records the Git blob object
ID, and the raw working-tree bytes must equal that indexed blob. Ignored or
untracked scratch files therefore cannot enter the frozen snapshot or make a
clean checkout incomplete. The driver verifies every frozen source against
`input-manifest.json`,
compiles each module directly with zero warnings, resolves theorem/lemma and
`#print axioms` targets to their complete namespace-qualified Lean names, and
requires the compiler to emit exactly one matching report for each target. It
rejects `sorry`, `admit`, `native_decide`,
`sorryAx`, declared axioms, opaque declarations, and unsafe declarations.
Partial and external declarations are rejected as well.
Only `propext`, `Classical.choice`, and `Quot.sound` are permitted.  It also
checks all aggregate imports, runs both `lake build IUTThreeClosures` and a
direct aggregate compilation, and verifies that every input matches the frozen
manifest and Git index at both the start and the end of the run. The recorded validation also
pins the exact `validate.py` and `validate.ps1` bytes that produced it. Every
Lake Git dependency must be clean and checked out at the revision pinned by
`lake-manifest.json`, both before and after the run.

The sealed `logs/` and `validation-run.json` record one maintainer run.
Ordinary reproduction runs write to the ignored repository `tmp/verification`
area, leaving the sealed package byte-for-byte unchanged.  Thus rerunning the
validation and then checking `verify-package.ps1` is a valid immutable
round-trip.

The evidence replay checks exact SHA-256 manifests for the affine and
Mersenne computation bundles and all three source ledgers.  It recomputes the
affine CRT packet, including the complete first-row factorization and the
failure of the three-quarter inequality.  It also regenerates the prime-index
Mersenne scan through 61 in a temporary directory, independently verifies
all 17 rows, and requires byte equality with both frozen JSON files.  The IUT
source verifier checks four primary files and the pinned Project LANA commit.
The Mersenne delivery manifest's report, Lean-module, and source-ledger hashes
are checked against the same frozen input inventory, so a locally consistent
computation bundle cannot retain a stale cross-directory reference.

The Mersenne order-layer modules kernel-check the fixed-index exact-order fibre
product decomposition, including the lifting factor and the complete `m = 6`
identity. They also prove the asymptotic implication from the explicitly stated
open hypothesis that the canonical order-block logarithmic mass is
`o(Nat.totient d)`. They also kernel-check the explicit canonical-block witness
at `(d, q) = (364, 1093)`, including its exact multiplicative-order and
factorization certificates. The verification does not assert the open
asymptotic hypothesis. The tail-reduction module separately kernel-checks the
finite/abstract Wieferich-mass dichotomy, its finite support-cardinality and
log-budget consequences, and the resulting ambient square-budget ratio bound,
while retaining its external
Brun--Titchmarsh-style input as an explicit hypothesis.

These checks certify only the displayed mathematical statements and finite
computations.  A finite no-hit remains finite evidence.  The package does not
claim a proof or disproof of the standard abc conjecture, and it does not
identify a model prime/unit signature with the complete published IUT output
carrier.
