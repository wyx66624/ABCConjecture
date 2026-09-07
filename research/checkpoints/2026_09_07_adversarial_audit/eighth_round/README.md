# Eighth-round adversarial and independent review work

This directory adds new material without changing the frozen earlier
rounds. It contains no claimed proof or disproof of ABC.

* `cm_boundary_shadow.md`, CB1--CB5: complete ordinary proof reviewed
  independently by independent_route, critical_bottleneck and root.
  Each reopened the original projective-image target and published
  N_3=7 input. The positive finite local CM shadows coexist with a
  rigorous global exclusion of CM residual candidates. Only the pure
  fixed-level branch is reduced to the two non-CM orbits 288 and 576.
* `paper/cm_boundary_shadow.tex`: complete self-contained transcription;
  both independent_route and critical_bottleneck completed final review
  with PASS. The latter's one double-comma typo was corrected.
* `replay_cm_shadow.py` and `cm_shadow_results.json`: actual standard
  library replay, write and `--check` both PASS. Sixteen complete field
  counts, 81,376 affine states and 32 actual congruence shadows. The
  canonical JSON SHA256 is
  `a244f2e71b150a6e8076f86e22abea176f82e1348527e760fb4d79c23e2f09bd`.
* `all_index_window_review.md`: independent ordinary PASS of the
  critical-bottleneck all-index analytic window. Its finite endpoint
  and exceptional roots remain explicit.
* `replay_twist_independent.gp`, `replay_twist_independent.py`, and
  `independent_twist_results.json`: independent complete Sturm replay
  with 98,312 exact rational-coordinate comparisons, including every
  coefficient 0..12288 for both twist identities. Canonical JSON SHA256
  `9864149fe7dc844d34f71306192e49b05c90d40bb22728fe71940b173a9807e0`.
* `twist_sturm_review.md`: final full BT1--BT4 ordinary/source review
  PASS, preserving the exact-software dependency and all coefficient
  embeddings. Also records root's personally executed GP and wrapper
  checks, and its independent CM replay.
* `pure_power_height_review.md`: final full ordinary review PASS of
  root's HB1--HB4, including the strict cutoff and explicit threshold
  T>=e^2 for the inverted exponent bound.
* `torsion_support_review.md`: final full TS1--TS3 ordinary/source
  review PASS, including the F_p subcharacter descent, unique
  inertia-trivial Jordan--Holder character at p, and the strict
  support cutoff above p. It preserves the separate BT dependencies.
* `boundary_support_lean_review.md`: read-only final review PASS of
  root's ten new actual integer theorems, with all four dependency
  hashes matched to its fresh scoped build manifest. The trace-factor
  disjunction and root lower bound remain explicit formal antecedents.
* `paper_review.md`: final full transcription PASS of BT, TS and the
  root height/formal-scope section, after explicit prime and integer
  domain additions. Rendering is a separate check.
* `finite_verifier_review.md`: read-only review PASS of the three-case
  finite dispatcher and fixed-version workflow; it does not assert
  that remote CI has run before publication.

To replay the exact local supplement from the repository root:

    python research/checkpoints/2026_09_07_adversarial_audit/eighth_round/replay_cm_shadow.py --check

To replay the independently implemented complete Sturm comparison:

    python research/checkpoints/2026_09_07_adversarial_audit/eighth_round/replay_twist_independent.py --check

There are no new Lean declarations in this directory. The published
large-image theorem, CM-induced representation description and complete
modular-space software enumeration remain explicit external ordinary
or software inputs.
