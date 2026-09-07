# Read-only review of the eighth-round finite verifier and workflow

Date: 2026-09-07. Status: source/scope review PASS. This is not a claim
that the new remote workflow has already run successfully.

Reviewed the complete `2026_09_07_cm_image/verify_finite.py` and
`.github/workflows/abc-boundary-support.yml`, together with both
twist wrappers and their previously executed certificates.

The dispatcher has exactly three cases: the complete finite CM
reduction/shadow replay, the independent_route full modular coefficient
replay, and the separately implemented adversarial_audit full twist
replay. It runs each in --check mode, requires success and empty
wrapper stderr, parses the single JSON result, requires PASS, checks
its certificate hash, and verifies that all listed source/certificate
bytes are unchanged across the run. Paths are derived correctly from
the repository root. The generated manifest is written as UTF-8 LF
bytes. The script records finite evidence only and explicitly excludes
global conclusions from residue shadows or an unproved Sturm input.

The first modular wrapper compares all degrees 0..12288, checks the
field coordinates and both quadratic characters, and requires the
exact PARI version [2,15,4]. It permits only its known fixed stack
allocation notice and rejects other GP stderr. The second wrapper
requires the exact final GP marker, version, cutoff and comparison
count, and rejects unexpected stderr; thus GP's possible zero exit
code after a top-level error is not treated as sufficient evidence.

The workflow uses Ubuntu 24.04, installs the specifically named
PARI/GP 2.15.4 Debian package, checks its expected SHA256 before
installation, and still checks the runtime version through both
wrappers. It invokes the separate fresh scoped Lean verifier and the
three finite replays, then retains their evidence as an artifact.
The dependency path filters include all four Lean source modules and
the repository compiler pin. The existing .gitattributes rule for
September 7 checkpoints preserves their sealed bytes across checkouts.

This review checks the stated finite scopes and execution/failure
logic. Root has separately reported actual successful local runs of
the wrappers. Remote CI status and PDF rendering remain distinct
publication checks, and the modular-form algorithms remain explicit
exact-software dependencies rather than Lean constructions.
