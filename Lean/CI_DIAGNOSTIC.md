# Lean diagnostic

Build return code: 1

```text
✖ [8788/8822] Building IUTThreeClosures.PrimePowerGeneratedThetaHull (7.9s)
error: IUTThreeClosures/PrimePowerGeneratedThetaHull.lean:340:8: Type mismatch
error: Lean exited with code 1
error: build failed
```

## Tail

```text
warning: IUTThreeClosures/TateLocalQJContribution.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/TateLocalQJContribution.lean:56:6: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/TateLocalQJContribution.lean:108:39: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
✔ [8781/8822] Built IUTThreeClosures.ActualPilotWitness (4.2s)
⚠ [8782/8822] Built IUTThreeClosures.ExactRootNormalization (4.8s)
warning: IUTThreeClosures/ExactRootNormalization.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8783/8822] Built IUTThreeClosures.PublicThetaHullComponentFormula (5.2s)
✔ [8784/8822] Built IUTThreeClosures.GeneratedSource (4.4s)
✔ [8785/8822] Built IUTThreeClosures.PublicThetaHullUpperBound (3.0s)
✔ [8786/8822] Built IUTThreeClosures.QuantifierCorrectClosure (5.2s)
⚠ [8787/8822] Built IUTThreeClosures.HonestContainerSource (6.3s)
warning: IUTThreeClosures/HonestContainerSource.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✖ [8788/8822] Building IUTThreeClosures.PrimePowerGeneratedThetaHull (7.9s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/PrimePowerGeneratedThetaHull.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/PrimePowerGeneratedThetaHull.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/PrimePowerGeneratedThetaHull.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/PrimePowerGeneratedThetaHull.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/PrimePowerGeneratedThetaHull.setup.json --json
warning: IUTThreeClosures/PrimePowerGeneratedThetaHull.lean:101:12: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
error: IUTThreeClosures/PrimePowerGeneratedThetaHull.lean:340:8: Type mismatch
  Function.update_noteq hdc
has type
  Function.update (fun x ↦ 0) c ?m.227 d = 0
but is expected to have type
  z d = 0
error: Lean exited with code 1
✔ [8790/8822] Built IUTThreeClosures.ABCClosure (4.4s)
⚠ [8791/8822] Built IUTThreeClosures.PublicIUTIVTheorem110 (10s)
warning: IUTThreeClosures/PublicIUTIVTheorem110.lean:199:31: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`
warning: IUTThreeClosures/PublicIUTIVTheorem110.lean:199:31: 'ring' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
⚠ [8792/8822] Built IUTThreeClosures.PublicLogVolumeInconsistency (6.8s)
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8793/8822] Built IUTThreeClosures.ThreeClosureTheorems (3.5s)
✔ [8794/8822] Built IUTThreeClosures.InhabitationBoundary (3.5s)
✔ [8795/8822] Built IUTThreeClosures.CircularityAudit (3.4s)
✔ [8796/8822] Built IUTThreeClosures.NonCircularDownstream (4.5s)
✔ [8797/8822] Built IUTThreeClosures.FourOpenConstructions (3.7s)
⚠ [8798/8822] Built IUTThreeClosures.ABCPointLegendreCurve (4.1s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8799/8822] Built IUTThreeClosures.PublicProgramUninhabited (4.0s)
warning: IUTThreeClosures/PublicProgramUninhabited.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8800/8822] Built IUTThreeClosures.LegendreArithmetic (4.8s)
warning: IUTThreeClosures/LegendreArithmetic.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8801/8822] Built IUTThreeClosures.BridgeInhabitationAudit (5.9s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
⚠ [8802/8822] Built IUTThreeClosures.TripodWeilHeight (4.3s)
warning: IUTThreeClosures/TripodWeilHeight.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/TripodWeilHeight.lean:94:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8803/8822] Built IUTThreeClosures.ABCFreyCurve (5.7s)
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
✔ [8804/8822] Built IUTThreeClosures.BridgeInhabitationExact (5.4s)
⚠ [8805/8822] Built IUTThreeClosures.LegendreHeightCorridor (6.4s)
warning: IUTThreeClosures/LegendreHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8806/8822] Built IUTThreeClosures.ShiftedJAdmissibleCurve (7.4s)
warning: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8807/8822] Built IUTThreeClosures.FreyDiscriminantConductor (6.2s)
warning: IUTThreeClosures/FreyDiscriminantConductor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8808/8822] Built IUTThreeClosures.CanonicalQPilotCorridor (6.1s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8809/8822] Built IUTThreeClosures.FreyJReducedData (5.8s)
warning: IUTThreeClosures/FreyJReducedData.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8810/8822] Built IUTThreeClosures.CanonicalCorridorAudit (5.8s)
⚠ [8811/8822] Built IUTThreeClosures.DifferentSupportAbsorption (6.5s)
warning: IUTThreeClosures/DifferentSupportAbsorption.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DifferentSupportAbsorption.lean:115:5: Variable name `hε` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
⚠ [8812/8822] Built IUTThreeClosures.SourceDerivedIUTIVBridge (6.5s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8813/8822] Built IUTThreeClosures.FreyJHeightCorridor (5.3s)
warning: IUTThreeClosures/FreyJHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8814/8822] Built IUTThreeClosures.FreyCalibratedIUTIVBridge (3.9s)
warning: IUTThreeClosures/FreyCalibratedIUTIVBridge.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/FreyCalibratedIUTIVBridge.lean:89:13: Variable name `hε` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
⚠ [8815/8822] Built IUTThreeClosures.CompleteGlobalJPacket (5.1s)
warning: IUTThreeClosures/CompleteGlobalJPacket.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8816/8822] Built IUTThreeClosures.GlobalQPilotReconstruction (5.5s)
warning: IUTThreeClosures/GlobalQPilotReconstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8817/8822] Built IUTThreeClosures.FreyConductorCalibratedIUTIVBridge (5.2s)
warning: IUTThreeClosures/FreyConductorCalibratedIUTIVBridge.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8818/8822] Built IUTThreeClosures.PublicFreyTheorem110Bridge (6.0s)
⚠ [8819/8822] Built IUTThreeClosures.SelectedBadPlaceGlobalReconstruction (5.6s)
warning: IUTThreeClosures/SelectedBadPlaceGlobalReconstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8820/8822] Built IUTThreeClosures.PublicFreyComponentBridge (6.4s)
Some required targets logged failures:
- IUTThreeClosures.PrimePowerGeneratedThetaHull
error: build failed
```
