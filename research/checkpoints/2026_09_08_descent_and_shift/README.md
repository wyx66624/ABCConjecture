# Squared-unit descent, ramified cubic exclusion and shifted boundaries

ABC remains unproved and undisproved. This continuation adds complete
ordinary proofs for precise fixed branches and paired arithmetic estimates,
alongside fifteen separately scoped Lean theorems. No percentage of an
ABC proof follows from these counts.

## Mathematical results

The squared-unit quotient

    H: y^2=-3s(s+1)(s^3-3s-1)

has Jacobian rank zero, rational group (Z/2Z)^2, and exactly the three
rational branch points over s=0,-1,infinity. The proof is an entire-Jacobian
two-descent with all closed-point norms, including at the prime two,
explicit cubic field and unit calculations, local matching, real signs,
and a complete rational-point argument. Its common-source curve has six
rational boundary points and no positive point.

For positive coprime a,b, set

    M=a^2+ab+b^2,
    F=a^4+3a^3*b+5a^2*b^2+3a*b^3+b^4.

Together with the previous unit classes this excludes M=U^2,F=Q^3.
A separate new argument proves the stronger ramified obstruction

    F=Q^3 implies 3 does not divide M.

It excludes M=3R^h,F=Q^g whenever the positive integer g is divisible
by three. The specified ramified common-source curves have no Q_3
points, including their projective exceptional fibres. This is compatible
with local solubility of the bare numerical equations at (a,b)=(1,4):
the exact global integral cube extraction is an essential additional input.

On original n^4 blocks, the shifted boundary polynomials are coprime
for every nonzero integer shift. Their actual common-depth lcm has an
O_h(n^2) resultant bound, with its full signed residual and exact
correction at three. The AP consequence controls every actual owner
above the block length, paying the extra degree factor, and yields an
explicit exceptional set. Unmatched high depths, singleton primes,
exceptional roots and arbitrary ABC coverage remain open.

## Verification scope

- `verification/ordinary_source_inventory.json` binds seven complete
  ordinary sources; `transcription_review.json` binds eight new TeX
  inputs, the master and nineteen complete internal review records.
- `verification/finite_replay_validation.json` records two successful
  exact replays. The four complete input files are hash-bound separately.
  These finite calculations do not prove the descent or infinite estimates.
- `Lean/F13FixedCurveArithmetic.lean` contains fifteen new theorems,
  distinct from the previous twenty-four selector theorems. Its source
  SHA256 is a459a5f16e8f0b8f6a2dd2dbfd742c672721f3963220463eed10e8b456e006ec.
  The canonical fresh compilation and all fifteen axiom queries passed
  with only propext, Classical.choice and Quot.sound. It proves literal
  finite-field predicates and polynomial identities, not the complete
  Jacobian, p-adic height, rational-locus, or ABC proof.
- The complete designated manuscript has 621 pages, SHA256
  8a1f1576399c1eb76766a2f28a0bc8152c7c33656f3f3d1415e66696297866a2.
  Three stable passes use 240 actual TeX sources. All 231 previous child
  sources remain unchanged. The first 594 extracted-text pages agree
  with the previous 600-page PDF. Page 1 and all pages 595--621 were
  actually rendered and visually inspected by three reviewers. The build
  has no overfull boxes or unresolved references. The source-bound
  `verification/manuscript_validation.json` records the actual evidence.

These are internal independent reviews, not external peer review or a
claim of whole-manuscript Lean verification. Historical `next-only`
headers in frozen sources record their original drafting stage; the
explicit publication inventory defines this continuation's actual scope.
Later unmatched-gate and residual-rank notes are outside this paper batch.

## Reproduce the finite and formal checks

From the repository root:

    python3 research/checkpoints/2026_09_08_descent_and_shift/verify_finite.py
    python3 research/checkpoints/2026_09_08_descent_and_shift/prepare_mathlib_project.py

Use Lean 4.32.0 and Mathlib revision
81a5d257c8e410db227a6665ed08f64fea08e997. Resolve the prepared dependency
project and fetch the five cached imports listed in
`.github/workflows/abc-descent-and-shift.yml`, then run:

    python3 research/checkpoints/2026_09_08_descent_and_shift/verify_mathlib.py --project tmp/abc_20260908/descent-shift-ci-project

The CI workflow invalidates historical PASS records before setup and
uploads actual evidence even on failure. A committed local PASS does
not establish that a later GitHub invocation succeeded.

`build_manuscript.py` uses the complete existing LaTeX architecture.
`seal_manuscript.py` requires the matching ordinary, transfer, formal,
finite and actual visual evidence before installing the rebuilt PDF.
The local prior-PDF and raster files are review inputs under tmp, not
Lean dependencies. Current mathematical gaps are recorded in
`current_gap_assessment.md` and the repository route ledger.
