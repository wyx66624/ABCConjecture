# Validation record

The recorded run completed successfully on September 1, 2026. Exact
machine-readable evidence is in `validation-run.json`,
`declaration-inventory.json`, `input-manifest.json`, and `logs/`.

## Frozen checkpoint

The input manifest contains 491 files. It includes every Git-tracked local
Lean source outside verification directories, the four checkpoint modules,
the Lake configuration, the four mathematical reports, the aggregate paper
and its four new fragments, the final PDF, and the sealed Mersenne scan and
verifier. Every Lake Git dependency is required to be clean at the revision in
`lake-manifest.json`.

| Module | Theorems | Lemmas | Definitions | Structures | Private proofs |
|---|---:|---:|---:|---:|---:|
| `AffineCommonKernelTripleSelection20260901` | 21 | 0 | 9 | 1 | 8 |
| `IUTAdmissibleVolumeIntegerBridge20260901` | 22 | 0 | 5 | 3 | 0 |
| `MersenneFixedPolylogBlockMassTriage20260901` | 12 | 2 | 4 | 0 | 0 |
| `PellResidueParityLocalization20260901` | 37 | 0 | 4 | 4 | 0 |
| **Total** | **92** | **2** | **22** | **8** | **8** |

There are 124 counted declarations and 94 theorem-or-lemma declarations. The
generated same-scope audit issues exactly 94 `#print axioms` commands,
including all eight private affine proofs. Its axiom union is exactly:

- `Classical.choice`;
- `Quot.sound`;
- `propext`.

All four direct compilations and the generated audit exited zero with zero
warnings. `lake build IUTThreeClosures` completed 9,220 jobs with no error. Its
301 warnings are inherited aggregate-project diagnostics; none occurs in a
direct checkpoint-module or generated-audit run.

The code-only scan finds no proof placeholder, custom axiom declaration,
`native_decide`, opaque declaration, unsafe definition, partial definition,
or external declaration in the four target sources.

## Independent finite computation

`verify_super_wieferich.py` independently reconstructs the prime list through
10,000,000 by segmented sieve and checks all 664,579 primes against the sealed
scan. It recovers precisely the base-two Wieferich hits 1093 and 3511, both at
valuation depth two, and no super-Wieferich hit. The validation scope records
this as finite-only evidence; absence of a deeper hit has no asymptotic
consequence.

## Paper artifact

Tectonic produced the 165-page A4 paper authored by ChatGPT. The retained final
pass log has no overfull box, undefined reference, undefined citation,
multiply-defined label, or TeX error. One historical underfull page break
remains. Representative pages covering the abstract, IUT bridge, affine
energy identity, Pell localization, Mersenne three-arm gate, formal audit, and
references were rendered with Poppler and inspected without finding clipping,
overlap, or unreadable mathematics.

The recorded scope fields remain `provesOrDisprovesStandardABC: false` and
`finiteOrConditionalClaimsUpgraded: false`.
