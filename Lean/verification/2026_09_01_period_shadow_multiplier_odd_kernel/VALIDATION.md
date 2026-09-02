# Validation record

The recorded run completed successfully on September 1, 2026.  The exact
machine-readable evidence is in `validation-run.json`,
`declaration-inventory.json`, `pell-independent-verification.json`, and
`logs/`.

## Frozen inputs and declarations

The input manifest freezes 502 files, including every configured local Lean
source outside verification directories, the four checkpoint modules, Lake
configuration, mathematical reports, computation evidence, the integrated
TeX manuscript, and the final PDF.  Its SHA-256 digest is
`23f4327f0fbb2d7c7638a69ba6da0e6645ce7340e37656565a858bd5d040a465`.
Every Lake Git checkout was clean at the revision pinned by
`lake-manifest.json`.

| Module | Theorems | Definitions | Structures | Instances | Private proofs | Proof reports |
|---|---:|---:|---:|---:|---:|---:|
| `AffineCollinearPeriodEnergy20260901` | 27 | 6 | 0 | 0 | 3 | 27 |
| `IUTRationalTripodShadowComparison20260901` | 28 | 21 | 1 | 1 | 0 | 28 |
| `MersenneMultiplierIndexTwoArm20260901` | 10 | 4 | 0 | 0 | 0 | 10 |
| `PellOddKernelThirdOrderPacket20260901` | 18 | 9 | 1 | 0 | 0 | 18 |
| **Total** | **83** | **40** | **2** | **1** | **3** | **83** |

There are 126 counted declarations.  Every theorem has exactly one generated
`#print axioms` report.  The deterministic same-scope audit digest is
`3e8eef2a073236ee55d5d12fb896f578bb675f6ec64a4e06fb3fac4d14308aed`;
the declaration inventory digest is
`70e827d9de6cfb76c6a23635f18b5515e154b221de895b99f3aa1b1115c80bf4`.
The axiom union is exactly:

- `Classical.choice`;
- `Quot.sound`;
- `propext`.

No target source contains `sorry`, `admit`, `native_decide`, `sorryAx`, a
custom `axiom` declaration, `opaque`, `unsafe`, `partial`, or `extern`.

## Compiler and computation replays

All four direct module compilations exited zero with warnings promoted to
errors.  The generated axiom audit also exited zero with no warnings.
`lake build IUTThreeClosures` completed successfully with exactly 9,224 jobs.
Its 301 warnings are retained pre-existing aggregate-project warnings; none
arises in a direct checkpoint-module or generated-audit compilation.

The independent Pell replay output is byte-identical to the frozen verifier
result, with SHA-256
`9718625edef806bddf00e3e4db12864fbf71da4af4ef27f9300cbc643793a0ef`.
It verifies:

- 668 bounded odd-prime indices through 5,000;
- 481 simple-divisor hits and 187 explicitly unresolved indices;
- 648,189 repeated-factor candidate tests, one depth-two hit, and no
  depth-three hit;
- all 42 exact simple-divisor certificates through prime index 191;
- the one large Pocklington primality certificate.

The computation is a finite theorem only.  Neither an unresolved bounded row
nor the absence of a depth-three hit is interpreted asymptotically.

This package certifies source-placeholder exclusion, direct kernel acceptance,
one-for-one theorem-level axiom reporting, the finite computation replay,
frozen inputs, and aggregate integration.  It does not claim that any of the
four modules proves or disproves the standard abc conjecture.
