# Lean CI result

- Tested commit: `6cf6440d81cc7d64b57534585181db2d2abe5850`
- Lean setup: `success`
- Dependency resolution/cache: `success`
- `lake build`: `failure`

## Error summary

```text
===== lean-dependencies.log =====
===== lean-build.log =====
61:✖ [8716/8763] Building IUTThreeClosures.HonestFinitePositiveLogVolume (10s)
68:error: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:29:31: expected token
69:error: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:37:2: `coe_injective'` is not a field of structure `SetLike`
70:error: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:35:48: Fields missing: `coe_injective`
71:warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:54:8: declaration uses `sorry`
72:warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:60:8: declaration uses `sorry`
73:error: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:118:8: Tactic `rfl` failed: The left-hand side
92:error: Lean exited with code 1
358:✖ [8754/8796] Building IUTThreeClosures.DistinguishedLabelQPilot (7.6s)
365:error: IUTThreeClosures/DistinguishedLabelQPilot.lean:46:2: Type mismatch
382:error: Lean exited with code 1
478:✖ [8787/8796] Building IUTThreeClosures.LegendreArithmetic (4.5s)
485:error: IUTThreeClosures/LegendreArithmetic.lean:59:2: linarith failed to find a contradiction
493:error: IUTThreeClosures/LegendreArithmetic.lean:131:21: Tactic `rewrite` failed: Did not find an occurrence of the pattern
505:error: Lean exited with code 1
526:Some required targets logged failures:
530:error: build failed
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
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 14 KB/s], Decompressed: 0Downloaded: 77 file(s) [attempted 77/8639 = 0%, 466 KB/s], Decompressed: 73Downloaded: 177 file(s) [attempted 177/8639 = 2%, 429 KB/s], Decompressed: 169Downloaded: 276 file(s) [attempted 276/8639 = 3%, 248 KB/s], Decompressed: 271Downloaded: 384 file(s) [attempted 384/8639 = 4%, 908 KB/s], Decompressed: 379Downloaded: 493 file(s) [attempted 493/8639 = 5%, 244 KB/s], Decompressed: 484Downloaded: 612 file(s) [attempted 612/8639 = 7%, 110 KB/s], Decompressed: 610Downloaded: 732 file(s) [attempted 732/8639 = 8%, 373 KB/s], Decompressed: 729Downloaded: 849 file(s) [attempted 849/8639 = 9%, 1036 KB/s], Decompressed: 845Downloaded: 969 file(s) [attempted 969/8639 = 11%, 1020 KB/s], Decompressed: 960Downloaded: 1082 file(s) [attempted 1082/8639 = 12%, 190 KB/s], Decompressed: 1076Downloaded: 1201 file(s) [attempted 1201/8639 = 13%, 458 KB/s], Decompressed: 1195Downloaded: 1317 file(s) [attempted 1317/8639 = 15%, 549 KB/s], Decompressed: 1314Downloaded: 1428 file(s) [attempted 1428/8639 = 16%, 1682 KB/s], Decompressed: 1421Downloaded: 1552 file(s) [attempted 1552/8639 = 17%, 631 KB/s], Decompressed: 1536Downloaded: 1669 file(s) [attempted 1669/8639 = 19%, 624 KB/s], Decompressed: 1659Downloaded: 1785 file(s) [attempted 1785/8639 = 20%, 3045 KB/s], Decompressed: 1783Downloaded: 1902 file(s) [attempted 1902/8639 = 22%, 4418 KB/s], Decompressed: 1899Downloaded: 2023 file(s) [attempted 2023/8639 = 23%, 982 KB/s], Decompressed: 2021Downloaded: 2139 file(s) [attempted 2139/8639 = 24%, 1152 KB/s], Decompressed: 2137Downloaded: 2247 file(s) [attempted 2247/8639 = 26%, 279 KB/s], Decompressed: 2244Downloaded: 2364 file(s) [attempted 2364/8639 = 27%, 211 KB/s], Decompressed: 2361Downloaded: 2470 file(s) [attempted 2470/8639 = 28%, 753 KB/s], Decompressed: 2466Downloaded: 2585 file(s) [attempted 2585/8639 = 29%, 959 KB/s], Decompressed: 2578Downloaded: 2710 file(s) [attempted 2710/8639 = 31%, 1853 KB/s], Decompressed: 2706Downloaded: 2823 file(s) [attempted 2823/8639 = 32%, 656 KB/s], Decompressed: 2813Downloaded: 2934 file(s) [attempted 2934/8639 = 33%, 250 KB/s], Decompressed: 2932Downloaded: 3050 file(s) [attempted 3050/8639 = 35%, 321 KB/s], Decompressed: 3044Downloaded: 3168 file(s) [attempted 3168/8639 = 36%, 431 KB/s], Decompressed: 3160Downloaded: 3291 file(s) [attempted 3291/8639 = 38%, 687 KB/s], Decompressed: 3286Downloaded: 3407 file(s) [attempted 3407/8639 = 39%, 160 KB/s], Decompressed: 3400Downloaded: 3524 file(s) [attempted 3524/8639 = 40%, 1570 KB/s], Decompressed: 3519Downloaded: 3644 file(s) [attempted 3644/8639 = 42%, 2186 KB/s], Decompressed: 3638Downloaded: 3757 file(s) [attempted 3757/8639 = 43%, 624 KB/s], Decompressed: 3748Downloaded: 3874 file(s) [attempted 3874/8639 = 44%, 130 KB/s], Decompressed: 3871Downloaded: 3995 file(s) [attempted 3995/8639 = 46%, 148 KB/s], Decompressed: 3988Downloaded: 4107 file(s) [attempted 4107/8639 = 47%, 1151 KB/s], Decompressed: 4102Downloaded: 4228 file(s) [attempted 4228/8639 = 48%, 318 KB/s], Decompressed: 4223Downloaded: 4347 file(s) [attempted 4347/8639 = 50%, 1365 KB/s], Decompressed: 4342Downloaded: 4467 file(s) [attempted 4467/8639 = 51%, 1638 KB/s], Decompressed: 4461Downloaded: 4587 file(s) [attempted 4587/8639 = 53%, 3084 KB/s], Decompressed: 4582Downloaded: 4695 file(s) [attempted 4695/8639 = 54%, 70 KB/s], Decompressed: 4692Downloaded: 4813 file(s) [attempted 4813/8639 = 55%, 896 KB/s], Decompressed: 4806Downloaded: 4941 file(s) [attempted 4941/8639 = 57%, 719 KB/s], Decompressed: 4939Downloaded: 5054 file(s) [attempted 5054/8639 = 58%, 164 KB/s], Decompressed: 5046Downloaded: 5166 file(s) [attempted 5166/8639 = 59%, 117 KB/s], Decompressed: 5163Downloaded: 5272 file(s) [attempted 5272/8639 = 61%, 842 KB/s], Decompressed: 5270Downloaded: 5387 file(s) [attempted 5387/8639 = 62%, 1407 KB/s], Decompressed: 5382Downloaded: 5491 file(s) [attempted 5491/8639 = 63%, 3325 KB/s], Decompressed: 5489Downloaded: 5608 file(s) [attempted 5608/8639 = 64%, 623 KB/s], Decompressed: 5603Downloaded: 5732 file(s) [attempted 5732/8639 = 66%, 796 KB/s], Decompressed: 5720Downloaded: 5850 file(s) [attempted 5850/8639 = 67%, 649 KB/s], Decompressed: 5841Downloaded: 5961 file(s) [attempted 5961/8639 = 69%, 558 KB/s], Decompressed: 5953Downloaded: 6072 file(s) [attempted 6072/8639 = 70%, 1096 KB/s], Decompressed: 6070Downloaded: 6200 file(s) [attempted 6200/8639 = 71%, 762 KB/s], Decompressed: 6195Downloaded: 6314 file(s) [attempted 6314/8639 = 73%, 140 KB/s], Decompressed: 6312Downloaded: 6432 file(s) [attempted 6432/8639 = 74%, 2573 KB/s], Decompressed: 6426Downloaded: 6547 file(s) [attempted 6547/8639 = 75%, 1082 KB/s], Decompressed: 6546Downloaded: 6672 file(s) [attempted 6672/8639 = 77%, 4795 KB/s], Decompressed: 6657Downloaded: 6785 file(s) [attempted 6785/8639 = 78%, 83 KB/s], Decompressed: 6783Downloaded: 6899 file(s) [attempted 6899/8639 = 79%, 458 KB/s], Decompressed: 6897Downloaded: 7018 file(s) [attempted 7018/8639 = 81%, 81 KB/s], Decompressed: 7016Downloaded: 7138 file(s) [attempted 7138/8639 = 82%, 493 KB/s], Decompressed: 7134Downloaded: 7261 file(s) [attempted 7261/8639 = 84%, 406 KB/s], Decompressed: 7256Downloaded: 7376 file(s) [attempted 7376/8639 = 85%, 995 KB/s], Decompressed: 7370Downloaded: 7491 file(s) [attempted 7491/8639 = 86%, 244 KB/s], Decompressed: 7489Downloaded: 7603 file(s) [attempted 7603/8639 = 88%, 410 KB/s], Decompressed: 7596Downloaded: 7732 file(s) [attempted 7732/8639 = 89%, 3963 KB/s], Decompressed: 7729Downloaded: 7844 file(s) [attempted 7844/8639 = 90%, 1418 KB/s], Decompressed: 7841Downloaded: 7958 file(s) [attempted 7958/8639 = 92%, 2451 KB/s], Decompressed: 7955Downloaded: 8069 file(s) [attempted 8069/8639 = 93%, 2578 KB/s], Decompressed: 8063Downloaded: 8193 file(s) [attempted 8193/8639 = 94%, 1877 KB/s], Decompressed: 8191Downloaded: 8310 file(s) [attempted 8310/8639 = 96%, 231 KB/s], Decompressed: 8307Downloaded: 8427 file(s) [attempted 8427/8639 = 97%, 1678 KB/s], Decompressed: 8422Downloaded: 8548 file(s) [attempted 8548/8639 = 98%, 2460 KB/s], Decompressed: 8543Downloaded: 8638 file(s) [attempted 8638/8639 = 99%, 439 KB/s], Decompressed: 8636Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 439 KB/s], Decompressed: 8636
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (423ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.MaxTerm (2.7s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.UltrametricSum (3.2s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (4.5s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (10s)
✔ [8661/8673] Built TateCurvesTheta.AnalyticQuotient (7.8s)
✔ [8662/8673] Built TateCurvesTheta.Analysis.Strassmann (5.3s)
✔ [8663/8675] Built Iut.Cor312.ThetaData.Places (8.1s)
✔ [8664/8675] Built TateCurvesTheta.QParameter.BaseChange (2.9s)
✔ [8665/8675] Built TateCurvesTheta.TateCurve.Weierstrass (3.9s)
✔ [8666/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (5.4s)
✔ [8667/8680] Built TateCurvesTheta.QParameter.PrimeToOrder (3.8s)
✔ [8668/8680] Built TateCurvesTheta.TateCurve.Discriminant (5.2s)
✔ [8669/8680] Built TateCurvesTheta.QParameter.NormalizedOrder (4.1s)
✔ [8670/8680] Built TateCurvesTheta.TateCurve.Parametrization (4.7s)
✔ [8671/8680] Built TateCurvesTheta.TateCurve.JInvariant (3.4s)
✔ [8672/8684] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (3.7s)
✔ [8673/8684] Built TateCurvesTheta.TateCurve.SplitReduction (5.1s)
✔ [8674/8692] Built Iut.Cor312.ThetaData.GlobalField (14s)
✔ [8675/8693] Built TateCurvesTheta.TateCurve.CoordinateExpansion (4.9s)
✔ [8676/8696] Built TateCurvesTheta.Theta.Basic (4.9s)
✔ [8677/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (5.9s)
✔ [8678/8696] Built TateCurvesTheta.QParameter.JParametrization (9.5s)
✔ [8679/8696] Built TateCurvesTheta.Theta.Periodicity (4.9s)
✔ [8680/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (9.2s)
✔ [8681/8699] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (10s)
✔ [8682/8705] Built TateCurvesTheta.QParameter.Characterization (4.0s)
✔ [8683/8708] Built TateCurvesTheta.Theta.Product (6.1s)
✔ [8684/8708] Built TateCurvesTheta.TateCurve.CoordinateInversion (5.9s)
✔ [8685/8708] Built TateCurvesTheta.Theta.QBinomial (7.7s)
✔ [8686/8708] Built TateCurvesTheta.TateCurve.EisensteinSeries (14s)
✔ [8687/8712] Built TateCurvesTheta.Theta.Divisor (5.7s)
✔ [8688/8713] Built TateCurvesTheta.Theta.Uniqueness (4.6s)
✔ [8689/8713] Built TateCurvesTheta.Theta.FactorSeries (4.9s)
✔ [8690/8713] Built TateCurvesTheta.TateCurve.IntegralModel (6.7s)
✔ [8691/8713] Built TateCurvesTheta.TateCurve.Quotient (8.0s)
✔ [8692/8715] Built TateCurvesTheta.Theta.LaurentSphere (5.4s)
✔ [8693/8715] Built TateCurvesTheta.TateCurve.SphereBounds (7.2s)
✔ [8694/8717] Built TateCurvesTheta.TateCurve.TatePointMem (3.5s)
✔ [8695/8718] Built TateCurvesTheta.Theta.LaurentSphereReduce (3.4s)
✔ [8696/8719] Built TateCurvesTheta.Theta.ThetaProdLaurent (5.0s)
✔ [8697/8720] Built TateCurvesTheta.Theta.FactorReciprocal (3.8s)
✔ [8698/8721] Built TateCurvesTheta.Theta.LaurentUnitSphere (3.5s)
✔ [8699/8721] Built TateCurvesTheta.TateCurve.PointMap (7.8s)
✔ [8700/8722] Built TateCurvesTheta.Theta.LaurentUnique (3.7s)
✔ [8701/8729] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (4.7s)
✔ [8702/8729] Built TateCurvesTheta.Theta.RatioAnnulus (3.0s)
✔ [8703/8729] Built TateCurvesTheta.Theta.SeriesZero (3.4s)
✔ [8704/8729] Built TateCurvesTheta.Theta.TripleProduct (3.9s)
✔ [8705/8729] Built TateCurvesTheta.Theta.Normalization (3.6s)
✔ [8706/8729] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (3.9s)
✔ [8707/8731] Built TateCurvesTheta.Theta.StrictDominant (7.3s)
✔ [8708/8733] Built TateCurvesTheta.Theta.Durfee (5.8s)
✔ [8709/8733] Built TateCurvesTheta.Uniformization (9.8s)
✔ [8710/8733] Built Iut.Cor312.Procession (9.3s)
✔ [8711/8733] Built TateCurvesTheta.Theta.Inversion (5.3s)
✔ [8712/8735] Built Iut.Cor312.RationalPlace (9.5s)
✔ [8713/8763] Built TateCurvesTheta.Theta.WeightSpace (15s)
✔ [8714/8763] Built Iut.Cor312.PacketPresentation (11s)
✔ [8715/8763] Built IUTThreeClosures.ABCStatement (4.4s)
✖ [8716/8763] Building IUTThreeClosures.HonestFinitePositiveLogVolume (10s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/HonestFinitePositiveLogVolume.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/HonestFinitePositiveLogVolume.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/HonestFinitePositiveLogVolume.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/HonestFinitePositiveLogVolume.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/HonestFinitePositiveLogVolume.setup.json --json
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:29:31: expected token
error: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:37:2: `coe_injective'` is not a field of structure `SetLike`
error: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:35:48: Fields missing: `coe_injective`
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:54:8: declaration uses `sorry`
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:60:8: declaration uses `sorry`
error: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:118:8: Tactic `rfl` failed: The left-hand side
  f (f^[n] ↑U)
is not definitionally equal to the right-hand side
  f^[n + 1] ↑U

case refine_1
α : Type u
inst✝ : MeasurableSpace α
μ : Measure α
f : Set α → Set α
a : ℝ
F : ScalingLaw f a
n : ℕ
G : ScalingLaw f^[n] (↑n * a) := iterate F n
U : FinitePositiveRegion α μ
⊢ f (f^[n] ↑U) = f^[n + 1] ↑U
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:126:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
error: Lean exited with code 1
✔ [8718/8781] Built IUTThreeClosures.FullPolyCore (10s)
⚠ [8720/8781] Built IUTThreeClosures.Cor312CoefficientAlgebra (10s)
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
✔ [8721/8781] Built Iut.Cor312.HolomorphicHull (10s)
✔ [8722/8781] Built Iut.Cor312.Container (9.3s)
✔ [8723/8781] Built IUTThreeClosures.WeakCompatibilityCountermodel (7.6s)
✔ [8724/8781] Built TateCurvesTheta.Theta.PuncturedProduct (50s)
✔ [8725/8781] Built Heights.WeilHeight (10s)
⚠ [8726/8781] Built IUTThreeClosures.ExplicitSemistableCurve (7.7s)
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:95:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8727/8781] Built IUTThreeClosures.SolvableRestrictionImage (6.8s)
warning: IUTThreeClosures/SolvableRestrictionImage.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/SolvableRestrictionImage.lean:121:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8728/8781] Built IUTThreeClosures.QPilotNormalizationAudit (6.7s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8729/8781] Built IUTThreeClosures.RootQPilotDivisor (7.3s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8730/8781] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (6.3s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8731/8781] Built IUTThreeClosures.RamificationCorrectedQPilot (6.0s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8732/8781] Built IUTThreeClosures.ProductWeightMarginalization (7.0s)
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
⚠ [8734/8781] Built IUTThreeClosures.AdmissiblePrimeSelection (6.5s)
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:104:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8735/8781] Built IUTThreeClosures.FiniteExceptionalSet (6.5s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8736/8781] Built IUTThreeClosures.GeneratedUnionCompactness (6.1s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8737/8781] Built Iut.Cor312.LogVolume (6.7s)
✔ [8738/8792] Built Iut.Cor312.ContainerHull (6.1s)
⚠ [8740/8796] Built IUTThreeClosures.ZModSL2Perfect (6.2s)
warning: IUTThreeClosures/ZModSL2Perfect.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZModSL2Perfect.lean:62:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8741/8796] Built Genl.Mathlib.Order.BoundedDiscrepancy (2.8s)
⚠ [8742/8796] Built IUTThreeClosures.QPilotNormalizationFork (6.2s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8743/8796] Built IUTThreeClosures.PrimePowerQPilotRegion (6.8s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8744/8796] Built IUTThreeClosures.TateParameterUnitBallRegion (3.2s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8745/8796] Built TateCurvesTheta.TateCurve.DefectVanishing (102s)
⚠ [8746/8796] Built IUTThreeClosures.FiniteExponentHull (6.4s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8747/8796] Built IUTThreeClosures.StandardZeroLabel (6.2s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8748/8796] Built IUTThreeClosures.BarycentricPacketReading (6.2s)
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
⚠ [8749/8796] Built IUTThreeClosures.DiagonalPacketNoGo (5.0s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8750/8796] Built Genl.GeneralPosition.HeightTheory (1.9s)
⚠ [8751/8796] Built IUTThreeClosures.PublicNormalizationObstruction (6.0s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8752/8796] Built Iut4Sec1.Global.ArithmeticDivisor (6.4s)
⚠ [8753/8796] Built IUTThreeClosures.IUTIVAbsorption (9.2s)
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
✖ [8754/8796] Building IUTThreeClosures.DistinguishedLabelQPilot (7.6s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/DistinguishedLabelQPilot.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/DistinguishedLabelQPilot.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/DistinguishedLabelQPilot.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/DistinguishedLabelQPilot.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/DistinguishedLabelQPilot.setup.json --json
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/DistinguishedLabelQPilot.lean:46:2: Type mismatch
  IUTThreeClosures.product_weight_marginal j₀ (vol.weight (RationalPlace.finite p)) (fun v ↦ -↑(order v) * Real.log ↑↑p)
    (vol.weight_sum_one (RationalPlace.finite p))
has type
  ∑ c ∈ @Finset.univ ((D.proc.capsule i).LabelType → D.Fiber (RationalPlace.finite p)) Pi.instFintype,
      (∏ j, vol.weight (RationalPlace.finite p) (c j)) * (-↑(order (c j₀)) * Real.log ↑↑p) =
    ∑ v, vol.weight (RationalPlace.finite p) v * (-↑(order v) * Real.log ↑↑p)
but is expected to have type
  ∑
      c ∈
        @Finset.univ ((D.proc.capsule i).LabelType → D.Fiber (RationalPlace.finite p))
          (D.instFintypeComponents i (RationalPlace.finite p)),
      (∏ j, vol.weight (RationalPlace.finite p) (c j)) * (-↑(order (c j₀)) * Real.log ↑↑p) =
    ∑ v, vol.weight (RationalPlace.finite p) v * (-↑(order v) * Real.log ↑↑p)
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:52:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
error: Lean exited with code 1
✔ [8755/8796] Built TateCurvesTheta.TateCurve.TatePointOnCurve (6.8s)
⚠ [8756/8796] Built IUTThreeClosures.ZeroLabelBarycentric (6.6s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
⚠ [8757/8796] Built IUTThreeClosures.StatementIIOutsideFinite (7.2s)
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
✔ [8758/8796] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (8.9s)
✔ [8759/8796] Built TateCurvesTheta.TateCurve.AdditionLaw (11s)
✔ [8760/8796] Built TateCurvesTheta.TateCurve.LargePointParametrization (14s)
✔ [8761/8796] Built TateCurvesTheta.TateCurve.AbelStep (6.5s)
✔ [8762/8796] Built TateCurvesTheta.TateCurve.GroupLaw (11s)
✔ [8763/8796] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (24s)
✔ [8764/8796] Built TateCurvesTheta.TateCurve.SurjectivitySphere (27s)
✔ [8765/8796] Built TateCurvesTheta.TateCurve.TateUniformization (4.4s)
✔ [8766/8796] Built TateCurvesTheta (3.6s)
✔ [8767/8796] Built Iut.Cor312.ThetaData.AdmissiblePrime (4.8s)
✔ [8768/8796] Built Iut.Cor312.ThetaData.Orbicurve (4.6s)
✔ [8769/8796] Built Iut.Cor312.ThetaData.LocalConditions (7.9s)
✔ [8770/8796] Built Iut.Cor312.ThetaData.Basic (4.6s)
✔ [8771/8796] Built Iut.Cor312.LeftHandSide (4.1s)
✔ [8772/8796] Built Iut.Cor312.RightHandSide (4.3s)
✔ [8773/8796] Built Iut.Cor312.Statement (4.1s)
⚠ [8774/8796] Built IUTThreeClosures.NativeQPilotCalibration (5.9s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8775/8796] Built IUTThreeClosures.CorrectedQPilotDivisor (6.1s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8776/8796] Built IUTThreeClosures.ActualPilotWitness (4.4s)
✔ [8777/8796] Built IUTThreeClosures.GeneratedSource (4.5s)
✔ [8778/8796] Built IUTThreeClosures.QuantifierCorrectClosure (4.1s)
⚠ [8779/8796] Built IUTThreeClosures.PublicLogVolumeInconsistency (4.3s)
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:71:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8780/8796] Built IUTThreeClosures.ABCClosure (3.0s)
✔ [8781/8796] Built IUTThreeClosures.ThreeClosureTheorems (3.0s)
✔ [8782/8796] Built IUTThreeClosures.InhabitationBoundary (4.1s)
✔ [8783/8796] Built IUTThreeClosures.CircularityAudit (4.1s)
✔ [8784/8796] Built IUTThreeClosures.NonCircularDownstream (5.2s)
✔ [8785/8796] Built IUTThreeClosures.FourOpenConstructions (4.2s)
⚠ [8786/8796] Built IUTThreeClosures.ABCPointLegendreCurve (4.6s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✖ [8787/8796] Building IUTThreeClosures.LegendreArithmetic (4.5s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/LegendreArithmetic.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/LegendreArithmetic.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/LegendreArithmetic.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/LegendreArithmetic.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/LegendreArithmetic.setup.json --json
warning: IUTThreeClosures/LegendreArithmetic.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/LegendreArithmetic.lean:59:2: linarith failed to find a contradiction
case h1
P : ABCPoint
hc : ↑P.c ≠ 0
hsum : ↑P.a + ↑P.b = ↑P.c
a✝ : ↑P.c * (↑P.c - ↑P.a) + ↑P.a ^ 2 < ↑(P.a ^ 2 + P.a * P.b + P.b ^ 2)
⊢ False
failed
error: IUTThreeClosures/LegendreArithmetic.lean:131:21: Tactic `rewrite` failed: Did not find an occurrence of the pattern
  1 - P.lambda
in the target expression
  256 * (↑P.legendreCore / ↑P.c ^ 2) ^ 3 / ((↑P.a / ↑P.c) ^ 2 * (1 - ↑P.a / ↑P.c) ^ 2) =
    256 * ↑P.legendreCore ^ 3 / (↑P.a ^ 2 * ↑P.b ^ 2 * ↑P.c ^ 2)

P : ABCPoint
⊢ 256 * (↑P.legendreCore / ↑P.c ^ 2) ^ 3 / ((↑P.a / ↑P.c) ^ 2 * (1 - ↑P.a / ↑P.c) ^ 2) =
    256 * ↑P.legendreCore ^ 3 / (↑P.a ^ 2 * ↑P.b ^ 2 * ↑P.c ^ 2)
warning: IUTThreeClosures/LegendreArithmetic.lean:138:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
error: Lean exited with code 1
⚠ [8790/8796] Built IUTThreeClosures.BridgeInhabitationAudit (5.0s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
✔ [8791/8796] Built IUTThreeClosures.BridgeInhabitationExact (3.0s)
⚠ [8792/8796] Built IUTThreeClosures.CanonicalQPilotCorridor (4.0s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8793/8796] Built IUTThreeClosures.CanonicalCorridorAudit (4.1s)
⚠ [8794/8796] Built IUTThreeClosures.SourceDerivedIUTIVBridge (5.1s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
Some required targets logged failures:
- IUTThreeClosures.HonestFinitePositiveLogVolume
- IUTThreeClosures.DistinguishedLabelQPilot
- IUTThreeClosures.LegendreArithmetic
error: build failed
```
