# Lean CI result

- Tested commit: `743b1214757469be1683a64fba8a7f1a27794e18`
- Lean setup: `success`
- Dependency resolution/cache: `success`
- `lake build`: `failure`

## Error summary

```text
===== lean-dependencies.log =====
===== lean-build.log =====
134:✖ [8725/8769] Building IUTThreeClosures.AdmissiblePrimeSelection (5.7s)
141:error: IUTThreeClosures/AdmissiblePrimeSelection.lean:22:8: omega could not prove the goal:
151:error: IUTThreeClosures/AdmissiblePrimeSelection.lean:24:8: omega could not prove the goal:
167:error: Lean exited with code 1
323:✖ [8747/8784] Building IUTThreeClosures.DistinguishedLabelQPilot (6.2s)
330:error: IUTThreeClosures/DistinguishedLabelQPilot.lean:34:10: Invalid field `packetVol_packetPrimePowerRegion`: The environment does not contain `Iut.LogVolumeData.packetVol_packetPrimePowerRegion`, so it is not possible to project the field `packetVol_packetPrimePowerRegion` from an expression
333:error: IUTThreeClosures/DistinguishedLabelQPilot.lean:33:44: unsolved goals
344:error: Lean exited with code 1
433:✖ [8780/8784] Building IUTThreeClosures.CanonicalQPilotCorridor (3.6s)
435:error: IUTThreeClosures/CanonicalQPilotCorridor.lean:89:2: linarith failed to find a contradiction
450:error: Lean exited with code 1
451:Some required targets logged failures:
455:error: build failed
```

## Dependency log tail

```text
info: toolchain not updated; already up-to-date
info: mathlib: running post-update hooks
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
Attempting to download 8639 file(s) from leanprover-community/mathlib4 cache at https://lakecache.blob.core.windows.net/mathlib4-master
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 15 KB/s], Decompressed: 0Downloaded: 110 file(s) [attempted 110/8639 = 1%, 948 KB/s], Decompressed: 106Downloaded: 245 file(s) [attempted 245/8639 = 2%, 962 KB/s], Decompressed: 241Downloaded: 389 file(s) [attempted 389/8639 = 4%, 862 KB/s], Decompressed: 383Downloaded: 544 file(s) [attempted 544/8639 = 6%, 1242 KB/s], Decompressed: 533Downloaded: 698 file(s) [attempted 698/8639 = 8%, 357 KB/s], Decompressed: 691Downloaded: 845 file(s) [attempted 845/8639 = 9%, 2324 KB/s], Decompressed: 838Downloaded: 1002 file(s) [attempted 1002/8639 = 11%, 2009 KB/s], Decompressed: 999Downloaded: 1166 file(s) [attempted 1166/8639 = 13%, 4490 KB/s], Decompressed: 1156Downloaded: 1321 file(s) [attempted 1321/8639 = 15%, 87 KB/s], Decompressed: 1316Downloaded: 1481 file(s) [attempted 1481/8639 = 17%, 945 KB/s], Decompressed: 1470Downloaded: 1638 file(s) [attempted 1638/8639 = 18%, 2559 KB/s], Decompressed: 1636Downloaded: 1799 file(s) [attempted 1799/8639 = 20%, 275 KB/s], Decompressed: 1787Downloaded: 1955 file(s) [attempted 1955/8639 = 22%, 1546 KB/s], Decompressed: 1950Downloaded: 2106 file(s) [attempted 2106/8639 = 24%, 108 KB/s], Decompressed: 2102Downloaded: 2270 file(s) [attempted 2270/8639 = 26%, 113 KB/s], Decompressed: 2264Downloaded: 2428 file(s) [attempted 2428/8639 = 28%, 1186 KB/s], Decompressed: 2421Downloaded: 2587 file(s) [attempted 2587/8639 = 29%, 5646 KB/s], Decompressed: 2582Downloaded: 2748 file(s) [attempted 2748/8639 = 31%, 590 KB/s], Decompressed: 2743Downloaded: 2907 file(s) [attempted 2907/8639 = 33%, 2357 KB/s], Decompressed: 2901Downloaded: 3060 file(s) [attempted 3060/8639 = 35%, 1440 KB/s], Decompressed: 3059Downloaded: 3216 file(s) [attempted 3216/8639 = 37%, 3234 KB/s], Decompressed: 3209Downloaded: 3378 file(s) [attempted 3378/8639 = 39%, 3447 KB/s], Decompressed: 3373Downloaded: 3538 file(s) [attempted 3538/8639 = 40%, 743 KB/s], Decompressed: 3533Downloaded: 3694 file(s) [attempted 3694/8639 = 42%, 2781 KB/s], Decompressed: 3692Downloaded: 3857 file(s) [attempted 3857/8639 = 44%, 1157 KB/s], Decompressed: 3852Downloaded: 4018 file(s) [attempted 4018/8639 = 46%, 2142 KB/s], Decompressed: 4006Downloaded: 4169 file(s) [attempted 4169/8639 = 48%, 963 KB/s], Decompressed: 4167Downloaded: 4331 file(s) [attempted 4331/8639 = 50%, 885 KB/s], Decompressed: 4323Downloaded: 4495 file(s) [attempted 4495/8639 = 52%, 2218 KB/s], Decompressed: 4489Downloaded: 4655 file(s) [attempted 4655/8639 = 53%, 6204 KB/s], Decompressed: 4647Downloaded: 4816 file(s) [attempted 4816/8639 = 55%, 511 KB/s], Decompressed: 4810Downloaded: 4978 file(s) [attempted 4978/8639 = 57%, 1036 KB/s], Decompressed: 4974Downloaded: 5147 file(s) [attempted 5147/8639 = 59%, 1344 KB/s], Decompressed: 5141Downloaded: 5302 file(s) [attempted 5302/8639 = 61%, 545 KB/s], Decompressed: 5298Downloaded: 5465 file(s) [attempted 5465/8639 = 63%, 2465 KB/s], Decompressed: 5461Downloaded: 5626 file(s) [attempted 5626/8639 = 65%, 4697 KB/s], Decompressed: 5624Downloaded: 5789 file(s) [attempted 5789/8639 = 67%, 1115 KB/s], Decompressed: 5787Downloaded: 5947 file(s) [attempted 5947/8639 = 68%, 375 KB/s], Decompressed: 5943Downloaded: 6106 file(s) [attempted 6106/8639 = 70%, 623 KB/s], Decompressed: 6104Downloaded: 6260 file(s) [attempted 6260/8639 = 72%, 504 KB/s], Decompressed: 6253Downloaded: 6423 file(s) [attempted 6423/8639 = 74%, 857 KB/s], Decompressed: 6416Downloaded: 6579 file(s) [attempted 6579/8639 = 76%, 5407 KB/s], Decompressed: 6572Downloaded: 6731 file(s) [attempted 6731/8639 = 77%, 1295 KB/s], Decompressed: 6729Downloaded: 6892 file(s) [attempted 6892/8639 = 79%, 5405 KB/s], Decompressed: 6885Downloaded: 7057 file(s) [attempted 7057/8639 = 81%, 1885 KB/s], Decompressed: 7056Downloaded: 7216 file(s) [attempted 7216/8639 = 83%, 5597 KB/s], Decompressed: 7211Downloaded: 7377 file(s) [attempted 7377/8639 = 85%, 214 KB/s], Decompressed: 7372Downloaded: 7530 file(s) [attempted 7530/8639 = 87%, 220 KB/s], Decompressed: 7519Downloaded: 7691 file(s) [attempted 7691/8639 = 89%, 2508 KB/s], Decompressed: 7689Downloaded: 7854 file(s) [attempted 7854/8639 = 90%, 2075 KB/s], Decompressed: 7850Downloaded: 8015 file(s) [attempted 8015/8639 = 92%, 902 KB/s], Decompressed: 8011Downloaded: 8174 file(s) [attempted 8174/8639 = 94%, 1193 KB/s], Decompressed: 8170Downloaded: 8335 file(s) [attempted 8335/8639 = 96%, 6112 KB/s], Decompressed: 8330Downloaded: 8495 file(s) [attempted 8495/8639 = 98%, 198 KB/s], Decompressed: 8489Downloaded: 8638 file(s) [attempted 8638/8639 = 99%, 307 KB/s], Decompressed: 8635Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 307 KB/s], Decompressed: 8635
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (476ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.MaxTerm (2.7s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.UltrametricSum (3.4s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (3.7s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (8.7s)
✔ [8661/8673] Built TateCurvesTheta.AnalyticQuotient (8.0s)
✔ [8662/8675] Built Iut.Cor312.ThetaData.Places (6.9s)
✔ [8663/8675] Built TateCurvesTheta.Analysis.Strassmann (4.9s)
✔ [8664/8675] Built TateCurvesTheta.QParameter.BaseChange (3.4s)
✔ [8665/8675] Built TateCurvesTheta.TateCurve.Weierstrass (3.7s)
✔ [8666/8675] Built TateCurvesTheta.QParameter.PrimeToOrder (2.7s)
✔ [8667/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (5.6s)
✔ [8668/8680] Built TateCurvesTheta.TateCurve.Discriminant (5.4s)
✔ [8669/8680] Built TateCurvesTheta.QParameter.NormalizedOrder (4.5s)
✔ [8670/8680] Built TateCurvesTheta.TateCurve.Parametrization (4.6s)
✔ [8671/8680] Built TateCurvesTheta.TateCurve.JInvariant (3.6s)
✔ [8672/8684] Built TateCurvesTheta.TateCurve.SplitReduction (4.7s)
✔ [8673/8684] Built Iut.Cor312.ThetaData.GlobalField (13s)
✔ [8674/8692] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (3.2s)
✔ [8675/8696] Built TateCurvesTheta.TateCurve.CoordinateExpansion (4.1s)
✔ [8676/8696] Built TateCurvesTheta.Theta.Basic (3.5s)
✔ [8677/8696] Built TateCurvesTheta.QParameter.JParametrization (9.1s)
✔ [8678/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (6.9s)
✔ [8679/8696] Built TateCurvesTheta.QParameter.Characterization (3.5s)
✔ [8680/8704] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (8.0s)
✔ [8681/8704] Built TateCurvesTheta.Theta.Periodicity (4.3s)
✔ [8682/8705] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (9.0s)
✔ [8683/8708] Built TateCurvesTheta.Theta.QBinomial (5.6s)
✔ [8684/8711] Built TateCurvesTheta.Theta.Product (5.5s)
✔ [8685/8711] Built TateCurvesTheta.TateCurve.CoordinateInversion (5.2s)
✔ [8686/8711] Built TateCurvesTheta.Theta.Divisor (5.6s)
✔ [8687/8712] Built TateCurvesTheta.Theta.Uniqueness (5.6s)
✔ [8688/8713] Built TateCurvesTheta.TateCurve.EisensteinSeries (12s)
✔ [8689/8713] Built TateCurvesTheta.TateCurve.Quotient (9.2s)
✔ [8690/8713] Built TateCurvesTheta.Theta.FactorSeries (4.0s)
✔ [8691/8713] Built TateCurvesTheta.Theta.LaurentSphere (4.5s)
✔ [8692/8714] Built TateCurvesTheta.TateCurve.IntegralModel (5.6s)
✔ [8693/8715] Built TateCurvesTheta.TateCurve.TatePointMem (3.7s)
✔ [8694/8716] Built TateCurvesTheta.Theta.ThetaProdLaurent (5.6s)
✔ [8695/8717] Built TateCurvesTheta.Theta.LaurentSphereReduce (4.2s)
✔ [8696/8718] Built TateCurvesTheta.TateCurve.SphereBounds (6.4s)
✔ [8697/8719] Built TateCurvesTheta.TateCurve.PointMap (8.6s)
✔ [8698/8721] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (4.1s)
✔ [8699/8721] Built TateCurvesTheta.Theta.LaurentUnitSphere (3.3s)
✔ [8700/8721] Built TateCurvesTheta.Theta.FactorReciprocal (4.3s)
✔ [8701/8729] Built TateCurvesTheta.Theta.LaurentUnique (3.5s)
✔ [8702/8729] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (3.0s)
✔ [8703/8729] Built TateCurvesTheta.Theta.SeriesZero (3.4s)
✔ [8704/8729] Built TateCurvesTheta.Theta.Normalization (4.6s)
✔ [8705/8729] Built TateCurvesTheta.Theta.RatioAnnulus (5.6s)
✔ [8706/8729] Built TateCurvesTheta.Theta.TripleProduct (4.8s)
✔ [8707/8731] Built TateCurvesTheta.Theta.StrictDominant (9.0s)
✔ [8708/8733] Built TateCurvesTheta.Theta.Durfee (4.7s)
✔ [8709/8735] Built TateCurvesTheta.Uniformization (8.7s)
✔ [8710/8735] Built Iut.Cor312.Procession (6.2s)
✔ [8711/8735] Built TateCurvesTheta.Theta.Inversion (3.7s)
✔ [8712/8735] Built Iut.Cor312.RationalPlace (5.8s)
✔ [8713/8769] Built Iut.Cor312.PacketPresentation (12s)
✔ [8714/8769] Built TateCurvesTheta.Theta.WeightSpace (17s)
✔ [8715/8769] Built Iut.Cor312.Container (8.7s)
✔ [8716/8769] Built Iut.Cor312.HolomorphicHull (9.6s)
✔ [8717/8769] Built IUTThreeClosures.ABCStatement (4.5s)
✔ [8718/8769] Built IUTThreeClosures.FullPolyCore (9.4s)
⚠ [8719/8769] Built IUTThreeClosures.Cor312CoefficientAlgebra (9.9s)
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
⚠ [8720/8769] Built IUTThreeClosures.QPilotNormalizationAudit (7.8s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8721/8769] Built IUTThreeClosures.RootQPilotDivisor (7.9s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8722/8769] Built TateCurvesTheta.Theta.PuncturedProduct (49s)
⚠ [8723/8769] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (6.6s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8724/8769] Built IUTThreeClosures.RamificationCorrectedQPilot (7.2s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✖ [8725/8769] Building IUTThreeClosures.AdmissiblePrimeSelection (5.7s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/AdmissiblePrimeSelection.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/AdmissiblePrimeSelection.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/AdmissiblePrimeSelection.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/AdmissiblePrimeSelection.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/AdmissiblePrimeSelection.setup.json --json
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/AdmissiblePrimeSelection.lean:22:8: omega could not prove the goal:
a possible counterexample may satisfy the constraints
  c ≥ 0
  b ≥ 0
  a ≥ 0
  a - b - c ≥ 1
where
 a := ↑p
 b := ↑(id p)
 c := ↑(∑ x ∈ s, id x)
error: IUTThreeClosures/AdmissiblePrimeSelection.lean:24:8: omega could not prove the goal:
a possible counterexample may satisfy the constraints
  e ≥ 0
  d ≥ 0
  c ≥ 0
  c - d - e ≥ 1
  b ≥ 0
  b - c ≥ 0
where
 b := ↑(s.sum id)
 c := ↑p
 d := ↑(id a)
 e := ↑(∑ x ∈ s, id x)
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:49:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
error: Lean exited with code 1
⚠ [8727/8769] Built IUTThreeClosures.ProductWeightMarginalization (7.3s)
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
⚠ [8728/8769] Built IUTThreeClosures.FiniteExceptionalSet (5.0s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8729/8769] Built IUTThreeClosures.GeneratedUnionCompactness (5.5s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8730/8769] Built Iut.Cor312.LogVolume (6.0s)
✔ [8731/8780] Built Iut.Cor312.ContainerHull (6.0s)
✔ [8733/8784] Built IUTThreeClosures.WeakCompatibilityCountermodel (5.8s)
⚠ [8734/8784] Built IUTThreeClosures.QPilotNormalizationFork (5.6s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8735/8784] Built Genl.Mathlib.Order.BoundedDiscrepancy (2.7s)
⚠ [8736/8784] Built IUTThreeClosures.PrimePowerQPilotRegion (6.1s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8737/8784] Built IUTThreeClosures.TateParameterUnitBallRegion (2.0s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8738/8784] Built IUTThreeClosures.FiniteExponentHull (5.7s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8739/8784] Built IUTThreeClosures.StandardZeroLabel (6.2s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8740/8784] Built IUTThreeClosures.BarycentricPacketReading (5.0s)
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
✔ [8741/8784] Built TateCurvesTheta.TateCurve.DefectVanishing (98s)
⚠ [8742/8784] Built IUTThreeClosures.DiagonalPacketNoGo (6.1s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8743/8784] Built Genl.GeneralPosition.HeightTheory (2.0s)
⚠ [8744/8784] Built IUTThreeClosures.PublicNormalizationObstruction (6.4s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8745/8784] Built Iut4Sec1.Global.ArithmeticDivisor (6.2s)
⚠ [8746/8784] Built IUTThreeClosures.IUTIVAbsorption (8.7s)
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
✖ [8747/8784] Building IUTThreeClosures.DistinguishedLabelQPilot (6.2s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/DistinguishedLabelQPilot.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/DistinguishedLabelQPilot.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/DistinguishedLabelQPilot.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/DistinguishedLabelQPilot.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/DistinguishedLabelQPilot.setup.json --json
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/DistinguishedLabelQPilot.lean:34:10: Invalid field `packetVol_packetPrimePowerRegion`: The environment does not contain `Iut.LogVolumeData.packetVol_packetPrimePowerRegion`, so it is not possible to project the field `packetVol_packetPrimePowerRegion` from an expression
  vol
of type `LogVolumeData D`
error: IUTThreeClosures/DistinguishedLabelQPilot.lean:33:44: unsolved goals
ι : Type u₁
V : Type u₂
D : LargeVolumeContainerData ι V
vol : LogVolumeData D
i : Fin D.proc.length
p : Nat.Primes
j₀ : (D.proc.capsule i).LabelType
order : D.Fiber (RationalPlace.finite p) → ℕ
⊢ vol.packetVol i (RationalPlace.finite p) (packetPrimePowerRegion i p fun c ↦ order (c j₀)) =
    ∑ v, vol.weight (RationalPlace.finite p) v * (-↑(order v) * Real.log ↑↑p)
error: Lean exited with code 1
⚠ [8748/8784] Built IUTThreeClosures.ZeroLabelBarycentric (6.4s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
✔ [8749/8784] Built TateCurvesTheta.TateCurve.TatePointOnCurve (6.3s)
⚠ [8750/8784] Built IUTThreeClosures.StatementIIOutsideFinite (6.7s)
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
✔ [8751/8784] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (7.8s)
✔ [8752/8784] Built TateCurvesTheta.TateCurve.AdditionLaw (10s)
✔ [8753/8784] Built TateCurvesTheta.TateCurve.LargePointParametrization (13s)
✔ [8754/8784] Built TateCurvesTheta.TateCurve.AbelStep (7.1s)
✔ [8755/8784] Built TateCurvesTheta.TateCurve.GroupLaw (10s)
✔ [8756/8784] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (23s)
✔ [8757/8784] Built TateCurvesTheta.TateCurve.SurjectivitySphere (27s)
✔ [8758/8784] Built TateCurvesTheta.TateCurve.TateUniformization (4.1s)
✔ [8759/8784] Built TateCurvesTheta (3.4s)
✔ [8760/8784] Built Iut.Cor312.ThetaData.AdmissiblePrime (4.5s)
✔ [8761/8784] Built Iut.Cor312.ThetaData.Orbicurve (4.4s)
✔ [8762/8784] Built Iut.Cor312.ThetaData.LocalConditions (7.5s)
✔ [8763/8784] Built Iut.Cor312.ThetaData.Basic (4.3s)
✔ [8764/8784] Built Iut.Cor312.LeftHandSide (3.8s)
✔ [8765/8784] Built Iut.Cor312.RightHandSide (4.1s)
⚠ [8766/8784] Built IUTThreeClosures.CorrectedQPilotDivisor (4.3s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8767/8784] Built IUTThreeClosures.NativeQPilotCalibration (5.2s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8768/8784] Built Iut.Cor312.Statement (5.0s)
✔ [8769/8784] Built IUTThreeClosures.ActualPilotWitness (3.8s)
✔ [8770/8784] Built IUTThreeClosures.GeneratedSource (4.2s)
✔ [8771/8784] Built IUTThreeClosures.QuantifierCorrectClosure (3.7s)
✔ [8772/8784] Built IUTThreeClosures.ABCClosure (3.7s)
✔ [8773/8784] Built IUTThreeClosures.ThreeClosureTheorems (3.7s)
✔ [8774/8784] Built IUTThreeClosures.InhabitationBoundary (3.8s)
✔ [8775/8784] Built IUTThreeClosures.CircularityAudit (3.9s)
✔ [8776/8784] Built IUTThreeClosures.NonCircularDownstream (4.9s)
✔ [8777/8784] Built IUTThreeClosures.FourOpenConstructions (3.7s)
⚠ [8778/8784] Built IUTThreeClosures.BridgeInhabitationAudit (4.2s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
✔ [8779/8784] Built IUTThreeClosures.BridgeInhabitationExact (3.7s)
✖ [8780/8784] Building IUTThreeClosures.CanonicalQPilotCorridor (3.6s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/CanonicalQPilotCorridor.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/CanonicalQPilotCorridor.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/CanonicalQPilotCorridor.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/CanonicalQPilotCorridor.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/CanonicalQPilotCorridor.setup.json --json
error: IUTThreeClosures/CanonicalQPilotCorridor.lean:89:2: linarith failed to find a contradiction
AG : AnabelianGeometry
TG : TemperedGeometry AG
Input : Type z
F : PointwiseIUTIIIFamily Input
C : CanonicalCoefficientCorridor F
P : ABCPoint
h312 : Corollary312Variant (F.source (C.encode P)).toVariantData
hraw : -C.qLog P ≤ (F.source (C.encode P)).toVariantData.rhsData.rhs
a✝ : (F.source (C.encode P)).toVariantData.rhsData.rhs < -1 * (F.qPilot (C.encode P)).absLogQ
⊢ False
failed
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:105:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
error: Lean exited with code 1
Some required targets logged failures:
- IUTThreeClosures.AdmissiblePrimeSelection
- IUTThreeClosures.DistinguishedLabelQPilot
- IUTThreeClosures.CanonicalQPilotCorridor
error: build failed
```
