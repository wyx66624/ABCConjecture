# Fourteenth round: adaptive precision, maximal depths and private density

The complete ordinary proofs were reviewed independently by root and
both peer routes before their selected finite cores were formalized.
The previous thirteen published rounds remain unchanged.

## Ordinary results and papers

- adaptive_precision.md proves AP1--AP4: the actual single-arm height
  cap, precision independent of moment length, complete per-prime
  positive excess at most 13 n log(8B), normalized 26/B, and the
  explicit but unproved far-prime cardinality interface.
- two_owner_concentration.md proves OC1--OC3: two actual maximal-depth
  indices contain all sufficiently deep roots, their complete finite
  remainder is at most 39 n^(5/6) log(8B), and sufficiently large prime
  labels have at most two positive-excess endpoints.
- private_density_gain.md proves DG1--DG4: a fixed-discriminant cofactor
  sieve with epsilon-uniform error, then an actual private independent
  domain of density at least 1/2+delta0 for some absolute delta0>0.
  The full-block mass inequality is used once.

paper/adaptive_precision.tex includes both AP and OC, with their full
proof chain and exact formal scope. paper/private_density_gain.tex
contains the complete density proof and precise primary inputs.
Both peer routes read both final TeX files, all PASS. These reviews
do not substitute for later PDF rendering and visual inspection.

## Twelve actual finite statements

Lean/AdaptiveOwnerArithmetic.lean has twelve declarations. It proves
actual finite maxima, deep-set containment, complete natural-excess
summation, real weighting, actual natural ceiling thresholds and the
final selected-set weighted budget. It includes genuine empty and
singleton cases and keeps natural truncated subtraction before casting.
The symmetric-count and pointwise-height hypotheses are explicit.

The author freshly compiled all twelve and the fifteen listed old
local dependencies with warnings as errors under Lean 4.32.0 and
Mathlib 81a5d257c8e410db227a6665ed08f64fea08e997. All 27 axiom
queries passed using only propext, Classical.choice and Quot.sound.
Root and both peer routes independently read the final source, all
PASS. Root also ran a separate joint 35-new/15-old fresh compilation.
Pinned Mathlib compiled dependencies were reused; no whole-Mathlib or
whole-repository rebuild is claimed.

Run the bounded author verifier under WSL:

    python3 research/checkpoints/2026_09_07_critical_bottleneck/fourteenth_round/verify_owner.py --project /root/abc-lean-build

Its source hashes, full declaration names and build scope are in
verification/owner_validation.json, and every axiom output is in
verification/owner-lean.log. review.md records independent ordinary,
formal-source and transcription audits, including the root density
module and the independent SS/VG results.

## Exact remaining scope

No theorem here controls the unrestricted cumulative cost of changing
maximal-depth owners. The number of distinct far deep primes, their
joint weights, pointwise exceptional roots and the independent-domain
complement are unbounded by these results. Signed credit can make the
positive-excess sufficient target stronger than necessary.

The actual torsion/lifting and ideal-valuations input, the primary
sieve and prime-distribution estimates, and the real fractional-power
constants 39/78 remain ordinary mathematics. The complete analytic
density theorem and ABC itself are not claimed as Lean theorems.

Files whose names start with next_ are separate later candidates.
In particular next_bounded_length_moments.md is excluded from this
round's paper, formal validation and release source-evidence inventory.
