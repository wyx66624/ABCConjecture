# Ninth round: actual signed arm compensation and split progression support

The ordinary results below have complete independent mathematical reviews.
They give a rigorously specified homogeneous signed-tail subclass and a
necessary progression condition for actual simultaneous pure-power norms.
They do not prove general membership in that subclass or solve ABC.

## Ordinary papers

- `signed_arm_compensation.md` proves actual integer arm quotients, their
  additive relation, a finite signed inequality allowing the third arm
  arbitrary depth, and the uniform sufficiently-large-exponent consequence
  when the other two arms supply enough credit. The analytic estimate uses
  the previously reviewed LR2 logarithmic-form theorem.
- `split_progression_compatibility.md` combines the actual first power root
  with the common-exponent factorization to place almost all denominator
  valuation mass in the split progression 1 modulo 6p. It retains all old
  input-arm depths, and bounds full valuations rather than the radical.
- `paper/signed_arm_compensation.tex` and
  `paper/split_progression_compatibility.tex` are the complete manuscript
  transcriptions, with final independent and root transcription approval.
- `review.md` records ordinary, transcription and source reviews, including
  the companion CE, PP and EP arguments. `ordinary_formal_scope.md` explains
  the exact ordinary-to-Lean portion of the signed arm proof.

## Actual Lean verification

`Lean/SignedArmArithmetic.lean` contains 32 proved declarations. These cover
the normalized actual integer powers, modular congruence propagation,
three coordinate divisibilities, quotient reconstruction, their additive
and boundary-product identities, the exact norm, coprimality under explicit
output primitivity, finite integer-weight depth/radical ledgers, and local
signed overlap bounds. Its final SHA256 is

`c9b1b53f7f35b7c2e9f7004c482f182cc1346ff01ca1e66556473c6341ef05aa`.

The actual fresh scoped Lake build passed under Lean 4.32.0 with warnings
treated as errors: 32 new theorems plus 39 dependency theorems, complete
axiom-query coverage, and only `propext`, `Classical.choice`, `Quot.sound`.
Both research peers independently read and approved all new source
signatures and proofs. The build is independently reproducible with
`python3 verify_lean.py` in an environment exposing Lean 4.32.0 and Lake.
It copies exact sources into a new temporary project; it is not a claim
that a complete repository build was performed by this script.

The exact theorem inventory, source hashes and compiler information are in
`verification/lean_validation.json`; the full captured output is in
`verification/fresh-lake-build.log`. Real logarithmic weights, prime-rank
and valuation laws, primitive-power preservation, the LR2 analytic theorem,
and general compensation membership are outside this formal module.

## Exact finite evidence

`python replay.py --check` recomputes six polynomial quotient rows, 113
actual primitive unramified cases and 678 exact rational instances of the
finite signed inequality, then checks the canonical bytes of
`finite_replay.json`. It also verifies by complete trial division an
actual example with a private prime of depth four in one quotient and
squarefree other quotients. The compact payload seal is
`4292da9eb4d642cf99c5e7530e8d462f12da945887d96086d325c56a04d02e8f`;
the complete UTF-8 LF JSON byte SHA256 is
`8e6a5da3fdc84d316ea2ef3cd98c74e6c111de04584e7e20a5706657f72f4132`.
These checks are finite evidence, not an infinite membership theorem.

The diagnostic `probe_arm_depth.py` was exploratory and is not part of the
verification gate. All continuing mathematical work is placed in the
separate tenth-round directory. Ninth-round mathematics and its Lean
source are frozen for root integration; a requested PDF visual review may
be added as separate verification documentation.
