# Fixed rational locus, actual cubic boundary and nonlinear selectors

ABC remains unproved and undisproved. This release closes one fixed
geometric branch in ordinary mathematics, records new arithmetic results
and obstructions, and separately verifies 24 elementary Lean theorems.
The complete analytic and rational-point argument is not yet a Lean proof.

## Results and their limits

The full twelve-disk five-adic calculation, global rational-group index
bridge and exact sieve at thirteen prove

    C: W^2 = z^6 - 27 z^4 + 99 z^2 - 9,
    C(Q) = {(+/-1,+/-8), infinity+, infinity-}.

There are six rational points. The inverse to the actual cubic problem
and the second square tested at the same source give twelve boundary
points on D_(3,zeta), none in its positive seed domain. This excludes
that unit class for odd exponents divisible by three. The zeta-squared
class and uniform bounds in varying families remain open.

The arithmetic chapters prove affine power-intersection bounds and
actual nonlinear square/cube selection results with fixed finite data.
An original-block coefficient-packet example refutes a fixed-power
lattice-index bound based on one short primitive polynomial. A corrected
coprime-resultant certificate includes the full adjustment at three.
Actual prime-chain examples delimit divisor-gap claims; paired packets
give a constructive sufficient certificate using each prime once.
None supplies the missing uniform signed estimate for all original roots.

Read [current_gap_assessment.md](current_gap_assessment.md) for the
remaining dependencies. Closing a fixed curve or increasing the number
of Lean declarations does not measure a percentage of an ABC proof.

## Evidence

- `verification/ordinary_source_inventory.json` binds 15 complete ordinary
  proof sources. The internal independent reviews and full TeX transfer
  reviews are separately bound in `verification/transcription_review.json`.
- `verification/finite_replay_validation.json` records eight actual
  successful exact replays; `finite_input_inventory.json` binds all 18
  program/certificate dependencies. Additional independent implementations
  of the finite sieve are published with their source review records.
- `Lean/NonlinearPowerSelectors.lean` contains exactly 24 new arithmetic
  theorems. The canonical fresh compiler run and every explicit axiom query
  are in `verification/mathlib_validation.json` and
  `verification/fresh-mathlib-build.log`. The source hash is
  `38849679f2e456475bf9f9ef8dfaa0c55df2e0cba8d705d7ec579c2e111776e9`.
  Its only axiom dependencies are `propext`, `Classical.choice`, and
  `Quot.sound`. CRT, sieve density, rank, local heights and the complete
  rational locus are outside these 24 theorems.
- The designated manuscript is
  `output/pdf/ChatGPT_ABC_Uniformity_2026_08_31.pdf`: 600 pages, SHA256
  `60732f02f13a00b3f8c057d5cdd9038f1ea39a7d3355cedaec5c223e11de9a72`.
  Three stable passes use 232 actual TeX inputs. The previous 216 child
  inputs are unchanged; the first 562 extracted-text pages agree with the
  previous sealed PDF. Actual PNG inspection covers page 1 and every page
  563--600, divided among three reviewers. No overfull boxes or unresolved
  references remain. This is not a claim that all 600 pages were newly
  visually reviewed. `verification/manuscript_validation.json` records
  the actual build, source and image hashes.

## Reproduction and provenance

From the repository root, run:

    python3 research/checkpoints/2026_09_08_fixed_curve_closure/verify_finite.py
    python3 research/checkpoints/2026_09_08_fixed_curve_closure/prepare_mathlib_project.py

Use Lean 4.32.0 and Mathlib revision
`81a5d257c8e410db227a6665ed08f64fea08e997`. Resolve the generated project
and fetch its three named cached imports as specified in
`.github/workflows/abc-fixed-curve-closure.yml`, then run:

    python3 research/checkpoints/2026_09_08_fixed_curve_closure/verify_mathlib.py --project tmp/abc_20260908/fixed-curve-closure-ci-project

The workflow invalidates historical evidence before any setup step, runs
the eight replays, performs a fresh kernel compilation, and uploads the
actual evidence even on failure. Committed local PASS records are not a
claim that a later GitHub run succeeded.

`build_manuscript.py` retains the complete existing LaTeX architecture;
`seal_manuscript.py` installs only the source-bound, actually reviewed
build. Its local previous PDF and raster inputs are review artifacts under
`tmp/`, not installed Lean dependencies.

Some ordinary sources and historical review receipts retain `next-only`
or pre-publication headers. They are frozen to preserve reviewed bytes.
The explicit publication inventory defines this release's included scope;
those historical headers do not describe the release's publication state.
Later shifted-resultant, zeta-squared and finite-field Lean research is
outside this 600-page/24-theorem release.
