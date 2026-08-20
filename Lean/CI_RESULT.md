# Lean CI result

- Tested commit: `74e98488377e12508d0a14b7a0cbded38ef23a93`
- Toolchain/dependency setup: `success`
- `lake build`: `failure`

## Error summary

```text
63:✖ [8718/8768] Building IUTThreeClosures.FullPolyCore (9.6s)
65:error: IUTThreeClosures/FullPolyCore.lean:52:4: don't know how to synthesize implicit argument `C₁`
79:error: IUTThreeClosures/FullPolyCore.lean:52:4: don't know how to synthesize implicit argument `C₀`
93:error: IUTThreeClosures/FullPolyCore.lean:87:2: Type mismatch: After simplification, term
99:error: Lean exited with code 1
148:✖ [8721/8768] Building IUTThreeClosures.QPilotNormalizationAudit (9.6s)
155:error: IUTThreeClosures/QPilotNormalizationAudit.lean:60:2: No goals to be solved
156:error: IUTThreeClosures/QPilotNormalizationAudit.lean:67:2: No goals to be solved
157:error: IUTThreeClosures/QPilotNormalizationAudit.lean:72:2: failed to prove positivity/nonnegativity/nonzeroness
158:error: IUTThreeClosures/QPilotNormalizationAudit.lean:113:5: unsolved goals
160:error: IUTThreeClosures/QPilotNormalizationAudit.lean:120:7: unexpected token ':'; expected 'add_aesop_rules', 'binder_predicate', 'builtin_cbv_simproc', 'builtin_dsimproc', 'builtin_simproc', 'cbv_simproc', 'def_eval_config_item', 'dsimproc', 'elab', 'elab_rules', 'grind_pattern', 'infix', 'infixl', 'infixr', 'instance', 'macro', 'macro_rules', 'notation', 'notation3', 'postfix', 'prefix', 'simproc', 'syntax' or 'unif_hint'
161:error: IUTThreeClosures/QPilotNormalizationAudit.lean:125:40: Invalid argument name `V` for function `GlobalQPilotNormalizationDatum`
162:error: IUTThreeClosures/QPilotNormalizationAudit.lean:129:40: Invalid argument name `V` for function `GlobalQPilotNormalizationDatum`
163:error: IUTThreeClosures/QPilotNormalizationAudit.lean:133:40: Invalid argument name `V` for function `GlobalQPilotNormalizationDatum`
164:error: IUTThreeClosures/QPilotNormalizationAudit.lean:137:40: Invalid argument name `V` for function `GlobalQPilotNormalizationDatum`
165:error: Lean exited with code 1
179:✖ [8725/8768] Building IUTThreeClosures.AdmissiblePrimeSelection (5.4s)
186:error: IUTThreeClosures/AdmissiblePrimeSelection.lean:14:11: unexpected token 'in'; expected ','
187:error: IUTThreeClosures/AdmissiblePrimeSelection.lean:30:23: unexpected token 'in'; expected ','
188:error: Lean exited with code 1
189:✖ [8727/8768] Building IUTThreeClosures.ProductWeightMarginalization (7.2s)
208:error: IUTThreeClosures/ProductWeightMarginalization.lean:58:44: unsolved goals
228:error: Lean exited with code 1
244:✖ [8736/8780] Building IUTThreeClosures.TateParameterUnitBallRegion (2.8s)
258:error: IUTThreeClosures/TateParameterUnitBallRegion.lean:52:8: Invalid rewrite argument: Expected an equality or iff proof or definition name, but `u` is a value of type
260:error: IUTThreeClosures/TateParameterUnitBallRegion.lean:69:4: Type mismatch
266:error: Lean exited with code 1
279:✖ [8740/8781] Building IUTThreeClosures.DiagonalPacketNoGo (6.6s)
291:error: IUTThreeClosures/DiagonalPacketNoGo.lean:19:2: Tactic `simp` failed with a nested error:
295:error: Lean exited with code 1
296:✖ [8742/8781] Building IUTThreeClosures.PublicNormalizationObstruction (5.3s)
303:error: IUTThreeClosures/PublicNormalizationObstruction.lean:32:9: Tactic `unfold` failed to unfold `documentedLocalDegreeContribution` in
305:error: Lean exited with code 1
307:✖ [8745/8785] Building IUTThreeClosures.PrimePowerQPilotRegion (6.2s)
314:error: IUTThreeClosures/PrimePowerQPilotRegion.lean:30:23: Invalid field `ne_zero`: The environment does not contain `Subtype.ne_zero`, so it is not possible to project the field `ne_zero` from an expression
317:error: IUTThreeClosures/PrimePowerQPilotRegion.lean:65:31: Invalid field `componentVol_primeImage`: The environment does not contain `Iut.LogVolumeData.componentVol_primeImage`, so it is not possible to project the field `componentVol_primeImage` from an expression
320:error: IUTThreeClosures/PrimePowerQPilotRegion.lean:74:9: failed to synthesize instance of type class
324:error: IUTThreeClosures/PrimePowerQPilotRegion.lean:74:29: Application type mismatch: The argument
333:error: IUTThreeClosures/PrimePowerQPilotRegion.lean:85:4: failed to synthesize instance of type class
337:error: IUTThreeClosures/PrimePowerQPilotRegion.lean:85:32: Application type mismatch: The argument
366:error: Lean exited with code 1
420:✖ [8749/8785] Building IUTThreeClosures.StatementIIOutsideFinite (5.5s)
442:error: IUTThreeClosures/StatementIIOutsideFinite.lean:46:24: unsolved goals
469:error: Lean exited with code 1
487:✖ [8767/8785] Running IUTThreeClosures.CorrectedQPilotDivisor
488:error: IUTThreeClosures/CorrectedQPilotDivisor.lean: could not disambiguate the module `Iut4Sec1.Global.ArithmeticDivisor`; multiple packages provide distinct definitions:
507:✖ [8779/8785] Building IUTThreeClosures.FourOpenConstructions (3.7s)
509:error: IUTThreeClosures/FourOpenConstructions.lean:33:88: unexpected token '/--'; expected 'lemma'
510:error: IUTThreeClosures/FourOpenConstructions.lean:34:65: unexpected identifier; expected 'lemma'
511:error: IUTThreeClosures/FourOpenConstructions.lean:66:4: Invalid field `downstream`: The environment does not contain `IUTThreeClosures.FourStageProgram.downstream`, so it is not possible to project the field `downstream` from an expression
514:error: Lean exited with code 1
515:Some required targets logged failures:
527:error: build failed
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (384ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.MaxTerm (3.3s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.UltrametricSum (3.6s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (2.0s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (9.2s)
✔ [8661/8667] Built TateCurvesTheta.Analysis.Strassmann (5.7s)
✔ [8662/8671] Built Iut.Cor312.ThetaData.Places (7.6s)
✔ [8663/8673] Built TateCurvesTheta.QParameter.BaseChange (2.9s)
✔ [8664/8675] Built TateCurvesTheta.AnalyticQuotient (9.6s)
✔ [8665/8680] Built TateCurvesTheta.Analysis.StrassmannSphere (5.6s)
✔ [8666/8689] Built TateCurvesTheta.TateCurve.Weierstrass (3.9s)
✔ [8667/8689] Built TateCurvesTheta.QParameter.PrimeToOrder (3.4s)
✔ [8668/8689] Built TateCurvesTheta.Theta.Basic (3.4s)
✔ [8669/8691] Built TateCurvesTheta.TateCurve.Parametrization (4.8s)
✔ [8670/8692] Built TateCurvesTheta.TateCurve.Discriminant (4.9s)
✔ [8671/8692] Built TateCurvesTheta.QParameter.NormalizedOrder (4.1s)
✔ [8672/8692] Built TateCurvesTheta.Theta.Periodicity (3.1s)
✔ [8673/8692] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (3.2s)
✔ [8674/8693] Built Iut.Cor312.ThetaData.GlobalField (13s)
✔ [8675/8696] Built TateCurvesTheta.TateCurve.CoordinateExpansion (3.9s)
✔ [8676/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (5.1s)
✔ [8677/8696] Built TateCurvesTheta.TateCurve.JInvariant (3.9s)
✔ [8678/8696] Built TateCurvesTheta.TateCurve.SplitReduction (5.1s)
✔ [8679/8696] Built TateCurvesTheta.Theta.Product (4.4s)
✔ [8680/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (10s)
✔ [8681/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (11s)
✔ [8682/8696] Built TateCurvesTheta.QParameter.JParametrization (13s)
✔ [8683/8696] Built TateCurvesTheta.TateCurve.EisensteinSeries (15s)
✔ [8684/8702] Built TateCurvesTheta.Theta.Divisor (6.0s)
✔ [8685/8705] Built TateCurvesTheta.Theta.Uniqueness (5.0s)
✔ [8686/8705] Built TateCurvesTheta.QParameter.Characterization (2.7s)
✔ [8687/8705] Built TateCurvesTheta.Theta.FactorSeries (5.3s)
✔ [8688/8705] Built TateCurvesTheta.Theta.QBinomial (4.8s)
✔ [8689/8708] Built TateCurvesTheta.Theta.LaurentSphere (4.7s)
✔ [8690/8708] Built TateCurvesTheta.TateCurve.TatePointMem (3.0s)
✔ [8691/8712] Built TateCurvesTheta.TateCurve.CoordinateInversion (3.7s)
✔ [8692/8713] Built TateCurvesTheta.Theta.LaurentSphereReduce (3.7s)
✔ [8693/8714] Built TateCurvesTheta.Theta.ThetaProdLaurent (4.9s)
✔ [8694/8715] Built TateCurvesTheta.Theta.LaurentUnitSphere (3.5s)
✔ [8695/8717] Built TateCurvesTheta.TateCurve.Quotient (8.2s)
✔ [8696/8717] Built TateCurvesTheta.TateCurve.IntegralModel (6.1s)
✔ [8697/8719] Built TateCurvesTheta.TateCurve.SphereBounds (6.8s)
✔ [8698/8720] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (5.1s)
✔ [8699/8720] Built TateCurvesTheta.Theta.FactorReciprocal (3.9s)
✔ [8700/8720] Built TateCurvesTheta.Theta.LaurentUnique (3.3s)
✔ [8701/8721] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (3.0s)
✔ [8702/8722] Built TateCurvesTheta.TateCurve.PointMap (8.1s)
✔ [8703/8722] Built TateCurvesTheta.Theta.Normalization (4.1s)
✔ [8704/8729] Built TateCurvesTheta.Theta.SeriesZero (4.4s)
✔ [8705/8729] Built TateCurvesTheta.Theta.RatioAnnulus (6.3s)
✔ [8706/8729] Built TateCurvesTheta.Theta.TripleProduct (5.0s)
✔ [8707/8730] Built TateCurvesTheta.Theta.StrictDominant (9.8s)
✔ [8708/8733] Built TateCurvesTheta.Theta.Durfee (5.3s)
✔ [8709/8735] Built TateCurvesTheta.Uniformization (7.4s)
✔ [8710/8735] Built Iut.Cor312.Procession (6.3s)
✔ [8711/8735] Built Iut.Cor312.RationalPlace (6.5s)
✔ [8712/8735] Built TateCurvesTheta.Theta.Inversion (3.0s)
✔ [8713/8750] Built Iut.Cor312.PacketPresentation (11s)
✔ [8714/8768] Built TateCurvesTheta.Theta.WeightSpace (16s)
✔ [8715/8768] Built Iut.Cor312.Container (9.2s)
✔ [8716/8768] Built Iut.Cor312.HolomorphicHull (9.3s)
✔ [8717/8768] Built IUTThreeClosures.ABCStatement (4.0s)
✖ [8718/8768] Building IUTThreeClosures.FullPolyCore (9.6s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut4Sec1/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/FullPolyCore.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/FullPolyCore.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/FullPolyCore.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/FullPolyCore.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/FullPolyCore.setup.json --json
error: IUTThreeClosures/FullPolyCore.lean:52:4: don't know how to synthesize implicit argument `C₁`
  @GeneratedChoice (?m.3 k₀ theta extraOutput) (?m.4 k₀ theta extraOutput) Extra
context:
A₀ : Type u₀
A₁ : Type u₁
C₀ : Type u₂
C₁ : Type u₃
Extra : Type u₄
k₀ : A₀ ≃ C₀
theta : A₀
extraOutput : Extra → C₁
⊢ Type ?u.16

Note: Because this declaration's type has been explicitly provided, all parameter types and holes (e.g., `_`) in its header are resolved before its body is processed; information from the declaration body cannot be used to infer what these values should be
error: IUTThreeClosures/FullPolyCore.lean:52:4: don't know how to synthesize implicit argument `C₀`
  @GeneratedChoice (?m.3 k₀ theta extraOutput) (?m.4 k₀ theta extraOutput) Extra
context:
A₀ : Type u₀
A₁ : Type u₁
C₀ : Type u₂
C₁ : Type u₃
Extra : Type u₄
k₀ : A₀ ≃ C₀
theta : A₀
extraOutput : Extra → C₁
⊢ Type ?u.17

Note: Because this declaration's type has been explicitly provided, all parameter types and holes (e.g., `_`) in its header are resolved before its body is processed; information from the declaration body cannot be used to infer what these values should be
error: IUTThreeClosures/FullPolyCore.lean:87:2: Type mismatch: After simplification, term
  hx
 has type
  x ∈ U
but is expected to have type
  y ∈ U
error: Lean exited with code 1
⚠ [8719/8768] Built IUTThreeClosures.Cor312CoefficientAlgebra (8.4s)
warning: IUTThreeClosures/Cor312CoefficientAlgebra.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/Cor312CoefficientAlgebra.lean:3:0: The module doc-string for a file should be the first command after the imports.
Please, add a module doc-string before `namespace IUTThreeClosures`.

Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/Cor312CoefficientAlgebra.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/Cor312CoefficientAlgebra.lean:3:0: The module doc-string for a file should be the first command after the imports.
Please, add a module doc-string before `/-- The scalar last step of IUT IV Theorem 1.10. -/
theorem q_bound_of_coefficient_expression {factor A q CTheta : ℝ} (hfactor : 0 < factor) (hCTheta : -1 ≤ CTheta)
    (hformula : CTheta = factor * (A - q / 6) - 1) : q / 6 ≤ A :=
  by
  rw [hformula] at hCTheta
  nlinarith`.

Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/Cor312CoefficientAlgebra.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/Cor312CoefficientAlgebra.lean:3:0: The module doc-string for a file should be the first command after the imports.
Please, add a module doc-string before `end IUTThreeClosures`.

Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/Cor312CoefficientAlgebra.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/Cor312CoefficientAlgebra.lean:3:0: The module doc-string for a file should be the first command after the imports.
Please, add a module doc-string before ``.

Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8720/8768] Built IUTThreeClosures.RootQPilotDivisor (7.8s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✖ [8721/8768] Building IUTThreeClosures.QPilotNormalizationAudit (9.6s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut4Sec1/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/QPilotNormalizationAudit.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/QPilotNormalizationAudit.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/QPilotNormalizationAudit.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/QPilotNormalizationAudit.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/QPilotNormalizationAudit.setup.json --json
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/QPilotNormalizationAudit.lean:60:2: No goals to be solved
error: IUTThreeClosures/QPilotNormalizationAudit.lean:67:2: No goals to be solved
error: IUTThreeClosures/QPilotNormalizationAudit.lean:72:2: failed to prove positivity/nonnegativity/nonzeroness
error: IUTThreeClosures/QPilotNormalizationAudit.lean:113:5: unsolved goals
⊢ 1 < ramifiedQuadraticExample.ramification
error: IUTThreeClosures/QPilotNormalizationAudit.lean:120:7: unexpected token ':'; expected 'add_aesop_rules', 'binder_predicate', 'builtin_cbv_simproc', 'builtin_dsimproc', 'builtin_simproc', 'cbv_simproc', 'def_eval_config_item', 'dsimproc', 'elab', 'elab_rules', 'grind_pattern', 'infix', 'infixl', 'infixr', 'instance', 'macro', 'macro_rules', 'notation', 'notation3', 'postfix', 'prefix', 'simproc', 'syntax' or 'unif_hint'
error: IUTThreeClosures/QPilotNormalizationAudit.lean:125:40: Invalid argument name `V` for function `GlobalQPilotNormalizationDatum`
error: IUTThreeClosures/QPilotNormalizationAudit.lean:129:40: Invalid argument name `V` for function `GlobalQPilotNormalizationDatum`
error: IUTThreeClosures/QPilotNormalizationAudit.lean:133:40: Invalid argument name `V` for function `GlobalQPilotNormalizationDatum`
error: IUTThreeClosures/QPilotNormalizationAudit.lean:137:40: Invalid argument name `V` for function `GlobalQPilotNormalizationDatum`
error: Lean exited with code 1
✔ [8722/8768] Built TateCurvesTheta.Theta.PuncturedProduct (49s)
⚠ [8723/8768] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (7.2s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8724/8768] Built IUTThreeClosures.RamificationCorrectedQPilot (7.1s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✖ [8725/8768] Building IUTThreeClosures.AdmissiblePrimeSelection (5.4s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut4Sec1/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/AdmissiblePrimeSelection.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/AdmissiblePrimeSelection.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/AdmissiblePrimeSelection.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/AdmissiblePrimeSelection.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/AdmissiblePrimeSelection.setup.json --json
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/AdmissiblePrimeSelection.lean:14:11: unexpected token 'in'; expected ','
error: IUTThreeClosures/AdmissiblePrimeSelection.lean:30:23: unexpected token 'in'; expected ','
error: Lean exited with code 1
✖ [8727/8768] Building IUTThreeClosures.ProductWeightMarginalization (7.2s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut4Sec1/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/ProductWeightMarginalization.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/ProductWeightMarginalization.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/ProductWeightMarginalization.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/ProductWeightMarginalization.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/ProductWeightMarginalization.setup.json --json
warning: IUTThreeClosures/ProductWeightMarginalization.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ProductWeightMarginalization.lean:36:0: `sum_product_weights_eq_one` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
info: IUTThreeClosures/ProductWeightMarginalization.lean:62:4: Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
error: IUTThreeClosures/ProductWeightMarginalization.lean:58:44: unsolved goals
L : Type u
V : Type v
inst✝³ : Fintype L
inst✝² : DecidableEq L
inst✝¹ : Fintype V
inst✝ : DecidableEq V
j₀ : L
w f : V → ℝ
hw : ∑ v, w v = 1
E : (L → V) ≃ V × ({ j // j ≠ j₀ } → V) := splitAtEquiv j₀
hrest : ∑ g, ∏ j, w (g j) = 1
x : V × ({ j // j ≠ j₀ } → V)
⊢ (w x.1 * ∏ x_1, w (if ↑x_1 = j₀ then x.1 else x.2 x_1)) * f x.1 = w x.1 * f x.1 * ∏ x_1, w (x.2 x_1)
warning: IUTThreeClosures/ProductWeightMarginalization.lean:45:0: `product_weight_marginal` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
error: Lean exited with code 1
⚠ [8730/8768] Built IUTThreeClosures.FiniteExceptionalSet (6.4s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8731/8780] Built IUTThreeClosures.GeneratedUnionCompactness (5.8s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8733/8780] Built Iut.Cor312.ContainerHull (5.9s)
✔ [8734/8780] Built Iut.Cor312.LogVolume (6.9s)
✔ [8735/8780] Built Genl.Mathlib.Order.BoundedDiscrepancy (2.8s)
✖ [8736/8780] Building IUTThreeClosures.TateParameterUnitBallRegion (2.8s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut4Sec1/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/TateParameterUnitBallRegion.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/TateParameterUnitBallRegion.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/TateParameterUnitBallRegion.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/TateParameterUnitBallRegion.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/TateParameterUnitBallRegion.setup.json --json
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:44:17: This simp argument is unused:
  mul_assoc

Hint: Omit it from the simp argument list.
  simp [hu0,̵ ̵m̵u̵l̵_̵a̵s̵s̵o̵c̵]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
error: IUTThreeClosures/TateParameterUnitBallRegion.lean:52:8: Invalid rewrite argument: Expected an equality or iff proof or definition name, but `u` is a value of type
  K
error: IUTThreeClosures/TateParameterUnitBallRegion.lean:69:4: Type mismatch
  norm_q_eq_pow_orderNat t hπ
has type
  ‖↑t.q‖ = ‖π‖ ^ (t.toOrdered hπ).orderNat
but is expected to have type
  ‖↑t.q‖ = ‖π ^ (t.toOrdered hπ).orderNat‖
error: Lean exited with code 1
⚠ [8737/8780] Built IUTThreeClosures.StandardZeroLabel (5.9s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8738/8780] Built IUTThreeClosures.FiniteExponentHull (6.3s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✖ [8740/8781] Building IUTThreeClosures.DiagonalPacketNoGo (6.6s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut4Sec1/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/DiagonalPacketNoGo.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/DiagonalPacketNoGo.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/DiagonalPacketNoGo.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/DiagonalPacketNoGo.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/DiagonalPacketNoGo.setup.json --json
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:19:8: Possibly looping simp theorem: `Fintype.card_eq_sum_ones`

Note: Possibly caused by: `Finset.sum_const` and `Finset.card_univ`

Hint: You can disable a simp theorem from the default simp set by passing `- theoremName` to `simp`.
error: IUTThreeClosures/DiagonalPacketNoGo.lean:19:2: Tactic `simp` failed with a nested error:
maximum recursion depth has been reached
use `set_option maxRecDepth <num>` to increase limit
use `set_option diagnostics true` to get diagnostic information
error: Lean exited with code 1
✖ [8742/8781] Building IUTThreeClosures.PublicNormalizationObstruction (5.3s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut4Sec1/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/PublicNormalizationObstruction.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/PublicNormalizationObstruction.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/PublicNormalizationObstruction.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/PublicNormalizationObstruction.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/PublicNormalizationObstruction.setup.json --json
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/PublicNormalizationObstruction.lean:32:9: Tactic `unfold` failed to unfold `documentedLocalDegreeContribution` in
  e = 1
error: Lean exited with code 1
✔ [8744/8785] Built Genl.GeneralPosition.HeightTheory (1.0s)
✖ [8745/8785] Building IUTThreeClosures.PrimePowerQPilotRegion (6.2s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut4Sec1/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/PrimePowerQPilotRegion.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/PrimePowerQPilotRegion.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/PrimePowerQPilotRegion.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/PrimePowerQPilotRegion.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/PrimePowerQPilotRegion.setup.json --json
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/PrimePowerQPilotRegion.lean:30:23: Invalid field `ne_zero`: The environment does not contain `Subtype.ne_zero`, so it is not possible to project the field `ne_zero` from an expression
  p
of type `{ p // Nat.Prime p }`
error: IUTThreeClosures/PrimePowerQPilotRegion.lean:65:31: Invalid field `componentVol_primeImage`: The environment does not contain `Iut.LogVolumeData.componentVol_primeImage`, so it is not possible to project the field `componentVol_primeImage` from an expression
  vol
of type `LogVolumeData D`
error: IUTThreeClosures/PrimePowerQPilotRegion.lean:74:9: failed to synthesize instance of type class
  Field (D.Components i (RationalPlace.finite p))

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
error: IUTThreeClosures/PrimePowerQPilotRegion.lean:74:29: Application type mismatch: The argument
  (D.packet i (RationalPlace.finite p)).integral
has type
  (c : (D.proc.capsule i).LabelType → { v // D.toRational v = RationalPlace.finite p }) →
    Subring ((D.packet i (RationalPlace.finite p)).Summand c)
of sort `Type (max v u₁ u₂)` but is expected to have type
  Set (D.Components i (RationalPlace.finite p))
of sort `Type (max u₁ u₂)` in the application
  primePowerImage p n (D.packet i (RationalPlace.finite p)).integral
error: IUTThreeClosures/PrimePowerQPilotRegion.lean:85:4: failed to synthesize instance of type class
  Field ((D.proc.capsule i).LabelType → { v // D.toRational v = RationalPlace.finite p })

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
error: IUTThreeClosures/PrimePowerQPilotRegion.lean:85:32: Application type mismatch: The argument
  (D.packet i (RationalPlace.finite p)).integral
has type
  (c : (D.proc.capsule i).LabelType → { v // D.toRational v = RationalPlace.finite p }) →
    Subring ((D.packet i (RationalPlace.finite p)).Summand c)
of sort `Type (max v u₁ u₂)` but is expected to have type
  Set ((D.proc.capsule i).LabelType → { v // D.toRational v = RationalPlace.finite p })
of sort `Type (max u₁ u₂)` in the application
  primePowerImage p (order c) (D.packet i (RationalPlace.finite p)).integral
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:93:6: declaration uses `sorry`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:87:8: declaration uses `sorry`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:94:2: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:95:2: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:96:2: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:94:2: 'apply Finset.sum_congr rfl' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:95:2: 'intro c hc' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:96:2: 'rw [vol.componentVol_primePowerIntegral]' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
error: Lean exited with code 1
⚠ [8747/8785] Built IUTThreeClosures.IUTIVAbsorption (9.1s)
warning: IUTThreeClosures/IUTIVAbsorption.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/IUTIVAbsorption.lean:3:0: The module doc-string for a file should be the first command after the imports.
Please, add a module doc-string before `namespace IUTThreeClosures`.

Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/IUTIVAbsorption.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/IUTIVAbsorption.lean:3:0: The module doc-string for a file should be the first command after the imports.
Please, add a module doc-string before `/-- Elementary epsilon absorption in the general-position calculation. -/
theorem proposition21_absorption {ε q6 diff cond C : ℝ} (hε : 0 < ε) (hε1 : ε ≤ 1) (hdiff : 0 ≤ diff) (hcond : 0 ≤ cond)
    (hC : 0 ≤ C) (hmain : q6 ≤ (1 + 2 * ε / 5) * (diff + cond) + (ε / 5) * (q6 + diff) + C) :
    q6 ≤ (1 + ε) * (diff + cond) + 2 * C :=
  by
  have hden : 0 < 1 - ε / 5 := by nlinarith
  have hfirst : (1 - ε / 5) * q6 ≤ (1 + 3 * ε / 5) * (diff + cond) + C := by nlinarith
  have hcoef : 1 + 3 * ε / 5 ≤ (1 - ε / 5) * (1 + ε) := by nlinarith [mul_nonneg hε.le (sub_nonneg.mpr hε1)]
  have hconst : C ≤ (1 - ε / 5) * (2 * C) := by nlinarith
  have htarget : (1 + 3 * ε / 5) * (diff + cond) + C ≤ (1 - ε / 5) * ((1 + ε) * (diff + cond) + 2 * C) :=
    by
    have hs : 0 ≤ diff + cond := add_nonneg hdiff hcond
    calc
      (1 + 3 * ε / 5) * (diff + cond) + C ≤ ((1 - ε / 5) * (1 + ε)) * (diff + cond) + (1 - ε / 5) * (2 * C) := by gcongr
      _ = (1 - ε / 5) * ((1 + ε) * (diff + cond) + 2 * C) := by ring
  nlinarith`.

Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/IUTIVAbsorption.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/IUTIVAbsorption.lean:3:0: The module doc-string for a file should be the first command after the imports.
Please, add a module doc-string before `end IUTThreeClosures`.

Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/IUTIVAbsorption.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/IUTIVAbsorption.lean:3:0: The module doc-string for a file should be the first command after the imports.
Please, add a module doc-string before ``.

Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8748/8785] Built TateCurvesTheta.TateCurve.DefectVanishing (104s)
✖ [8749/8785] Building IUTThreeClosures.StatementIIOutsideFinite (5.5s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut4Sec1/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/StatementIIOutsideFinite.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/StatementIIOutsideFinite.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/StatementIIOutsideFinite.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/StatementIIOutsideFinite.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/StatementIIOutsideFinite.setup.json --json
warning: IUTThreeClosures/StatementIIOutsideFinite.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/StatementIIOutsideFinite.lean:18:19: Variable name `d` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
warning: IUTThreeClosures/StatementIIOutsideFinite.lean:18:27: Variable name `ε` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
warning: IUTThreeClosures/StatementIIOutsideFinite.lean:18:35: Variable name `K` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
error: IUTThreeClosures/StatementIIOutsideFinite.lean:46:24: unsolved goals
T : Genl.HeightTheory
D : StatementIIOutsideFinite T
d : ℕ
ε : ℝ
hε : 0 < ε
K : T.CBS
B : ℝ
hB :
  ∀ P ∈ T.cbsSet K ∩ T.ptLE T.tripod d,
    P ∉ D.exceptional d ε K → T.htCan T.tripod P ≤ (1 + ε) * (T.logDiff T.tripod P + T.logCond T.tripod P) + B
S : Set (T.Pt T.tripod) := T.cbsSet K ∩ T.ptLE T.tripod d
rhs : T.Pt T.tripod → ℝ := (1 + ε) • (T.logDiff T.tripod + T.logCond T.tripod)
E : Finset (T.Pt T.tripod) := {P ∈ D.exceptional d ε K | P ∈ S}
Cin : ℝ
hCin : ∀ x ∈ E, T.htCan T.tripod x - rhs x ≤ Cin
P : T.Pt T.tripod
hP : P ∈ T.cbsSet K ∩ T.ptLE T.tripod d
hExc : P ∈ D.exceptional d ε K
⊢ P ∈ T.cbsSet K ∧ P ∈ T.ptLE T.tripod d
warning: IUTThreeClosures/StatementIIOutsideFinite.lean:47:24: This simp argument is unused:
  hP

Hint: Omit it from the simp argument list.
  simp [E, hExc, S,̵ ̵h̵P̵]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
error: Lean exited with code 1
✔ [8750/8785] Built Iut4Sec1.Global.ArithmeticDivisor (7.0s)
✔ [8751/8785] Built Iut4Sec1.Global.ArithmeticDivisor (5.9s)
✔ [8752/8785] Built TateCurvesTheta.TateCurve.TatePointOnCurve (4.7s)
✔ [8753/8785] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (8.3s)
✔ [8754/8785] Built TateCurvesTheta.TateCurve.AdditionLaw (9.4s)
✔ [8755/8785] Built TateCurvesTheta.TateCurve.LargePointParametrization (13s)
✔ [8756/8785] Built TateCurvesTheta.TateCurve.AbelStep (6.4s)
✔ [8757/8785] Built TateCurvesTheta.TateCurve.GroupLaw (10s)
✔ [8758/8785] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (24s)
✔ [8759/8785] Built TateCurvesTheta.TateCurve.SurjectivitySphere (25s)
✔ [8760/8785] Built TateCurvesTheta.TateCurve.TateUniformization (4.2s)
✔ [8761/8785] Built TateCurvesTheta (3.5s)
✔ [8762/8785] Built Iut.Cor312.ThetaData.AdmissiblePrime (4.6s)
✔ [8763/8785] Built Iut.Cor312.ThetaData.Orbicurve (4.5s)
✔ [8764/8785] Built Iut.Cor312.ThetaData.LocalConditions (7.6s)
✔ [8765/8785] Built Iut.Cor312.ThetaData.Basic (4.5s)
✔ [8766/8785] Built Iut.Cor312.LeftHandSide (4.0s)
✖ [8767/8785] Running IUTThreeClosures.CorrectedQPilotDivisor
error: IUTThreeClosures/CorrectedQPilotDivisor.lean: could not disambiguate the module `Iut4Sec1.Global.ArithmeticDivisor`; multiple packages provide distinct definitions:
  iut4Sec1@0.1.0 (hash: de632136b4400dd6)
  iut@0.1.0 (hash: 8229d57b9632bb55)
✔ [8768/8785] Built Iut.Cor312.RightHandSide (4.2s)
✔ [8769/8785] Built Iut.Cor312.Statement (3.9s)
⚠ [8770/8785] Built IUTThreeClosures.NativeQPilotCalibration (4.3s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8771/8785] Built IUTThreeClosures.ActualPilotWitness (3.9s)
✔ [8772/8785] Built IUTThreeClosures.GeneratedSource (4.4s)
✔ [8773/8785] Built IUTThreeClosures.QuantifierCorrectClosure (3.9s)
✔ [8774/8785] Built IUTThreeClosures.ABCClosure (3.9s)
✔ [8775/8785] Built IUTThreeClosures.ThreeClosureTheorems (3.9s)
✔ [8776/8785] Built IUTThreeClosures.InhabitationBoundary (4.1s)
✔ [8777/8785] Built IUTThreeClosures.CircularityAudit (4.2s)
✔ [8778/8785] Built IUTThreeClosures.NonCircularDownstream (5.2s)
✖ [8779/8785] Building IUTThreeClosures.FourOpenConstructions (3.7s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut4Sec1/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/FourOpenConstructions.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/FourOpenConstructions.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/FourOpenConstructions.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/FourOpenConstructions.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/FourOpenConstructions.setup.json --json
error: IUTThreeClosures/FourOpenConstructions.lean:33:88: unexpected token '/--'; expected 'lemma'
error: IUTThreeClosures/FourOpenConstructions.lean:34:65: unexpected identifier; expected 'lemma'
error: IUTThreeClosures/FourOpenConstructions.lean:66:4: Invalid field `downstream`: The environment does not contain `IUTThreeClosures.FourStageProgram.downstream`, so it is not possible to project the field `downstream` from an expression
  P
of type `FourStageProgram`
error: Lean exited with code 1
Some required targets logged failures:
- IUTThreeClosures.FullPolyCore
- IUTThreeClosures.QPilotNormalizationAudit
- IUTThreeClosures.AdmissiblePrimeSelection
- IUTThreeClosures.ProductWeightMarginalization
- IUTThreeClosures.TateParameterUnitBallRegion
- IUTThreeClosures.DiagonalPacketNoGo
- IUTThreeClosures.PublicNormalizationObstruction
- IUTThreeClosures.PrimePowerQPilotRegion
- IUTThreeClosures.StatementIIOutsideFinite
- IUTThreeClosures.CorrectedQPilotDivisor
- IUTThreeClosures.FourOpenConstructions
error: build failed
```
