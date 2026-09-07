# Tenth round: actual signed compensation, remaining mass, and elementary block inputs

RC and FM have complete root and adversarial ordinary reviews. All three
paper transcriptions RC, FM and EA have adversarial final full-read
approval. EA has a complete independent ordinary review and a separate
independent exact replay. These results do not prove general signed-tail
membership, a radical bound or ABC.

- `reciprocal_depth_compensation.md` proves the full finite reciprocal-cap
  inequality, uniform large-exponent consequences, the five maximal cap
  patterns and sharpness only in the abstract finite-weight model. One
  squarefree quotient above the cutoff can compensate both other arms
  with no depth restriction on them.
- `full_mass_tail_location.md` proves an actual root-block mean bound for
  full valuation mass. On a proportion tending to one, primes above the
  all-index window carry mass asymptotic to three times the actual
  height. At prime index it is the first-depth top-rank packet. Full
  mass is not signed cost: shallow primes can supply negative credit.
- `elementary_block_inputs.md` proves direct angle and exact two/three
  valuation estimates on B>=n, giving Delta/t<=4/n and two-prime mass
  at most 20/n. It replaces the logarithmic-form steps of FM on those
  blocks, leaving a proof chain based on elementary arguments and the
  established Brun--Titchmarsh estimate.
- `paper/reciprocal_depth_compensation.tex`,
  `paper/full_mass_tail_location.tex`, and
  `paper/elementary_block_inputs.tex` contain complete transcriptions.
  The EA section should follow FM in the main manuscript.
- `ordinary_formal_scope.md`, `review.md`, and
  `actual_prime_log_review.md` distinguish ordinary results, finite
  evidence, independent source review and actual compiler executions.
- `source_evidence.json` records final mathematical-source and finite
  evidence hashes. The compiler manifest separately inventories the
  exact copied Lean sources and all axiom queries.

`Lean/ReciprocalDepthArithmetic.lean` has seventeen declarations. Its
fresh Lean 4.32.0 scoped Lake build passed with seventy-one dependency
declarations, warnings as errors, full axiom-query coverage and only
`propext`, `Classical.choice`, `Quot.sound`. Both peers read all source
signatures and proofs and approved their exact scope. Final source SHA256:

`ec42e21085ad65c1a3ffdd939a742a0f5276c728ff4ca8a564b3d79c8d1e934c`.

`verify_lean.py` builds exact copied sources in a fresh temporary project;
`verification/lean_validation.json` has the full source and theorem
inventory, and `verification/fresh-lake-build.log` the captured output.
Our formal scope is integer-weight finite lists, common-denominator cap
arithmetic, canonical coefficient and small-mass bounds, and complete
positive integer cap classifications. Prime factorization and Real.log
are not defined in this module. Root's separate 24-declaration Mathlib
bridge is reviewed in `actual_prime_log_review.md` and is not added to
our module's seventeen-declaration count.

`replay_elementary_block.py --check` independently passed the canonical
`elementary_block_replay.json`: 571 actual roots, 1142 exact two/three
valuation identities, and actual integer norm/height prerequisites.
Its byte SHA256 is
`05ff5fa1ddb45dfb1c662e5ad0bae06a60adea8956038dd51d49ed778c8ef213`.
It does not use floating-point angles as proof or fully factor the
boundaries. No finite computation is asserted to prove the FM or EA
asymptotics. Their exact-rank interval inputs were proved and replayed
in earlier rounds.

The TD private-depth construction belongs to the adversarial agent's
independent checkpoint. I read its complete proof and replay, actually
ran its canonical check, and reviewed its final TeX. It defeats automatic
membership of the entire reciprocal-cap union, without refuting the
net signed compensation criterion. The separate mixed and double
oriented-cover geometric routes remain open and independently reviewed.

The next target remains a bound on actual deep excess minus the radical
credits in the surviving tail, including exceptional roots. New research
continues in `eleventh_round`; these tenth-round mathematical sources
are ready for the root's final integration and freeze.
