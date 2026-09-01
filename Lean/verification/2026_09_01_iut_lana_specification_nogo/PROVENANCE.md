# Provenance

* Project LANA source snapshot:
  `ddaddc274281adb5674d647e24fa478745ac6d40` on branch `main`.
* Main project's pinned `iut` dependency:
  `ddaddc274281adb5674d647e24fa478745ac6d40`.
* Main workspace baseline commit observed during validation:
  `cc1e9ba899ed6b1bb268d4647a3dd4f71f901f57` on branch `main`.
* Lean toolchain: Lean 4.32.0, release commit
  `8c9756b28d64dab099da31a4c09229a9e6a2ef35`.

`Iut/Cor312/SpecificationNoGoAudit.lean` is a new untracked audit module in
the temporary pinned clone.  No tracked upstream source file was changed.

The main workspace was shared with other concurrent research work and was
already dirty.  This audit added
`Lean/IUTThreeClosures/IUTLanaSpecificationNoGo20260901.lean` and one import
block to `Lean/IUTThreeClosures.lean`.  The restricted status and exact hashes
observed at validation time are in `logs/provenance.log`.

SHA256 hashes for the immutable files in this replay bundle are recorded in
`SHA256SUMS`.

