# Quantitative transversality and generated-packet verification

This directory is the reproducibility package for the September 3, 2026
five-module checkpoint. It certifies the exact Lean declarations, axiom
dependencies, deterministic finite evidence, source capsule, integrated paper,
and PDF quality-assurance record described below. It does **not** contain a
proof or disproof of the standard abc conjecture, a verification of IUT, or an
asymptotic conclusion drawn from a bounded computation.

## Formal inventory

| Lean module | Theorems | Definitions | Other named declarations | Total |
|---|---:|---:|---:|---:|
| `MersenneFareyQuantitativeSwarm20260903` | 17 | 3 | 0 | 20 |
| `AlternativeQualityPackingBridge20260903` | 9 | 4 | 0 | 13 |
| `PellFixedTwoTransversality20260903` | 25 | 6 | 0 | 31 |
| `SteinbergFiveTermBoundaryBridge20260903` | 66 | 41 | 1 abbreviation, 5 structures | 113 |
| `ABCSynchronizedDivisorPackets20260903` | 52 | 25 | 2 structures, 2 named instances | 81 |
| **Total** | **169** | **79** | **1 abbreviation, 7 structures, 2 named instances** | **258** |

`validate.py` first blanks nested comments, strings, character literals, and
attributes while preserving line numbers. It then inventories the supported
declaration grammar and rejects `sorry`, `admit`, `native_decide`, `sorryAx`,
declaration-style axioms, custom opaque declarations, unsafe/partial/extern
declarations, private declarations, anonymous instances, and unsupported
declaration forms. Exact per-module and aggregate counts are fixed.

The generated `axiom-audit.lean` contains exactly one `#print axioms` command
for every named declaration, including definitions, the abbreviation,
structures, and named instances. All 258 reports must occur exactly once. Their
union must remain within `propext`, `Classical.choice`, and `Quot.sound`.
The generated audit also compiles exact type contracts for both Steinberg
submodule inclusions, definitional (`rfl`) contracts for the three synchronized
quality functions, and the minimum-energy majorant. Thus retaining a theorem
name while weakening its type or changing one of those definition bodies is
not enough to pass.

The umbrella target is built first and must report exactly 9,265 jobs. Each of
the five source modules and each hand-written `AxiomAudit` companion is then
compiled directly with `-DwarningAsError=true`; the generated all-declaration
audit is compiled under the same setting.

## Exact scope

The formal checkpoint includes the Mersenne quantitative swarm reductions and
quantifier transfer; the alternative-quality packing identities and abstract
metric countermodel; fixed-`T=2` Pell transversality and simultaneous
zero-displacement reductions; the Steinberg five-term relation and positive
rational-realization bridge; and the synchronized-divisor-packet algebra,
explicit counterexamples, exact family, and real-log finite-minimum quality
majorant.

For Steinberg, the proved statement is that the generated submodule is
**contained in** the boundary kernel. This package does not claim equality with
the kernel. Arbitrary-target positive filling and the two analytic Gate VF cost
estimates remain open. For synchronized packets, Lean proves
`standardQuality_le_minimumPacketEnergy`; it does not supply the eventual
radical upper bound on that minimum. The critical Mersenne counting input and
the global fixed-Pell squarefull exclusion also remain open.

## Evidence replay and source boundary

The validator performs the following independent checks:

- it reruns the official Sankaran arXiv source-capsule verifier and compares its
  JSON output semantically with the frozen result;
- it reruns the Mersenne/alternative-quality cross-audit, requiring `PASS`, no
  critical errors, exact countermodels, and the documented finite/asymptotic
  boundary;
- it reruns 3,091,963 fixed-Pell candidate-prime tests and an independent
  matrix-power verifier, requiring byte-identical outputs and the full-premise
  witness `(ell,q,channel)=(7,13,B)` while retaining the global exclusion as
  open;
- it reruns the Steinberg five-term scan and self-validator, requiring semantic
  equality with the frozen validation JSON and no unexpected axioms; and
- it reruns the synchronized-packet search over 3,795,230 primitive triples,
  requiring byte-identical JSON/stdout, 151,244 enumerated fibres, 151,711
  packets, 467 proper packets, 105 exact-gap packets, the corner, cubic,
  quartic/product-square, and constant-one quintic full-premise
  counterexamples, and no promotion of finite evidence to an asymptotic
  theorem.

All `SHA256SUMS`, `SHA256SUMS.txt`, `INPUT_SHA256SUMS.txt`, and
`manifest.sha256` files in the designated archives are checked. Repository-root
and archive-local paths are distinguished explicitly and path traversal is
rejected. Replayed producers must leave the frozen input manifest byte-for-byte
unchanged.

The input manifest freezes the five modules and their hand-written audits, the
umbrella import, status and route registry, checkpoint reports, integrated TeX
and fragments, final PDF, all version-controlled Lean source dependencies, the
designated source/computation archives, and the new PDF QA directory. Text
checks cover strict UTF-8 decoding, isolated carriage returns, unexpected
control characters, malformed bare TeX `qquad`, and trailing whitespace in
authored files. Both `git diff --check` and `git diff --cached --check` must
pass.

The Lean input closure includes every tracked Lean source plus the ten explicit
checkpoint files. Any other nonignored, untracked `.lean` file is rejected;
this prevents an auxiliary import from participating in a build while escaping
the frozen input manifest. Generated verification-package files are sealed as
outputs and are the only package-local exception.

The PDF QA record must report `PASS`, match the final PDF's SHA-256 and byte
size, identify the author as ChatGPT, cover every page with a raster, contain
no blank/border-contact/low-text pages, and list contact sheets whose ranges
exactly cover the document. The validator also reads the PDF independently
with `pypdf`, checks page count, metadata, extracted-text length, malformed
tokens, and seven checkpoint anchors, verifies every recorded page-geometry
row, rejects final-pass TeX diagnostics, and requires the QA `SHA256SUMS` file
to cover every sibling file exactly once.

Ignored `Scratch`, `Tmp`, and `Check` experiments are not imported checkpoint
sources and are deliberately excluded from the fixed input manifest.

## Replay

From this directory, or from any working directory, run:

```powershell
.\validate.ps1 -Check
```

Maintainers regenerate the inventory, audit, and input manifest with
`-Prepare` only after all source files and the PDF QA directory are final. They
run `-Record` to execute every check, write `validation-run.json` and command
logs, and create `SHA256SUMS`. A later `-Check` verifies the immutable package
seal before rerunning the validation in `tmp/verification/` and comparing all
stable fields and command exit statuses with the sealed record.

`SHA256SUMS` is an internal integrity root. It is neither a digital signature
nor an externally timestamped attestation; provenance against a hostile
repository requires obtaining its digest from a trusted copy.
