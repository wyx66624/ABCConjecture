# Verification record

Research checkpoint: 2026-09-07 product-tripod rigidity.

- Ordinary proof: `../README.md`.
- Independent mathematical review: the separate `adversarial_audit` agent
  read PR, PR2, and the mixed-map ledger and found no logical gap. It requested
  the characteristic-p boundary example and the explicit localization
  retraction, both now included. This is independent agent review, not journal
  peer review or a formal verification of the geometry.
- Formal scope: exactly ten public integer theorems in
  `../Lean/ProductTripodRectangle.lean`, including global matrix separation.
- Toolchain: Lean 4.32.0, WSL Ubuntu-24.04, `import Std` only.
- Final compilation exited zero; the ten explicit axiom queries contain only
  `propext`, `Classical.choice`, and `Quot.sound`.
- Final Lean source SHA256:
  `09846b89e181ac5125f9aae64d61eeb75258981fff5449fc21a20e8a45e87d96`.
- No `sorry`, `admit`, custom axiom, or target-equivalent hypothesis is present.

From the repository root, the actual successful PowerShell replay command was:

```powershell
wsl -d Ubuntu-24.04 -- bash -lc '/root/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /mnt/e/agent/ABCConjecture/research/checkpoints/2026_09_07_independent_route/Lean/ProductTripodRectangle.lean -o /mnt/e/agent/ABCConjecture/tmp/abc_20260907/olean/ProductTripodRectangle.olean'
```

The temporary output directory must already exist. The `.olean` is a local
build artifact, not a source dependency. `lean.log` is the final output.

The first development compile found an unassisted integer zero-product split
and two missing order facts. The final source supplies `Int.mul_eq_zero`,
`Int.sq_nonneg`, and `Int.mul_pos` explicitly; the successful replay is for
the repaired source, and no failed development compile is claimed as verified.

The geometry theorem, the UFD localization facts, Mason specialization and
the radical/gcd ledger are complete ordinary arguments. They are not silently
promoted to the ten Lean theorem statements.
