# Lean CI result

- Tested commit: `88708ac8bf5152f2d6bbbc977d08ae03d9645955`
- Lean setup: `success`
- Dependency resolution/cache: `success`
- `lake build`: `success`

## Error summary

```text
===== lean-dependencies.log =====
===== lean-build.log =====
```

## Dependency log tail

```text
info: heights: cloning https://github.com/lana-agents/heights.git
info: heights: checking out revision '3539e2a12dd3470c057a4eb531dc3fd627d4c97b'
info: genl: cloning https://github.com/LANA-Project/genl.git
info: genl: checking out revision '6e9a6543b46a2a02fd7fe7ec8ab203d878f32859'
info: iut: cloning https://github.com/lana-agents/iut.git
info: iut: checking out revision 'ddaddc274281adb5674d647e24fa478745ac6d40'
info: toolchain not updated; already up-to-date
info: mathlib: cloning https://github.com/leanprover-community/mathlib4
info: mathlib: checking out revision '81a5d257c8e410db227a6665ed08f64fea08e997'
info: tate-curves-theta: cloning https://github.com/lana-agents/tate-curves-theta
info: tate-curves-theta: checking out revision '90d7fac0e4ef2d6bf2a619326c30adb862d1b3de'
info: plausible: cloning https://github.com/leanprover-community/plausible
info: plausible: checking out revision 'e12c1910fe855cbfc38803cd4e55543906d5fa62'
info: LeanSearchClient: cloning https://github.com/leanprover-community/LeanSearchClient
info: LeanSearchClient: checking out revision 'c5d5b8fe6e5158def25cd28eb94e4141ad97c843'
info: importGraph: cloning https://github.com/leanprover-community/import-graph
info: importGraph: checking out revision '7e9612bf0b9ee66db3cb5b9988a35afc706f5a12'
info: proofwidgets: cloning https://github.com/leanprover-community/ProofWidgets4
info: proofwidgets: checking out revision '6e311e2a844da9b2cc3971187df2fe0066947b93'
info: aesop: cloning https://github.com/leanprover-community/aesop
info: aesop: checking out revision 'a7dbf0c63b694e47f425f3dcddbc0e178bb432d3'
info: Qq: cloning https://github.com/leanprover-community/quote4
info: Qq: checking out revision '38d591e778f100aec9762bb582f9c7f55f50e9dc'
info: batteries: cloning https://github.com/leanprover-community/batteries
info: batteries: checking out revision '023ce7d62a0531e22a5331e20b587817a80d49ff'
info: formal-schemes: cloning https://github.com/lana-agents/formal-schemes
info: formal-schemes: checking out revision '51aa935079537bf4dc580751a6e70727fb23ca93'
info: Cli: cloning https://github.com/leanprover/lean4-cli
info: Cli: checking out revision '88679d088c9720c27ebdf2ba4dafe17341747f94'
info: mathlib: running post-update hooks
✔ [2/6] Built Cache.Cli (275ms)
✔ [3/6] Built Cache.Lean (315ms)
✔ [9/27] Built Cache.Cli:c.o (130ms)
✔ [10/27] Built Cache.Lean:c.o (158ms)
✔ [11/27] Built Cache.Infra (394ms)
✔ [12/27] Built Cache.Infra:c.o (170ms)
✔ [13/27] Built Cache.IO (1.2s)
✔ [14/27] Built Cache.Hashing (582ms)
✔ [15/27] Built Cache.Hashing:c.o (352ms)
✔ [16/27] Built Cache.IO:c.o (1.4s)
✔ [17/27] Built Cache.Requests (1.7s)
✔ [18/27] Built Cache.Marker (407ms)
✔ [19/27] Built Cache.Marker:c.o (133ms)
✔ [20/27] Built Cache.Query (539ms)
✔ [21/27] Built Cache.Query:c.o (321ms)
✔ [22/27] Built Cache.Warning (597ms)
✔ [23/27] Built Cache.Warning:c.o (207ms)
✔ [24/27] Built Cache.Requests:c.o (2.4s)
✔ [25/27] Built Cache.Main (1.5s)
✔ [26/27] Built Cache.Main:c.o (716ms)
✔ [27/27] Built cache:exe (545ms)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
Attempting to download 8639 file(s) from leanprover-community/mathlib4 cache at https://lakecache.blob.core.windows.net/mathlib4-master
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 15 KB/s], Decompressed: 0Downloaded: 70 file(s) [attempted 70/8639 = 0%, 80 KB/s], Decompressed: 38Downloaded: 148 file(s) [attempted 148/8639 = 1%, 1411 KB/s], Decompressed: 65Downloaded: 236 file(s) [attempted 236/8639 = 2%, 736 KB/s], Decompressed: 113Downloaded: 325 file(s) [attempted 325/8639 = 3%, 301 KB/s], Decompressed: 113Downloaded: 418 file(s) [attempted 418/8639 = 4%, 153 KB/s], Decompressed: 113Downloaded: 516 file(s) [attempted 516/8639 = 5%, 1778 KB/s], Decompressed: 227Downloaded: 614 file(s) [attempted 614/8639 = 7%, 560 KB/s], Decompressed: 227Downloaded: 719 file(s) [attempted 719/8639 = 8%, 2528 KB/s], Decompressed: 227Downloaded: 822 file(s) [attempted 822/8639 = 9%, 368 KB/s], Decompressed: 227Downloaded: 923 file(s) [attempted 923/8639 = 10%, 1792 KB/s], Decompressed: 227Downloaded: 1025 file(s) [attempted 1025/8639 = 11%, 398 KB/s], Decompressed: 227Downloaded: 1130 file(s) [attempted 1130/8639 = 13%, 2665 KB/s], Decompressed: 227Downloaded: 1235 file(s) [attempted 1235/8639 = 14%, 851 KB/s], Decompressed: 493Downloaded: 1335 file(s) [attempted 1335/8639 = 15%, 64 KB/s], Decompressed: 493Downloaded: 1433 file(s) [attempted 1433/8639 = 16%, 351 KB/s], Decompressed: 493Downloaded: 1531 file(s) [attempted 1531/8639 = 17%, 2238 KB/s], Decompressed: 493Downloaded: 1631 file(s) [attempted 1631/8639 = 18%, 889 KB/s], Decompressed: 493Downloaded: 1741 file(s) [attempted 1741/8639 = 20%, 465 KB/s], Decompressed: 493Downloaded: 1846 file(s) [attempted 1846/8639 = 21%, 445 KB/s], Decompressed: 493Downloaded: 1946 file(s) [attempted 1946/8639 = 22%, 1473 KB/s], Decompressed: 493Downloaded: 2039 file(s) [attempted 2039/8639 = 23%, 2263 KB/s], Decompressed: 493Downloaded: 2146 file(s) [attempted 2146/8639 = 24%, 365 KB/s], Decompressed: 493Downloaded: 2228 file(s) [attempted 2228/8639 = 25%, 870 KB/s], Decompressed: 493Downloaded: 2328 file(s) [attempted 2328/8639 = 26%, 1131 KB/s], Decompressed: 493Downloaded: 2401 file(s) [attempted 2401/8639 = 27%, 2330 KB/s], Decompressed: 493Downloaded: 2501 file(s) [attempted 2501/8639 = 28%, 791 KB/s], Decompressed: 493Downloaded: 2608 file(s) [attempted 2608/8639 = 30%, 1114 KB/s], Decompressed: 493Downloaded: 2711 file(s) [attempted 2711/8639 = 31%, 149 KB/s], Decompressed: 493Downloaded: 2813 file(s) [attempted 2813/8639 = 32%, 1823 KB/s], Decompressed: 493Downloaded: 2930 file(s) [attempted 2930/8639 = 33%, 2694 KB/s], Decompressed: 1184Downloaded: 3039 file(s) [attempted 3039/8639 = 35%, 664 KB/s], Decompressed: 1184Downloaded: 3142 file(s) [attempted 3142/8639 = 36%, 629 KB/s], Decompressed: 1184Downloaded: 3240 file(s) [attempted 3240/8639 = 37%, 1093 KB/s], Decompressed: 1184Downloaded: 3340 file(s) [attempted 3340/8639 = 38%, 1110 KB/s], Decompressed: 1184Downloaded: 3431 file(s) [attempted 3431/8639 = 39%, 148 KB/s], Decompressed: 1184Downloaded: 3531 file(s) [attempted 3531/8639 = 40%, 854 KB/s], Decompressed: 1184Downloaded: 3638 file(s) [attempted 3638/8639 = 42%, 535 KB/s], Decompressed: 1184Downloaded: 3748 file(s) [attempted 3748/8639 = 43%, 1003 KB/s], Decompressed: 1184Downloaded: 3856 file(s) [attempted 3856/8639 = 44%, 891 KB/s], Decompressed: 1184Downloaded: 3962 file(s) [attempted 3962/8639 = 45%, 654 KB/s], Decompressed: 1184Downloaded: 4070 file(s) [attempted 4070/8639 = 47%, 4326 KB/s], Decompressed: 1184Downloaded: 4163 file(s) [attempted 4163/8639 = 48%, 793 KB/s], Decompressed: 1184Downloaded: 4265 file(s) [attempted 4265/8639 = 49%, 807 KB/s], Decompressed: 1184Downloaded: 4356 file(s) [attempted 4356/8639 = 50%, 1060 KB/s], Decompressed: 1184Downloaded: 4478 file(s) [attempted 4478/8639 = 51%, 553 KB/s], Decompressed: 1184Downloaded: 4582 file(s) [attempted 4582/8639 = 53%, 699 KB/s], Decompressed: 1184Downloaded: 4616 file(s) [attempted 4616/8639 = 53%, 152 KB/s], Decompressed: 1184Downloaded: 4722 file(s) [attempted 4722/8639 = 54%, 2553 KB/s], Decompressed: 1184Downloaded: 4834 file(s) [attempted 4834/8639 = 55%, 185 KB/s], Decompressed: 1184Downloaded: 4946 file(s) [attempted 4946/8639 = 57%, 62 KB/s], Decompressed: 1184Downloaded: 5049 file(s) [attempted 5049/8639 = 58%, 154 KB/s], Decompressed: 1184Downloaded: 5156 file(s) [attempted 5156/8639 = 59%, 158 KB/s], Decompressed: 1184Downloaded: 5256 file(s) [attempted 5256/8639 = 60%, 846 KB/s], Decompressed: 1184Downloaded: 5356 file(s) [attempted 5356/8639 = 61%, 804 KB/s], Decompressed: 1184Downloaded: 5461 file(s) [attempted 5461/8639 = 63%, 1885 KB/s], Decompressed: 1184Downloaded: 5566 file(s) [attempted 5566/8639 = 64%, 629 KB/s], Decompressed: 1184Downloaded: 5673 file(s) [attempted 5673/8639 = 65%, 4508 KB/s], Decompressed: 1184Downloaded: 5776 file(s) [attempted 5776/8639 = 66%, 1528 KB/s], Decompressed: 1184Downloaded: 5876 file(s) [attempted 5876/8639 = 68%, 859 KB/s], Decompressed: 1184Downloaded: 5981 file(s) [attempted 5981/8639 = 69%, 665 KB/s], Decompressed: 1184Downloaded: 6093 file(s) [attempted 6093/8639 = 70%, 1619 KB/s], Decompressed: 1184Downloaded: 6196 file(s) [attempted 6196/8639 = 71%, 690 KB/s], Decompressed: 1184Downloaded: 6301 file(s) [attempted 6301/8639 = 72%, 376 KB/s], Decompressed: 1184Downloaded: 6401 file(s) [attempted 6401/8639 = 74%, 684 KB/s], Decompressed: 1184Downloaded: 6459 file(s) [attempted 6459/8639 = 74%, 2665 KB/s], Decompressed: 1184Downloaded: 6557 file(s) [attempted 6557/8639 = 75%, 475 KB/s], Decompressed: 1184Downloaded: 6657 file(s) [attempted 6657/8639 = 77%, 684 KB/s], Decompressed: 1184Downloaded: 6762 file(s) [attempted 6762/8639 = 78%, 1706 KB/s], Decompressed: 1184Downloaded: 6871 file(s) [attempted 6871/8639 = 79%, 978 KB/s], Decompressed: 1184Downloaded: 6972 file(s) [attempted 6972/8639 = 80%, 411 KB/s], Decompressed: 1184Downloaded: 7081 file(s) [attempted 7081/8639 = 81%, 75 KB/s], Decompressed: 1184Downloaded: 7186 file(s) [attempted 7186/8639 = 83%, 112 KB/s], Decompressed: 1184Downloaded: 7287 file(s) [attempted 7287/8639 = 84%, 244 KB/s], Decompressed: 1184Downloaded: 7394 file(s) [attempted 7394/8639 = 85%, 4646 KB/s], Decompressed: 1184Downloaded: 7499 file(s) [attempted 7499/8639 = 86%, 933 KB/s], Decompressed: 2883Downloaded: 7601 file(s) [attempted 7601/8639 = 87%, 223 KB/s], Decompressed: 2883Downloaded: 7706 file(s) [attempted 7706/8639 = 89%, 348 KB/s], Decompressed: 2883Downloaded: 7815 file(s) [attempted 7815/8639 = 90%, 580 KB/s], Decompressed: 2883Downloaded: 7918 file(s) [attempted 7918/8639 = 91%, 508 KB/s], Decompressed: 2883Downloaded: 8023 file(s) [attempted 8023/8639 = 92%, 306 KB/s], Decompressed: 2883Downloaded: 8128 file(s) [attempted 8128/8639 = 94%, 528 KB/s], Decompressed: 2883Downloaded: 8235 file(s) [attempted 8235/8639 = 95%, 428 KB/s], Decompressed: 2883Downloaded: 8289 file(s) [attempted 8289/8639 = 95%, 1076 KB/s], Decompressed: 2883Downloaded: 8389 file(s) [attempted 8389/8639 = 97%, 324 KB/s], Decompressed: 2883Downloaded: 8510 file(s) [attempted 8510/8639 = 98%, 156 KB/s], Decompressed: 2883Downloaded: 8615 file(s) [attempted 8615/8639 = 99%, 382 KB/s], Decompressed: 2883Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 382 KB/s], Decompressed: 2883
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (301ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.UltrametricSum (2.4s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.MaxTerm (2.6s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (2.6s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (5.9s)
✔ [8661/8667] Built TateCurvesTheta.Analysis.Strassmann (3.6s)
✔ [8662/8673] Built TateCurvesTheta.QParameter.BaseChange (2.4s)
✔ [8663/8673] Built Iut.Cor312.ThetaData.Places (5.0s)
✔ [8664/8675] Built TateCurvesTheta.AnalyticQuotient (6.6s)
✔ [8665/8675] Built TateCurvesTheta.TateCurve.Weierstrass (2.8s)
✔ [8666/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (3.0s)
✔ [8667/8680] Built TateCurvesTheta.QParameter.PrimeToOrder (2.6s)
✔ [8668/8684] Built TateCurvesTheta.QParameter.NormalizedOrder (2.6s)
✔ [8669/8689] Built TateCurvesTheta.TateCurve.Discriminant (3.4s)
✔ [8670/8689] Built TateCurvesTheta.TateCurve.Parametrization (3.3s)
✔ [8671/8691] Built TateCurvesTheta.Theta.Basic (2.4s)
✔ [8672/8691] Built TateCurvesTheta.TateCurve.JInvariant (2.1s)
✔ [8673/8691] Built TateCurvesTheta.TateCurve.SplitReduction (3.0s)
✔ [8674/8692] Built Iut.Cor312.ThetaData.GlobalField (9.9s)
✔ [8675/8692] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (2.2s)
✔ [8676/8696] Built TateCurvesTheta.TateCurve.CoordinateExpansion (2.8s)
✔ [8677/8696] Built TateCurvesTheta.Theta.Periodicity (2.2s)
✔ [8678/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (3.6s)
✔ [8679/8696] Built TateCurvesTheta.QParameter.JParametrization (7.3s)
✔ [8680/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (6.6s)
✔ [8681/8704] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (7.1s)
✔ [8682/8705] Built TateCurvesTheta.Theta.Product (5.1s)
✔ [8683/8705] Built TateCurvesTheta.QParameter.Characterization (2.1s)
✔ [8684/8705] Built TateCurvesTheta.Theta.QBinomial (4.1s)
✔ [8685/8705] Built TateCurvesTheta.Theta.Divisor (3.0s)
✔ [8686/8708] Built TateCurvesTheta.Theta.Uniqueness (4.7s)
✔ [8687/8708] Built TateCurvesTheta.TateCurve.CoordinateInversion (4.0s)
✔ [8688/8708] Built TateCurvesTheta.Theta.FactorSeries (4.7s)
✔ [8689/8708] Built TateCurvesTheta.TateCurve.EisensteinSeries (9.3s)
✔ [8690/8711] Built TateCurvesTheta.Theta.LaurentSphere (3.5s)
✔ [8691/8712] Built TateCurvesTheta.TateCurve.TatePointMem (2.4s)
✔ [8692/8713] Built TateCurvesTheta.Theta.ThetaProdLaurent (3.5s)
✔ [8693/8714] Built TateCurvesTheta.Theta.LaurentSphereReduce (2.5s)
✔ [8694/8715] Built TateCurvesTheta.TateCurve.Quotient (4.8s)
✔ [8695/8716] Built TateCurvesTheta.TateCurve.IntegralModel (3.6s)
✔ [8696/8717] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (3.7s)
✔ [8697/8717] Built TateCurvesTheta.Theta.LaurentUnitSphere (3.2s)
✔ [8698/8718] Built TateCurvesTheta.TateCurve.SphereBounds (4.0s)
✔ [8699/8719] Built TateCurvesTheta.Theta.FactorReciprocal (2.5s)
✔ [8700/8719] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (2.7s)
✔ [8701/8720] Built TateCurvesTheta.TateCurve.PointMap (6.8s)
✔ [8702/8721] Built TateCurvesTheta.Theta.Normalization (2.0s)
✔ [8703/8722] Built TateCurvesTheta.Theta.LaurentUnique (4.4s)
✔ [8704/8729] Built TateCurvesTheta.Theta.SeriesZero (2.5s)
✔ [8705/8729] Built TateCurvesTheta.Theta.RatioAnnulus (4.3s)
✔ [8706/8729] Built TateCurvesTheta.Theta.TripleProduct (2.9s)
✔ [8707/8729] Built TateCurvesTheta.Theta.Durfee (4.7s)
✔ [8708/8729] Built TateCurvesTheta.Theta.StrictDominant (5.9s)
✔ [8709/8729] Built TateCurvesTheta.Theta.Inversion (2.7s)
✔ [8710/8731] Built TateCurvesTheta.Uniformization (5.9s)
✔ [8711/8733] Built TateCurvesTheta.Theta.WeightSpace (11s)
✔ [8712/8735] Built Iut.Cor312.Procession (8.5s)
✔ [8713/8765] Built Iut.Cor312.RationalPlace (5.7s)
✔ [8714/8765] Built Iut.Cor312.PacketPresentation (5.7s)
✔ [8715/8765] Built IUTThreeClosures.ABCStatement (1.8s)
⚠ [8716/8765] Built IUTThreeClosures.HonestFinitePositiveLogVolume (6.8s)
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:126:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8717/8765] Built IUTThreeClosures.FullPolyCore (5.6s)
⚠ [8719/8786] Built IUTThreeClosures.Cor312CoefficientAlgebra (5.2s)
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
✔ [8720/8786] Built Iut.Cor312.Container (4.8s)
✔ [8721/8786] Built Iut.Cor312.HolomorphicHull (5.3s)
⚠ [8722/8786] Built IUTThreeClosures.HonestPilotWitness (5.0s)
warning: IUTThreeClosures/HonestPilotWitness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestPilotWitness.lean:86:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8723/8786] Built TateCurvesTheta.Theta.PuncturedProduct (36s)
✔ [8724/8786] Built IUTThreeClosures.WeakCompatibilityCountermodel (4.4s)
✔ [8725/8786] Built Heights.WeilHeight (6.2s)
⚠ [8726/8786] Built IUTThreeClosures.ExplicitSemistableCurve (4.7s)
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:95:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8727/8786] Built IUTThreeClosures.SolvableRestrictionImage (5.4s)
warning: IUTThreeClosures/SolvableRestrictionImage.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/SolvableRestrictionImage.lean:121:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8728/8786] Built IUTThreeClosures.QPilotNormalizationAudit (4.8s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8729/8786] Built IUTThreeClosures.RootQPilotDivisor (4.7s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8730/8786] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (4.6s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8731/8786] Built IUTThreeClosures.RamificationCorrectedQPilot (4.9s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8732/8786] Built IUTThreeClosures.ProductWeightMarginalization (5.4s)
warning: IUTThreeClosures/ProductWeightMarginalization.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ProductWeightMarginalization.lean:41:0: `sum_product_weights_eq_one` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
warning: IUTThreeClosures/ProductWeightMarginalization.lean:50:0: `product_weight_marginal` does not use the following hypotheses in its type:
  • [DecidableEq L] (#4)
  • [DecidableEq V] (#6)

Consider removing these hypotheses and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
warning: IUTThreeClosures/ProductWeightMarginalization.lean:105:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8734/8786] Built IUTThreeClosures.AdmissiblePrimeSelection (4.7s)
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:104:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8735/8786] Built IUTThreeClosures.FiniteExceptionalSet (4.4s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8736/8786] Built IUTThreeClosures.GeneratedUnionCompactness (4.3s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8737/8786] Built TateCurvesTheta.TateCurve.DefectVanishing (70s)
✔ [8738/8786] Built Iut.Cor312.LogVolume (4.8s)
✔ [8739/8797] Built Iut.Cor312.ContainerHull (4.5s)
⚠ [8741/8801] Built IUTThreeClosures.HonestGeneratedSource (4.4s)
warning: IUTThreeClosures/HonestGeneratedSource.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8742/8801] Built IUTThreeClosures.ZModSL2Perfect (4.4s)
warning: IUTThreeClosures/ZModSL2Perfect.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZModSL2Perfect.lean:62:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8743/8801] Built IUTThreeClosures.QPilotNormalizationFork (4.2s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8744/8801] Built Genl.Mathlib.Order.BoundedDiscrepancy (2.3s)
⚠ [8745/8801] Built IUTThreeClosures.TateParameterUnitBallRegion (2.8s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8746/8801] Built TateCurvesTheta.TateCurve.TatePointOnCurve (5.1s)
⚠ [8747/8801] Built IUTThreeClosures.PrimePowerQPilotRegion (5.5s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8748/8801] Built IUTThreeClosures.FiniteExponentHull (4.4s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8749/8801] Built IUTThreeClosures.StandardZeroLabel (4.3s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8750/8801] Built IUTThreeClosures.BarycentricPacketReading (4.3s)
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
⚠ [8751/8801] Built IUTThreeClosures.DiagonalPacketNoGo (4.3s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8752/8801] Built Genl.GeneralPosition.HeightTheory (1.3s)
✔ [8753/8801] Built Iut4Sec1.Global.ArithmeticDivisor (4.4s)
⚠ [8754/8801] Built IUTThreeClosures.PublicNormalizationObstruction (4.7s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8755/8801] Built IUTThreeClosures.IUTIVAbsorption (6.4s)
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
✔ [8756/8801] Built TateCurvesTheta.TateCurve.AdditionLaw (8.6s)
✔ [8757/8801] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (6.8s)
⚠ [8758/8801] Built IUTThreeClosures.DistinguishedLabelQPilot (7.0s)
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:52:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8759/8801] Built TateCurvesTheta.TateCurve.LargePointParametrization (10s)
⚠ [8760/8801] Built IUTThreeClosures.ZeroLabelBarycentric (4.4s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
⚠ [8761/8801] Built IUTThreeClosures.StatementIIOutsideFinite (4.8s)
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
✔ [8762/8801] Built TateCurvesTheta.TateCurve.AbelStep (5.2s)
✔ [8763/8801] Built TateCurvesTheta.TateCurve.GroupLaw (7.8s)
✔ [8764/8801] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (16s)
✔ [8765/8801] Built TateCurvesTheta.TateCurve.SurjectivitySphere (18s)
✔ [8766/8801] Built TateCurvesTheta.TateCurve.TateUniformization (3.1s)
✔ [8767/8801] Built TateCurvesTheta (2.5s)
✔ [8768/8801] Built Iut.Cor312.ThetaData.AdmissiblePrime (3.5s)
✔ [8769/8801] Built Iut.Cor312.ThetaData.Orbicurve (3.4s)
✔ [8770/8801] Built Iut.Cor312.ThetaData.LocalConditions (5.6s)
✔ [8771/8801] Built Iut.Cor312.ThetaData.Basic (3.2s)
✔ [8772/8801] Built Iut.Cor312.LeftHandSide (2.9s)
✔ [8773/8801] Built Iut.Cor312.RightHandSide (3.0s)
⚠ [8774/8801] Built IUTThreeClosures.NativeQPilotCalibration (3.1s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8775/8801] Built Iut.Cor312.Statement (3.7s)
⚠ [8776/8801] Built IUTThreeClosures.CorrectedQPilotDivisor (3.9s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8777/8801] Built IUTThreeClosures.ActualPilotWitness (2.8s)
✔ [8778/8801] Built IUTThreeClosures.GeneratedSource (3.2s)
✔ [8779/8801] Built IUTThreeClosures.QuantifierCorrectClosure (2.8s)
✔ [8780/8801] Built IUTThreeClosures.ABCClosure (2.9s)
⚠ [8781/8801] Built IUTThreeClosures.PublicLogVolumeInconsistency (3.2s)
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8782/8801] Built IUTThreeClosures.ThreeClosureTheorems (2.8s)
✔ [8783/8801] Built IUTThreeClosures.InhabitationBoundary (2.9s)
✔ [8784/8801] Built IUTThreeClosures.CircularityAudit (2.9s)
✔ [8785/8801] Built IUTThreeClosures.NonCircularDownstream (3.8s)
✔ [8786/8801] Built IUTThreeClosures.FourOpenConstructions (2.0s)
⚠ [8787/8801] Built IUTThreeClosures.ABCPointLegendreCurve (3.2s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8788/8801] Built IUTThreeClosures.BridgeInhabitationAudit (3.5s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
⚠ [8789/8801] Built IUTThreeClosures.PublicProgramUninhabited (4.2s)
warning: IUTThreeClosures/PublicProgramUninhabited.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8790/8801] Built IUTThreeClosures.LegendreArithmetic (4.6s)
warning: IUTThreeClosures/LegendreArithmetic.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8791/8801] Built IUTThreeClosures.BridgeInhabitationExact (3.9s)
⚠ [8792/8801] Built IUTThreeClosures.TripodWeilHeight (3.5s)
warning: IUTThreeClosures/TripodWeilHeight.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/TripodWeilHeight.lean:94:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8793/8801] Built IUTThreeClosures.ABCFreyCurve (4.5s)
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
⚠ [8794/8801] Built IUTThreeClosures.CanonicalQPilotCorridor (3.5s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8795/8801] Built IUTThreeClosures.LegendreHeightCorridor (3.8s)
warning: IUTThreeClosures/LegendreHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8796/8801] Built IUTThreeClosures.CanonicalCorridorAudit (3.9s)
⚠ [8797/8801] Built IUTThreeClosures.SourceDerivedIUTIVBridge (3.0s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8798/8801] Built IUTThreeClosures.FreyJReducedData (3.8s)
warning: IUTThreeClosures/FreyJReducedData.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8799/8801] Built IUTThreeClosures.FreyJHeightCorridor (3.5s)
warning: IUTThreeClosures/FreyJHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8800/8801] Built IUTThreeClosures (2.5s)
warning: IUTThreeClosures.lean:63:46: '' starts on column 46, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
Build completed successfully (8801 jobs).
```
