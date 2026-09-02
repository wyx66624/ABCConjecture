# Validation record

The recorded run completed successfully on September 2, 2026. The exact
machine-readable evidence is in `validation-run.json`,
`declaration-inventory.json`, `evidence-replay.json`, and `logs/`.

## Frozen inputs and declarations

The input manifest freezes 594 files, including every configured local Lean
source outside verification directories, the four checkpoint modules, Lake
configuration, route registries and mathematical reports, computation and
source-audit evidence, the integrated TeX manuscript, the final PDF, and its
complete QA directory. Its SHA-256 digest is
`a6f335acc10fcf15cfdc40836557e6dbf08ccfdd51da04d6758233cdd017dbed`.
All 14 Lake Git dependencies were clean at the revisions pinned by
`lake-manifest.json`.

| Module | Theorems | Definitions | Private proofs | Proof reports |
|---|---:|---:|---:|---:|
| `AffineSignedRayCanonicalCaps20260901` | 41 | 4 | 0 | 41 |
| `IUTAdmissibleScalingOrderIndex20260901` | 11 | 2 | 0 | 11 |
| `MersenneCriticalSlowSlackGate20260901` | 16 | 4 | 0 | 16 |
| `PellLucasCorrelatedAllOrderExclusion20260901` | 22 | 6 | 0 | 22 |
| **Total** | **90** | **16** | **0** | **90** |

There are 106 counted declarations. The validator hard-checks every
per-module count and all totals during both live validation and sealed-record
verification. Every theorem has exactly one generated `#print axioms` report.
The deterministic same-scope audit digest is
`b12aa958883112c69ec4b9e983889b2efe3f0eaeacf462b6df5d5b9986a1a24a`;
the declaration inventory digest is
`9e77f317c4eb378e6631d20c95569939dddb963dc3c5f286020e5c9cc17e2243`.
The axiom union is exactly:

- `Classical.choice`;
- `Quot.sound`;
- `propext`.

No target source contains `sorry`, `admit`, `native_decide`, `sorryAx`, a
custom `axiom` declaration, `opaque`, `unsafe`, `partial`, or `extern`.

## Compiler and evidence replays

All four direct module compilations exited zero with warnings promoted to
errors. The generated axiom audit also exited zero with no warnings.
`lake build IUTThreeClosures` completed successfully with exactly 9,233 jobs.
Its 301 warnings are retained pre-existing aggregate-project warnings; none
arises in a direct checkpoint-module or generated-audit compilation.

The independent four-route replay document has SHA-256
`45a0eafdf29cb2a01cc1d7769fba8667dc69fbf044be4d8daff28fb9272f1569`.
It verifies 41 frozen hashes and independently reproduces the accepted
evidence object:

- 1,776,807 affine cubic ledgers, 2,390,018 quadratic ledgers, 15,840 signed
  directions, and 43,403 arm-capture cases;
- 9,591 odd-prime Mersenne rows through 100,000, including the exact 1093 and
  3511 certificates and the complete character table;
- 57 Pell prime indices through 271, 138,675 coefficient pairs, 228
  polynomial checks, and 527,352 candidate-prime tests;
- Project LANA commit
  `c65b28c9f9631635e742294c3a5df15759e7c74c`, 13 frozen source records, 15
  sealed hashes, three patch files, and the recorded 8,767-job upstream
  compilation.

The frozen delivery PDF is the 193-page A4 manuscript by ChatGPT with SHA-256
`16a9f976d65f76539e633b842899c688e1082a6d7561a6d412b4629463415dfa`.
Its QA record includes a full 193-page render, ten contact sheets, 24 selected
high-resolution inspections, embedded-font and link checks, and a final log
with zero overfull boxes and four cosmetic underfull page-break warnings.

The exact finite counterexamples retire only their full-premise
strengthenings: deletion of selected affine catalogue membership, overstrong
affine period/threshold claims, total-set positive IUT volume shifts,
surjective-projection product-order recovery, universal even Mersenne
multiplier, and all-negative-edge Pell character rows. They do not retire the
corrected affine, critical Mersenne, correlated Pell--Lucas, or admissible IUT
routes. Finite no-hit searches are recorded without asymptotic extrapolation.

This package certifies the local theorems, source-placeholder exclusion,
one-for-one axiom reporting, deterministic evidence replay, frozen inputs, and
aggregate integration. It does not claim an unconditional proof or disproof
of the standard abc conjecture.
