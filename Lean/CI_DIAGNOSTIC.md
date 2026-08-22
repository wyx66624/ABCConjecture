# Lean diagnostic

Build return code: 1

```text
✖ [8788/8822] Building IUTThreeClosures.PrimePowerGeneratedThetaHull (7.5s)
error: IUTThreeClosures/PrimePowerGeneratedThetaHull.lean:341:12: Tactic `rewrite` failed: Did not find an occurrence of the pattern
Full error:
  Application type mismatch: The argument
error: Lean exited with code 1
error: build failed
```

## Tail

```text
  Function.update (fun x ↦ 0) c (x c) d = 0

AG : AnabelianGeometry
TG : TemperedGeometry AG
D : InitialThetaData AG TG
G : GeneratedRHSData D
A : GeneratedPrimePowerThetaHullData G
i : Fin G.container.proc.length
p : Nat.Primes
R' : Set (G.container.packet i (RationalPlace.finite p)).Total
hUnionR' : (G.outputs.unionRegion i).region (RationalPlace.finite p) ⊆ R'
a : (G.container.packet i (RationalPlace.finite p)).Total
ha :
  ∀ (c : (G.container.proc.capsule i).LabelType → { v // G.container.toRational v = RationalPlace.finite p }), a c ≠ 0
hRa : R' = (G.container.packet i (RationalPlace.finite p)).scaledIntegral a
x : (G.container.packet i (RationalPlace.finite p)).Total
hx : x ∈ PrimePowerQPilotRegion.packetPrimePowerRegion i p (A.minimumExponent i p)
c : (G.container.proc.capsule i).LabelType → { v // G.container.toRational v = RationalPlace.finite p }
o : G.outputs.Output
ho : A.exponent o i p c = A.minimumExponent i p c
z : (G.container.packet i (RationalPlace.finite p)).Total := Function.update (fun x ↦ 0) c (x c)
d : G.container.Components i (RationalPlace.finite p)
hdc : ¬d = c
hz0 :
  0 ∈
    PrimePowerQPilotRegion.primePowerImage p (A.exponent o i p d)
      ↑((G.container.packet i (RationalPlace.finite p)).integral d)
⊢ Function.update (fun x ↦ 0) c (x c) d = 0

Note: The target expression is not type-correct under the `instances` transparency level, which may have triggered the failure. This is usually caused by unfolding of semireducible definitions in prior tactic steps. Use `set_option linter.tacticCheckInstances true` to investigate the source of the issue.
Full error:
  Application type mismatch: The argument
    d
  has type
    G.container.Components i (RationalPlace.finite p)
  but is expected to have type
    (G.container.proc.capsule i).LabelType → { v // G.container.toRational v = RationalPlace.finite p }
  in the application
    (G.container.packet i (RationalPlace.finite p)).Summand d
error: Lean exited with code 1
⚠ [8790/8822] Built IUTThreeClosures.PublicIUTIVTheorem110 (10s)
warning: IUTThreeClosures/PublicIUTIVTheorem110.lean:199:31: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`
warning: IUTThreeClosures/PublicIUTIVTheorem110.lean:199:31: 'ring' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
✔ [8791/8822] Built IUTThreeClosures.ABCClosure (4.3s)
⚠ [8792/8822] Built IUTThreeClosures.PublicLogVolumeInconsistency (5.5s)
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8793/8822] Built IUTThreeClosures.ThreeClosureTheorems (3.9s)
✔ [8794/8822] Built IUTThreeClosures.InhabitationBoundary (3.0s)
✔ [8795/8822] Built IUTThreeClosures.CircularityAudit (4.0s)
✔ [8796/8822] Built IUTThreeClosures.NonCircularDownstream (4.9s)
✔ [8797/8822] Built IUTThreeClosures.FourOpenConstructions (4.1s)
⚠ [8798/8822] Built IUTThreeClosures.ABCPointLegendreCurve (4.6s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8799/8822] Built IUTThreeClosures.PublicProgramUninhabited (5.5s)
warning: IUTThreeClosures/PublicProgramUninhabited.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8800/8822] Built IUTThreeClosures.LegendreArithmetic (5.2s)
warning: IUTThreeClosures/LegendreArithmetic.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8801/8822] Built IUTThreeClosures.BridgeInhabitationAudit (6.3s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
⚠ [8802/8822] Built IUTThreeClosures.TripodWeilHeight (4.5s)
warning: IUTThreeClosures/TripodWeilHeight.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/TripodWeilHeight.lean:94:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8803/8822] Built IUTThreeClosures.ABCFreyCurve (6.2s)
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
✔ [8804/8822] Built IUTThreeClosures.BridgeInhabitationExact (5.8s)
⚠ [8805/8822] Built IUTThreeClosures.LegendreHeightCorridor (6.4s)
warning: IUTThreeClosures/LegendreHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8806/8822] Built IUTThreeClosures.ShiftedJAdmissibleCurve (7.3s)
warning: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8807/8822] Built IUTThreeClosures.CanonicalQPilotCorridor (6.2s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8808/8822] Built IUTThreeClosures.FreyDiscriminantConductor (6.7s)
warning: IUTThreeClosures/FreyDiscriminantConductor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8809/8822] Built IUTThreeClosures.FreyJReducedData (6.4s)
warning: IUTThreeClosures/FreyJReducedData.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8810/8822] Built IUTThreeClosures.CanonicalCorridorAudit (6.0s)
⚠ [8811/8822] Built IUTThreeClosures.SourceDerivedIUTIVBridge (6.0s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8812/8822] Built IUTThreeClosures.DifferentSupportAbsorption (6.9s)
warning: IUTThreeClosures/DifferentSupportAbsorption.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DifferentSupportAbsorption.lean:115:5: Variable name `hε` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
⚠ [8813/8822] Built IUTThreeClosures.FreyJHeightCorridor (5.4s)
warning: IUTThreeClosures/FreyJHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8814/8822] Built IUTThreeClosures.GlobalQPilotReconstruction (4.0s)
warning: IUTThreeClosures/GlobalQPilotReconstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8815/8822] Built IUTThreeClosures.CompleteGlobalJPacket (5.0s)
warning: IUTThreeClosures/CompleteGlobalJPacket.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8816/8822] Built IUTThreeClosures.FreyCalibratedIUTIVBridge (5.8s)
warning: IUTThreeClosures/FreyCalibratedIUTIVBridge.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/FreyCalibratedIUTIVBridge.lean:89:13: Variable name `hε` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
⚠ [8817/8822] Built IUTThreeClosures.SelectedBadPlaceGlobalReconstruction (6.1s)
warning: IUTThreeClosures/SelectedBadPlaceGlobalReconstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8818/8822] Built IUTThreeClosures.FreyConductorCalibratedIUTIVBridge (5.9s)
warning: IUTThreeClosures/FreyConductorCalibratedIUTIVBridge.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8819/8822] Built IUTThreeClosures.PublicFreyTheorem110Bridge (6.8s)
✔ [8820/8822] Built IUTThreeClosures.PublicFreyComponentBridge (7.1s)
Some required targets logged failures:
- IUTThreeClosures.PrimePowerGeneratedThetaHull
error: build failed
```
