# Lean CI result

- Tested commit: `b51d1feb7fa4154267d435770817a25c31be63fa`
- Lean setup: `success`
- Dependency resolution/cache: `success`
- `lake build`: `failure`

## Error summary

```text
===== lean-dependencies.log =====
===== lean-build.log =====
110:✖ [8725/8778] Building IUTThreeClosures.ExplicitSemistableCurve (6.4s)
117:error: IUTThreeClosures/ExplicitSemistableCurve.lean:56:39: unsolved goals
119:error: IUTThreeClosures/ExplicitSemistableCurve.lean:59:40: unsolved goals
121:error: IUTThreeClosures/ExplicitSemistableCurve.lean:62:39: unsolved goals
123:error: IUTThreeClosures/ExplicitSemistableCurve.lean:65:40: unsolved goals
125:error: IUTThreeClosures/ExplicitSemistableCurve.lean:68:40: unsolved goals
127:error: IUTThreeClosures/ExplicitSemistableCurve.lean:71:42: unsolved goals
129:error: IUTThreeClosures/ExplicitSemistableCurve.lean:74:38: unsolved goals
131:error: IUTThreeClosures/ExplicitSemistableCurve.lean:86:2: 'change' tactic failed, pattern
138:error: Lean exited with code 1
247:✖ [8744/8793] Building IUTThreeClosures.DistinguishedLabelQPilot (6.4s)
254:error: IUTThreeClosures/DistinguishedLabelQPilot.lean:39:2: Type mismatch
268:error: Lean exited with code 1
444:✖ [8782/8793] Building IUTThreeClosures.ABCPointLegendreCurve (3.9s)
451:error: IUTThreeClosures/ABCPointLegendreCurve.lean:34:2: omega could not prove the goal:
459:error: IUTThreeClosures/ABCPointLegendreCurve.lean:37:2: omega could not prove the goal:
467:error: IUTThreeClosures/ABCPointLegendreCurve.lean:94:2: No goals to be solved
468:error: IUTThreeClosures/ABCPointLegendreCurve.lean:124:2: 'change' tactic failed, pattern
476:error: Lean exited with code 1
498:Some required targets logged failures:
502:error: build failed
```

## Dependency log tail

```text
info: heights: cloning https://github.com/lana-agents/heights.git
info: heights: checking out revision '3539e2a12dd3470c057a4eb531dc3fd627d4c97b'
info: toolchain not updated; already up-to-date
info: mathlib: running post-update hooks
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
Attempting to download 8639 file(s) from leanprover-community/mathlib4 cache at https://lakecache.blob.core.windows.net/mathlib4-master
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 14 KB/s], Decompressed: 0Downloaded: 76 file(s) [attempted 76/8639 = 0%, 555 KB/s], Decompressed: 73Downloaded: 178 file(s) [attempted 178/8639 = 2%, 471 KB/s], Decompressed: 176Downloaded: 270 file(s) [attempted 270/8639 = 3%, 2117 KB/s], Decompressed: 264Downloaded: 381 file(s) [attempted 381/8639 = 4%, 216 KB/s], Decompressed: 372Downloaded: 488 file(s) [attempted 488/8639 = 5%, 1452 KB/s], Decompressed: 486Downloaded: 593 file(s) [attempted 593/8639 = 6%, 102 KB/s], Decompressed: 589Downloaded: 719 file(s) [attempted 719/8639 = 8%, 496 KB/s], Decompressed: 716Downloaded: 836 file(s) [attempted 836/8639 = 9%, 251 KB/s], Decompressed: 831Downloaded: 945 file(s) [attempted 945/8639 = 10%, 559 KB/s], Decompressed: 941Downloaded: 1069 file(s) [attempted 1069/8639 = 12%, 3836 KB/s], Decompressed: 1067Downloaded: 1184 file(s) [attempted 1184/8639 = 13%, 1299 KB/s], Decompressed: 1181Downloaded: 1294 file(s) [attempted 1294/8639 = 14%, 831 KB/s], Decompressed: 1292Downloaded: 1424 file(s) [attempted 1424/8639 = 16%, 238 KB/s], Decompressed: 1412Downloaded: 1533 file(s) [attempted 1533/8639 = 17%, 2594 KB/s], Decompressed: 1531Downloaded: 1645 file(s) [attempted 1645/8639 = 19%, 639 KB/s], Decompressed: 1641Downloaded: 1754 file(s) [attempted 1754/8639 = 20%, 1660 KB/s], Decompressed: 1750Downloaded: 1864 file(s) [attempted 1864/8639 = 21%, 2120 KB/s], Decompressed: 1862Downloaded: 1967 file(s) [attempted 1967/8639 = 22%, 227 KB/s], Decompressed: 1965Downloaded: 2076 file(s) [attempted 2076/8639 = 24%, 1700 KB/s], Decompressed: 2074Downloaded: 2191 file(s) [attempted 2191/8639 = 25%, 530 KB/s], Decompressed: 2184Downloaded: 2319 file(s) [attempted 2319/8639 = 26%, 436 KB/s], Decompressed: 2307Downloaded: 2427 file(s) [attempted 2427/8639 = 28%, 2369 KB/s], Decompressed: 2424Downloaded: 2536 file(s) [attempted 2536/8639 = 29%, 965 KB/s], Decompressed: 2533Downloaded: 2641 file(s) [attempted 2641/8639 = 30%, 889 KB/s], Decompressed: 2638Downloaded: 2757 file(s) [attempted 2757/8639 = 31%, 1493 KB/s], Decompressed: 2752Downloaded: 2860 file(s) [attempted 2860/8639 = 33%, 689 KB/s], Decompressed: 2857Downloaded: 2969 file(s) [attempted 2969/8639 = 34%, 680 KB/s], Decompressed: 2965Downloaded: 3081 file(s) [attempted 3081/8639 = 35%, 940 KB/s], Decompressed: 3079Downloaded: 3205 file(s) [attempted 3205/8639 = 37%, 1684 KB/s], Decompressed: 3199Downloaded: 3319 file(s) [attempted 3319/8639 = 38%, 912 KB/s], Decompressed: 3317Downloaded: 3428 file(s) [attempted 3428/8639 = 39%, 353 KB/s], Decompressed: 3427Downloaded: 3538 file(s) [attempted 3538/8639 = 40%, 1880 KB/s], Decompressed: 3536Downloaded: 3638 file(s) [attempted 3638/8639 = 42%, 249 KB/s], Decompressed: 3636Downloaded: 3745 file(s) [attempted 3745/8639 = 43%, 1583 KB/s], Decompressed: 3743Downloaded: 3857 file(s) [attempted 3857/8639 = 44%, 1160 KB/s], Decompressed: 3855Downloaded: 3962 file(s) [attempted 3962/8639 = 45%, 357 KB/s], Decompressed: 3960Downloaded: 4065 file(s) [attempted 4065/8639 = 47%, 2552 KB/s], Decompressed: 4060Downloaded: 4167 file(s) [attempted 4167/8639 = 48%, 3785 KB/s], Decompressed: 4165Downloaded: 4270 file(s) [attempted 4270/8639 = 49%, 894 KB/s], Decompressed: 4268Downloaded: 4373 file(s) [attempted 4373/8639 = 50%, 204 KB/s], Decompressed: 4370Downloaded: 4477 file(s) [attempted 4477/8639 = 51%, 1005 KB/s], Decompressed: 4473Downloaded: 4580 file(s) [attempted 4580/8639 = 53%, 199 KB/s], Decompressed: 4578Downloaded: 4685 file(s) [attempted 4685/8639 = 54%, 354 KB/s], Decompressed: 4683Downloaded: 4790 file(s) [attempted 4790/8639 = 55%, 4213 KB/s], Decompressed: 4788Downloaded: 4895 file(s) [attempted 4895/8639 = 56%, 919 KB/s], Decompressed: 4892Downloaded: 5008 file(s) [attempted 5008/8639 = 57%, 2588 KB/s], Decompressed: 5000Downloaded: 5116 file(s) [attempted 5116/8639 = 59%, 1207 KB/s], Decompressed: 5112Downloaded: 5237 file(s) [attempted 5237/8639 = 60%, 135 KB/s], Decompressed: 5228Downloaded: 5356 file(s) [attempted 5356/8639 = 61%, 967 KB/s], Decompressed: 5352Downloaded: 5468 file(s) [attempted 5468/8639 = 63%, 497 KB/s], Decompressed: 5466Downloaded: 5586 file(s) [attempted 5586/8639 = 64%, 432 KB/s], Decompressed: 5578Downloaded: 5715 file(s) [attempted 5715/8639 = 66%, 1259 KB/s], Decompressed: 5706Downloaded: 5823 file(s) [attempted 5823/8639 = 67%, 346 KB/s], Decompressed: 5820Downloaded: 5939 file(s) [attempted 5939/8639 = 68%, 1599 KB/s], Decompressed: 5934Downloaded: 6051 file(s) [attempted 6051/8639 = 70%, 2118 KB/s], Decompressed: 6049Downloaded: 6171 file(s) [attempted 6171/8639 = 71%, 180 KB/s], Decompressed: 6163Downloaded: 6291 file(s) [attempted 6291/8639 = 72%, 134 KB/s], Decompressed: 6286Downloaded: 6399 file(s) [attempted 6399/8639 = 74%, 1025 KB/s], Decompressed: 6397Downloaded: 6508 file(s) [attempted 6508/8639 = 75%, 1664 KB/s], Decompressed: 6505Downloaded: 6617 file(s) [attempted 6617/8639 = 76%, 770 KB/s], Decompressed: 6615Downloaded: 6729 file(s) [attempted 6729/8639 = 77%, 1072 KB/s], Decompressed: 6727Downloaded: 6833 file(s) [attempted 6833/8639 = 79%, 228 KB/s], Decompressed: 6830Downloaded: 6944 file(s) [attempted 6944/8639 = 80%, 273 KB/s], Decompressed: 6939Downloaded: 7051 file(s) [attempted 7051/8639 = 81%, 2153 KB/s], Decompressed: 7046Downloaded: 7159 file(s) [attempted 7159/8639 = 82%, 375 KB/s], Decompressed: 7155Downloaded: 7279 file(s) [attempted 7279/8639 = 84%, 3844 KB/s], Decompressed: 7268Downloaded: 7396 file(s) [attempted 7396/8639 = 85%, 1443 KB/s], Decompressed: 7395Downloaded: 7513 file(s) [attempted 7513/8639 = 86%, 410 KB/s], Decompressed: 7506Downloaded: 7620 file(s) [attempted 7620/8639 = 88%, 223 KB/s], Decompressed: 7617Downloaded: 7728 file(s) [attempted 7728/8639 = 89%, 882 KB/s], Decompressed: 7725Downloaded: 7837 file(s) [attempted 7837/8639 = 90%, 3790 KB/s], Decompressed: 7836Downloaded: 7946 file(s) [attempted 7946/8639 = 91%, 371 KB/s], Decompressed: 7944Downloaded: 8070 file(s) [attempted 8070/8639 = 93%, 1345 KB/s], Decompressed: 8056Downloaded: 8189 file(s) [attempted 8189/8639 = 94%, 2069 KB/s], Decompressed: 8186Downloaded: 8300 file(s) [attempted 8300/8639 = 96%, 792 KB/s], Decompressed: 8293Downloaded: 8411 file(s) [attempted 8411/8639 = 97%, 165 KB/s], Decompressed: 8408Downloaded: 8537 file(s) [attempted 8537/8639 = 98%, 409 KB/s], Decompressed: 8524Downloaded: 8625 file(s) [attempted 8625/8639 = 99%, 1605 KB/s], Decompressed: 8623Downloaded: 8638 file(s) [attempted 8638/8639 = 99%, 507 KB/s], Decompressed: 8636Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 507 KB/s], Decompressed: 8636
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (357ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.MaxTerm (3.4s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.UltrametricSum (3.6s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (3.0s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (9.1s)
✔ [8661/8667] Built TateCurvesTheta.Analysis.Strassmann (5.9s)
✔ [8662/8671] Built Iut.Cor312.ThetaData.Places (7.6s)
✔ [8663/8673] Built TateCurvesTheta.AnalyticQuotient (8.3s)
✔ [8664/8675] Built TateCurvesTheta.QParameter.BaseChange (2.7s)
✔ [8665/8675] Built TateCurvesTheta.QParameter.PrimeToOrder (3.3s)
✔ [8666/8675] Built TateCurvesTheta.TateCurve.Weierstrass (3.9s)
✔ [8667/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (5.0s)
✔ [8668/8684] Built TateCurvesTheta.QParameter.NormalizedOrder (3.2s)
✔ [8669/8689] Built TateCurvesTheta.TateCurve.Discriminant (4.9s)
✔ [8670/8689] Built TateCurvesTheta.TateCurve.Parametrization (4.7s)
✔ [8671/8689] Built TateCurvesTheta.Theta.Basic (4.1s)
✔ [8672/8691] Built TateCurvesTheta.TateCurve.JInvariant (3.3s)
✔ [8673/8691] Built Iut.Cor312.ThetaData.GlobalField (13s)
✔ [8674/8692] Built TateCurvesTheta.TateCurve.SplitReduction (4.5s)
✔ [8675/8692] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (3.6s)
✔ [8676/8693] Built TateCurvesTheta.TateCurve.CoordinateExpansion (3.8s)
✔ [8677/8693] Built TateCurvesTheta.Theta.Periodicity (3.8s)
✔ [8678/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (5.3s)
✔ [8679/8696] Built TateCurvesTheta.QParameter.JParametrization (8.6s)
✔ [8680/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (9.7s)
✔ [8681/8699] Built TateCurvesTheta.Theta.Product (6.7s)
✔ [8682/8699] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (10s)
✔ [8683/8699] Built TateCurvesTheta.QParameter.Characterization (3.2s)
✔ [8684/8704] Built TateCurvesTheta.Theta.Divisor (6.0s)
✔ [8685/8705] Built TateCurvesTheta.Theta.Uniqueness (5.7s)
✔ [8686/8705] Built TateCurvesTheta.Theta.FactorSeries (6.7s)
✔ [8687/8705] Built TateCurvesTheta.TateCurve.EisensteinSeries (14s)
✔ [8688/8705] Built TateCurvesTheta.Theta.LaurentSphere (5.4s)
✔ [8689/8708] Built TateCurvesTheta.Theta.QBinomial (6.2s)
✔ [8690/8708] Built TateCurvesTheta.TateCurve.TatePointMem (3.3s)
✔ [8691/8711] Built TateCurvesTheta.Theta.ThetaProdLaurent (5.2s)
✔ [8692/8712] Built TateCurvesTheta.TateCurve.CoordinateInversion (3.4s)
✔ [8693/8713] Built TateCurvesTheta.Theta.LaurentSphereReduce (3.7s)
✔ [8694/8714] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (4.9s)
✔ [8695/8715] Built TateCurvesTheta.TateCurve.Quotient (8.1s)
✔ [8696/8715] Built TateCurvesTheta.TateCurve.IntegralModel (6.3s)
✔ [8697/8715] Built TateCurvesTheta.TateCurve.SphereBounds (6.9s)
✔ [8698/8717] Built TateCurvesTheta.Theta.LaurentUnitSphere (3.5s)
✔ [8699/8717] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (3.8s)
✔ [8700/8717] Built TateCurvesTheta.Theta.Normalization (3.9s)
✔ [8701/8719] Built TateCurvesTheta.Theta.FactorReciprocal (5.6s)
✔ [8702/8720] Built TateCurvesTheta.TateCurve.PointMap (10s)
✔ [8703/8721] Built TateCurvesTheta.Theta.LaurentUnique (4.0s)
✔ [8704/8722] Built TateCurvesTheta.Theta.Durfee (7.6s)
✔ [8705/8722] Built TateCurvesTheta.Theta.RatioAnnulus (4.1s)
✔ [8706/8722] Built TateCurvesTheta.Theta.SeriesZero (3.4s)
✔ [8707/8722] Built TateCurvesTheta.Theta.Inversion (3.9s)
✔ [8708/8729] Built TateCurvesTheta.Theta.StrictDominant (6.6s)
✔ [8709/8729] Built TateCurvesTheta.Theta.TripleProduct (5.7s)
✔ [8710/8731] Built TateCurvesTheta.Theta.WeightSpace (14s)
✔ [8711/8733] Built TateCurvesTheta.Uniformization (13s)
✔ [8712/8735] Built Iut.Cor312.Procession (10s)
✔ [8713/8760] Built Iut.Cor312.RationalPlace (9.0s)
✔ [8714/8760] Built Iut.Cor312.PacketPresentation (8.7s)
✔ [8715/8760] Built IUTThreeClosures.ABCStatement (3.6s)
✔ [8716/8760] Built IUTThreeClosures.FullPolyCore (8.7s)
⚠ [8718/8760] Built IUTThreeClosures.Cor312CoefficientAlgebra (8.4s)
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
✔ [8719/8760] Built Iut.Cor312.Container (7.2s)
✔ [8720/8778] Built Iut.Cor312.HolomorphicHull (6.9s)
✔ [8721/8778] Built TateCurvesTheta.Theta.PuncturedProduct (49s)
✔ [8722/8778] Built IUTThreeClosures.WeakCompatibilityCountermodel (5.7s)
✔ [8723/8778] Built Iut.Cor312.LogVolume (6.6s)
✔ [8724/8778] Built Iut.Cor312.ContainerHull (5.7s)
✖ [8725/8778] Building IUTThreeClosures.ExplicitSemistableCurve (6.4s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/ExplicitSemistableCurve.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/ExplicitSemistableCurve.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/ExplicitSemistableCurve.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/ExplicitSemistableCurve.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/ExplicitSemistableCurve.setup.json --json
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/ExplicitSemistableCurve.lean:56:39: unsolved goals
⊢ (E37Z⁄ℚ).b₂ = 0
error: IUTThreeClosures/ExplicitSemistableCurve.lean:59:40: unsolved goals
⊢ (E37Z⁄ℚ).b₄ = -2
error: IUTThreeClosures/ExplicitSemistableCurve.lean:62:39: unsolved goals
⊢ (E37Z⁄ℚ).b₆ = 1
error: IUTThreeClosures/ExplicitSemistableCurve.lean:65:40: unsolved goals
⊢ (E37Z⁄ℚ).b₈ = -1
error: IUTThreeClosures/ExplicitSemistableCurve.lean:68:40: unsolved goals
⊢ (E37Z⁄ℚ).c₄ = 48
error: IUTThreeClosures/ExplicitSemistableCurve.lean:71:42: unsolved goals
⊢ (E37Z⁄ℚ).c₆ = -216
error: IUTThreeClosures/ExplicitSemistableCurve.lean:74:38: unsolved goals
⊢ (E37Z⁄ℚ).Δ = 37
error: IUTThreeClosures/ExplicitSemistableCurve.lean:86:2: 'change' tactic failed, pattern
  (↑E37.Δ')⁻¹ * E37.c₄ ^ 3 = ?m.29
is not definitionally equal to target
  ↑E37.Δ'⁻¹ * E37.c₄ ^ 3 = 110592 / 37
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:90:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
error: Lean exited with code 1
✔ [8726/8778] Built Heights.WeilHeight (8.8s)
⚠ [8727/8778] Built IUTThreeClosures.SolvableRestrictionImage (7.4s)
warning: IUTThreeClosures/SolvableRestrictionImage.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/SolvableRestrictionImage.lean:121:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8728/8778] Built IUTThreeClosures.QPilotNormalizationAudit (6.5s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8729/8778] Built IUTThreeClosures.RootQPilotDivisor (6.2s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8730/8778] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (6.4s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8731/8778] Built IUTThreeClosures.RamificationCorrectedQPilot (6.7s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8732/8778] Built IUTThreeClosures.GeneratedUnionCompactness (6.2s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8733/8778] Built IUTThreeClosures.ProductWeightMarginalization (7.4s)
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
⚠ [8735/8778] Built IUTThreeClosures.AdmissiblePrimeSelection (6.0s)
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:104:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8736/8778] Built IUTThreeClosures.FiniteExceptionalSet (5.0s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8738/8793] Built TateCurvesTheta.TateCurve.DefectVanishing (102s)
⚠ [8739/8793] Built IUTThreeClosures.PrimePowerQPilotRegion (6.9s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8740/8793] Built Genl.Mathlib.Order.BoundedDiscrepancy (2.5s)
⚠ [8741/8793] Built IUTThreeClosures.ZModSL2Perfect (6.5s)
warning: IUTThreeClosures/ZModSL2Perfect.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZModSL2Perfect.lean:62:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8742/8793] Built IUTThreeClosures.QPilotNormalizationFork (6.1s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8743/8793] Built IUTThreeClosures.TateParameterUnitBallRegion (2.8s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✖ [8744/8793] Building IUTThreeClosures.DistinguishedLabelQPilot (6.4s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/DistinguishedLabelQPilot.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/DistinguishedLabelQPilot.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/DistinguishedLabelQPilot.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/DistinguishedLabelQPilot.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/DistinguishedLabelQPilot.setup.json --json
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/DistinguishedLabelQPilot.lean:39:2: Type mismatch
  IUTThreeClosures.product_weight_marginal j₀ (vol.weight (RationalPlace.finite p)) (fun v ↦ -↑(order v) * Real.log ↑↑p)
    (vol.weight_sum_one (RationalPlace.finite p))
has type
  ∑ c ∈ @Finset.univ ((D.proc.capsule i).LabelType → D.Fiber (RationalPlace.finite p)) Pi.instFintype,
      (∏ j, vol.weight (RationalPlace.finite p) (c j)) * (-↑(order (c j₀)) * Real.log ↑↑p) =
    ∑ v, vol.weight (RationalPlace.finite p) v * (-↑(order v) * Real.log ↑↑p)
but is expected to have type
  ∑ c ∈ @Finset.univ (D.Components i (RationalPlace.finite p)) (D.instFintypeComponents i (RationalPlace.finite p)),
      vol.packetWeight i (RationalPlace.finite p) c * (-↑(order (c j₀)) * Real.log ↑↑p) =
    ∑ v, vol.weight (RationalPlace.finite p) v * (-↑(order v) * Real.log ↑↑p)
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:45:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
error: Lean exited with code 1
⚠ [8745/8793] Built IUTThreeClosures.FiniteExponentHull (5.7s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8746/8793] Built IUTThreeClosures.StandardZeroLabel (5.7s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8747/8793] Built IUTThreeClosures.BarycentricPacketReading (5.9s)
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
⚠ [8748/8793] Built IUTThreeClosures.DiagonalPacketNoGo (5.7s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8749/8793] Built IUTThreeClosures.PublicNormalizationObstruction (7.3s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8750/8793] Built TateCurvesTheta.TateCurve.TatePointOnCurve (6.0s)
✔ [8751/8793] Built Iut4Sec1.Global.ArithmeticDivisor (7.0s)
✔ [8752/8793] Built Genl.GeneralPosition.HeightTheory (1.9s)
⚠ [8753/8793] Built IUTThreeClosures.IUTIVAbsorption (9.9s)
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
⚠ [8754/8793] Built IUTThreeClosures.ZeroLabelBarycentric (7.0s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
✔ [8755/8793] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (9.1s)
✔ [8756/8793] Built TateCurvesTheta.TateCurve.AdditionLaw (11s)
✔ [8757/8793] Built TateCurvesTheta.TateCurve.LargePointParametrization (15s)
⚠ [8758/8793] Built IUTThreeClosures.StatementIIOutsideFinite (8.7s)
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
✔ [8759/8793] Built TateCurvesTheta.TateCurve.AbelStep (7.5s)
✔ [8760/8793] Built TateCurvesTheta.TateCurve.GroupLaw (10s)
✔ [8761/8793] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (23s)
✔ [8762/8793] Built TateCurvesTheta.TateCurve.SurjectivitySphere (25s)
✔ [8763/8793] Built TateCurvesTheta.TateCurve.TateUniformization (4.1s)
✔ [8764/8793] Built TateCurvesTheta (3.4s)
✔ [8765/8793] Built Iut.Cor312.ThetaData.AdmissiblePrime (4.6s)
✔ [8766/8793] Built Iut.Cor312.ThetaData.Orbicurve (4.4s)
✔ [8767/8793] Built Iut.Cor312.ThetaData.LocalConditions (7.4s)
✔ [8768/8793] Built Iut.Cor312.ThetaData.Basic (4.3s)
✔ [8769/8793] Built Iut.Cor312.LeftHandSide (3.9s)
✔ [8770/8793] Built Iut.Cor312.RightHandSide (4.1s)
✔ [8771/8793] Built Iut.Cor312.Statement (3.9s)
⚠ [8772/8793] Built IUTThreeClosures.NativeQPilotCalibration (5.6s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8773/8793] Built IUTThreeClosures.CorrectedQPilotDivisor (5.7s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8774/8793] Built IUTThreeClosures.ActualPilotWitness (4.1s)
✔ [8775/8793] Built IUTThreeClosures.GeneratedSource (4.3s)
✔ [8776/8793] Built IUTThreeClosures.QuantifierCorrectClosure (3.7s)
✔ [8777/8793] Built IUTThreeClosures.ABCClosure (3.7s)
✔ [8778/8793] Built IUTThreeClosures.ThreeClosureTheorems (3.7s)
✔ [8779/8793] Built IUTThreeClosures.InhabitationBoundary (3.8s)
✔ [8780/8793] Built IUTThreeClosures.CircularityAudit (3.9s)
✔ [8781/8793] Built IUTThreeClosures.NonCircularDownstream (4.9s)
✖ [8782/8793] Building IUTThreeClosures.ABCPointLegendreCurve (3.9s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/ABCPointLegendreCurve.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/ABCPointLegendreCurve.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/ABCPointLegendreCurve.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/ABCPointLegendreCurve.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/ABCPointLegendreCurve.setup.json --json
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/ABCPointLegendreCurve.lean:34:2: omega could not prove the goal:
a possible counterexample may satisfy the constraints
  e ≥ 0
  d ≥ 0
  d - e ≥ 0
where
 d := ↑P.a
 e := ↑P.c
error: IUTThreeClosures/ABCPointLegendreCurve.lean:37:2: omega could not prove the goal:
a possible counterexample may satisfy the constraints
  e ≥ 0
  d ≥ 0
  d - e ≥ 0
where
 d := ↑P.b
 e := ↑P.c
error: IUTThreeClosures/ABCPointLegendreCurve.lean:94:2: No goals to be solved
error: IUTThreeClosures/ABCPointLegendreCurve.lean:124:2: 'change' tactic failed, pattern
  (↑(abcLegendreCurve P).Δ')⁻¹ * (abcLegendreCurve P).c₄ ^ 3 = ?m.95
is not definitionally equal to target
  ↑(abcLegendreCurve P).Δ'⁻¹ * (abcLegendreCurve P).c₄ ^ 3 =
    256 * (1 - P.lambda + P.lambda ^ 2) ^ 3 / (P.lambda ^ 2 * (1 - P.lambda) ^ 2)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
error: Lean exited with code 1
✔ [8786/8793] Built IUTThreeClosures.FourOpenConstructions (4.1s)
⚠ [8787/8793] Built IUTThreeClosures.BridgeInhabitationAudit (4.2s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
✔ [8788/8793] Built IUTThreeClosures.BridgeInhabitationExact (3.7s)
⚠ [8789/8793] Built IUTThreeClosures.CanonicalQPilotCorridor (3.8s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8790/8793] Built IUTThreeClosures.CanonicalCorridorAudit (3.9s)
⚠ [8791/8793] Built IUTThreeClosures.SourceDerivedIUTIVBridge (4.9s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
Some required targets logged failures:
- IUTThreeClosures.ExplicitSemistableCurve
- IUTThreeClosures.DistinguishedLabelQPilot
- IUTThreeClosures.ABCPointLegendreCurve
error: build failed
```
