# Signed, slow-slack, correlated, and admissible verification

This directory is the reproducibility package for the September 2, 2026
checkpoint joining four Lean modules:

- `AffineSignedRayCanonicalCaps20260901.lean`;
- `IUTAdmissibleScalingOrderIndex20260901.lean`;
- `MersenneCriticalSlowSlackGate20260901.lean`;
- `PellLucasCorrelatedAllOrderExclusion20260901.lean`.

The package certifies the formal declarations, deterministic finite
computations, frozen-source comparisons, and exact narrow counterexamples in
those modules. It does not supply an unconditional term of `ABCConjecture`, a
term of its negation, or a verification of IUT.

## Declaration inventory

The comment-, literal-, and attribute-stripped source inventory is:

| Module | Theorems | Lemmas | Definitions | Counted declarations | Proof declarations |
| --- | ---: | ---: | ---: | ---: | ---: |
| `AffineSignedRayCanonicalCaps20260901` | 41 | 0 | 4 | 45 | 41 |
| `IUTAdmissibleScalingOrderIndex20260901` | 11 | 0 | 2 | 13 | 11 |
| `MersenneCriticalSlowSlackGate20260901` | 16 | 0 | 4 | 20 | 16 |
| `PellLucasCorrelatedAllOrderExclusion20260901` | 22 | 0 | 6 | 28 | 22 |
| **Total** | **90** | **0** | **16** | **106** | **90** |

There are no `abbrev`, `structure`, `class`, `inductive`, or `instance`
declarations in these four modules, and none of the 90 proof declarations is
private. These counts and the zero private-proof count are hard-coded
acceptance gates.

`validate.py` rejects `sorry`, `admit`, `native_decide`, `sorryAx`, and
`unsafe`, as well as declaration-style `axiom`, `axioms`, `opaque`, `partial`,
or `extern` commands. It deterministically amalgamates the exact four source
bodies, removes their existing diagnostic `#print axioms` lines, and generates
one fresh `#print axioms` command for every theorem and lemma. The audit must
therefore return exactly 90 reports in source order.

The axiom gate permits only `propext`, `Classical.choice`, and `Quot.sound`.
The current expected union is exactly those three standard Lean axioms. Every
target module and the generated audit are compiled with
`-DwarningAsError=true`.

## Independent four-route replay

`replay_evidence.py` does not trust a success word. It independently verifies
the frozen SHA-256 ledgers and recomputes the checkpoint's exact finite
arithmetic:

- **Affine:** 15,840 signed directions, 1,776,807 cubic ledgers, 2,390,018
  quadratic ledgers, 43,403 arm-capture cases, and the exact selected-catalogue
  and deletion witnesses.
- **Mersenne:** all primes through 100,000, 9,591 odd-prime rows, the complete
  mod-eight character table, and the exact 1093 and 3511 order/depth rows.
- **Pell--Lucas:** 57 odd prime indices through 271, 138,675 coefficient
  pairs, 228 polynomial evaluations, 527,352 candidate-prime tests, the
  exact-depth-two row, and the absence of a depth-three hit in the stated
  finite range.
- **IUT interface:** the pinned public commit, 13 frozen source records, 15
  sealed hashes, the three-file admissibility patch, and the recorded
  successful 8,767-job upstream build.

The replay output must equal the hard-coded structured object whose schema is
`abc-signed-slow-correlated-admissible-evidence-v1`; all 41 evidence hashes and
every count above are exact gates. The replay rewrites
`evidence-replay.json`, and the validator rechecks every frozen input after all
compiler and computation runs.

## Aggregate and frozen-input gates

All four imports must occur in `Lean/IUTThreeClosures.lean`. The aggregate
command is `lake build IUTThreeClosures`, and its exact accepted completion
count is **9,233 jobs**.

The input manifest covers every Git-tracked local Lean source outside
`Lean/.lake` and `Lean/verification`, the four target modules even before they
are tracked, Lean and Lake configuration, route registries and reports, the
integrated manuscript and fragments, the final PDF, all four computation and
source-audit bundles, and the final PDF QA directory. Every Lake dependency
must be at its manifest-pinned Git revision with a clean checkout. Inputs,
drivers, generated audit, and dependency state are compared again after all
runs.

## Exact counterexample boundaries

Only claims refuted with every stated premise are retired.

- **Affine:** exact tuples refute non-strict threshold and extra-period
  strengthenings; nonprimitive and coefficient-coprimality witnesses show
  those premises are necessary. The actual `(B,C,M,N,R)=(1,2,10,9,2)` box
  refutes deletion of selected-catalogue membership because `972496 > 1072`.
  The corrected signed-ray, arm-cap, selected-catalogue, and global-energy
  routes remain active.
- **IUT interface:** the empty and whole sets refute the total-set and merely
  nonempty-set positive-shift laws. Congruence-order subrings refute the claim
  that surjective coordinate projections force product order. They do not
  refute the admissible, index-aware same-pilot route, IUT, or abc.
- **Mersenne:** the actual prime `1093` has exact order 364, depth two, and odd
  multiplier three, refuting the universal even-multiplier strengthening.
  The critical arithmetic target `sigma=1` and both surviving localized arms
  remain active; the finite scan is not extrapolated.
- **Pell--Lucas:** the mixed-sign row at index 11 refutes only the claim that
  every edge in a negative character row is negative. The bounded absence of
  a depth-three pair does not retire the correlated squarefull-packet route.

The recorded `validation-run.json` makes this boundary machine-readable with
`provesOrDisprovesStandardABC=false` and
`finiteOrConditionalClaimsUpgraded=false`.

See `COMMANDS.md` for the maintainer sequence. Freeze, record, and seal must be
performed only after the final PDF QA and every other frozen input are
complete.

