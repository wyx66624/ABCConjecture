# Lean CI result

- Tested commit: `8b4d918fafd4d1354da659e969faa61e5c21e072`
- Lean setup: `success`
- Dependency resolution/cache: `success`
- `lake build`: `failure`

## Error summary

```text
===== lean-dependencies.log =====
===== lean-build.log =====
104:✖ [8718/8770] Building IUTThreeClosures.SolvableRestrictionImage (8.5s)
111:error: IUTThreeClosures/SolvableRestrictionImage.lean:58:36: Unknown identifier `le_comap_map`
115:error: Lean exited with code 1
344:✖ [8751/8785] Building IUTThreeClosures.DistinguishedLabelQPilot (11s)
351:error: IUTThreeClosures/DistinguishedLabelQPilot.lean:38:8: failed to synthesize instance of type class
358:error: Lean exited with code 1
418:✖ [8783/8785] Building IUTThreeClosures.SourceDerivedIUTIVBridge (4.3s)
420:error: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:82:8: Type mismatch
426:error: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:84:8: Type mismatch
432:error: Lean exited with code 1
433:Some required targets logged failures:
437:error: build failed
```

## Dependency log tail

```text
info: toolchain not updated; already up-to-date
info: mathlib: running post-update hooks
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
Attempting to download 8639 file(s) from leanprover-community/mathlib4 cache at https://lakecache.blob.core.windows.net/mathlib4-master
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 16 KB/s], Decompressed: 0Downloaded: 103 file(s) [attempted 103/8639 = 1%, 1577 KB/s], Decompressed: 101Downloaded: 236 file(s) [attempted 236/8639 = 2%, 2302 KB/s], Decompressed: 229Downloaded: 377 file(s) [attempted 377/8639 = 4%, 321 KB/s], Decompressed: 369Downloaded: 516 file(s) [attempted 516/8639 = 5%, 2395 KB/s], Decompressed: 514Downloaded: 664 file(s) [attempted 664/8639 = 7%, 469 KB/s], Decompressed: 659Downloaded: 808 file(s) [attempted 808/8639 = 9%, 2131 KB/s], Decompressed: 799Downloaded: 957 file(s) [attempted 957/8639 = 11%, 290 KB/s], Decompressed: 950Downloaded: 1105 file(s) [attempted 1105/8639 = 12%, 1971 KB/s], Decompressed: 1100Downloaded: 1260 file(s) [attempted 1260/8639 = 14%, 1143 KB/s], Decompressed: 1251Downloaded: 1404 file(s) [attempted 1404/8639 = 16%, 4136 KB/s], Decompressed: 1398Downloaded: 1554 file(s) [attempted 1554/8639 = 17%, 516 KB/s], Decompressed: 1550Downloaded: 1713 file(s) [attempted 1713/8639 = 19%, 569 KB/s], Decompressed: 1703Downloaded: 1857 file(s) [attempted 1857/8639 = 21%, 521 KB/s], Decompressed: 1855Downloaded: 2009 file(s) [attempted 2009/8639 = 23%, 980 KB/s], Decompressed: 2005Downloaded: 2152 file(s) [attempted 2152/8639 = 24%, 1389 KB/s], Decompressed: 2147Downloaded: 2301 file(s) [attempted 2301/8639 = 26%, 673 KB/s], Decompressed: 2295Downloaded: 2455 file(s) [attempted 2455/8639 = 28%, 1144 KB/s], Decompressed: 2451Downloaded: 2601 file(s) [attempted 2601/8639 = 30%, 5819 KB/s], Decompressed: 2598Downloaded: 2759 file(s) [attempted 2759/8639 = 31%, 508 KB/s], Decompressed: 2752Downloaded: 2912 file(s) [attempted 2912/8639 = 33%, 2193 KB/s], Decompressed: 2907Downloaded: 3058 file(s) [attempted 3058/8639 = 35%, 1694 KB/s], Decompressed: 3046Downloaded: 3204 file(s) [attempted 3204/8639 = 37%, 493 KB/s], Decompressed: 3190Downloaded: 3353 file(s) [attempted 3353/8639 = 38%, 862 KB/s], Decompressed: 3333Downloaded: 3500 file(s) [attempted 3500/8639 = 40%, 277 KB/s], Decompressed: 3498Downloaded: 3650 file(s) [attempted 3650/8639 = 42%, 1126 KB/s], Decompressed: 3645Downloaded: 3797 file(s) [attempted 3797/8639 = 43%, 539 KB/s], Decompressed: 3792Downloaded: 3948 file(s) [attempted 3948/8639 = 45%, 241 KB/s], Decompressed: 3939Downloaded: 4098 file(s) [attempted 4098/8639 = 47%, 6266 KB/s], Decompressed: 4095Downloaded: 4249 file(s) [attempted 4249/8639 = 49%, 899 KB/s], Decompressed: 4246Downloaded: 4396 file(s) [attempted 4396/8639 = 50%, 1178 KB/s], Decompressed: 4386Downloaded: 4559 file(s) [attempted 4559/8639 = 52%, 519 KB/s], Decompressed: 4549Downloaded: 4707 file(s) [attempted 4707/8639 = 54%, 1203 KB/s], Decompressed: 4701Downloaded: 4857 file(s) [attempted 4857/8639 = 56%, 304 KB/s], Decompressed: 4848Downloaded: 5007 file(s) [attempted 5007/8639 = 57%, 1269 KB/s], Decompressed: 4992Downloaded: 5156 file(s) [attempted 5156/8639 = 59%, 1067 KB/s], Decompressed: 5148Downloaded: 5305 file(s) [attempted 5305/8639 = 61%, 2494 KB/s], Decompressed: 5303Downloaded: 5465 file(s) [attempted 5465/8639 = 63%, 728 KB/s], Decompressed: 5459Downloaded: 5621 file(s) [attempted 5621/8639 = 65%, 441 KB/s], Decompressed: 5605Downloaded: 5768 file(s) [attempted 5768/8639 = 66%, 119 KB/s], Decompressed: 5759Downloaded: 5920 file(s) [attempted 5920/8639 = 68%, 2869 KB/s], Decompressed: 5915Downloaded: 6074 file(s) [attempted 6074/8639 = 70%, 3481 KB/s], Decompressed: 6064Downloaded: 6224 file(s) [attempted 6224/8639 = 72%, 5025 KB/s], Decompressed: 6220Downloaded: 6373 file(s) [attempted 6373/8639 = 73%, 2270 KB/s], Decompressed: 6365Downloaded: 6506 file(s) [attempted 6506/8639 = 75%, 3341 KB/s], Decompressed: 6477Downloaded: 6619 file(s) [attempted 6619/8639 = 76%, 89 KB/s], Decompressed: 6610Downloaded: 6774 file(s) [attempted 6774/8639 = 78%, 1702 KB/s], Decompressed: 6766Downloaded: 6926 file(s) [attempted 6926/8639 = 80%, 415 KB/s], Decompressed: 6913Downloaded: 7069 file(s) [attempted 7069/8639 = 81%, 1625 KB/s], Decompressed: 7062Downloaded: 7226 file(s) [attempted 7226/8639 = 83%, 4739 KB/s], Decompressed: 7214Downloaded: 7378 file(s) [attempted 7378/8639 = 85%, 569 KB/s], Decompressed: 7372Downloaded: 7533 file(s) [attempted 7533/8639 = 87%, 1414 KB/s], Decompressed: 7528Downloaded: 7675 file(s) [attempted 7675/8639 = 88%, 1788 KB/s], Decompressed: 7671Downloaded: 7829 file(s) [attempted 7829/8639 = 90%, 1128 KB/s], Decompressed: 7824Downloaded: 7983 file(s) [attempted 7983/8639 = 92%, 1922 KB/s], Decompressed: 7978Downloaded: 8130 file(s) [attempted 8130/8639 = 94%, 483 KB/s], Decompressed: 8127Downloaded: 8279 file(s) [attempted 8279/8639 = 95%, 1944 KB/s], Decompressed: 8274Downloaded: 8433 file(s) [attempted 8433/8639 = 97%, 6004 KB/s], Decompressed: 8428Downloaded: 8594 file(s) [attempted 8594/8639 = 99%, 1978 KB/s], Decompressed: 8589Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 1978 KB/s], Decompressed: 8631
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (469ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.MaxTerm (3.4s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.UltrametricSum (3.4s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (3.0s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (8.8s)
✔ [8661/8673] Built TateCurvesTheta.AnalyticQuotient (8.0s)
✔ [8662/8675] Built Iut.Cor312.ThetaData.Places (6.4s)
✔ [8663/8675] Built TateCurvesTheta.QParameter.BaseChange (3.5s)
✔ [8664/8675] Built TateCurvesTheta.TateCurve.Weierstrass (3.6s)
✔ [8665/8675] Built TateCurvesTheta.Analysis.Strassmann (5.3s)
✔ [8666/8675] Built TateCurvesTheta.QParameter.PrimeToOrder (2.5s)
✔ [8667/8679] Built TateCurvesTheta.TateCurve.Discriminant (5.3s)
✔ [8668/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (6.0s)
✔ [8669/8679] Built TateCurvesTheta.QParameter.NormalizedOrder (4.8s)
✔ [8670/8684] Built TateCurvesTheta.TateCurve.SplitReduction (4.2s)
✔ [8671/8689] Built TateCurvesTheta.TateCurve.JInvariant (3.5s)
✔ [8672/8689] Built Iut.Cor312.ThetaData.GlobalField (14s)
✔ [8673/8689] Built TateCurvesTheta.TateCurve.Parametrization (4.5s)
✔ [8674/8692] Built TateCurvesTheta.Theta.Basic (3.8s)
✔ [8675/8692] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (4.3s)
✔ [8676/8693] Built TateCurvesTheta.TateCurve.CoordinateExpansion (4.8s)
✔ [8677/8696] Built TateCurvesTheta.Theta.Periodicity (4.8s)
✔ [8678/8696] Built TateCurvesTheta.QParameter.JParametrization (8.0s)
✔ [8679/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (5.3s)
✔ [8680/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (8.4s)
✔ [8681/8704] Built TateCurvesTheta.QParameter.Characterization (3.9s)
✔ [8682/8704] Built TateCurvesTheta.Theta.Product (6.3s)
✔ [8683/8705] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (8.3s)
✔ [8684/8705] Built TateCurvesTheta.Theta.Divisor (5.9s)
✔ [8685/8705] Built TateCurvesTheta.Theta.QBinomial (6.6s)
✔ [8686/8708] Built TateCurvesTheta.Theta.Uniqueness (7.0s)
✔ [8687/8708] Built TateCurvesTheta.TateCurve.EisensteinSeries (12s)
✔ [8688/8708] Built TateCurvesTheta.Theta.FactorSeries (6.2s)
✔ [8689/8708] Built TateCurvesTheta.TateCurve.CoordinateInversion (5.6s)
✔ [8690/8711] Built TateCurvesTheta.Theta.LaurentSphere (4.0s)
✔ [8691/8712] Built TateCurvesTheta.TateCurve.TatePointMem (3.1s)
✔ [8692/8713] Built TateCurvesTheta.Theta.LaurentSphereReduce (3.5s)
✔ [8693/8714] Built TateCurvesTheta.Theta.ThetaProdLaurent (5.1s)
✔ [8694/8715] Built TateCurvesTheta.TateCurve.Quotient (6.7s)
✔ [8695/8716] Built TateCurvesTheta.TateCurve.IntegralModel (5.1s)
✔ [8696/8717] Built TateCurvesTheta.Theta.LaurentUnitSphere (3.8s)
✔ [8697/8719] Built TateCurvesTheta.TateCurve.SphereBounds (6.0s)
✔ [8698/8720] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (5.5s)
✔ [8699/8720] Built TateCurvesTheta.Theta.FactorReciprocal (4.2s)
✔ [8700/8720] Built TateCurvesTheta.Theta.LaurentUnique (3.6s)
✔ [8701/8721] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (3.7s)
✔ [8702/8722] Built TateCurvesTheta.Theta.Normalization (3.8s)
✔ [8703/8722] Built TateCurvesTheta.TateCurve.PointMap (8.5s)
✔ [8704/8729] Built TateCurvesTheta.Theta.SeriesZero (3.2s)
✔ [8705/8729] Built TateCurvesTheta.Theta.RatioAnnulus (4.7s)
✔ [8706/8729] Built TateCurvesTheta.Theta.TripleProduct (4.6s)
✔ [8707/8729] Built TateCurvesTheta.Theta.Durfee (7.5s)
✔ [8708/8729] Built TateCurvesTheta.Theta.StrictDominant (10s)
✔ [8709/8729] Built TateCurvesTheta.Theta.Inversion (4.7s)
✔ [8710/8731] Built TateCurvesTheta.Uniformization (11s)
✔ [8711/8733] Built TateCurvesTheta.Theta.WeightSpace (15s)
✔ [8712/8735] Built Iut.Cor312.Procession (8.5s)
✔ [8713/8770] Built Iut.Cor312.RationalPlace (9.9s)
✔ [8714/8770] Built Iut.Cor312.PacketPresentation (9.8s)
✔ [8715/8770] Built IUTThreeClosures.ABCStatement (3.5s)
✔ [8716/8770] Built IUTThreeClosures.FullPolyCore (8.6s)
⚠ [8717/8770] Built IUTThreeClosures.Cor312CoefficientAlgebra (9.8s)
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
✖ [8718/8770] Building IUTThreeClosures.SolvableRestrictionImage (8.5s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/SolvableRestrictionImage.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/SolvableRestrictionImage.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/SolvableRestrictionImage.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/SolvableRestrictionImage.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/SolvableRestrictionImage.setup.json --json
warning: IUTThreeClosures/SolvableRestrictionImage.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/SolvableRestrictionImage.lean:58:36: Unknown identifier `le_comap_map`
warning: IUTThreeClosures/SolvableRestrictionImage.lean:118:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
error: Lean exited with code 1
⚠ [8719/8770] Built IUTThreeClosures.QPilotNormalizationAudit (8.5s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8720/8770] Built TateCurvesTheta.Theta.PuncturedProduct (48s)
⚠ [8721/8770] Built IUTThreeClosures.RootQPilotDivisor (7.2s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8722/8770] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (6.6s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8723/8770] Built IUTThreeClosures.RamificationCorrectedQPilot (6.0s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8724/8770] Built IUTThreeClosures.AdmissiblePrimeSelection (6.1s)
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:49:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8726/8770] Built IUTThreeClosures.ProductWeightMarginalization (7.5s)
warning: IUTThreeClosures/ProductWeightMarginalization.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ProductWeightMarginalization.lean:36:0: `sum_product_weights_eq_one` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
warning: IUTThreeClosures/ProductWeightMarginalization.lean:45:0: `product_weight_marginal` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
⚠ [8727/8770] Built IUTThreeClosures.FiniteExceptionalSet (6.2s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8728/8770] Built Iut.Cor312.Container (5.9s)
✔ [8730/8785] Built Iut.Cor312.HolomorphicHull (6.0s)
✔ [8731/8785] Built IUTThreeClosures.WeakCompatibilityCountermodel (5.8s)
⚠ [8732/8785] Built IUTThreeClosures.QPilotNormalizationFork (5.7s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8733/8785] Built IUTThreeClosures.GeneratedUnionCompactness (5.9s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8734/8785] Built Genl.Mathlib.Order.BoundedDiscrepancy (2.4s)
✔ [8735/8785] Built Iut.Cor312.LogVolume (6.6s)
✔ [8736/8785] Built Iut.Cor312.ContainerHull (6.4s)
⚠ [8737/8785] Built IUTThreeClosures.TateParameterUnitBallRegion (2.9s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8738/8785] Built IUTThreeClosures.FiniteExponentHull (5.7s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8739/8785] Built IUTThreeClosures.BarycentricPacketReading (5.8s)
warning: IUTThreeClosures/BarycentricPacketReading.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/BarycentricPacketReading.lean:21:0: `product_weight_barycentric` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
warning: IUTThreeClosures/BarycentricPacketReading.lean:57:0: `product_weight_barycentric_of_sum_one` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
warning: IUTThreeClosures/BarycentricPacketReading.lean:70:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8740/8785] Built IUTThreeClosures.StandardZeroLabel (6.2s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8741/8785] Built TateCurvesTheta.TateCurve.DefectVanishing (99s)
⚠ [8742/8785] Built IUTThreeClosures.DiagonalPacketNoGo (5.7s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8743/8785] Built IUTThreeClosures.PublicNormalizationObstruction (6.8s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8744/8785] Built Genl.GeneralPosition.HeightTheory (1.9s)
⚠ [8745/8785] Built IUTThreeClosures.IUTIVAbsorption (9.4s)
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
✔ [8746/8785] Built Iut4Sec1.Global.ArithmeticDivisor (6.2s)
⚠ [8747/8785] Built IUTThreeClosures.PrimePowerQPilotRegion (7.2s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8748/8785] Built IUTThreeClosures.ZeroLabelBarycentric (7.3s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
✔ [8749/8785] Built TateCurvesTheta.TateCurve.TatePointOnCurve (6.3s)
⚠ [8750/8785] Built IUTThreeClosures.StatementIIOutsideFinite (6.6s)
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
✖ [8751/8785] Building IUTThreeClosures.DistinguishedLabelQPilot (11s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/DistinguishedLabelQPilot.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/DistinguishedLabelQPilot.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/DistinguishedLabelQPilot.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/DistinguishedLabelQPilot.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/DistinguishedLabelQPilot.setup.json --json
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/DistinguishedLabelQPilot.lean:38:8: failed to synthesize instance of type class
  DecidableEq (D.proc.capsule i).LabelType

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:44:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
error: Lean exited with code 1
✔ [8752/8785] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (9.5s)
✔ [8753/8785] Built TateCurvesTheta.TateCurve.AdditionLaw (11s)
✔ [8754/8785] Built TateCurvesTheta.TateCurve.LargePointParametrization (14s)
✔ [8755/8785] Built TateCurvesTheta.TateCurve.AbelStep (5.6s)
✔ [8756/8785] Built TateCurvesTheta.TateCurve.GroupLaw (10s)
✔ [8757/8785] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (22s)
✔ [8758/8785] Built TateCurvesTheta.TateCurve.SurjectivitySphere (27s)
✔ [8759/8785] Built TateCurvesTheta.TateCurve.TateUniformization (4.2s)
✔ [8760/8785] Built TateCurvesTheta (3.4s)
✔ [8761/8785] Built Iut.Cor312.ThetaData.AdmissiblePrime (4.6s)
✔ [8762/8785] Built Iut.Cor312.ThetaData.Orbicurve (4.5s)
✔ [8763/8785] Built Iut.Cor312.ThetaData.LocalConditions (7.6s)
✔ [8764/8785] Built Iut.Cor312.ThetaData.Basic (4.4s)
✔ [8765/8785] Built Iut.Cor312.LeftHandSide (3.0s)
✔ [8766/8785] Built Iut.Cor312.RightHandSide (4.2s)
⚠ [8767/8785] Built IUTThreeClosures.NativeQPilotCalibration (4.2s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8768/8785] Built Iut.Cor312.Statement (5.1s)
⚠ [8769/8785] Built IUTThreeClosures.CorrectedQPilotDivisor (5.5s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8770/8785] Built IUTThreeClosures.ActualPilotWitness (4.0s)
✔ [8771/8785] Built IUTThreeClosures.GeneratedSource (4.4s)
✔ [8772/8785] Built IUTThreeClosures.QuantifierCorrectClosure (3.8s)
✔ [8773/8785] Built IUTThreeClosures.ABCClosure (3.8s)
✔ [8774/8785] Built IUTThreeClosures.ThreeClosureTheorems (3.8s)
✔ [8775/8785] Built IUTThreeClosures.InhabitationBoundary (3.9s)
✔ [8776/8785] Built IUTThreeClosures.CircularityAudit (3.0s)
✔ [8777/8785] Built IUTThreeClosures.NonCircularDownstream (5.0s)
✔ [8778/8785] Built IUTThreeClosures.FourOpenConstructions (3.8s)
⚠ [8779/8785] Built IUTThreeClosures.BridgeInhabitationAudit (4.2s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
✔ [8780/8785] Built IUTThreeClosures.BridgeInhabitationExact (3.8s)
⚠ [8781/8785] Built IUTThreeClosures.CanonicalQPilotCorridor (3.9s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8782/8785] Built IUTThreeClosures.CanonicalCorridorAudit (3.9s)
✖ [8783/8785] Building IUTThreeClosures.SourceDerivedIUTIVBridge (4.3s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/SourceDerivedIUTIVBridge.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/SourceDerivedIUTIVBridge.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/SourceDerivedIUTIVBridge.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/SourceDerivedIUTIVBridge.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/SourceDerivedIUTIVBridge.setup.json --json
error: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:82:8: Type mismatch
  add_le_add_right hq B.heightError
has type
  B.heightError + B.corridor.qLog P / 6 ≤ B.heightError + B.corridor.mainTerm P
but is expected to have type
  B.corridor.qLog P / 6 + B.heightError ≤ B.corridor.mainTerm P + B.heightError
error: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:84:8: Type mismatch
  add_le_add_right hm B.heightError
has type
  B.heightError + B.corridor.mainTerm P ≤ B.heightError + ((1 + ε) * P.conductor + C)
but is expected to have type
  B.corridor.mainTerm P + B.heightError ≤ (1 + ε) * P.conductor + C + B.heightError
error: Lean exited with code 1
Some required targets logged failures:
- IUTThreeClosures.SolvableRestrictionImage
- IUTThreeClosures.DistinguishedLabelQPilot
- IUTThreeClosures.SourceDerivedIUTIVBridge
error: build failed
```
