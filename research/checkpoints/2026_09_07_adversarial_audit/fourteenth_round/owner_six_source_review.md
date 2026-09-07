# Independent six-statement adaptive-owner source review

2026-09-07, adversarial_audit. Full semantic review PASS for the six-statement snapshot of AdaptiveOwnerArithmetic.lean, source SHA256 1d68641084484d161316930b2cdfeeb1ca3f294a172a9b56d8472f8a2af7544b.

The cubic and two-owner thresholds are derived from actual Nat.choose identities; M=0 is covered, and the second statement explicitly requires positive r and r^2>=6n. No root count is silently defined to satisfy the conclusion.

The adaptive precision theorem uses the actual Nat.ceil of a real quotient and actual Nat subtraction before casting. It permits L=0 and r=0, with w>0. Its max-four branch is handled explicitly; the ceiling error is absorbed without a lost weight term. The complete_middle_layers theorem is pointwise Nat arithmetic and includes empty layer ranges.

exists_two_maximal constructs a subset using two successive genuine finite maxima, with empty and singleton cases. It proves both min(2,card s) and the ordering against every remaining index. two_maximal_contains_deep then proves containment of all deep indices from their actual filtered cardinality. It does not assume that containment as an owner-selection oracle. The choice need not be a deterministic tie break; existence is exactly the source statement.

The current source stops at these six conclusions. Although the ordinary plan also discusses finite sums, weights and adding back the owners, this snapshot has no such summed/weighted theorem. Those ordinary conclusions must not yet be described as formalized by these six declarations. Construction of actual valuations, finite-ring torsion, independence and analytic estimates remains outside the module.

I independently read the source and recomputed both listed source hashes, counted all six plus fifteen dependency declarations, matched all twenty-one recorded axiom-query outputs and checked the recorded log for errors/sorryAx. Its axiom output uses only propext, Classical.choice and Quot.sound. I did not rerun Lean. Evidence is in verification/owner_six_source_review.json; this record must remain scoped to six if later versions add declarations.
