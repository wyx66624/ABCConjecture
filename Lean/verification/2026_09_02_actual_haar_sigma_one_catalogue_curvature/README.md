# Actual-Haar, sigma-one, catalogue, and curvature verification

This directory is the reproducibility package for the September 2, 2026
checkpoint joining four Lean modules:

- `IUTActualHaarAdmissibleOrbit20260902.lean`;
- `MersenneSigmaOneExactOrderCoupling20260902.lean`;
- `AffineInversePeriodCatalogueNovelty20260902.lean`;
- `PellLucasFactorQuotientProjectiveCoupling20260902.lean`.

It certifies the stated local theorems, exact counterexamples, deterministic
finite computations, source hygiene, and aggregate integration. It does not
provide an unconditional term of `ABCConjecture`, a term of its negation, or
a verification of IUT.

## Declaration and trust gates

The comment-, string-, and attribute-stripped source inventory is fixed at:

| Module | Theorems | Definitions | Other declarations | Counted declarations |
|---|---:|---:|---:|---:|
| `IUTActualHaarAdmissibleOrbit20260902` | 33 | 8 | 1 structure | 42 |
| `MersenneSigmaOneExactOrderCoupling20260902` | 19 | 6 | 1 abbrev, 1 structure | 27 |
| `AffineInversePeriodCatalogueNovelty20260902` | 26 | 0 | 0 | 26 |
| `PellLucasFactorQuotientProjectiveCoupling20260902` | 24 | 4 | 0 | 28 |
| **Total** | **102** | **18** | **3** | **123** |

There are no lemmas, classes, inductives, instances, or private proof
declarations in these four files. The validator rejects `sorry`, `admit`,
`native_decide`, `sorryAx`, and `unsafe`, together with declaration commands
`axiom`, `axioms`, `opaque`, `partial`, and `extern`.

`axiom-audit.lean` is generated deterministically by importing the exact four
compiled modules and appending exactly one `#print axioms` command for every
public theorem or lemma. Private proofs are a hard failure. The expected 102
reports must occur in source order. The
axiom union must be exactly Lean's standard implementation axioms
`Classical.choice`, `Quot.sound`, and `propext`. Each module and the generated
audit is compiled with `-DwarningAsError=true`.

## Independent computation replay

`replay_evidence.py` verifies all four computation manifests and regenerates
the evidence in a temporary directory:

- the 20 actual-Haar coefficient rows, normalized packet identity, and the
  residue-degree-two raw-volume counterexample;
- the Mersenne exact witness and rational logarithmic certificates, plus a
  fresh C++20 scan of all 50,847,534 primes through `10^9`, byte-compared with
  the archived two-hit result;
- all six affine reproduction scripts, including 755,322 selected points,
  48,400 Euler cases, 10,001 occupancy cases, and the exact
  `23392/23701` subcritical boundary;
- the Pell producer, verifier, and manifest verifier, including 57 endpoint
  rows through index 271, 13 factor-quotient rows, the local `(3,7,797)`
  counterexample, and the exact index-seven `U^2` sharpness boundary.

All regenerated stdout, JSON, and packet artifacts are compared to the
frozen evidence. The four manifests currently contain 43 hash entries.

## Aggregate and immutable-input gates

All four imports must occur in `Lean/IUTThreeClosures.lean`.
`lake build IUTThreeClosures` must complete with exactly **9,239 jobs**. The
record also runs the exact command `git diff --check` and requires empty
output.

The input manifest freezes every Git-tracked local Lean source outside
`Lean/.lake` and `Lean/verification`, the target and author-audit modules,
Lake configuration, research status and route registry, four mathematical
reports, the combined report and adversarial audits, cited primary-source
artifacts, four computation bundles, integrated TeX and its four fragments,
the complete 68-file TeX source tree, the final PDF, and its complete QA
directory. Every Lake dependency must be
at the Git revision pinned by `lake-manifest.json` with a clean checkout.
For every input-manifest row, the validator reads the stage-zero `:path` blob
directly through `git cat-file --batch`; its byte length and SHA-256 must equal
the worktree record exactly. This proves that all frozen inputs are present in
the Git index with byte-identical content. Both `git diff --check` and
`git diff --cached --check` must exit zero with empty output.

## Counterexample boundary

Only exact claims whose complete premise lists are realized are retired.
The residue-degree-two example refutes raw-Haar weight-sum normalization; the
1093 and 3511 rows refute the listed pointwise sigma-one strengthenings; the
affine period-one examples refute strict savings from the elementary period,
singleton, or `R<C` premises alone; and the Pell examples refute recovery of
the missing 2-adic factor from companion jets alone, local-to-global Pell
realization, and endpoint `U^3` divisibility. These examples do not retire the
corrected admissible IUT interface, sigma-one average, affine catalogue, or
global Pell routes.

See `COMMANDS.md` for the maintainer sequence. Freeze and seal only after the
paper, PDF, and visual QA inputs are final.
