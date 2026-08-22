# Lean diagnostic

Build return code: 1

```text
✖ [8792/8822] Building IUTThreeClosures.PrimePowerGeneratedThetaHull (17s)
error: IUTThreeClosures/PrimePowerGeneratedThetaHull.lean:311:8: Type mismatch
error: Lean exited with code 1
error: build failed
```

## Tail

```text
warning: IUTThreeClosures/ExactRootNormalization.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8784/8822] Built IUTThreeClosures.PublicThetaHullUpperBound (4.1s)
✔ [8785/8822] Built IUTThreeClosures.GeneratedSource (4.3s)
⚠ [8786/8822] Built IUTThreeClosures.HonestContainerSource (6.6s)
warning: IUTThreeClosures/HonestContainerSource.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8787/8822] Built IUTThreeClosures.QuantifierCorrectClosure (7.1s)
⚠ [8788/8822] Built IUTThreeClosures.PublicIUTIVTheorem110 (11s)
warning: IUTThreeClosures/PublicIUTIVTheorem110.lean:199:31: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`
warning: IUTThreeClosures/PublicIUTIVTheorem110.lean:199:31: 'ring' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
✔ [8789/8822] Built IUTThreeClosures.ABCClosure (5.2s)
⚠ [8790/8822] Built IUTThreeClosures.PublicLogVolumeInconsistency (5.4s)
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8791/8822] Built IUTThreeClosures.ThreeClosureTheorems (3.6s)
✖ [8792/8822] Building IUTThreeClosures.PrimePowerGeneratedThetaHull (17s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/PrimePowerGeneratedThetaHull.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/PrimePowerGeneratedThetaHull.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/PrimePowerGeneratedThetaHull.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/PrimePowerGeneratedThetaHull.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/PrimePowerGeneratedThetaHull.setup.json --json
warning: IUTThreeClosures/PrimePowerGeneratedThetaHull.lean:81:12: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
error: IUTThreeClosures/PrimePowerGeneratedThetaHull.lean:311:8: Type mismatch
  Pi.single_eq_of_ne hdc (x c)
has type
  @Pi.single (G.container.Components i (RationalPlace.finite p)) (G.container.packet i (RationalPlace.finite p)).Summand
      (fun i_1 ↦ instMulZeroClassOfSemiring.toZero)
      (fun a b ↦
        @Fintype.decidablePiFintype (G.container.proc.capsule i).LabelType
          (fun a ↦ G.container.Fiber (RationalPlace.finite p)) (fun a a_1 b ↦ Classical.propDecidable (a_1 = b))
          (G.container.proc.capsule i).instFintypeLabelType a b)
      c (x c) d =
    0
but is expected to have type
  @Pi.single ((G.container.proc.capsule i).LabelType → { v // G.container.toRational v = RationalPlace.finite p })
      (G.container.packet i (RationalPlace.finite p)).Summand (fun i_1 ↦ instMulZeroClassOfSemiring.toZero)
      (fun a b ↦
        @Fintype.decidablePiFintype (G.container.proc.capsule i).LabelType
          (fun a ↦ { v // G.container.toRational v = RationalPlace.finite p }) (fun a a_1 b ↦ a_1.instDecidableEq b)
          (G.container.proc.capsule i).instFintypeLabelType a b)
      c (x c) d =
    0
error: Lean exited with code 1
✔ [8794/8822] Built IUTThreeClosures.InhabitationBoundary (3.9s)
✔ [8795/8822] Built IUTThreeClosures.CircularityAudit (4.1s)
✔ [8796/8822] Built IUTThreeClosures.NonCircularDownstream (4.7s)
✔ [8797/8822] Built IUTThreeClosures.FourOpenConstructions (3.8s)
⚠ [8798/8822] Built IUTThreeClosures.ABCPointLegendreCurve (4.3s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8799/8822] Built IUTThreeClosures.PublicProgramUninhabited (5.2s)
warning: IUTThreeClosures/PublicProgramUninhabited.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8800/8822] Built IUTThreeClosures.LegendreArithmetic (4.9s)
warning: IUTThreeClosures/LegendreArithmetic.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8801/8822] Built IUTThreeClosures.BridgeInhabitationAudit (6.1s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
✔ [8802/8822] Built IUTThreeClosures.BridgeInhabitationExact (3.9s)
⚠ [8803/8822] Built IUTThreeClosures.TripodWeilHeight (5.4s)
warning: IUTThreeClosures/TripodWeilHeight.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/TripodWeilHeight.lean:94:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8804/8822] Built IUTThreeClosures.ABCFreyCurve (6.0s)
warning: IUTThreeClosures/ABCFreyCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCFreyCurve.lean:45:48: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`
warning: IUTThreeClosures/ABCFreyCurve.lean:45:48: 'ring' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/ABCFreyCurve.lean:49:44: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
warning: IUTThreeClosures/ABCFreyCurve.lean:57:44: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
warning: IUTThreeClosures/ABCFreyCurve.lean:78:47: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`
warning: IUTThreeClosures/ABCFreyCurve.lean:78:47: 'ring' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/ABCFreyCurve.lean:82:43: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
warning: IUTThreeClosures/ABCFreyCurve.lean:90:43: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
⚠ [8805/8822] Built IUTThreeClosures.CanonicalQPilotCorridor (6.0s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8806/8822] Built IUTThreeClosures.LegendreHeightCorridor (6.1s)
warning: IUTThreeClosures/LegendreHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8807/8822] Built IUTThreeClosures.ShiftedJAdmissibleCurve (7.3s)
warning: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8808/8822] Built IUTThreeClosures.FreyDiscriminantConductor (6.0s)
warning: IUTThreeClosures/FreyDiscriminantConductor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8809/8822] Built IUTThreeClosures.CanonicalCorridorAudit (5.6s)
⚠ [8810/8822] Built IUTThreeClosures.SourceDerivedIUTIVBridge (7.1s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8811/8822] Built IUTThreeClosures.FreyJReducedData (5.0s)
warning: IUTThreeClosures/FreyJReducedData.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8812/8822] Built IUTThreeClosures.DifferentSupportAbsorption (5.0s)
warning: IUTThreeClosures/DifferentSupportAbsorption.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DifferentSupportAbsorption.lean:115:5: Variable name `hε` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
⚠ [8813/8822] Built IUTThreeClosures.FreyJHeightCorridor (4.4s)
warning: IUTThreeClosures/FreyJHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8814/8822] Built IUTThreeClosures.CompleteGlobalJPacket (3.0s)
warning: IUTThreeClosures/CompleteGlobalJPacket.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8815/8822] Built IUTThreeClosures.FreyCalibratedIUTIVBridge (5.8s)
warning: IUTThreeClosures/FreyCalibratedIUTIVBridge.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/FreyCalibratedIUTIVBridge.lean:89:13: Variable name `hε` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
⚠ [8816/8822] Built IUTThreeClosures.GlobalQPilotReconstruction (5.9s)
warning: IUTThreeClosures/GlobalQPilotReconstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8817/8822] Built IUTThreeClosures.PublicFreyTheorem110Bridge (6.7s)
✔ [8818/8822] Built IUTThreeClosures.PublicFreyComponentBridge (7.2s)
⚠ [8819/8822] Built IUTThreeClosures.FreyConductorCalibratedIUTIVBridge (5.8s)
warning: IUTThreeClosures/FreyConductorCalibratedIUTIVBridge.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8820/8822] Built IUTThreeClosures.SelectedBadPlaceGlobalReconstruction (5.9s)
warning: IUTThreeClosures/SelectedBadPlaceGlobalReconstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
Some required targets logged failures:
- IUTThreeClosures.PrimePowerGeneratedThetaHull
error: build failed
```
