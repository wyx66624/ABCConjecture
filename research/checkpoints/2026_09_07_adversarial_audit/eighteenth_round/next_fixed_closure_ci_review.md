# Fixed-curve closure release: source and CI integrity review

Status: **PASS, read-only inspection; no blocking defect found**, 2026-09-07.
This review did not rerun compilation, cache download, or the eight-replay wrapper. It actually read the full five CI/preparation/verifier files, all released module declarations and queries, the complete final build log, both result manifests, and the complete finite input inventory. The individual mathematical finite scripts were already independently reviewed and run in the separate next-review records; their current imports and file reads were checked against the inventory here.

## Actual chain and failure states

The workflow checks out the source and immediately calls `initialize_ci_evidence.py`, before compiler installation, project preparation or cache retrieval. That initializer overwrites both historical result manifests with NOT_RUN and overwrites the old compiler log. Either verifier also invalidates its own result before argument parsing, input reads, Git/compiler preflight or subprocess launch. Thus setup failure cannot upload a previous PASS as the result of this invocation.

The Mathlib preparation uses a separate dependency-only project, Lean 4.32.0 and the exact Mathlib revision `81a5d257c8e410db227a6665ed08f64fea08e997`. Existing differing project configuration is rejected. The three explicit cache roots match the three actual module imports: `Mathlib.Tactic`, `Mathlib.RingTheory.Coprime.Lemmas`, `Mathlib.Data.ZMod.Basic`; cache retrieval follows their dependency closure. No full FLT or project build is launched.

`verify_mathlib.py` checks the package revision and tracked Mathlib/toolchain differences, verifies the compiler version, copies the literal canonical release bytes to a fresh directory and prepends that directory to LEAN_PATH. It rejects added axiom/opaque declarations and sorry/admit/native_decide, and requires a one-to-one set of theorem/lemma declarations and explicit axiom queries. The actual module has 24 and 24. Fresh `lean -o` with warnings as errors compiles these bytes; the source is compared again after compilation. Every named query must occur in the new log with either no axioms or only the allowed standard three. PASS is written only after all those steps.

Failure during initial preflight leaves NOT_RUN. A compiler failure records FAIL and exits nonzero. A later source/axiom assertion failure can leave RUNNING, which is still explicitly not PASS and is accompanied by the failing step. This is safe evidence semantics, though it is not a claim that every failure receives a fully annotated diagnostic JSON. No additional negative-path execution was performed for this release by this reviewer.

`sys.executable` is passed as one subprocess argument to `lake env`, preserving the active Linux interpreter and handling an interpreter path with spaces without shell quoting. The finite wrapper likewise calls the current interpreter with UTF-8 enabled. No PowerShell-specific executable name is hardcoded into Linux CI.

The finite inventory contains eight distinct programs and eighteen bound input/output/source files. Every program is itself hashed. Imports between UD/SU/ZD/IF and the zero-slope helper remain within that bound set; the prior HT JSON and the complete primality certificate are also included. Input hashes are checked both before and after all read-only `--check` invocations. An exception or nonzero child exit records FAIL and rethrows. The manifest identifies each actual script result and does not label finite tests as an analytic proof or a Lean theorem.

The workflow path filters cover the new checkpoint, every included old next-script/certificate location and both author's eighteen-round directories, including the prior HT JSON. The always-upload artifact is limited to the two current result manifests and new compiler log. It does not purport to upload a complete formalization of the rational locus.

## Evidence actually read

The release-copy source is byte-identical to the previously reviewed 24-theorem module, SHA256 `38849679f2e456475bf9f9ef8dfaa0c55df2e0cba8d705d7ec579c2e111776e9`. Root's separate release manifest records 24 new declarations, zero old project declarations rebuilt, and the complete standard axiom union. The final log contains every named query. This is evidence of root's actual run, not an additional reviewer compiler run.

Bound hashes:

| File | SHA256 |
|---|---|
| `.github/workflows/abc-fixed-curve-closure.yml` | `6ac226d0345f0afa4bd7c88e06a418a4d1d4bbfd66d2e97bafd0b66b87ffc6bf` |
| `initialize_ci_evidence.py` | `4df33cebe2bf902e46886e7ea238cb9254f66548706b09a5c1535546c8460d12` |
| `prepare_mathlib_project.py` | `0652df12ab37fa05cdcde939938d3a8444850f1ea16592d90bceefec78789965` |
| `verify_mathlib.py` | `9035626a5d599e25b73dd6a43f031aec55fca2590c206bbeca53b81d95dc83f6` |
| `verify_finite.py` | `5cddb1c9b69718342bc77197aa49399e18691b573838cf19b40997712c31f332` |
| `verification/finite_input_inventory.json` | `33bb397e8bb36c13153d3fb8d7958ade85bed92fb7ef125836e0fa54cd761866` |
| `verification/mathlib_validation.json` | `819d4c775e13aecc69d8063c5fec1e6fa4cbc16a804e24f9aa6598c065f87cf2` |
| `verification/fresh-mathlib-build.log` | `9d87dfd1d55d6e71eb26807eccce156bd6f0178e10e939f742aad9fe2a321957` |
| `verification/finite_replay_validation.json` | `67119b932aa58617cc11d13d173bfe03a218e9c246b097394f51972d0273050b` |

Unqualified paths in this table belong to `research/checkpoints/2026_09_08_fixed_curve_closure`. The module remains finite selector arithmetic: no CRT or density premise is smuggled in, and none of the analytic, rational-group or rational-locus proofs is claimed formalized.
