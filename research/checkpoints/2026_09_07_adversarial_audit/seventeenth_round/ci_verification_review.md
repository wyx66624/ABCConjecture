# Read-only CI and verifier audit

Status: the identified stale-PASS artifact risk is RESOLVED in the current
workflow and verifier entry points. No successful Lean compilation or network
download was run by this audit. Apart from this requested review record, the
reviewer did not modify the workflow, verifiers, mathematical sources or
verification outputs.

## Original finding and implemented resolution

Previously, failure during dependency preparation or before a verifier wrote
its new output could leave a checked-in PASS JSON/log available to the
workflow's unconditional artifact upload. This could mislabel the uploaded
evidence as current, although the failed CI job would still be red.

The workflow now runs `initialize_ci_evidence.py` immediately after checkout,
before the compiler-install, project-preparation and cache steps. It writes
NOT_RUN records for both verification results and replaces the old compiler
log with an explicit no-output marker. Both verifier main functions also
invalidate their own records before argument parsing or filesystem/dependency
preflight. Thus standalone failed invocations cannot retain an old PASS.
Successful results are written only after the corresponding checks complete.

The initializer and both modified verifier entries were read in full. The
recorded negative-path evidence was also inspected and its three protected
script hashes compared with the actual files. This is an inspection of the
author's executed isolated tests, not a claim that this reviewer reran them.

## Source-to-verification chain

The isolated project fixes Lean 4.32.0 and the complete Mathlib commit
81a5d257c8e410db227a6665ed08f64fea08e997. Preparation refuses conflicting
existing project files. Verification checks the actual Mathlib HEAD and
tracked Mathlib/toolchain changes, and checks the compiler version.

The five local modules are copied byte-for-byte into a fresh temporary
directory in dependency order: EisensteinDescent, ActualGramRigidity,
ActualSignedProducts, JointPhasePackets, QuotientCurveArithmetic. The fresh
directory is prepended to LEAN_PATH, and each .olean is built directly from
that copy with warnings treated as errors. The code records copied-source
SHA256 values and rechecks them against both the copy and original source.
All 27 new and 45 dependency theorem names have matching explicit axiom
queries; every expected query must appear in the successful output, with
only the three permitted standard axioms. The empty-axiom form is handled.

The cache requests cover every direct Mathlib dependency. In particular,
the apparently omitted Group.Finset.Basic is already a transitive import
of Data.Fintype.BigOperators through Group.Finset.Piecewise (also Sigma);
the pinned local import files were actually inspected. Std comes from the
compiler. The ordinary geometric, residue-group, height and ABC interfaces
are not enlarged by this CI setup.

Using `sys.executable` under `lake env` selects the actual invoking Python
on Windows or Linux; no Windows-only executable path is embedded in the
repository. `os.pathsep`, absolute temporary paths and subprocess argument
lists preserve the platform's path conventions. Source and evidence paths
are resolved from the scripts, not an assumed caller working directory.

The finite verifier pins the exact QS certificate bytes before invoking the
actual standard-library replay in `--check` mode, requires successful exit,
and records both script and certificate hashes. It does not claim the
geometric conclusions from those finite counts.

## Workflow coverage and test scope

The push-on-main path filters include all three old local module sources,
the entire root checkpoint containing the verifiers and two new modules,
the three relevant sixteenth-round evidence/source directories, the compiler
toolchain file and the workflow itself. Manual dispatch is also supported.
This is a scoped five-module/cache verification job, not a whole-repository
or Mathlib rebuild.

The first negative-test version reset both records and then tested failed
standalone invocations without reseeding stale PASS. That did exercise
failure, but could not independently detect removal of the entry-point
invalidation. The reviewer reported this precise test-coverage limitation
to root; it does not invalidate the protection already present in the source.
The final tester now reseeds the respective file with `PASS: stale` before
each standalone failed invocation. Those two changes were actually reread;
root reported an actual successful rerun with exit zero, and the resulting
three-path PASS record was inspected. Its protected-source hashes match
the current initializer and both verifiers. This closes the specific test
blind spot as well as the original implementation risk.

## Final reviewed SHA256 values

* Workflow: `21f9994c6ecabcd0d7767d9c4409de3e14279d0fbe0c635a74a6ff804ff3d9c5`.
* `initialize_ci_evidence.py`: `b24a0006cae36f7ac8f4cf07029bcab992a70edf44571a97a90f0f6d2861b7bf`.
* `verify_mathlib.py`: `66b29f4ce8431683f2134f2a15741ffd2c7022a90bb25d9a226873542756fa28`.
* `verify_finite.py`: `f35f4d9e36ae33071a30ba8cd9388e8c2eab757af57cf7e6a7e5fd533e0883a2`.
* `prepare_mathlib_project.py`: `9e8502f60d4f28ab2c7cb4c6781cf40e6344f284f2343f52f279dacdc9747104`.
* Final `verify_ci_failure_paths.py`: `e9de1a7d49e1d79e269050f602c994d63463fab580dcd8c9e8344e49d5d60d14`.
* `verification/ci_negative_path_validation.json`: `460c683d2b56ce3325248da5d3d01a445b3f3c0461dd0d86d93b6c74e4fc9c32`.

Final conclusion: PASS / RESOLVED for this bounded CI review. This does
not predict an unrun remote CI result; successful local Lean evidence
remains the separately reviewed exact manifest, and the new tests cover
only the three explicitly named reset/failed-preflight scenarios.
