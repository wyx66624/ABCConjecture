# Source, multiplier, catalogue, and Lucas verification

This directory is the reproducibility package for the September 1, 2026
checkpoint joining four Lean modules:

- `AffineCatalogueWeightOverlap20260901.lean`;
- `IUTRationalDegreeOneSourceRealization20260901.lean`;
- `MersenneBalancedMultiplierDepthLocalization20260901.lean`;
- `PellLucasAllOrderStaircase20260901.lean`.

The package certifies the formal declarations, the stated finite computation,
and the exact narrow counterexamples in those modules. It does not supply an
unconditional term of `ABCConjecture`, a term of its negation, or a verification
of IUT.

## Declaration inventory

The comment-, literal-, and attribute-stripped source inventory is:

| Module | Theorems | Lemmas | Definitions | Structures | Counted declarations | Proof declarations |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| `AffineCatalogueWeightOverlap20260901` | 14 | 0 | 5 | 0 | 19 | 14 |
| `IUTRationalDegreeOneSourceRealization20260901` | 17 | 0 | 10 | 1 | 28 | 17 |
| `MersenneBalancedMultiplierDepthLocalization20260901` | 14 | 0 | 0 | 0 | 14 | 14 |
| `PellLucasAllOrderStaircase20260901` | 22 | 0 | 3 | 0 | 25 | 22 |
| **Total** | **67** | **0** | **18** | **1** | **86** | **67** |

There are no `abbrev`, `class`, `inductive`, or `instance` declarations in
these four modules, and none of the 67 proof declarations is private. These
per-module counts, the totals, the 67 proof declarations, and the zero private
proof count are hard-coded acceptance gates. The live run and sealed-package
verification reject any different inventory.

`validate.py` rejects `sorry`, `admit`, `native_decide`, `sorryAx`, and
`unsafe`, as well as declaration-style `axiom`, `axioms`, `opaque`, `partial`,
or `extern` commands. It deterministically amalgamates the exact four source
bodies, removes their existing diagnostic `#print axioms` lines, and generates
one fresh `#print axioms` command for every theorem and lemma. The audit must
therefore return exactly 67 reports in source order.

The axiom gate permits only:

- `propext`;
- `Classical.choice`;
- `Quot.sound`.

The current checkpoint's expected union is exactly those three standard Lean
axioms. Any `sorryAx` occurrence or any axiom outside that set fails validation.
Each target module and the generated audit are compiled with
`-DwarningAsError=true`.

## Independent Pell--Lucas replay

The validator runs
`research/computation/2026_09_01_pell_lucas_all_order/verify_lucas_all_order_packet.py`
with Python bytecode generation disabled. The verifier recomputes the local
Lucas values by binary powering in `Z[T]/(T^2-6T+1)`, independently of the
producer's linear recurrence. The present packet has five rows whose target
residues are exactly `0, 1, 2, 3, 4` modulo five. `validate.py` reads those
five `target_residue` fields directly, rejects missing, noninteger, duplicate,
or out-of-range coverage, and checks that the verifier's reported row count
agrees with the packet. It also recomputes the
all-order coefficient staircase, normalized-tail coprimality, companion
correction, and channel splitter for `ell = 3, 5, 7, 11` using binary Binet and
Pell powering.

The replay document must equal this object, not merely contain a success word:

```json
{
  "local_method": "binary powering in Z[T]/(T^2-6T+1)",
  "local_rows": 5,
  "sample_indices": [3, 5, 7, 11],
  "sample_method": "binary Binet and Pell powering",
  "verification": "PASS"
}
```

The recorded computation entry must additionally contain
`targetResidues=[0,1,2,3,4]`, and sealed-package verification rechecks that
field. The replay stdout must also contain `PASS`. The verifier rewrites
`lucas_all_order_verification.json`; the validator checks all frozen inputs
again afterward, so the replay is accepted only when that write reproduces the
frozen bytes exactly.

## Aggregate and frozen-input gates

All four imports must occur in `Lean/IUTThreeClosures.lean`. The aggregate
command is `lake build IUTThreeClosures`, and its exact accepted completion
count is **9,229 jobs**. A missing completion marker or any other job count is
a hard failure.

The input manifest covers every Git-tracked local Lean source outside
`Lean/.lake` and `Lean/verification`, the four target modules even before they
are tracked, the Lean and Lake configuration, route registries and reports,
the integrated paper source and fragments, the final PDF, the Pell computation
bundle, the Mersenne, Pell, and IUT source-audit bundles, and the final PDF QA
directory. Every Lake dependency must be at its manifest-pinned Git revision
with a clean checkout. Inputs, validation drivers, generated audit, and Lake
dependency state are compared again after all compiler and computation runs.

## Exact counterexample boundaries

The counterexamples retire only the displayed stronger claims whose full
premises they satisfy.

- **Affine catalogue.** The powerful pairwise-coprime packet
  `(d_U,d_V,d_W,T)=(9,25,1,5)` has total weight 225, small weight 7, and
  large weight 218. It refutes `L_T >= D-T`, since `218 < 220`. It does not
  refute the correct divisor-count tail, the cubic-energy lower bound, or the
  active signed-ray and repeated-label routes.
- **IUT abstraction.** The degree-empty and height-zero shadows both satisfy
  `StatementI` and admit the entire abstract `ProofPackage`; they show that
  the current abstract API alone does not manufacture degree-one source
  membership or the required uniform height comparison. The conductor-inflated
  shadow satisfies `StatementI`, exact degree one, exact height, and zero
  different while defeating a uniform conductor upper comparison; no
  `ProofPackage` is claimed for this model. The different-inflated shadow does
  admit `ProofPackage` and shows that the abstract record does not force the
  arithmetic different. Two sequence models separately refute reverse
  transport when either required bounded-discrepancy orientation is omitted.
  These are semantic pressure tests on the formal interface, not
  counterexamples to Mochizuki's arithmetic statements, IUT, or abc.
- **Mersenne multiplier.** Complete positive label packets rule out a uniform
  linear-in-`H` bound for arbitrary positive injective labels; `H=4` already
  refutes the coefficient-one version. The actual prime `3511` has exact order
  `1755`, repeated depth two, and multiplier two, so it refutes the universal
  assertion that every repeated exact-order prime has multiplier at least
  three. These facts do not refute either remaining localized little-oh
  estimate, and a finite prime row is not an asymptotic counterexample.
- **Pell--Lucas.** At `n=3`, `s=5`, `t=1`, the positive odd multiplier
  `k=2451=1+2*35^2` yields normalized correction `2 mod 5`. This is a
  full-premise counterexample to the exact fixed-zero local-rigidity claim. It
  does not refute the paired-channel correlation, the all-order staircase, or
  the squarefull-packet route.

The recorded `validation-run.json` makes this boundary machine-readable with
`provesOrDisprovesStandardABC=false` and
`finiteOrConditionalClaimsUpgraded=false`.

See `COMMANDS.md` for the maintainer sequence. Freeze, record, and seal must be
performed only after the final PDF QA directory and every other frozen input
are complete.
