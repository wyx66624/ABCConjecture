# Lean CI result

- Tested commit: `ad1be4a9d42cbaa2f5c23b14b0140b7ca546b54d`
- Lean setup: `success`
- Dependency resolution/cache: `success`
- `lake build`: `failure`

## Error summary

```text
===== lean-dependencies.log =====
===== lean-build.log =====
521:✖ [8795/8800] Building IUTThreeClosures.ShiftedJAdmissibleCurve (5.0s)
528:error: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:78:6: Tactic `rewrite` failed: Did not find an occurrence of the pattern
535:error: Lean exited with code 1
547:Some required targets logged failures:
549:error: build failed
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
✔ [2/6] Built Cache.Cli (324ms)
✔ [3/6] Built Cache.Lean (413ms)
✔ [8/27] Built Cache.Cli:c.o (180ms)
✔ [9/27] Built Cache.Lean:c.o (183ms)
✔ [11/27] Built Cache.Infra (411ms)
✔ [12/27] Built Cache.Infra:c.o (163ms)
✔ [13/27] Built Cache.IO (1.3s)
✔ [14/27] Built Cache.Hashing (744ms)
✔ [15/27] Built Cache.Hashing:c.o (367ms)
✔ [16/27] Built Cache.IO:c.o (1.5s)
✔ [17/27] Built Cache.Requests (1.9s)
✔ [18/27] Built Cache.Marker (584ms)
✔ [19/27] Built Cache.Marker:c.o (128ms)
✔ [20/27] Built Cache.Query (704ms)
✔ [21/27] Built Cache.Query:c.o (336ms)
✔ [22/27] Built Cache.Warning (743ms)
✔ [23/27] Built Cache.Warning:c.o (306ms)
✔ [24/27] Built Cache.Requests:c.o (2.6s)
✔ [25/27] Built Cache.Main (1.4s)
✔ [26/27] Built Cache.Main:c.o (774ms)
✔ [27/27] Built cache:exe (672ms)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
Attempting to download 8639 file(s) from leanprover-community/mathlib4 cache at https://lakecache.blob.core.windows.net/mathlib4-master
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 17 KB/s], Decompressed: 0Downloaded: 40 file(s) [attempted 40/8639 = 0%, 32 KB/s], Decompressed: 25Downloaded: 103 file(s) [attempted 103/8639 = 1%, 1144 KB/s], Decompressed: 59Downloaded: 197 file(s) [attempted 197/8639 = 2%, 505 KB/s], Decompressed: 92Downloaded: 286 file(s) [attempted 286/8639 = 3%, 895 KB/s], Decompressed: 92Downloaded: 382 file(s) [attempted 382/8639 = 4%, 244 KB/s], Decompressed: 185Downloaded: 484 file(s) [attempted 484/8639 = 5%, 1019 KB/s], Decompressed: 185Downloaded: 587 file(s) [attempted 587/8639 = 6%, 205 KB/s], Decompressed: 185Downloaded: 706 file(s) [attempted 706/8639 = 8%, 288 KB/s], Decompressed: 185Downloaded: 816 file(s) [attempted 816/8639 = 9%, 192 KB/s], Decompressed: 185Downloaded: 926 file(s) [attempted 926/8639 = 10%, 660 KB/s], Decompressed: 382Downloaded: 1040 file(s) [attempted 1040/8639 = 12%, 1329 KB/s], Decompressed: 382Downloaded: 1164 file(s) [attempted 1164/8639 = 13%, 211 KB/s], Decompressed: 382Downloaded: 1278 file(s) [attempted 1278/8639 = 14%, 581 KB/s], Decompressed: 382Downloaded: 1383 file(s) [attempted 1383/8639 = 16%, 521 KB/s], Decompressed: 382Downloaded: 1500 file(s) [attempted 1500/8639 = 17%, 352 KB/s], Decompressed: 382Downloaded: 1624 file(s) [attempted 1624/8639 = 18%, 1430 KB/s], Decompressed: 382Downloaded: 1731 file(s) [attempted 1731/8639 = 20%, 1565 KB/s], Decompressed: 382Downloaded: 1845 file(s) [attempted 1845/8639 = 21%, 266 KB/s], Decompressed: 382Downloaded: 1958 file(s) [attempted 1958/8639 = 22%, 565 KB/s], Decompressed: 382Downloaded: 2065 file(s) [attempted 2065/8639 = 23%, 291 KB/s], Decompressed: 382Downloaded: 2179 file(s) [attempted 2179/8639 = 25%, 1537 KB/s], Decompressed: 382Downloaded: 2291 file(s) [attempted 2291/8639 = 26%, 600 KB/s], Decompressed: 382Downloaded: 2410 file(s) [attempted 2410/8639 = 27%, 323 KB/s], Decompressed: 914Downloaded: 2476 file(s) [attempted 2476/8639 = 28%, 1123 KB/s], Decompressed: 914Downloaded: 2578 file(s) [attempted 2578/8639 = 29%, 750 KB/s], Decompressed: 914Downloaded: 2681 file(s) [attempted 2681/8639 = 31%, 208 KB/s], Decompressed: 914Downloaded: 2781 file(s) [attempted 2781/8639 = 32%, 288 KB/s], Decompressed: 914Downloaded: 2882 file(s) [attempted 2882/8639 = 33%, 1780 KB/s], Decompressed: 914Downloaded: 2972 file(s) [attempted 2972/8639 = 34%, 115 KB/s], Decompressed: 914Downloaded: 3036 file(s) [attempted 3036/8639 = 35%, 3232 KB/s], Decompressed: 914Downloaded: 3134 file(s) [attempted 3134/8639 = 36%, 2628 KB/s], Decompressed: 914Downloaded: 3234 file(s) [attempted 3234/8639 = 37%, 3937 KB/s], Decompressed: 914Downloaded: 3334 file(s) [attempted 3334/8639 = 38%, 1254 KB/s], Decompressed: 914Downloaded: 3435 file(s) [attempted 3435/8639 = 39%, 2935 KB/s], Decompressed: 914Downloaded: 3537 file(s) [attempted 3537/8639 = 40%, 279 KB/s], Decompressed: 914Downloaded: 3647 file(s) [attempted 3647/8639 = 42%, 348 KB/s], Decompressed: 914Downloaded: 3754 file(s) [attempted 3754/8639 = 43%, 761 KB/s], Decompressed: 914Downloaded: 3860 file(s) [attempted 3860/8639 = 44%, 595 KB/s], Decompressed: 914Downloaded: 3965 file(s) [attempted 3965/8639 = 45%, 707 KB/s], Decompressed: 914Downloaded: 4075 file(s) [attempted 4075/8639 = 47%, 771 KB/s], Decompressed: 914Downloaded: 4175 file(s) [attempted 4175/8639 = 48%, 627 KB/s], Decompressed: 914Downloaded: 4280 file(s) [attempted 4280/8639 = 49%, 4437 KB/s], Decompressed: 914Downloaded: 4396 file(s) [attempted 4396/8639 = 50%, 1111 KB/s], Decompressed: 914Downloaded: 4506 file(s) [attempted 4506/8639 = 52%, 212 KB/s], Decompressed: 914Downloaded: 4620 file(s) [attempted 4620/8639 = 53%, 177 KB/s], Decompressed: 914Downloaded: 4681 file(s) [attempted 4681/8639 = 54%, 1780 KB/s], Decompressed: 914Downloaded: 4781 file(s) [attempted 4781/8639 = 55%, 742 KB/s], Decompressed: 914Downloaded: 4886 file(s) [attempted 4886/8639 = 56%, 325 KB/s], Decompressed: 914Downloaded: 4968 file(s) [attempted 4968/8639 = 57%, 1827 KB/s], Decompressed: 914Downloaded: 5057 file(s) [attempted 5057/8639 = 58%, 1293 KB/s], Decompressed: 914Downloaded: 5115 file(s) [attempted 5115/8639 = 59%, 224 KB/s], Decompressed: 914Downloaded: 5213 file(s) [attempted 5213/8639 = 60%, 4527 KB/s], Decompressed: 914Downloaded: 5320 file(s) [attempted 5320/8639 = 61%, 2487 KB/s], Decompressed: 914Downloaded: 5421 file(s) [attempted 5421/8639 = 62%, 3683 KB/s], Decompressed: 914Downloaded: 5486 file(s) [attempted 5486/8639 = 63%, 1304 KB/s], Decompressed: 914Downloaded: 5577 file(s) [attempted 5577/8639 = 64%, 1020 KB/s], Decompressed: 914Downloaded: 5682 file(s) [attempted 5682/8639 = 65%, 2905 KB/s], Decompressed: 914Downloaded: 5783 file(s) [attempted 5783/8639 = 66%, 132 KB/s], Decompressed: 2380Downloaded: 5885 file(s) [attempted 5885/8639 = 68%, 581 KB/s], Decompressed: 2380Downloaded: 5990 file(s) [attempted 5990/8639 = 69%, 671 KB/s], Decompressed: 2380Downloaded: 6105 file(s) [attempted 6105/8639 = 70%, 1449 KB/s], Decompressed: 2380Downloaded: 6205 file(s) [attempted 6205/8639 = 71%, 271 KB/s], Decompressed: 2380Downloaded: 6305 file(s) [attempted 6305/8639 = 72%, 1262 KB/s], Decompressed: 2380Downloaded: 6406 file(s) [attempted 6406/8639 = 74%, 2084 KB/s], Decompressed: 2380Downloaded: 6508 file(s) [attempted 6508/8639 = 75%, 2785 KB/s], Decompressed: 2380Downloaded: 6613 file(s) [attempted 6613/8639 = 76%, 70 KB/s], Decompressed: 2380Downloaded: 6716 file(s) [attempted 6716/8639 = 77%, 432 KB/s], Decompressed: 2380Downloaded: 6816 file(s) [attempted 6816/8639 = 78%, 6161 KB/s], Decompressed: 2380Downloaded: 6919 file(s) [attempted 6919/8639 = 80%, 978 KB/s], Decompressed: 2380Downloaded: 7017 file(s) [attempted 7017/8639 = 81%, 322 KB/s], Decompressed: 2380Downloaded: 7120 file(s) [attempted 7120/8639 = 82%, 135 KB/s], Decompressed: 2380Downloaded: 7213 file(s) [attempted 7213/8639 = 83%, 794 KB/s], Decompressed: 2380Downloaded: 7227 file(s) [attempted 7227/8639 = 83%, 134 KB/s], Decompressed: 2380Downloaded: 7330 file(s) [attempted 7330/8639 = 84%, 103 KB/s], Decompressed: 2380Downloaded: 7433 file(s) [attempted 7433/8639 = 86%, 699 KB/s], Decompressed: 2380Downloaded: 7533 file(s) [attempted 7533/8639 = 87%, 1097 KB/s], Decompressed: 2380Downloaded: 7638 file(s) [attempted 7638/8639 = 88%, 1819 KB/s], Decompressed: 2380Downloaded: 7748 file(s) [attempted 7748/8639 = 89%, 355 KB/s], Decompressed: 2380Downloaded: 7836 file(s) [attempted 7836/8639 = 90%, 100 KB/s], Decompressed: 2380Downloaded: 7941 file(s) [attempted 7941/8639 = 91%, 5120 KB/s], Decompressed: 2380Downloaded: 8046 file(s) [attempted 8046/8639 = 93%, 1047 KB/s], Decompressed: 2380Downloaded: 8147 file(s) [attempted 8147/8639 = 94%, 462 KB/s], Decompressed: 2380Downloaded: 8249 file(s) [attempted 8249/8639 = 95%, 2551 KB/s], Decompressed: 2380Downloaded: 8352 file(s) [attempted 8352/8639 = 96%, 163 KB/s], Decompressed: 2380Downloaded: 8458 file(s) [attempted 8458/8639 = 97%, 219 KB/s], Decompressed: 2380Downloaded: 8515 file(s) [attempted 8515/8639 = 98%, 306 KB/s], Decompressed: 2380Downloaded: 8616 file(s) [attempted 8616/8639 = 99%, 241 KB/s], Decompressed: 2380Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 241 KB/s], Decompressed: 2380
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (482ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.MaxTerm (2.6s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.UltrametricSum (3.5s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (3.7s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (7.9s)
✔ [8661/8673] Built TateCurvesTheta.AnalyticQuotient (7.9s)
✔ [8662/8673] Built Iut.Cor312.ThetaData.Places (6.1s)
✔ [8663/8675] Built TateCurvesTheta.QParameter.BaseChange (2.0s)
✔ [8664/8675] Built TateCurvesTheta.Analysis.Strassmann (4.3s)
✔ [8665/8675] Built TateCurvesTheta.TateCurve.Weierstrass (3.7s)
✔ [8666/8678] Built TateCurvesTheta.QParameter.PrimeToOrder (2.4s)
✔ [8667/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (5.6s)
✔ [8668/8680] Built TateCurvesTheta.TateCurve.Discriminant (5.1s)
✔ [8669/8680] Built TateCurvesTheta.QParameter.NormalizedOrder (4.5s)
✔ [8670/8684] Built Iut.Cor312.ThetaData.GlobalField (10s)
✔ [8671/8689] Built TateCurvesTheta.TateCurve.JInvariant (3.2s)
✔ [8672/8689] Built TateCurvesTheta.TateCurve.Parametrization (3.9s)
✔ [8673/8689] Built TateCurvesTheta.TateCurve.SplitReduction (4.0s)
✔ [8674/8691] Built TateCurvesTheta.Theta.Basic (3.2s)
✔ [8675/8692] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (2.9s)
✔ [8676/8693] Built TateCurvesTheta.TateCurve.CoordinateExpansion (3.1s)
✔ [8677/8693] Built TateCurvesTheta.Theta.Periodicity (4.9s)
✔ [8678/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (5.4s)
✔ [8679/8696] Built TateCurvesTheta.QParameter.JParametrization (9.1s)
✔ [8680/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (7.5s)
✔ [8681/8696] Built TateCurvesTheta.Theta.Product (4.2s)
✔ [8682/8696] Built TateCurvesTheta.QParameter.Characterization (4.2s)
✔ [8683/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (9.1s)
✔ [8684/8704] Built TateCurvesTheta.Theta.Divisor (5.7s)
✔ [8685/8705] Built TateCurvesTheta.Theta.Uniqueness (4.0s)
✔ [8686/8705] Built TateCurvesTheta.TateCurve.EisensteinSeries (11s)
✔ [8687/8705] Built TateCurvesTheta.Theta.FactorSeries (5.7s)
✔ [8688/8705] Built TateCurvesTheta.Theta.QBinomial (5.3s)
✔ [8689/8708] Built TateCurvesTheta.Theta.LaurentSphere (4.1s)
✔ [8690/8708] Built TateCurvesTheta.TateCurve.TatePointMem (3.4s)
✔ [8691/8708] Built TateCurvesTheta.Theta.ThetaProdLaurent (4.0s)
✔ [8692/8712] Built TateCurvesTheta.TateCurve.CoordinateInversion (3.3s)
✔ [8693/8713] Built TateCurvesTheta.Theta.LaurentSphereReduce (3.3s)
✔ [8694/8714] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (4.2s)
✔ [8695/8715] Built TateCurvesTheta.TateCurve.Quotient (7.5s)
✔ [8696/8715] Built TateCurvesTheta.TateCurve.IntegralModel (5.4s)
✔ [8697/8715] Built TateCurvesTheta.TateCurve.SphereBounds (5.0s)
✔ [8698/8716] Built TateCurvesTheta.Theta.LaurentUnitSphere (3.3s)
✔ [8699/8717] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (3.4s)
✔ [8700/8717] Built TateCurvesTheta.Theta.Normalization (4.1s)
✔ [8701/8719] Built TateCurvesTheta.Theta.FactorReciprocal (5.1s)
✔ [8702/8720] Built TateCurvesTheta.TateCurve.PointMap (10s)
✔ [8703/8721] Built TateCurvesTheta.Theta.Durfee (6.5s)
✔ [8704/8722] Built TateCurvesTheta.Theta.LaurentUnique (4.3s)
✔ [8705/8722] Built TateCurvesTheta.Theta.RatioAnnulus (3.4s)
✔ [8706/8722] Built TateCurvesTheta.Theta.SeriesZero (2.8s)
✔ [8707/8729] Built TateCurvesTheta.Theta.Inversion (3.4s)
✔ [8708/8729] Built TateCurvesTheta.Theta.StrictDominant (10s)
✔ [8709/8729] Built TateCurvesTheta.Theta.WeightSpace (14s)
✔ [8710/8731] Built TateCurvesTheta.Theta.TripleProduct (4.4s)
✔ [8711/8733] Built TateCurvesTheta.Uniformization (9.1s)
✔ [8712/8735] Built Iut.Cor312.Procession (10s)
✔ [8713/8765] Built Iut.Cor312.RationalPlace (8.0s)
✔ [8714/8765] Built Iut.Cor312.PacketPresentation (7.0s)
✔ [8715/8765] Built IUTThreeClosures.ABCStatement (3.3s)
⚠ [8716/8765] Built IUTThreeClosures.HonestFinitePositiveLogVolume (6.5s)
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:126:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8717/8785] Built TateCurvesTheta.Theta.PuncturedProduct (38s)
✔ [8719/8785] Built IUTThreeClosures.FullPolyCore (6.3s)
⚠ [8720/8785] Built IUTThreeClosures.Cor312CoefficientAlgebra (5.8s)
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
✔ [8721/8785] Built Iut.Cor312.Container (5.8s)
✔ [8722/8785] Built Iut.Cor312.HolomorphicHull (5.9s)
⚠ [8723/8785] Built IUTThreeClosures.HonestPilotWitness (5.7s)
warning: IUTThreeClosures/HonestPilotWitness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestPilotWitness.lean:86:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8724/8785] Built Heights.WeilHeight (8.5s)
⚠ [8725/8785] Built IUTThreeClosures.ExplicitSemistableCurve (6.3s)
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:95:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8726/8785] Built IUTThreeClosures.SolvableRestrictionImage (6.6s)
warning: IUTThreeClosures/SolvableRestrictionImage.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/SolvableRestrictionImage.lean:121:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8727/8785] Built IUTThreeClosures.QPilotNormalizationAudit (6.5s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8728/8785] Built IUTThreeClosures.RootQPilotDivisor (5.8s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8729/8785] Built TateCurvesTheta.TateCurve.DefectVanishing (76s)
⚠ [8730/8785] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (5.0s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8731/8785] Built IUTThreeClosures.RamificationCorrectedQPilot (6.8s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8733/8785] Built IUTThreeClosures.AdmissiblePrimeSelection (5.8s)
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:104:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8734/8785] Built IUTThreeClosures.FiniteExceptionalSet (5.6s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8735/8785] Built IUTThreeClosures.ProductWeightMarginalization (6.9s)
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
✔ [8736/8785] Built IUTThreeClosures.WeakCompatibilityCountermodel (5.8s)
⚠ [8737/8785] Built IUTThreeClosures.GeneratedUnionCompactness (5.4s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8738/8785] Built Iut.Cor312.ContainerHull (5.5s)
✔ [8739/8785] Built Iut.Cor312.LogVolume (5.9s)
⚠ [8741/8800] Built IUTThreeClosures.HonestGeneratedSource (6.8s)
warning: IUTThreeClosures/HonestGeneratedSource.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8742/8800] Built IUTThreeClosures.ZModSL2Perfect (6.5s)
warning: IUTThreeClosures/ZModSL2Perfect.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZModSL2Perfect.lean:62:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8743/8800] Built TateCurvesTheta.TateCurve.TatePointOnCurve (6.1s)
⚠ [8744/8800] Built IUTThreeClosures.QPilotNormalizationFork (6.2s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8745/8800] Built Genl.Mathlib.Order.BoundedDiscrepancy (2.4s)
⚠ [8746/8800] Built IUTThreeClosures.TateParameterUnitBallRegion (2.6s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8747/8800] Built IUTThreeClosures.PrimePowerQPilotRegion (6.1s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8748/8800] Built IUTThreeClosures.FiniteExponentHull (5.8s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8749/8800] Built IUTThreeClosures.StandardZeroLabel (5.5s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8750/8800] Built IUTThreeClosures.BarycentricPacketReading (5.6s)
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
⚠ [8751/8800] Built IUTThreeClosures.DiagonalPacketNoGo (5.5s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8752/8800] Built IUTThreeClosures.PublicNormalizationObstruction (5.9s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8753/8800] Built IUTThreeClosures.IUTIVAbsorption (8.1s)
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
✔ [8754/8800] Built Iut4Sec1.Global.ArithmeticDivisor (5.0s)
✔ [8755/8800] Built Genl.GeneralPosition.HeightTheory (1.8s)
✔ [8756/8800] Built TateCurvesTheta.TateCurve.AdditionLaw (10s)
✔ [8757/8800] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (8.3s)
⚠ [8758/8800] Built IUTThreeClosures.DistinguishedLabelQPilot (8.0s)
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:52:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8759/8800] Built TateCurvesTheta.TateCurve.LargePointParametrization (13s)
⚠ [8760/8800] Built IUTThreeClosures.ZeroLabelBarycentric (6.0s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
⚠ [8761/8800] Built IUTThreeClosures.StatementIIOutsideFinite (5.4s)
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
✔ [8762/8800] Built TateCurvesTheta.TateCurve.AbelStep (5.3s)
✔ [8763/8800] Built TateCurvesTheta.TateCurve.GroupLaw (9.5s)
✔ [8764/8800] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (18s)
✔ [8765/8800] Built TateCurvesTheta.TateCurve.SurjectivitySphere (22s)
✔ [8766/8800] Built TateCurvesTheta.TateCurve.TateUniformization (4.1s)
✔ [8767/8800] Built TateCurvesTheta (3.4s)
✔ [8768/8800] Built Iut.Cor312.ThetaData.AdmissiblePrime (4.5s)
✔ [8769/8800] Built Iut.Cor312.ThetaData.Orbicurve (4.4s)
✔ [8770/8800] Built Iut.Cor312.ThetaData.LocalConditions (7.1s)
✔ [8771/8800] Built Iut.Cor312.ThetaData.Basic (4.3s)
✔ [8772/8800] Built Iut.Cor312.LeftHandSide (3.9s)
✔ [8773/8800] Built Iut.Cor312.RightHandSide (4.1s)
⚠ [8774/8800] Built IUTThreeClosures.NativeQPilotCalibration (4.3s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8775/8800] Built Iut.Cor312.Statement (4.8s)
⚠ [8776/8800] Built IUTThreeClosures.CorrectedQPilotDivisor (5.2s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8777/8800] Built IUTThreeClosures.ActualPilotWitness (3.8s)
✔ [8778/8800] Built IUTThreeClosures.GeneratedSource (4.3s)
✔ [8779/8800] Built IUTThreeClosures.QuantifierCorrectClosure (3.8s)
✔ [8780/8800] Built IUTThreeClosures.ABCClosure (3.9s)
⚠ [8781/8800] Built IUTThreeClosures.PublicLogVolumeInconsistency (4.1s)
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8782/8800] Built IUTThreeClosures.ThreeClosureTheorems (3.8s)
✔ [8783/8800] Built IUTThreeClosures.InhabitationBoundary (3.8s)
✔ [8784/8800] Built IUTThreeClosures.CircularityAudit (3.9s)
✔ [8785/8800] Built IUTThreeClosures.NonCircularDownstream (4.9s)
✔ [8786/8800] Built IUTThreeClosures.FourOpenConstructions (4.0s)
⚠ [8787/8800] Built IUTThreeClosures.ABCPointLegendreCurve (4.4s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8788/8800] Built IUTThreeClosures.PublicProgramUninhabited (4.1s)
warning: IUTThreeClosures/PublicProgramUninhabited.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8789/8800] Built IUTThreeClosures.BridgeInhabitationAudit (5.6s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
⚠ [8790/8800] Built IUTThreeClosures.LegendreArithmetic (5.4s)
warning: IUTThreeClosures/LegendreArithmetic.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8791/8800] Built IUTThreeClosures.TripodWeilHeight (4.6s)
warning: IUTThreeClosures/TripodWeilHeight.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/TripodWeilHeight.lean:94:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8792/8800] Built IUTThreeClosures.BridgeInhabitationExact (4.0s)
⚠ [8793/8800] Built IUTThreeClosures.ABCFreyCurve (5.9s)
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
⚠ [8794/8800] Built IUTThreeClosures.CanonicalQPilotCorridor (4.4s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✖ [8795/8800] Building IUTThreeClosures.ShiftedJAdmissibleCurve (5.0s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/ShiftedJAdmissibleCurve.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/ShiftedJAdmissibleCurve.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/ShiftedJAdmissibleCurve.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/ShiftedJAdmissibleCurve.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/ShiftedJAdmissibleCurve.setup.json --json
warning: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/ShiftedJAdmissibleCurve.lean:78:6: Tactic `rewrite` failed: Did not find an occurrence of the pattern
  ↑(Int.natAbs ?m.23)
in the target expression
  (2 * ↑P.c + ↑P.a).natAbs = 2 * P.c + P.a

P : ABCPoint
⊢ (2 * ↑P.c + ↑P.a).natAbs = 2 * P.c + P.a
error: Lean exited with code 1
⚠ [8796/8800] Built IUTThreeClosures.LegendreHeightCorridor (6.1s)
warning: IUTThreeClosures/LegendreHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8797/8800] Built IUTThreeClosures.CanonicalCorridorAudit (4.5s)
⚠ [8798/8800] Built IUTThreeClosures.SourceDerivedIUTIVBridge (5.4s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
Some required targets logged failures:
- IUTThreeClosures.ShiftedJAdmissibleCurve
error: build failed
```
