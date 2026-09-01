# Full Galois lifts, exact local hulls, and global initial data: validation

Research dates: 2026-08-30 and 2026-08-31. Author: ChatGPT.

The standard unconditional `IUTThreeClosures.ABCConjecture` is **neither
proved nor disproved**. This increment accepts seven new Lean modules,
130 public theorems, 15 additional proof-carrying constructions, and a
66-page English partial-results manuscript. The mathematical results
extend beyond the formalized components; their exact boundary is below.

## Reproduction and recorded results

Run from the repository's `Lean` directory with the pinned toolchain:

```powershell
lake build
lake env lean IUTThreeClosures/ResearchGaloisLifts20260830Audit.lean
lake env lean IUTThreeClosures/ResearchUniformGate20260830Audit.lean
lake env lean IUTThreeClosures/ResearchContinuation20260830Audit.lean
```

All four recorded runs exited with code zero. The final default build
completed **9129 jobs**, with **265 pre-existing warning entries** and
**no warning in any new module or its audit**. Initial outputs retaining
the subsequently fixed style warnings are archived separately. No linter
was disabled. Resource limits used for exact finite integer arithmetic
are explained at their declarations; they do not add axioms.

| New module | Public theorems | Additional constructions |
| --- | ---: | ---: |
| `IUTFullGaloisWordLift20260830` | 20 | 2 |
| `IUTThreeLabelMinimumLayer20260830` | 15 | 2 |
| `Frey139Tate210Realization20260830` | 34 | 6 |
| `SL2TransvectionGeneration20260830` | 12 | 2 |
| `Frey43BalancedRealization20260830` | 26 | 3 |
| `IUTGeneralTameSquareLabels20260830` | 17 | 0 |
| `TraceDualPreidealHull20260831` | 6 | 0 |
| **Total** | **130** | **15** |

`declarations.json` and `constructions.json` list the exact names.
`axioms.txt` contains a checked type and dependency report for all **145**
declarations. Six need no axioms; every remaining dependency is a subset
of `propext`, `Classical.choice`, and `Quot.sound`. There is no `sorryAx`,
new mathematical axiom, missing report, or unexpected declaration.
`axiom-dependencies.json` and `axiom-summary.json` contain the parsed audit.
The older **89**- and **43**-declaration audits were independently rerun,
also with standard axioms only and no warning.

These commands and hashes establish reproducibility, not a proof of any
unformalized hypothesis. The audit prints the unchanged standard target
but supplies no closed inhabitant of it.

## Mathematical scope and formal boundary

Complete mathematical arguments were written before the corresponding
Lean components. The principal new paper results are:

- Explicit full local-Galois word lifts and one common minimum-layer
  Kummer arrow for every square label in the specified tame family.
- An exact pre-transport ideal hull: the sharp trace-dual upper bound
  meets the actual point-orbit lower bound. The larger whole-product
  source has hull `p^(-1)` times this ideal and is not silently identified
  with it. Changing every logarithmic coordinate to the standard scale
  changes the source and length-`m` hull by `p^m`.
- Actual rational Frey curves realizing the local fields, an exact
  level-43 example, and an unbounded CRT/power-free family with controlled
  height and prime-to-level Tate orders.
- Complete original IUT I Definition 3.1 initial theta data for the
  level-43 example and every member of the constructed unbounded family,
  including the core, graph cover, distinguished cusp, and independent
  selected-place choices. No extra torsion-field extension is inserted.

Lean proves the displayed free-group words and automorphism, actual
linear equivalences, finite avoidance, SL2 matrix generation and normal
subgroup implications, actual Weierstrass invariants and point counts,
exact prime-exponent and real-logarithm bounds, general label arithmetic,
and a genuine algebra-trace/dual-submodule pre-ideal bound. In particular,
the trace-dual module uses `Algebra.traceForm`, finite-product traces,
and the actual `Submodule.span` after transport; it does not assume its
desired containment as a hypothesis.

The full profinite Galois presentation, local class field theory,
Tate uniformization, Galois representations, inverse different and
tensor-order identifications, Linnik's theorem, core and étale-theta
geometry, complete initial-data construction, and the published global
IUT comparison are **not completely formalized**. Their mathematical
proofs and precisely cited external inputs are not hidden inside new
Lean axioms. Full initial data does not itself give the weighted global
pilot/Ind3/cross-Frobenius comparison or the all-epsilon abc estimate.

## Exact manuscript and visual review

The author is **ChatGPT**. Tectonic 0.17.0 produced a **66-page**,
**555812-byte** PDF with **zero final TeX warnings**:

```text
752027de98d87d2457e2c038fda635b212a6534d63b9f82e903c66eb7484a4c1
```

`pdf-metadata.json`, `latex-run.json`, and `validation_summary.json`
identify that same artifact. Every page was actually viewed as an image.
Four disjoint page-range reports cover 1–18, 19–36, 37–50, and 51–66;
`PDF_QA.md` indexes them. Image hashes and pixel identity of pair images
with their single-page sources were also checked. No final layout or
reference correction was required after these checks.

`DOC_REVIEW.md` records mathematical cross-review separately from visual
QA. These are internal AI reviews, **not external human peer review,
journal acceptance, or a priority claim**. The manuscript expressly
states that no abc proof or disproof is claimed.

## Protected files and historical integrity

`environment.json` records the actual Lean/Lake versions, repository HEAD,
package revisions, and hashes. The standard ABC definition, protected
downstream interface, toolchain, lakefile, and dependency manifest match
the preceding stage byte for byte. Pinned package revisions also match.
Existing unrelated working-tree changes have been preserved. No commit,
push, external message, journal submission, or edit to an original or
user-uploaded PDF was performed.

The preceding **506-entry** manifest remains unchanged with SHA-256
`c470be98f60af38a31b8a00393d09f276e10d223c197034cfd1a1ee5628afe7a`.
Six mutable canonical files were captured before this increment in
`previous_snapshot/`; `previous-manifest-map.json` records their paths.
Replaying the preceding manifest through those six mappings gives **zero
failures**. This preserves the previous 34-page paper and 89-theorem
acceptance record without claiming that today's canonical files are the
old versions. The older 447-entry replay and its ten mappings remain
preserved inside that history.

The verifier `verify_manifest.py` checks this increment and replays both
previous manifests with their documented path mappings. It does not run
the old stage's verifier against the changed canonical PDF. Checksums
are integrity checks, not substitutes for the mathematical arguments.

The ultimate unconditional ABC goal remains active and unachieved. No
broad mathematical route is abandoned for being incomplete.
