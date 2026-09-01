# Balanced-persistence Lean validation

Validated on 2026-08-31. The standard `ABCConjecture` remains open; 
this evidence freezes conditional and structural results only.

- Four new mathematical modules and `ResearchBalancedPersistence20260831Audit.lean` compiled directly with exit code zero.
- The audit covers 77 explicit public declarations: 62 theorems and 15 definitions/structures.
- Kernel dependencies are exactly: Classical.choice, Quot.sound, propext.
- No audited declaration depends on `sorryAx`; source scanning found no code-level `sorry`, `admit`, `axiom`, or `unsafe`, and no extended escape declarations.
- The audit target build passed with 8767 jobs and 19 historical dependency warning headers; 0 are attributed to the four modules or audit file.
- `lake build IUTThreeClosures` passed with 9147 jobs and 265 warning headers.
- The repository-default `lake build` also passed with 9147 jobs and 265 warning headers.
- The frozen dual-route baseline has 265 warning headers.
- Library-target warning multiset matches the baseline: true.
- Default-build warning multiset matches the baseline: true.
- Warnings attributed to the four modules or audit file: 0.
- Added and removed warning headers, if any, are listed verbatim in `warning-comparison.json`, separating historical warnings from stage-local warnings.
- Package pins match the frozen baseline: true.
- Protected statement/toolchain files match the frozen baseline: true.
- Hashes taken before and after validation confirm that no mathematical or Lean source input changed during this run.

The conditional theorems named `not_abcConjecture_of_unbounded_*` require explicit unbounded-family hypotheses. Neither those hypotheses nor an unconditional proof or disproof of `ABCConjecture` is supplied.
