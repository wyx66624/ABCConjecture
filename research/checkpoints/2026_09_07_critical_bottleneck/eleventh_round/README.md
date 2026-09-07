# Eleventh continuation: global signed bridge and actual squarefree window

This directory contains ordinary proofs, their independently reviewed
paper transcriptions, and a narrowly scoped Mathlib formalization.
It does not contain a proof or disproof of ABC.

## Mathematical files

- large_cutoff_signed_bridge.md (LC1--LC3): one actual majority set
  independent of moving reciprocal caps; explicit global signed and
  radical transfers. Cap or net-budget membership above the cutoff
  remains an explicit sufficient condition.
- squarefree_outer_window.md (SQ1--SQ3): at prime exponent n, almost
  every actual root in the n^4 block has all supported primes in
  (n^4, floor(n^4 log n/log log n)] at depth one simultaneously.
  This window's typical full mass is sublinear; the farther top-rank
  packet and exceptional roots remain unresolved.
- ordinary_global_bridge.md: finite proof and exact scope preceding
  the new Lean implementation.
- paper/large_cutoff_signed_bridge.tex,
  paper/squarefree_outer_window.tex,
  paper/actual_global_signed_bridge.tex: self-contained paper inputs.
- review.md: mathematical and transcription review ledger.

LC and SQ have full independent ordinary approval. All three paper
inputs have final independent transcription approval. SQ was reviewed
in full by root, adversarial_audit and independent_route. Its analytic
theorem is not represented as formalized by the finite Lean module.

## Actual finite formalization

Lean/ActualGlobalSignedBridge.lean proves nine declarations, connecting
the existing actual Nat.factorization and Real.log sums to the global
signed cost, with a global radical height transfer, the explicit
39/43 numerical transfer, and the finite actual arm bound with 3/2
of the full small-prime mass.

The source was freshly compiled with Lean 4.32.0, warnings as errors,
and Mathlib commit 81a5d257c8e410db227a6665ed08f64fea08e997.
All nine new and 24 local dependency declarations were freshly checked
and all 33 have explicit axiom queries. Only propext, Classical.choice
and Quot.sound occur. The precompiled Mathlib cache was reused.

The WSL command is python3 followed by
research/checkpoints/2026_09_07_critical_bottleneck/eleventh_round/verify_global_logs.py
and --project /root/abc-lean-build, run at the repository root.
The project argument is the verified WSL-local pinned cache.
The driver checks its pin and uses fresh copied local sources. Evidence
is recorded in verification/global_log_validation.json and its log.
Root subsequently performs the larger joint-round build; that separate
manifest is maintained in root's checkpoint.

Final module SHA256:
92145cb1ee76d9e125fcb91fd695f2ffb1fe673d58d0148b80a12ada2b90b26e.
Author fresh manifest SHA256:
cb46f1f823d81992649cf7924b0d21f880a0794af4fd9cc241c34000725c2df6.

The Lean signatures retain explicit height, tail and small-mass
hypotheses. They do not prove those analytic hypotheses, prime-rank
distribution, actual cap membership, or control of exceptional roots.
New research beyond this sealed batch is placed in twelfth_round.
