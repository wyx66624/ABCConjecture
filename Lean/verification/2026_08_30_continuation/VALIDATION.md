# Verification record: August 30, 2026 continuation

## Outcome and exact scope

The final default `lake build` exited **0** with **9115 jobs**. The direct
continuation audit exited **0** and reported **43 declarations**. Their
dependencies are confined to `propext`, `Classical.choice`, and
`Quot.sound`; none reports `sorryAx` or a new mathematical axiom.
The exact declaration types and dependencies are in `axioms.txt`.

This is **not** an unconditional Lean proof or disproof of
`IUTThreeClosures.ABCConjecture`. In particular, the complete effective
finiteness theorem for the specified Pell family is a mathematical
application of unconditional published results. Matveev and BEG have not
been formalized here. Their numerical conclusions remain visible
arguments of the corresponding Lean implications.

The original target, `abcRadical`, and `ABCPoint` were checked against
repository HEAD and are unchanged. Neither a restricted target nor an
interface whose hypothesis already implies abc is presented as the goal.
The complete build includes pre-existing conditional results and external
computation interfaces; it does not certify every old external computation
anew or convert those interfaces into unconditional facts.

## Reproduction

In the repository's `Lean` directory, run:

```powershell
lake env lean --version
lake --version
lake build
lake env lean IUTThreeClosures/ResearchContinuation20260830Audit.lean
git diff --exit-code HEAD -- IUTThreeClosures/ABCStatement.lean IUTThreeClosures/NonCircularDownstream.lean lean-toolchain lakefile.toml lake-manifest.json
python verification/2026_08_30_continuation/verify_manifest.py
```

The final build transcript is `build-output.txt`. The first integration
transcript, before style repairs, is retained separately as
`build-initial-with-style-warnings.txt`. Two new files needed standard
copyright headers and several long audit commands needed shorter qualified
names. These were repaired without changing mathematical statements or
disabling any linter.

The final build contains **265 older warning entries** and **zero warnings
from the six new component modules or the new audit module**. Build success
is not a claim that the older repository is warning-free.

## Environment and unchanged dependencies

The exact reported environment and check time are in `environment.json`.

| Item | Verified value |
| --- | --- |
| Lean | 4.32.0, x86_64-w64-windows-gnu |
| Lean commit | `8c9756b28d64dab099da31a4c09229a9e6a2ef35` |
| Lake | 5.0.0-src+8c9756b |
| Repository HEAD | `3447f881ec8331f6c343a466e07b8689ded4bebe` |
| mathlib | `81a5d257c8e410db227a6665ed08f64fea08e997` |
| iut | `ddaddc274281adb5674d647e24fa478745ac6d40` |
| genl | `6e9a6543b46a2a02fd7fe7ec8ab203d878f32859` |
| heights | `3539e2a12dd3470c057a4eb531dc3fd627d4c97b` |
| tate-curves-theta | `90d7fac0e4ef2d6bf2a619326c30adb862d1b3de` |

No toolchain, manifest, package pin, or repository commit was changed.
This record describes the working tree, not a new commit or a publication.

## New components

All module paths in this table are within `Lean/IUTThreeClosures`.

| Module | Checked result and remaining boundary |
| --- | --- |
| `AnalyticAmplificationContinuation20260830.lean` | Actual radical inequalities; CRT uniqueness and finite counts with a common size certificate; conic identities and the certificate's height bound. The ellipse-direction count and asymptotic comparison are paper proofs. |
| `DVRReachableHaar20260830.lean` | Cramer divisibility, attainment of a minimum determinant on actual reachable columns, exact Smith quotient cardinality, compact closed span, and full-rank Haar/log-volume on the compact integral lattice. The ambient Haar restriction identification and deficient-rank case are not constructed in this module. |
| `GeometryUniformityContinuation20260830.lean` | Actual norm/ratio estimates, logarithmic absorption with explicit input, the primitive Frey--Mordell point and invariant normalization, and its split cubic. The approximation and regulator inputs remain outside the formalization. |
| `IUTReachabilityContinuation20260830.lean` | Tensor units, scaled linear independence, and inclusion of a full integral tensor span in a coefficient-module hull. The concrete local Kummer and IUT source identifications are not inferred automatically. |
| `MatveevPellFinitePacket20260830.lean` | Real square-root expressions tied to Pell coordinates; strict approximation; normalized exponent algebra; `p < 2^52 log(2ep)` implies `p < 2^59`; explicit combination with a supplied BEG height estimate. No Matveev/BEG axiom was added. |
| `IUTTargetReset20260830.lean` | Covariance of the whole all-linear-isomorphism collation while repeated source labels use the same map, covariance of its span, and compatible source reindexing. The source classes are kept fixed; arbitrary Frobenius preservation and full Galois reachability are not asserted. |
| `ResearchContinuation20260830Audit.lean` | Prints the unchanged standard abc target, exact types, and dependency reports for 43 declarations. |

The six component imports were added to `IUTThreeClosures.lean`; the
library glob includes the audit module as well. The earlier five principal
components and earlier audit remain present. All new proofs were preceded
by mathematical arguments in the accompanying research notes. Separate
agents cross-checked the Matveev parameters, the CRT/conic edge cases,
the full-rank Haar interpretation, and the IUT source comparison. This is
internal AI-assisted review, not external human certification or journal
peer review.

## Mathematical conclusions that must not be overstated

- The specified positive integer family
  `b+2=3r^2`, `b+3=s^2`, `b^2+3b+1=T_p(X)`, `p>=3`, `X>1`
  is mathematically effectively finite, by the cited Matveev Corollary 2.3
  and BEG theorem. Its nontrivial index satisfies `p<2^59`. No reduction of
  all abc exceptions to this family was constructed.
- The complete local Haar theorem in the paper has a full-rank compact
  formulation in Lean. It does not by itself identify any IUT source set
  with its hypotheses or with the region in a global upper estimate.
- The 109-adic noncontainment compares two explicitly specified local
  recipes. It does not satisfy Joshi IV's subsequent prime-window
  hypothesis and is not an instance refuting that global theorem. The
  original Mochizuki IV local theorem has a different hypothesis chain.
- The latest exact-hull/window note is proved only for the stated full
  integral-linear automorphism model. Its overall local-field realization
  is not formalized in this increment. A separate counterexample shows why
  a smaller allowed family cannot be silently replaced by the full group.

The current Chinese overview and source pointers are in
`research/ABC_CONTINUATION_2026_08_30.md` relative to the repository root.

## Manuscript and original sources

The English manuscript is `paper/ChatGPT_ABC_Uniformity_2026.tex`, with four
included continuation files, and the output is
`output/pdf/ChatGPT_ABC_Uniformity_2026.pdf`. Both the title page and PDF
metadata name **ChatGPT** as author. It reports partial mathematical
results and explicitly denies having proved or disproved abc.

Tectonic compiled the updated manuscript successfully. The final TeX pass
has no overfull/underfull boxes or unresolved-reference warnings. All
pages were rendered and visually checked; the final page count, file hash,
and inspected page list are recorded in `PDF_QA.md` and
`validation_summary.json`. Formula typography, proof pagination, repeated
table headers, references, author metadata, and absence of clipping were
checked. Original-source page renders were also used for Matveev and IUT
formula verification; they are not confused with the manuscript QA.

Seven additional original PDFs are archived in
`research/sources/continuation_2026_08_30`, with exact version dates, URLs,
byte counts, page counts, and SHA-256 values. The Matveev application uses
the independence-free corollary and retains its `0.16` condition. The IUT
author versions are not described as the differently paginated journal
files. A listed later Győry corrigendum was not obtained; no claim is made
to have inspected its text.

## Historical snapshot and current hashes

The earlier record `verification/2026_08_30/` is preserved. Its ten-page
manuscript and source were copied before this edit into
`verification/2026_08_30/paper_snapshot/`. The previous PDF has SHA-256
`9db9ee3cbcc0f40e7db454788cf98587c8afde394454b1766ffef38e03e3a364`.
The earlier hash manifest describes that earlier working-tree state;
some current index and manuscript files have intentionally advanced.

The overview's final independent consistency review and its corrections
are recorded in `DOC_REVIEW.md`. They did not require a Lean or PDF change.

This directory's `SHA256SUMS` records **447** final current files, with paths
relative to the repository root, including the unchanged core definitions,
new modules, source manifests, research notes, manuscript inputs and PDF,
and final validation outputs. It is generated after the edits and checked
again against every listed file. User-provided PDFs were not edited or
removed. No route, branch, external message, commit, push, or submission was
created or deleted as a side effect of this validation.
