# Lean CI result

- Tested commit: `689064447cd55c38676ca5560df6888785d7baa7`
- Lean setup: `success`
- Dependency resolution/cache: `success`
- `lake build`: `failure`

## Error summary

```text
===== lean-dependencies.log =====
===== lean-build.log =====
521:✖ [8795/8800] Building IUTThreeClosures.ShiftedJAdmissibleCurve (6.0s)
534:error: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:41:47: unsolved goals
538:error: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:83:4: Type mismatch: After simplification, term
544:error: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:95:4: Type mismatch: After simplification, term
550:error: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:106:2: omega could not prove the goal:
555:error: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:111:2: omega could not prove the goal:
557:error: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:124:2: omega could not prove the goal:
562:error: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:129:2: omega could not prove the goal:
570:error: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:156:2: Type mismatch
576:error: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:166:46: omega could not prove the goal:
584:error: Lean exited with code 1
596:Some required targets logged failures:
598:error: build failed
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
✔ [2/6] Built Cache.Cli (370ms)
✔ [3/6] Built Cache.Lean (477ms)
✔ [8/27] Built Cache.Cli:c.o (182ms)
✔ [9/27] Built Cache.Lean:c.o (233ms)
✔ [11/27] Built Cache.Infra (490ms)
✔ [12/27] Built Cache.Infra:c.o (203ms)
✔ [13/27] Built Cache.IO (1.5s)
✔ [14/27] Built Cache.Hashing (901ms)
✔ [15/27] Built Cache.Hashing:c.o (574ms)
✔ [16/27] Built Cache.IO:c.o (1.6s)
✔ [17/27] Built Cache.Requests (2.2s)
✔ [18/27] Built Cache.Marker (660ms)
✔ [19/27] Built Cache.Marker:c.o (129ms)
✔ [20/27] Built Cache.Query (897ms)
✔ [21/27] Built Cache.Query:c.o (434ms)
✔ [22/27] Built Cache.Warning (798ms)
✔ [23/27] Built Cache.Warning:c.o (368ms)
✔ [24/27] Built Cache.Requests:c.o (3.2s)
✔ [25/27] Built Cache.Main (1.7s)
✔ [26/27] Built Cache.Main:c.o (917ms)
✔ [27/27] Built cache:exe (772ms)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
Attempting to download 8639 file(s) from leanprover-community/mathlib4 cache at https://lakecache.blob.core.windows.net/mathlib4-master
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 16 KB/s], Decompressed: 0Downloaded: 82 file(s) [attempted 82/8639 = 0%, 421 KB/s], Decompressed: 8Downloaded: 204 file(s) [attempted 204/8639 = 2%, 3046 KB/s], Decompressed: 35Downloaded: 297 file(s) [attempted 297/8639 = 3%, 3536 KB/s], Decompressed: 35Downloaded: 400 file(s) [attempted 400/8639 = 4%, 2776 KB/s], Decompressed: 35Downloaded: 509 file(s) [attempted 509/8639 = 5%, 554 KB/s], Decompressed: 35Downloaded: 625 file(s) [attempted 625/8639 = 7%, 238 KB/s], Decompressed: 131Downloaded: 705 file(s) [attempted 705/8639 = 8%, 249 KB/s], Decompressed: 131Downloaded: 808 file(s) [attempted 808/8639 = 9%, 515 KB/s], Decompressed: 131Downloaded: 915 file(s) [attempted 915/8639 = 10%, 494 KB/s], Decompressed: 131Downloaded: 1045 file(s) [attempted 1045/8639 = 12%, 2690 KB/s], Decompressed: 131Downloaded: 1160 file(s) [attempted 1160/8639 = 13%, 472 KB/s], Decompressed: 131Downloaded: 1279 file(s) [attempted 1279/8639 = 14%, 1873 KB/s], Decompressed: 131Downloaded: 1414 file(s) [attempted 1414/8639 = 16%, 469 KB/s], Decompressed: 131Downloaded: 1526 file(s) [attempted 1526/8639 = 17%, 286 KB/s], Decompressed: 131Downloaded: 1653 file(s) [attempted 1653/8639 = 19%, 5796 KB/s], Decompressed: 131Downloaded: 1771 file(s) [attempted 1771/8639 = 20%, 806 KB/s], Decompressed: 131Downloaded: 1906 file(s) [attempted 1906/8639 = 22%, 1189 KB/s], Decompressed: 131Downloaded: 2013 file(s) [attempted 2013/8639 = 23%, 549 KB/s], Decompressed: 131Downloaded: 2128 file(s) [attempted 2128/8639 = 24%, 507 KB/s], Decompressed: 131Downloaded: 2268 file(s) [attempted 2268/8639 = 26%, 88 KB/s], Decompressed: 131Downloaded: 2400 file(s) [attempted 2400/8639 = 27%, 1366 KB/s], Decompressed: 131Downloaded: 2512 file(s) [attempted 2512/8639 = 29%, 70 KB/s], Decompressed: 131Downloaded: 2653 file(s) [attempted 2653/8639 = 30%, 354 KB/s], Decompressed: 537Downloaded: 2780 file(s) [attempted 2780/8639 = 32%, 280 KB/s], Decompressed: 537Downloaded: 2890 file(s) [attempted 2890/8639 = 33%, 1360 KB/s], Decompressed: 537Downloaded: 3007 file(s) [attempted 3007/8639 = 34%, 3692 KB/s], Decompressed: 537Downloaded: 3114 file(s) [attempted 3114/8639 = 36%, 587 KB/s], Decompressed: 537Downloaded: 3237 file(s) [attempted 3237/8639 = 37%, 3854 KB/s], Decompressed: 537Downloaded: 3375 file(s) [attempted 3375/8639 = 39%, 898 KB/s], Decompressed: 537Downloaded: 3512 file(s) [attempted 3512/8639 = 40%, 1419 KB/s], Decompressed: 537Downloaded: 3631 file(s) [attempted 3631/8639 = 42%, 281 KB/s], Decompressed: 537Downloaded: 3762 file(s) [attempted 3762/8639 = 43%, 183 KB/s], Decompressed: 537Downloaded: 3890 file(s) [attempted 3890/8639 = 45%, 391 KB/s], Decompressed: 537Downloaded: 4002 file(s) [attempted 4002/8639 = 46%, 1000 KB/s], Decompressed: 537Downloaded: 4100 file(s) [attempted 4100/8639 = 47%, 5750 KB/s], Decompressed: 537Downloaded: 4202 file(s) [attempted 4202/8639 = 48%, 429 KB/s], Decompressed: 537Downloaded: 4312 file(s) [attempted 4312/8639 = 49%, 727 KB/s], Decompressed: 537Downloaded: 4421 file(s) [attempted 4421/8639 = 51%, 6976 KB/s], Decompressed: 537Downloaded: 4543 file(s) [attempted 4543/8639 = 52%, 775 KB/s], Decompressed: 537Downloaded: 4654 file(s) [attempted 4654/8639 = 53%, 357 KB/s], Decompressed: 537Downloaded: 4769 file(s) [attempted 4769/8639 = 55%, 880 KB/s], Decompressed: 537Downloaded: 4893 file(s) [attempted 4893/8639 = 56%, 646 KB/s], Decompressed: 537Downloaded: 5002 file(s) [attempted 5002/8639 = 57%, 336 KB/s], Decompressed: 537Downloaded: 5114 file(s) [attempted 5114/8639 = 59%, 1077 KB/s], Decompressed: 537Downloaded: 5244 file(s) [attempted 5244/8639 = 60%, 278 KB/s], Decompressed: 537Downloaded: 5373 file(s) [attempted 5373/8639 = 62%, 544 KB/s], Decompressed: 537Downloaded: 5484 file(s) [attempted 5484/8639 = 63%, 76 KB/s], Decompressed: 537Downloaded: 5589 file(s) [attempted 5589/8639 = 64%, 271 KB/s], Decompressed: 537Downloaded: 5708 file(s) [attempted 5708/8639 = 66%, 412 KB/s], Decompressed: 537Downloaded: 5825 file(s) [attempted 5825/8639 = 67%, 1741 KB/s], Decompressed: 537Downloaded: 5969 file(s) [attempted 5969/8639 = 69%, 145 KB/s], Decompressed: 537Downloaded: 6086 file(s) [attempted 6086/8639 = 70%, 100 KB/s], Decompressed: 537Downloaded: 6228 file(s) [attempted 6228/8639 = 72%, 395 KB/s], Decompressed: 537Downloaded: 6339 file(s) [attempted 6339/8639 = 73%, 851 KB/s], Decompressed: 537Downloaded: 6468 file(s) [attempted 6468/8639 = 74%, 1426 KB/s], Decompressed: 537Downloaded: 6594 file(s) [attempted 6594/8639 = 76%, 87 KB/s], Decompressed: 537Downloaded: 6703 file(s) [attempted 6703/8639 = 77%, 269 KB/s], Decompressed: 537Downloaded: 6778 file(s) [attempted 6778/8639 = 78%, 420 KB/s], Decompressed: 537Downloaded: 6913 file(s) [attempted 6913/8639 = 80%, 422 KB/s], Decompressed: 537Downloaded: 7037 file(s) [attempted 7037/8639 = 81%, 731 KB/s], Decompressed: 537Downloaded: 7165 file(s) [attempted 7165/8639 = 82%, 85 KB/s], Decompressed: 537Downloaded: 7307 file(s) [attempted 7307/8639 = 84%, 932 KB/s], Decompressed: 537Downloaded: 7377 file(s) [attempted 7377/8639 = 85%, 1105 KB/s], Decompressed: 537Downloaded: 7477 file(s) [attempted 7477/8639 = 86%, 5731 KB/s], Decompressed: 537Downloaded: 7589 file(s) [attempted 7589/8639 = 87%, 2270 KB/s], Decompressed: 537Downloaded: 7724 file(s) [attempted 7724/8639 = 89%, 486 KB/s], Decompressed: 537Downloaded: 7848 file(s) [attempted 7848/8639 = 90%, 1150 KB/s], Decompressed: 537Downloaded: 7969 file(s) [attempted 7969/8639 = 92%, 862 KB/s], Decompressed: 537Downloaded: 8100 file(s) [attempted 8100/8639 = 93%, 333 KB/s], Decompressed: 537Downloaded: 8240 file(s) [attempted 8240/8639 = 95%, 2680 KB/s], Decompressed: 537Downloaded: 8351 file(s) [attempted 8351/8639 = 96%, 384 KB/s], Decompressed: 537Downloaded: 8477 file(s) [attempted 8477/8639 = 98%, 1429 KB/s], Decompressed: 537Downloaded: 8611 file(s) [attempted 8611/8639 = 99%, 206 KB/s], Decompressed: 537Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 206 KB/s], Decompressed: 537
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (465ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.MaxTerm (3.6s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.UltrametricSum (3.6s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (3.6s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (8.7s)
✔ [8661/8673] Built TateCurvesTheta.AnalyticQuotient (8.5s)
✔ [8662/8675] Built Iut.Cor312.ThetaData.Places (7.4s)
✔ [8663/8675] Built TateCurvesTheta.QParameter.BaseChange (3.5s)
✔ [8664/8675] Built TateCurvesTheta.Analysis.Strassmann (5.6s)
✔ [8665/8675] Built TateCurvesTheta.TateCurve.Weierstrass (4.1s)
✔ [8666/8675] Built TateCurvesTheta.QParameter.PrimeToOrder (2.8s)
✔ [8667/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (5.9s)
✔ [8668/8680] Built TateCurvesTheta.TateCurve.Discriminant (5.5s)
✔ [8669/8680] Built TateCurvesTheta.QParameter.NormalizedOrder (4.0s)
✔ [8670/8689] Built TateCurvesTheta.TateCurve.SplitReduction (4.6s)
✔ [8671/8689] Built TateCurvesTheta.TateCurve.Parametrization (4.0s)
✔ [8672/8689] Built TateCurvesTheta.TateCurve.JInvariant (3.8s)
✔ [8673/8689] Built Iut.Cor312.ThetaData.GlobalField (13s)
✔ [8674/8692] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (3.2s)
✔ [8675/8696] Built TateCurvesTheta.Theta.Basic (3.5s)
✔ [8676/8696] Built TateCurvesTheta.TateCurve.CoordinateExpansion (3.6s)
✔ [8677/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (4.5s)
✔ [8678/8696] Built TateCurvesTheta.Theta.Periodicity (5.2s)
✔ [8679/8696] Built TateCurvesTheta.QParameter.JParametrization (10s)
✔ [8680/8699] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (9.6s)
✔ [8681/8704] Built TateCurvesTheta.QParameter.Characterization (4.5s)
✔ [8682/8704] Built TateCurvesTheta.Theta.Product (6.3s)
✔ [8683/8704] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (11s)
✔ [8684/8704] Built TateCurvesTheta.TateCurve.EisensteinSeries (13s)
✔ [8685/8705] Built TateCurvesTheta.Theta.QBinomial (5.7s)
✔ [8686/8708] Built TateCurvesTheta.Theta.Uniqueness (5.2s)
✔ [8687/8708] Built TateCurvesTheta.Theta.Divisor (6.3s)
✔ [8688/8708] Built TateCurvesTheta.TateCurve.CoordinateInversion (4.0s)
✔ [8689/8708] Built TateCurvesTheta.Theta.FactorSeries (5.4s)
✔ [8690/8712] Built TateCurvesTheta.TateCurve.TatePointMem (3.9s)
✔ [8691/8713] Built TateCurvesTheta.Theta.LaurentSphere (4.2s)
✔ [8692/8714] Built TateCurvesTheta.TateCurve.IntegralModel (6.0s)
✔ [8693/8715] Built TateCurvesTheta.Theta.ThetaProdLaurent (6.3s)
✔ [8694/8717] Built TateCurvesTheta.TateCurve.SphereBounds (6.8s)
✔ [8695/8718] Built TateCurvesTheta.TateCurve.Quotient (8.5s)
✔ [8696/8719] Built TateCurvesTheta.Theta.LaurentSphereReduce (3.7s)
✔ [8697/8720] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (4.5s)
✔ [8698/8721] Built TateCurvesTheta.Theta.FactorReciprocal (3.0s)
✔ [8699/8721] Built TateCurvesTheta.Theta.LaurentUnique (3.4s)
✔ [8700/8721] Built TateCurvesTheta.Theta.LaurentUnitSphere (2.0s)
✔ [8701/8722] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (3.8s)
✔ [8702/8729] Built TateCurvesTheta.TateCurve.PointMap (8.4s)
✔ [8703/8729] Built TateCurvesTheta.Theta.SeriesZero (3.8s)
✔ [8704/8729] Built TateCurvesTheta.Theta.RatioAnnulus (4.0s)
✔ [8705/8729] Built TateCurvesTheta.Theta.Normalization (5.4s)
✔ [8706/8729] Built TateCurvesTheta.Theta.TripleProduct (5.2s)
✔ [8707/8731] Built TateCurvesTheta.Theta.StrictDominant (10s)
✔ [8708/8733] Built TateCurvesTheta.Theta.Durfee (5.2s)
✔ [8709/8735] Built TateCurvesTheta.Uniformization (8.7s)
✔ [8710/8735] Built Iut.Cor312.Procession (6.7s)
✔ [8711/8735] Built TateCurvesTheta.Theta.Inversion (3.8s)
✔ [8712/8735] Built Iut.Cor312.RationalPlace (6.2s)
✔ [8713/8765] Built Iut.Cor312.PacketPresentation (12s)
✔ [8714/8765] Built TateCurvesTheta.Theta.WeightSpace (16s)
✔ [8715/8765] Built Iut.Cor312.Container (9.7s)
✔ [8716/8765] Built Iut.Cor312.HolomorphicHull (11s)
✔ [8717/8765] Built IUTThreeClosures.ABCStatement (4.4s)
⚠ [8718/8765] Built IUTThreeClosures.HonestFinitePositiveLogVolume (10s)
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:126:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8719/8765] Built IUTThreeClosures.FullPolyCore (8.2s)
⚠ [8721/8785] Built IUTThreeClosures.Cor312CoefficientAlgebra (7.8s)
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
✔ [8722/8785] Built TateCurvesTheta.Theta.PuncturedProduct (45s)
✔ [8723/8785] Built Iut.Cor312.LogVolume (7.4s)
✔ [8724/8785] Built Iut.Cor312.ContainerHull (6.9s)
⚠ [8725/8785] Built IUTThreeClosures.HonestPilotWitness (6.2s)
warning: IUTThreeClosures/HonestPilotWitness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestPilotWitness.lean:86:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8726/8785] Built IUTThreeClosures.WeakCompatibilityCountermodel (6.0s)
✔ [8727/8785] Built Heights.WeilHeight (8.9s)
⚠ [8728/8785] Built IUTThreeClosures.ExplicitSemistableCurve (6.9s)
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:95:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8729/8785] Built IUTThreeClosures.SolvableRestrictionImage (7.5s)
warning: IUTThreeClosures/SolvableRestrictionImage.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/SolvableRestrictionImage.lean:121:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8730/8785] Built IUTThreeClosures.QPilotNormalizationAudit (6.8s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8731/8785] Built IUTThreeClosures.RootQPilotDivisor (6.1s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8732/8785] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (6.8s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8733/8785] Built TateCurvesTheta.TateCurve.DefectVanishing (90s)
⚠ [8734/8785] Built IUTThreeClosures.RamificationCorrectedQPilot (7.5s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8735/8785] Built IUTThreeClosures.ProductWeightMarginalization (7.5s)
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
⚠ [8736/8785] Built IUTThreeClosures.GeneratedUnionCompactness (6.3s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8738/8785] Built IUTThreeClosures.AdmissiblePrimeSelection (6.4s)
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:104:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8739/8785] Built IUTThreeClosures.FiniteExceptionalSet (6.5s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8740/8785] Built IUTThreeClosures.PrimePowerQPilotRegion (6.4s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8741/8796] Built IUTThreeClosures.HonestGeneratedSource (6.6s)
warning: IUTThreeClosures/HonestGeneratedSource.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8743/8800] Built IUTThreeClosures.ZModSL2Perfect (6.3s)
warning: IUTThreeClosures/ZModSL2Perfect.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZModSL2Perfect.lean:62:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8744/8800] Built Genl.Mathlib.Order.BoundedDiscrepancy (3.2s)
⚠ [8745/8800] Built IUTThreeClosures.QPilotNormalizationFork (7.3s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8746/8800] Built TateCurvesTheta.TateCurve.TatePointOnCurve (6.8s)
⚠ [8747/8800] Built IUTThreeClosures.DistinguishedLabelQPilot (7.1s)
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:52:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8748/8800] Built IUTThreeClosures.TateParameterUnitBallRegion (2.8s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8749/8800] Built IUTThreeClosures.FiniteExponentHull (5.8s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8750/8800] Built IUTThreeClosures.StandardZeroLabel (6.2s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8751/8800] Built IUTThreeClosures.BarycentricPacketReading (6.1s)
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
⚠ [8752/8800] Built IUTThreeClosures.DiagonalPacketNoGo (5.9s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8753/8800] Built Genl.GeneralPosition.HeightTheory (1.9s)
✔ [8754/8800] Built Iut4Sec1.Global.ArithmeticDivisor (6.2s)
⚠ [8755/8800] Built IUTThreeClosures.PublicNormalizationObstruction (6.8s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8756/8800] Built IUTThreeClosures.IUTIVAbsorption (8.9s)
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
✔ [8757/8800] Built TateCurvesTheta.TateCurve.AdditionLaw (9.4s)
✔ [8758/8800] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (9.5s)
⚠ [8759/8800] Built IUTThreeClosures.ZeroLabelBarycentric (9.2s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
✔ [8760/8800] Built TateCurvesTheta.TateCurve.LargePointParametrization (13s)
⚠ [8761/8800] Built IUTThreeClosures.StatementIIOutsideFinite (8.1s)
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
✔ [8762/8800] Built TateCurvesTheta.TateCurve.AbelStep (6.7s)
✔ [8763/8800] Built TateCurvesTheta.TateCurve.GroupLaw (10s)
✔ [8764/8800] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (22s)
✔ [8765/8800] Built TateCurvesTheta.TateCurve.SurjectivitySphere (23s)
✔ [8766/8800] Built TateCurvesTheta.TateCurve.TateUniformization (4.4s)
✔ [8767/8800] Built TateCurvesTheta (3.8s)
✔ [8768/8800] Built Iut.Cor312.ThetaData.AdmissiblePrime (5.1s)
✔ [8769/8800] Built Iut.Cor312.ThetaData.Orbicurve (4.9s)
✔ [8770/8800] Built Iut.Cor312.ThetaData.LocalConditions (8.7s)
✔ [8771/8800] Built Iut.Cor312.ThetaData.Basic (4.7s)
✔ [8772/8800] Built Iut.Cor312.LeftHandSide (4.3s)
✔ [8773/8800] Built Iut.Cor312.RightHandSide (4.5s)
⚠ [8774/8800] Built IUTThreeClosures.CorrectedQPilotDivisor (4.9s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8775/8800] Built Iut.Cor312.Statement (5.3s)
⚠ [8776/8800] Built IUTThreeClosures.NativeQPilotCalibration (5.5s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8777/8800] Built IUTThreeClosures.ActualPilotWitness (4.1s)
✔ [8778/8800] Built IUTThreeClosures.GeneratedSource (4.6s)
✔ [8779/8800] Built IUTThreeClosures.QuantifierCorrectClosure (3.0s)
✔ [8780/8800] Built IUTThreeClosures.ABCClosure (4.2s)
⚠ [8781/8800] Built IUTThreeClosures.PublicLogVolumeInconsistency (4.5s)
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8782/8800] Built IUTThreeClosures.ThreeClosureTheorems (4.0s)
✔ [8783/8800] Built IUTThreeClosures.InhabitationBoundary (4.2s)
✔ [8784/8800] Built IUTThreeClosures.CircularityAudit (4.2s)
✔ [8785/8800] Built IUTThreeClosures.NonCircularDownstream (5.2s)
✔ [8786/8800] Built IUTThreeClosures.FourOpenConstructions (4.4s)
⚠ [8787/8800] Built IUTThreeClosures.ABCPointLegendreCurve (4.9s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8788/8800] Built IUTThreeClosures.PublicProgramUninhabited (4.8s)
warning: IUTThreeClosures/PublicProgramUninhabited.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8789/8800] Built IUTThreeClosures.BridgeInhabitationAudit (6.2s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
⚠ [8790/8800] Built IUTThreeClosures.LegendreArithmetic (5.0s)
warning: IUTThreeClosures/LegendreArithmetic.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8791/8800] Built IUTThreeClosures.BridgeInhabitationExact (5.2s)
⚠ [8792/8800] Built IUTThreeClosures.ABCFreyCurve (5.6s)
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
⚠ [8793/8800] Built IUTThreeClosures.TripodWeilHeight (5.9s)
warning: IUTThreeClosures/TripodWeilHeight.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/TripodWeilHeight.lean:94:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8794/8800] Built IUTThreeClosures.CanonicalQPilotCorridor (4.7s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✖ [8795/8800] Building IUTThreeClosures.ShiftedJAdmissibleCurve (6.0s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/ShiftedJAdmissibleCurve.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/ShiftedJAdmissibleCurve.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/ShiftedJAdmissibleCurve.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/ShiftedJAdmissibleCurve.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/ShiftedJAdmissibleCurve.setup.json --json
warning: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
info: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:46:2: Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
error: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:41:47: unsolved goals
P : ABCPoint
hc : ↑P.c ≠ 0
⊢ ↑P.c * 2 + ↑P.a = ↑(P.c * 2 + P.a)
error: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:83:4: Type mismatch: After simplification, term
  coprime_shiftedJ_num_den P
 has type
  P.a.Coprime P.c
but is expected to have type
  (2 * ↑P.c + ↑P.a).natAbs.Coprime P.c
error: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:95:4: Type mismatch: After simplification, term
  coprime_shiftedJ_num_den P
 has type
  P.a.Coprime P.c
but is expected to have type
  (2 * ↑P.c + ↑P.a).natAbs.Coprime P.c
error: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:106:2: omega could not prove the goal:
a possible counterexample may satisfy the constraints
  0 ≤ d ≤ 1
where
 d := ↑P.c
error: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:111:2: omega could not prove the goal:
No usable constraints found. You may need to unfold definitions so `omega` can see linear arithmetic facts about `Nat` and `Int`, which may also involve multiplication, division, and modular remainder by constants.
error: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:124:2: omega could not prove the goal:
a possible counterexample may satisfy the constraints
  d ≥ 0
where
 d := ↑P.c
error: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:129:2: omega could not prove the goal:
a possible counterexample may satisfy the constraints
  e ≥ 0
  d ≥ 0
  d + e ≤ 0
where
 d := ↑P.c
 e := ↑P.a
error: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:156:2: Type mismatch
  hlog
has type
  Real.log 2 + Real.log ↑P.c ≤ Real.log ↑(2 * P.c + P.a)
but is expected to have type
  Real.log ↑P.c + Real.log 2 ≤ Real.log ↑(2 * P.c + P.a)
error: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:166:46: omega could not prove the goal:
a possible counterexample may satisfy the constraints
  e ≥ 0
  d ≥ 0
  2*d + e ≤ 0
where
 d := ↑P.c
 e := ↑P.a
error: Lean exited with code 1
⚠ [8796/8800] Built IUTThreeClosures.LegendreHeightCorridor (6.2s)
warning: IUTThreeClosures/LegendreHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8797/8800] Built IUTThreeClosures.CanonicalCorridorAudit (5.3s)
⚠ [8798/8800] Built IUTThreeClosures.SourceDerivedIUTIVBridge (6.0s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
Some required targets logged failures:
- IUTThreeClosures.ShiftedJAdmissibleCurve
error: build failed
```
