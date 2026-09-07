# Bounded lean-only FLT dependency compatibility probes

The complete upstream FLT import remains an active, unfinished objective. The
fourteenth-round package is frozen. This directory records subsequent local
work and does not change its verified S2 bridge or its full-import inventory.

## Actual results

At upstream commit `aa2d8b34692b16c70f699536de0d8e75b9a3e9ef`, eighteen
unchanged source modules in the complete FLT dependency closure have now been
compiled with the project's existing Lean 4.32.0 and Mathlib
`81a5d257c8e410db227a6665ed08f64fea08e997`. These are one helper, five
definition modules, six leaf solution modules and their six exported-theorem
wrappers. All compilation processes returned zero.

Six explicit queries of the solution declarations and six explicit queries
of their exported wrappers returned exactly `propext`, `Classical.choice`
and `Quot.sound`. These twelve named declarations were checked; no claim is
made that every declaration in the five definition modules received a new
exhaustive axiom query. Some upstream definition files also print their own
axiom lists, which remain visible in the saved compilation output.

The three complete reports bind the upstream source hashes, exact commands,
compiler and Mathlib pins, process exits, outputs and measured resources:

| Report | Actual scope | Measured compiler time | Highest observed RSS |
| --- | --- | ---: | ---: |
| `verification/lean_only_leaf_probe.json` | Twelve source compilations | 51.808 s | 6,999,016 KiB |
| `verification/leaf_axiom_audit.json` | Six solution axiom queries | 19.562 s | 6,886,084 KiB |
| `verification/wrapped_leaf_probe.json` | Six wrappers and their six axiom queries | 36.849 s | 6,943,132 KiB |

These times exclude fetching sources and cannot be extrapolated to the full
target. The first twelve `.olean` files occupy 4,327,800 bytes. The source
sample was intentionally small; it establishes no compatibility result for
the tens of thousands of untried dependency modules.

Only `.olean` output was requested. No C, native object, comparator, or full
target was built. The existing `/root/abc-lean-build` cache was read only.
Compilation ran one process at a time with `LEAN_NUM_THREADS=2`, a monitored
8 GiB resident-memory stopping threshold, and a 180-second per-process
timeout. The resident monitor samples every 0.25 seconds; reported peaks are
observations, not a hard instantaneous upper bound. Both old compiler and
old Mathlib remain unchanged.

## Reproduction

Run these commands inside WSL. The existing pinned project dependency cache
is required. Source downloads are verified against the complete pinned
source/import inventory published in round fourteen.

```sh
repo=/mnt/e/agent/ABCConjecture
base=$repo/research/checkpoints/2026_09_07_adversarial_audit
python3 "$base/fifteenth_round/FLT/next_probe_lean_only.py" \
  --graph "$base/fourteenth_round/FLT/verification/full_import_graph.json.gz" \
  --output "$base/fifteenth_round/FLT/verification/lean_only_leaf_probe.json"
python3 "$base/fifteenth_round/FLT/verify_leaf_axioms.py" \
  --probe "$base/fifteenth_round/FLT/verification/lean_only_leaf_probe.json" \
  --output "$base/fifteenth_round/FLT/verification/leaf_axiom_audit.json"
python3 "$base/fifteenth_round/FLT/probe_wrapped_leaf_exports.py" \
  --graph "$base/fourteenth_round/FLT/verification/full_import_graph.json.gz" \
  --probe "$base/fifteenth_round/FLT/verification/lean_only_leaf_probe.json" \
  --output "$base/fifteenth_round/FLT/verification/wrapped_leaf_probe.json"
```

The leaf probe resumes completed, source-hash-matching work in its isolated
directory. The wrapper probe verifies that all local prerequisites are in
that completed leaf set, then compiles only the next six wrappers. Each
script stops at the first source/build/query failure rather than skipping a
failed mathematical dependency and reporting success.

The audit bridge files in `verification/` have actually been compiled. They
only import the named modules and query existing constants; they introduce
no FLT theorem or additional mathematical axiom.

An earlier harness attempt used an 8 GiB virtual-address-space limit. It
stopped at the helper with a thread-creation error; the complete record is
`verification/initial_address_space_probe.json`. Replacing that unsuitable
address-space limit with the resident-memory monitor allowed the unchanged
helper and the complete selected sample to compile. This was a harness
resource failure, not an upstream proof or API failure.

## Full import boundary and next step

The exact round-fourteen source scan found 60,475 local modules for
`FinalCheck`, 60,474 for the exported `fermat_last_theorem` module, and 60,473
for its solution module. Calling the final theorem directly therefore does
not substantially reduce the unchanged lexical import closure. All 1,705
direct Mathlib imports have sources and `.olean` paths in the existing
cache, and the additional `Lean` standard import was checked separately.
That path inventory does not establish API compatibility.

The eighteen-module result supports continuing with explicit, bounded
topological batches and measured lean-only storage. It does not justify
starting the complete target without further capacity measurements, nor
using the official native-C build's 220 GiB transient figure as a required
lean-only footprint. No modified upstream proof, assumed theorem, or local
`sorry` is used to bypass the remaining dependency chain.

## Final stopped topological batch: nineteen source successes in total

After the complete eighteen-module milestone, a proposed thirty-new-module
probe was authorized with one compiler process, at most 600 seconds per
batch, 120 seconds per module, and an observed 8 GiB resident-memory stop.
It did **not** finish successfully. The complete two attempt records are
`verification/topological_batch_probe.json` and
`verification/topological_batch_retry.json`; the reproduction harness is
`probe_topological_batch.py`.

The first attempt stopped on a source-download read timeout before starting
any compiler. In a separate retry, the unchanged
`Definitions.Def_Algebra_PointDerivations` compiled in 21.812 seconds, with
observed peak RSS 6,614,600 KiB. Its source SHA256 is
`e54ef18402112ab66421a3eccb0a8f30ea9402cc167be91c6770da0c43d144cd`;
its Lean object SHA256 is
`be977eeefcf2a14c3814102d2dfb141f6aef7a08a835f649e74d339dfb409e03`.

The next solution stopped at its first import because the newly created
`P2M` package root shadowed the earlier verified prerequisite root. Lean
looked for `P2M/Util.olean` in the new isolated directory rather than the
existing read-only prerequisite directory. The complete error is retained
in the retry report. This is a diagnosed harness/package-root lookup
failure, not an upstream mathematical-proof or API incompatibility result.
No proof was modified and no missing result was assumed.

There are therefore **nineteen distinct unchanged source modules actually
compiled**, comprising the completed eighteen-module milestone plus one
additional definition. The named axiom-query count remains twelve. The
thirty-module batch is explicitly **not PASS**, and neither record verifies
the full FLT theorem. Future isolation repairs and bounded probes belong
to round sixteen; this round's scripts and evidence are frozen.
