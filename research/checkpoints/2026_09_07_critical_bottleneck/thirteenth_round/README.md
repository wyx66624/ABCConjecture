# Thirteenth round: uniform moments on actual independent roots

All published twelfth-round sources are frozen. This directory
contains the independently reviewed UM continuation.

- uniform_moments.md gives the full ordinary proof, with root,
  adversarial_audit and independent_route all reporting FULL PASS.
- paper/uniform_moments.tex is its self-contained manuscript input.
- ordinary_arithmetic_scope.md records the bounded ordinary proofs
  before their formal implementation.
- Lean/UniformMomentArithmetic.lean contains fifteen new verified
  arithmetic statements. Its exact source hash is
  646308163a102479ea842b33b2f06eb8b1adf342e459f13cf8b4a51c597d1568.
- verify_moment.py performs a fresh local-source compilation and
  queries every declaration's axioms. Its actual final execution
  passed under Lean 4.32.0 with pinned Mathlib
  81a5d257c8e410db227a6665ed08f64fea08e997, reusing the compiled
  dependency cache.
- verification/moment_validation.json and moment-lean.log record
  the result. The validation hash is
  a67a2119fdaa1b2faaee2c783d3903971ae41197410e55461ac9a5411226e047.
- review.md records independent reviews and the exact boundaries
  between ordinary mathematics, finite interfaces and formal proofs.

The new ordinary result pays complete positive excess through
floor(n^5 (log n)^(1-delta)), for each fixed delta>0, on an actual
set of relative size at least one half minus an error tending to zero.
Its all-length tuple comparison precedes the growing moment choice;
no fixed-moment constant is silently used uniformly.

The formal module proves the binomial three-root threshold, explicit
integer square-root bounds, actual filtered-list counts, the entire
finite excess sum, real weights and the numerical factors 38 and 80.
Root's separate module constructs the symmetric-product injection
from private valuation witnesses. Neither construction is a Lean
proof of the norm-support density or the finite-ring lifting theorem.

The farther signed contribution, the roots outside the proved domain,
and the remaining exceptional subsets are still open. This checkpoint
contains no proof or disproof of ABC.
