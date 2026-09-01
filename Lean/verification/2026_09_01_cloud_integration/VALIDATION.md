# Cloud branch integration validation — 2026-09-01

## Scope

Integration branch: `codex/integrate-latest-20260901`.

Remote baseline at integration time:

- `origin/main`: `0044247afc81a3bf813382b839e3a25d708488c5`
- `origin/formalize/canonical-exponent-height-ledger-v29`:
  `6efb8b2d7f16562df2a1d58c93e15125a0b17188`
- `origin/formalize/cross-support-exponent-depth-v29`:
  `9db5143b254793922e3f3dc025ae5524ac0afcb4`
- `origin/formalize/shared-support-affine-contact-v29`:
  `046c6463cdcad9255aa7a1e4fd78fdf14bc6c852`
- `origin/formalize/cross-endpoint-contact-depth-v29b`:
  `a8b4c9d592c8d569b36bbeb1f101be9aee9373e6`
- `origin/formalize/coprime-residue-product-core-v27`:
  `72cd25d80bb1ff1c1e700f3e53e854c778be48ea`

The local research snapshot was committed first as `eff21f8`.  Remote main and
the selected feature lines were then integrated by merge commits `ac09c7a`,
`ca00a42`, `be23158`, `68668d4`, `b3d27ab`, and `9f6bf56`.

The selection preserves every unique, source-bearing Lean theorem and research
report found on the recent continuation lines.  Branch-specific target and
success-marker workflows were omitted because they encode temporary CI state,
not mathematical content.  Diagnostic-only branches and older branches whose
content is already present in a later continuation were left unchanged on the
remote for auditability.

Useful local artifacts were retained, including Lean modules, research notes,
source material, reproducible computation inputs and outputs, papers, PDFs, and
verification records.  Scratch probes, rebuildable executable binaries, and
byte-identical duplicate PDFs remain local but are ignored.

## Compatibility and integration repairs

The cloud branches compiled independently against their own import graphs, but
the unified current tree exposed several incompatibilities.  The integration
repairs are:

1. close anonymous `noncomputable section` scopes before closing their named
   namespaces in `NatExponentProfileBridge` and
   `CanonicalCubeEndpointNormalForm`;
2. lift the radical finite product from `Nat` to `Real` through an explicit
   cast equality;
3. correct the signs in the scaled and quadratic shared-support contact
   identities;
4. make the cubeful-tail sandwich use explicit associative equalities and the
   nonnegativity premise required for its reverse implication;
5. reuse the established `ABCPoint.endpointMin`, `ABCPoint.largeEndpoint`, and
   coprimality API instead of redeclaring the same names in
   `CanonicalPowerfulResidualCore`;
6. retain the earlier merge repairs to canonical contact depth, cross-support
   exponent depth, cube signed defect, positive right-contact closure, and the
   arithmetic-derivative barrier;
7. import the integrated v26--v29 arithmetic modules from the library root so
   cross-route name and dependency conflicts are checked together.

## Verification

Environment:

- Lean `4.32.0`, commit `8c9756b28d64dab099da31a4c09229a9e6a2ef35`
- Lake `5.0.0-src+8c9756b`
- Windows x86-64 toolchain

The final command

```text
cd Lean
lake build
```

completed with exit code 0:

```text
Build completed successfully (9189 jobs).
```

Direct `lake env lean` checks also passed for the repaired ordered-hull and
closed-ray bridge, contact,
exponent-profile, cube-normal-form, and cubeful-tail modules.  Their printed
axiom dependencies contain only subsets of `propext`, `Classical.choice`, and
`Quot.sound`; no `sorryAx` appears.  Repository checks found no merge-conflict
markers in the integrated sources and no `sorry` or `admit` proof placeholders
in the repaired modules.  Existing style and unused-argument linter warnings do
not affect kernel checking.

## Mathematical boundary

This integration proves and preserves structural reductions.  It does not
prove or disprove the general abc conjecture.  In particular, it does not add
the uniform high-exponent tail estimate required by the arithmetic route, and
it does not assert that the global Step (xi-f) hull is a source-defined
approximant of the same input pilot or that the published IUT machinery supplies
the quantitative closed-ray approximation isolated by the new scalar bridge.
