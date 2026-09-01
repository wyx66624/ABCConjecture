# Verification record: 30 August 2026 research increment

## Result and scope

The final default `lake build` completed successfully with **9108 jobs** and
exit code **0**. The consolidated declaration audit also exited **0**.
Its eleven reported declarations depend only on `propext`,
`Classical.choice`, and `Quot.sound`; none reports `sorryAx` or a new
mathematical axiom. The verbatim declaration types and dependency output are
in [axioms.txt](axioms.txt).

**This is not a proof or disproof of `ABCConjecture`.** An equivalence with
that target does not supply either side. A scalar implication whose argument
is an effective-height bound does not prove that argument. The full build
checks the repository development as written, including explicitly
conditional theorems and previously documented external-input interfaces;
it must not be advertised as a proof of abc or as a new audit of every old
external computation.

Existing modules still emit linter warnings in the complete build. A
successful build is not a claim that the older development is warning-free.

## Reproduction

Run these commands in the repository's `Lean` directory:

```powershell
lake env lean --version
lake --version
lake build
lake env lean IUTThreeClosures/ResearchSession20260830Audit.lean
```

The checked environment reported:

```text
Lean 4.32.0, x86_64-w64-windows-gnu
Lean commit: 8c9756b28d64dab099da31a4c09229a9e6a2ef35
Lake 5.0.0-src+8c9756b
Build completed successfully (9108 jobs).
```

The final checks include the integer square-factor descent and all eleven
declarations in the final audit module. The full raw build transcript is
also retained as [build-output.txt](build-output.txt).

Dependencies were restored at the repository's existing pinned revisions.
Neither `lake-manifest.json`, `lakefile.toml`, nor `lean-toolchain` was
changed. In particular:

| Package | Checked revision |
|---|---|
| mathlib | `81a5d257c8e410db227a6665ed08f64fea08e997` |
| iut | `ddaddc274281adb5674d647e24fa478745ac6d40` |
| genl | `6e9a6543b46a2a02fd7fe7ec8ab203d878f32859` |
| heights | `3539e2a12dd3470c057a4eb531dc3fd627d4c97b` |
| tate-curves-theta | `90d7fac0e4ef2d6bf2a619326c30adb862d1b3de` |

Baseline repository HEAD was
`3447f881ec8331f6c343a466e07b8689ded4bebe`; this record describes the working
tree increment, not a newly created commit. The reproducibility hashes are
in [SHA256SUMS](SHA256SUMS), with paths relative to the repository root.

## Checked components

All paths in this table are within `Lean/IUTThreeClosures`.

| Module | What is checked |
|---|---|
| `SmoothLowOmegaCounting.lean` | Actual natural-number factorization into bounded prime powers, finite low-support counting, and the finite first-moment lower bound |
| `SignedPrimeSupport.lean` | Realization of signed layers by actual prime factors, exact defect identities, and equivalence with the unchanged abc statement |
| `SignedEndpointDyadicObstruction.lean` | Genuine primitive triples `(1,2^N,2^N+1)` and the impossibility of a uniform separate-endpoint slope below one |
| `ReachableTensorLatticeCriterion.lean` | Unit-determinant reachable-column span certificate, exact symmetric span in rank two, a missing off-diagonal tensor, and independent pure-tensor generation |
| `FreyPellEffectiveResidualCorridor20260830.lean` | The integral cubic map, integer square-factor descent, scalar implications with explicit height hypotheses, and the actual Frey denominator inequality `c^4 <= 1024*den(j)` |
| `ResearchSession20260830Audit.lean` | Prints the original abc target and the types and axiom dependencies of eleven central declarations |

The first five modules are imported by `IUTThreeClosures.lean`. The library
glob also includes the audit module. No definition of `ABCConjecture`,
`ABCPoint`, or the natural-number radical was weakened or replaced.

The existing `SignedPrimeExponentLayer.lean` did not pass a direct rebuild
at the beginning of this increment. It was repaired by adding the required
endpoint import, completing the exponent-one algebra branch with `ring`,
and unfolding the two defect definitions before rewriting their logarithmic
identities. The statements were preserved. A prior merge description was
not treated as evidence that its advertised result already compiled.

## Mathematical proof and external-input boundaries

The new mathematical statements were proved before their Lean components
were implemented. Separate route agents cross-reviewed the arguments and
source hypotheses. This is internal AI-assisted review, not journal peer
review or an independent human certification.

- The refutation of the stated Carella moment assertions combines the
  checked finite counting theorem with Younis's unconditional short-interval
  theorem and classical smooth-number asymptotics. Those analytic inputs
  and the limit argument are proved or cited in the paper, not formalized
  as a complete Lean refutation of the preprint.
- The full local Haar formula and arbitrary-rank independent-orbit theorem
  have mathematical proofs. The present Lean module checks the specified
  algebraic certificates; it does not formalize the entire measure argument
  or supply actual IUT output data.
- The Bérczes–Evertse–Győry effective integral-point theorem is an explicitly
  cited published input. The Lean scalar lemmas retain numerical height
  bounds as arguments. Integer square-factor descent itself has no such
  external hypothesis.
- Finiteness under a fixed small-Frey-denominator hypothesis, the asymptotic
  Pell conclusions, and the endomorphism-algebra obstruction have paper
  proofs. Their full asymptotic and geometric arguments are not claimed as
  Lean-checked theorems in this increment.
- The coupled bound remains equivalent to abc and unproved. The primitive
  dyadic and simultaneous-tensor counterexamples refute only the specific
  stronger substitute statements. They are not abc counterexamples.

Original sources are archived under `research/sources/`, with three dated
route manifests identifying URLs, versions, theorem locations and SHA-256
values. A new or controversial preprint was not accepted as a proven abc
input merely because of its abstract or publication date.

## Manuscript artifact

Source: `paper/ChatGPT_ABC_Uniformity_2026.tex`.

PDF: `output/pdf/ChatGPT_ABC_Uniformity_2026.pdf`.

The title is *Uniformity, Prime Support, and Reachable Lattices in Approaches
to the abc Conjecture*, author **ChatGPT**, dated 30 August 2026. It is a
research manuscript about partial results and obstructions, not a completed
abc proof, a published article, or a claim of external peer review.

It was compiled with bundled Tectonic 0.17.0 through the LaTeX skill's
`compile_latex.py` wrapper, with exit code 0. The final PDF has 10 pages and
155622 bytes. Its final TeX pass has no overfull/underfull box or unresolved
reference warning. Text extraction found no unresolved `??` or replacement
characters. Every page was rendered and visually inspected; the long module
name in the formal-scope table was wrapped to remove an overflow. Source
references, equation numbering, mathematical glyphs, title and author
metadata, margins and page breaks were checked.

```text
PDF SHA-256:
9db9ee3cbcc0f40e7db454788cf98587c8afde394454b1766ffef38e03e3a364
```

The final objective remains open: construct a closed proof term of the
original unconditional `ABCConjecture`, or a rigorous disproof with one
fixed positive exponent gap and unbounded violations.
