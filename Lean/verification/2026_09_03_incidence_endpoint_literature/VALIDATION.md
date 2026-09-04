# Incidence / endpoint / shared-CRT validation ledger

Status: **PASS**

## Controlled replay

`run_checkpoint.py` completed all 30 recorded commands with exit code zero,
with every command's declared input hashes unchanged during execution. The
formal and computational replay used CPython 3.12.14 with optimization off,
`PYTHONHASHSEED=0`, and `PYTHONDONTWRITEBYTECODE=1`. The Lean toolchain was
Lean 4.32.0, commit `8c9756b28d64dab099da31a4c09229a9e6a2ef35`.

The replay built the `IUTThreeClosures` umbrella, elaborated all eleven source
modules and all eleven separate axiom-audit modules directly with
`-DwarningAsError=true`, and elaborated the independent compiled-environment
audit. It then ran the endpoint producer and independent Hall audit, the
three-arm successor producer, and the PBT producer and independent full-scope
validator.

## Formal inventory

The eleven source modules contain exactly 496 public declarations:

| Module | Declarations |
| --- | ---: |
| `ABCValuationIncidenceComplex20260903` | 85 |
| `ABCValuationIncidenceFixedBudgetObstruction20260903` | 18 |
| `ABCValuationIncidenceScaleBudgetObstruction20260903` | 34 |
| `ABCSignedEndpointPrimeTokenTransport20260903` | 77 |
| `ABCThreeArmIncidenceSuccessor20260903` | 65 |
| `ABCThreeArmComplementTransportObstruction20260903` | 37 |
| `ABCBidirectionalPrimeTransportSuccessor20260903` | 44 |
| `ABCBidirectionalEnergyPythagoreanObstruction20260903` | 40 |
| `ABCPrimePacketBoundaryTransportSuccessor20260903` | 39 |
| `ABCPrimePacketBoundaryLinnikObstruction20260903` | 27 |
| `ABCSharedCRTIncidenceSuccessor20260903` | 30 |

Their declaration kinds are 336 theorems, 131 definitions, 20
abbreviations, eight structures, and one inductive type. Each declaration has
one ordered `#print axioms` query. The source and compiled-log gates find no
`sorry`, `admit`, custom axiom, `unsafe`, `partial`, or `native_decide`.

The compiled-environment audit reports 837 generated public declarations in
the eleven module environments, including 72 in the shared-CRT environment.
Its dependency union is exactly `propext`, `Classical.choice`, and
`Quot.sound`; generated unsafe and partial declarations are both zero.

The unconditional Lean results close finite algebraic kernels, exact bridge
identities, and the stated counterexample families. The PBT module proves
`LinnikPrimeNeighborEscape -> not UniformEndpointPrimePacketBound`; the
published Linnik theorem used by the preceding ordinary proof is not present
in the pinned Mathlib tree and is not inserted as an axiom. The shared-CRT
module proves its once-charge finite kernel and the conditional implication
`UniformAdmissibleSharedCRTBoundary Admissible -> ABCConjecture`; it does not
assert the uniform premise.

## Exact computations

The endpoint replay enumerated 3,795,230 normalized primitive nonunit triples
with `c <= 5000`. It found zero exact-identity failures, 113,086 failures of
full integral dominance matching, 113,027 such failures despite the scalar
core inequality, and 3,792,836 zero-residual fractional monotone flows. The
independent exact upper-tail Hall implementation reproduced every count. The
frozen and replay JSON files are byte-identical with SHA-256
`f94936e6e10a506e743c6e84716807bc2af3d8093b1e6305b8668263ae9afd64`.

The three-arm replay enumerated 218,893 primitive unordered positive triples
with `c <= 1200` and found 1,669 zero-defect-cover failures. Its maximum
observed raw and flow ratios are respectively `1.0655592465417085` and
`0.6131471927654585`. Frozen/replay JSON and CSV pairs are byte-identical,
with SHA-256 values
`1c1ec381bbb651b366835d170cff856d1abee103940939f2f05a6dd5d55e91d3`
and `e19459d20ffe237d89341ab40dc11db26341ac14ac8a1c5d81169a9705f3e80c`.

The prime-packet replay exhaustively optimized 1,368,094 normalized primitive
triples with `c <= 3000`. It found 624 positive optimal residuals, 572 strict
fragmentation gaps, and 567 points with zero scalar defect but positive packet
residual. The maximum residual/conductor ratio lies in
`[5468/12000, 5469/12000)` at `(1,2400,2401)`; the largest residual factor is
16 at `(1,2591,2592)`. The 1,038 structured-family rows and the full scope were
independently replayed. Frozen/replay JSON and CSV hashes are respectively
`b48f4f0ef45da1cc55ca3cf1301643f842e18176a90ea4216f5bf4c5f0d475a0`
and `544de25a5b498b2380253440a6b6ebdcb02e7b91819adffa3e96225e80cef37e`.
All finite scopes remain explicit and are not extrapolated into asymptotic
claims.

## Paper artifact

The paper-build wrapper recorded identical pre-build and post-build SHA-256
maps for the exact 87-file TeX closure. The final PDF is 270 pages and
1705875 bytes, with SHA-256
`9daf48428922e6a1216c8e191b93734cd4a496e4162684350df67a7c28b07e7e`.
Its metadata title is *Uniformity, Prime Support, and Reachable Lattices in
Approaches to the abc Conjecture*, its author is ChatGPT, and it is not
encrypted. The final engine, bundled-driver, and render exits are zero.

The warning gate is clean. All 270 pages were rendered; 17 contact sheets and
nine selected full-resolution pages were visually inspected. The structural
audit found no blank raster, four-pixel border contact, page below 100
characters, or missing one of the 14 required text targets.
The PDF contains 36 fonts. The final PDF, build provenance, logs, metrics,
audit program, report, and all 17 contact sheets are sealed by the manifest.

These checks validate the claimed exact subtheorems, counterexamples, finite
searches, and conditional reductions. No term of unconditional
`ABCConjecture`, and no term of its negation, is produced. The standard abc
conjecture remains open.
