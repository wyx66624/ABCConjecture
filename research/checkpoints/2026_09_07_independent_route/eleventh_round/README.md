# Eleventh round: integral reconstruction of the rational curves

The ordinary results IL1--IL4, CI1--CI2, GE1--GE4, and BK1--BK3 are complete and independently
reviewed by root, critical_bottleneck, and adversarial_audit. All three
also passed the complete self-contained TeX transcriptions. Ordinary
proofs and their mathematical TeX sources are frozen for parent
integration; subsequent new mathematics belongs in a later round.

* `integral_profile_lifting.md` and `paper/integral_profile_lifting.tex`
  quantify the residual cost of cancellation, prove the exact inverse
  criterion at fixed root norms, and state the finite local exclusions
  with their precise budget scope.
* `pure_coefficient_inverse.md` and `paper/pure_coefficient_inverse.tex`
  prove that every rational fiber-product point with finite positive base
  coordinate gives an actual positive primitive seed with the same two
  pure exponents. The first ramified parity can change when the first
  exponent is odd. The positive locus is empty when both exponents are
  even, by the previously proved combined-square obstruction.
* `gaussian_even_profile.md` and `paper/gaussian_even_profile.tex`
  construct the second actual Gaussian profile when the first norm is
  an unramified even power, retain the quadratic support conditions for
  moving residuals, and prove the cyclotomic equation's exact integer
  inverse with its extra square condition.
* `biquadratic_power_cover.md` and `paper/biquadratic_power_cover.tex`
  lift actual square-first pure-second seeds to explicit simultaneous
  covers over the fixed field Q(i,sqrt(-3)). The exact relation module
  gives degree g^2 for odd g, and two degree-g^2/2 components for even g.
  There is no point-height bound uniform in the exponent.
* `REVIEW.md` records independent review and formalization scope.
* `projective_content_review.md` records this agent's full ordinary and
  TeX review of the peer's PC1--PC2. It does not claim an independent run
  of the peer's finite replay.
* `verification_inventory.json` binds the source files by SHA-256.
* `replay_gaussian_cover.py --check` verifies the canonical exact
  supplement `gaussian_cover_replay.json`, using only Python's standard
  library. Both author and parent independently ran it successfully.

The radical in `rad(C)^n | V V'` cannot be replaced by the full content.
The pure-coefficient conclusion concerns the finite positive rational
base locus, not all rational points on the curves. There is no general
point-height upper bound, construction of simultaneous small residuals,
or proof or disproof of ABC here. No new Lean module is supplied by this
agent in this round; the parent develops separate arithmetic kernels.

The tenth-round mathematical sources remain frozen. Any further new
candidate is recorded separately from these reviewed theorems.
