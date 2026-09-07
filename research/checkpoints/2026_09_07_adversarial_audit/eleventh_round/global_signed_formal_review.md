# Independent review of the actual global signed bridge

Date: 2026-09-07. Full source, theorem-signature, proof, and validation
inventory review PASS. The author ran the fresh compilation; this reviewer
read its complete output and independently checked current source hashes
and declaration/query counts without duplicating the build.

Source: `2026_09_07_critical_bottleneck/eleventh_round/Lean/ActualGlobalSignedBridge.lean`.
SHA256: `92145cb1ee76d9e125fcb91fd695f2ffb1fe673d58d0148b80a12ada2b90b26e`.

All nine declarations were read in full. The cutoff monotonicity applies
to the actual prime weights and finite prime-factor sums. The zero-cutoff
identities and mass partition give the global signed inequality; the
small-prime signed contribution is bounded above by its full mass, not
silently removed. The height transfer uses a lower bound on log N and
upper bounds on the actual tail and low-prime mass, all explicit in the
signature. The numerical theorem requires n nonzero and t positive, and
correctly combines 4+39=43 and 2 eta+eta=3 eta before division by 3t.
It retains the signed net cost in its valid finite inequality.

The final finite arm theorem applies to positive actual natural-number
factors with the stated pairwise coprime arms and coordinate height
bounds. The previously proved half low-mass term and the global
conversion's additional full low mass yield exactly 3/2 times the
small-prime mass. No implicit analytic estimate or membership assertion
is used. The global radical is the defined actual prime-log sum at cutoff
zero; no new formal identification with a separate Nat.radical API is
claimed here.

The source does not formalize the existence/density of the analytic good
set, the elementary angular and 2/3 estimates, arbitrary reciprocal-cap
membership, exceptional-root control, or ABC.

Manifest:
`2026_09_07_critical_bottleneck/eleventh_round/verification/global_log_validation.json`.
SHA256: `cb46f1f823d81992649cf7924b0d21f880a0794af4fd9cc241c34000725c2df6`.
Build/axiom log SHA256:
`fed999a9808ebe2f48a40699ad416cc1838cf20815e33cbf16ab298e16a37e46`.

The evidence records nine new declarations and 24 unchanged declarations
from the two actual prime-log modules, all three local sources freshly
compiled. All 33 theorem queries are present in the inspected output;
their axiom union is only propext, Classical.choice, and Quot.sound.
Lean 4.32.0 commit 8c9756b28d64dab099da31a4c09229a9e6a2ef35 and Mathlib
81a5d257c8e410db227a6665ed08f64fea08e997 are the recorded versions.
The pinned Mathlib dependency cache was reused, not rebuilt in full.
