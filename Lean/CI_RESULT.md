# Lean CI result

- Tested commit: `3733a8cfdbc97f5dfb1d3ee1b12596d42ffbe80b`
- Lean setup: `success`
- Dependency resolution/cache: `success`
- `lake build`: `failure`

## Error summary

```text
===== lean-dependencies.log =====
===== lean-build.log =====
538:✖ [8799/8802] Building IUTThreeClosures.FreyJHeightCorridor (4.2s)
551:error: IUTThreeClosures/FreyJHeightCorridor.lean:77:2: mod_cast has type
555:error: IUTThreeClosures/FreyJHeightCorridor.lean:111:2: linarith failed to find a contradiction
567:error: IUTThreeClosures/FreyJHeightCorridor.lean:135:2: linarith failed to find a contradiction
579:error: Lean exited with code 1
580:Some required targets logged failures:
582:error: build failed
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
✔ [2/6] Built Cache.Cli (347ms)
✔ [3/6] Built Cache.Lean (464ms)
✔ [8/27] Built Cache.Cli:c.o (196ms)
✔ [10/27] Built Cache.Lean:c.o (282ms)
✔ [11/27] Built Cache.Infra (515ms)
✔ [12/27] Built Cache.Infra:c.o (241ms)
✔ [13/27] Built Cache.IO (1.6s)
✔ [14/27] Built Cache.Hashing (860ms)
✔ [15/27] Built Cache.Hashing:c.o (653ms)
✔ [16/27] Built Cache.IO:c.o (1.8s)
✔ [17/27] Built Cache.Requests (2.2s)
✔ [18/27] Built Cache.Marker (619ms)
✔ [19/27] Built Cache.Marker:c.o (141ms)
✔ [20/27] Built Cache.Query (783ms)
✔ [21/27] Built Cache.Query:c.o (501ms)
✔ [22/27] Built Cache.Warning (795ms)
✔ [23/27] Built Cache.Warning:c.o (292ms)
✔ [24/27] Built Cache.Requests:c.o (3.3s)
✔ [25/27] Built Cache.Main (1.9s)
✔ [26/27] Built Cache.Main:c.o (970ms)
✔ [27/27] Built cache:exe (742ms)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
Attempting to download 8639 file(s) from leanprover-community/mathlib4 cache at https://lakecache.blob.core.windows.net/mathlib4-master
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 14 KB/s], Decompressed: 0Downloaded: 72 file(s) [attempted 72/8639 = 0%, 311 KB/s], Decompressed: 9Downloaded: 159 file(s) [attempted 159/8639 = 1%, 674 KB/s], Decompressed: 34Downloaded: 262 file(s) [attempted 262/8639 = 3%, 139 KB/s], Decompressed: 34Downloaded: 386 file(s) [attempted 386/8639 = 4%, 370 KB/s], Decompressed: 34Downloaded: 509 file(s) [attempted 509/8639 = 5%, 691 KB/s], Decompressed: 34Downloaded: 607 file(s) [attempted 607/8639 = 7%, 137 KB/s], Decompressed: 34Downloaded: 733 file(s) [attempted 733/8639 = 8%, 101 KB/s], Decompressed: 143Downloaded: 848 file(s) [attempted 848/8639 = 9%, 1352 KB/s], Decompressed: 143Downloaded: 971 file(s) [attempted 971/8639 = 11%, 518 KB/s], Decompressed: 143Downloaded: 1102 file(s) [attempted 1102/8639 = 12%, 1874 KB/s], Decompressed: 143Downloaded: 1233 file(s) [attempted 1233/8639 = 14%, 2863 KB/s], Decompressed: 143Downloaded: 1358 file(s) [attempted 1358/8639 = 15%, 1309 KB/s], Decompressed: 143Downloaded: 1491 file(s) [attempted 1491/8639 = 17%, 672 KB/s], Decompressed: 143Downloaded: 1606 file(s) [attempted 1606/8639 = 18%, 90 KB/s], Decompressed: 143Downloaded: 1750 file(s) [attempted 1750/8639 = 20%, 542 KB/s], Decompressed: 143Downloaded: 1861 file(s) [attempted 1861/8639 = 21%, 474 KB/s], Decompressed: 143Downloaded: 1974 file(s) [attempted 1974/8639 = 22%, 451 KB/s], Decompressed: 143Downloaded: 2083 file(s) [attempted 2083/8639 = 24%, 173 KB/s], Decompressed: 143Downloaded: 2209 file(s) [attempted 2209/8639 = 25%, 504 KB/s], Decompressed: 143Downloaded: 2305 file(s) [attempted 2305/8639 = 26%, 1230 KB/s], Decompressed: 143Downloaded: 2424 file(s) [attempted 2424/8639 = 28%, 377 KB/s], Decompressed: 143Downloaded: 2559 file(s) [attempted 2559/8639 = 29%, 3757 KB/s], Decompressed: 143Downloaded: 2690 file(s) [attempted 2690/8639 = 31%, 105 KB/s], Decompressed: 143Downloaded: 2825 file(s) [attempted 2825/8639 = 32%, 226 KB/s], Decompressed: 670Downloaded: 2937 file(s) [attempted 2937/8639 = 33%, 3553 KB/s], Decompressed: 670Downloaded: 3048 file(s) [attempted 3048/8639 = 35%, 1516 KB/s], Decompressed: 670Downloaded: 3181 file(s) [attempted 3181/8639 = 36%, 1173 KB/s], Decompressed: 670Downloaded: 3298 file(s) [attempted 3298/8639 = 38%, 831 KB/s], Decompressed: 670Downloaded: 3412 file(s) [attempted 3412/8639 = 39%, 291 KB/s], Decompressed: 670Downloaded: 3521 file(s) [attempted 3521/8639 = 40%, 1389 KB/s], Decompressed: 670Downloaded: 3633 file(s) [attempted 3633/8639 = 42%, 8299 KB/s], Decompressed: 670Downloaded: 3767 file(s) [attempted 3767/8639 = 43%, 1957 KB/s], Decompressed: 670Downloaded: 3896 file(s) [attempted 3896/8639 = 45%, 583 KB/s], Decompressed: 670Downloaded: 4013 file(s) [attempted 4013/8639 = 46%, 924 KB/s], Decompressed: 670Downloaded: 4104 file(s) [attempted 4104/8639 = 47%, 1949 KB/s], Decompressed: 670Downloaded: 4186 file(s) [attempted 4186/8639 = 48%, 824 KB/s], Decompressed: 670Downloaded: 4312 file(s) [attempted 4312/8639 = 49%, 1261 KB/s], Decompressed: 670Downloaded: 4426 file(s) [attempted 4426/8639 = 51%, 906 KB/s], Decompressed: 670Downloaded: 4547 file(s) [attempted 4547/8639 = 52%, 504 KB/s], Decompressed: 670Downloaded: 4661 file(s) [attempted 4661/8639 = 53%, 593 KB/s], Decompressed: 670Downloaded: 4743 file(s) [attempted 4743/8639 = 54%, 329 KB/s], Decompressed: 670Downloaded: 4857 file(s) [attempted 4857/8639 = 56%, 492 KB/s], Decompressed: 670Downloaded: 4995 file(s) [attempted 4995/8639 = 57%, 1559 KB/s], Decompressed: 670Downloaded: 5128 file(s) [attempted 5128/8639 = 59%, 5445 KB/s], Decompressed: 670Downloaded: 5240 file(s) [attempted 5240/8639 = 60%, 816 KB/s], Decompressed: 670Downloaded: 5358 file(s) [attempted 5358/8639 = 62%, 1653 KB/s], Decompressed: 670Downloaded: 5482 file(s) [attempted 5482/8639 = 63%, 643 KB/s], Decompressed: 670Downloaded: 5592 file(s) [attempted 5592/8639 = 64%, 3229 KB/s], Decompressed: 670Downloaded: 5719 file(s) [attempted 5719/8639 = 66%, 291 KB/s], Decompressed: 670Downloaded: 5843 file(s) [attempted 5843/8639 = 67%, 2595 KB/s], Decompressed: 670Downloaded: 5985 file(s) [attempted 5985/8639 = 69%, 344 KB/s], Decompressed: 670Downloaded: 6093 file(s) [attempted 6093/8639 = 70%, 2069 KB/s], Decompressed: 670Downloaded: 6179 file(s) [attempted 6179/8639 = 71%, 396 KB/s], Decompressed: 670Downloaded: 6233 file(s) [attempted 6233/8639 = 72%, 1173 KB/s], Decompressed: 670Downloaded: 6328 file(s) [attempted 6328/8639 = 73%, 7384 KB/s], Decompressed: 670Downloaded: 6426 file(s) [attempted 6426/8639 = 74%, 482 KB/s], Decompressed: 670Downloaded: 6529 file(s) [attempted 6529/8639 = 75%, 246 KB/s], Decompressed: 670Downloaded: 6634 file(s) [attempted 6634/8639 = 76%, 281 KB/s], Decompressed: 670Downloaded: 6734 file(s) [attempted 6734/8639 = 77%, 1174 KB/s], Decompressed: 670Downloaded: 6846 file(s) [attempted 6846/8639 = 79%, 500 KB/s], Decompressed: 670Downloaded: 6934 file(s) [attempted 6934/8639 = 80%, 125 KB/s], Decompressed: 670Downloaded: 7054 file(s) [attempted 7054/8639 = 81%, 879 KB/s], Decompressed: 670Downloaded: 7107 file(s) [attempted 7107/8639 = 82%, 4105 KB/s], Decompressed: 670Downloaded: 7210 file(s) [attempted 7210/8639 = 83%, 5131 KB/s], Decompressed: 670Downloaded: 7314 file(s) [attempted 7314/8639 = 84%, 1106 KB/s], Decompressed: 670Downloaded: 7414 file(s) [attempted 7414/8639 = 85%, 4779 KB/s], Decompressed: 670Downloaded: 7549 file(s) [attempted 7549/8639 = 87%, 887 KB/s], Decompressed: 670Downloaded: 7689 file(s) [attempted 7689/8639 = 89%, 1221 KB/s], Decompressed: 670Downloaded: 7836 file(s) [attempted 7836/8639 = 90%, 236 KB/s], Decompressed: 670Downloaded: 7960 file(s) [attempted 7960/8639 = 92%, 4741 KB/s], Decompressed: 670Downloaded: 8093 file(s) [attempted 8093/8639 = 93%, 185 KB/s], Decompressed: 670Downloaded: 8219 file(s) [attempted 8219/8639 = 95%, 5892 KB/s], Decompressed: 670Downloaded: 8344 file(s) [attempted 8344/8639 = 96%, 1908 KB/s], Decompressed: 670Downloaded: 8466 file(s) [attempted 8466/8639 = 97%, 2262 KB/s], Decompressed: 670Downloaded: 8580 file(s) [attempted 8580/8639 = 99%, 2481 KB/s], Decompressed: 670Downloaded: 8638 file(s) [attempted 8638/8639 = 99%, 451 KB/s], Decompressed: 670Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 451 KB/s], Decompressed: 670
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (460ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.UltrametricSum (3.5s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.MaxTerm (3.7s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (4.3s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (9.2s)
✔ [8661/8671] Built TateCurvesTheta.Analysis.Strassmann (5.0s)
✔ [8662/8673] Built Iut.Cor312.ThetaData.Places (7.8s)
✔ [8663/8673] Built TateCurvesTheta.AnalyticQuotient (8.6s)
✔ [8664/8675] Built TateCurvesTheta.QParameter.BaseChange (3.5s)
✔ [8665/8675] Built TateCurvesTheta.QParameter.PrimeToOrder (3.1s)
✔ [8666/8675] Built TateCurvesTheta.TateCurve.Weierstrass (4.4s)
✔ [8667/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (6.1s)
✔ [8668/8684] Built TateCurvesTheta.QParameter.NormalizedOrder (4.1s)
✔ [8669/8685] Built TateCurvesTheta.TateCurve.Discriminant (5.5s)
✔ [8670/8685] Built TateCurvesTheta.TateCurve.Parametrization (5.2s)
✔ [8671/8689] Built TateCurvesTheta.Theta.Basic (4.1s)
✔ [8672/8689] Built Iut.Cor312.ThetaData.GlobalField (14s)
✔ [8673/8689] Built TateCurvesTheta.TateCurve.JInvariant (3.7s)
✔ [8674/8692] Built TateCurvesTheta.TateCurve.SplitReduction (5.2s)
✔ [8675/8692] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (3.3s)
✔ [8676/8693] Built TateCurvesTheta.Theta.Periodicity (3.8s)
✔ [8677/8696] Built TateCurvesTheta.TateCurve.CoordinateExpansion (4.7s)
✔ [8678/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (5.4s)
✔ [8679/8696] Built TateCurvesTheta.Theta.Product (6.3s)
✔ [8680/8696] Built TateCurvesTheta.QParameter.JParametrization (9.9s)
✔ [8681/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (11s)
✔ [8682/8696] Built TateCurvesTheta.Theta.Divisor (6.6s)
✔ [8683/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (11s)
✔ [8684/8702] Built TateCurvesTheta.Theta.Uniqueness (5.1s)
✔ [8685/8702] Built TateCurvesTheta.QParameter.Characterization (4.9s)
✔ [8686/8702] Built TateCurvesTheta.Theta.FactorSeries (6.9s)
✔ [8687/8704] Built TateCurvesTheta.TateCurve.EisensteinSeries (14s)
✔ [8688/8705] Built TateCurvesTheta.TateCurve.TatePointMem (3.6s)
✔ [8689/8708] Built TateCurvesTheta.Theta.LaurentSphere (5.4s)
✔ [8690/8708] Built TateCurvesTheta.Theta.ThetaProdLaurent (5.6s)
✔ [8691/8711] Built TateCurvesTheta.Theta.QBinomial (4.8s)
✔ [8692/8712] Built TateCurvesTheta.Theta.LaurentSphereReduce (3.9s)
✔ [8693/8713] Built TateCurvesTheta.TateCurve.CoordinateInversion (4.5s)
✔ [8694/8713] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (4.6s)
✔ [8695/8714] Built TateCurvesTheta.Theta.LaurentUnitSphere (4.1s)
✔ [8696/8715] Built TateCurvesTheta.TateCurve.IntegralModel (5.8s)
✔ [8697/8715] Built TateCurvesTheta.TateCurve.Quotient (7.6s)
✔ [8698/8717] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (4.9s)
✔ [8699/8717] Built TateCurvesTheta.TateCurve.SphereBounds (6.8s)
✔ [8700/8718] Built TateCurvesTheta.Theta.Normalization (4.3s)
✔ [8701/8719] Built TateCurvesTheta.Theta.FactorReciprocal (5.5s)
✔ [8702/8720] Built TateCurvesTheta.Theta.Durfee (8.5s)
✔ [8703/8720] Built TateCurvesTheta.Theta.LaurentUnique (4.8s)
✔ [8704/8720] Built TateCurvesTheta.TateCurve.PointMap (11s)
✔ [8705/8720] Built TateCurvesTheta.Theta.RatioAnnulus (3.9s)
✔ [8706/8721] Built TateCurvesTheta.Theta.Inversion (4.4s)
✔ [8707/8722] Built TateCurvesTheta.Theta.SeriesZero (5.8s)
✔ [8708/8722] Built TateCurvesTheta.Theta.WeightSpace (16s)
✔ [8709/8729] Built TateCurvesTheta.Theta.TripleProduct (4.9s)
✔ [8710/8731] Built TateCurvesTheta.Theta.StrictDominant (11s)
✔ [8711/8733] Built TateCurvesTheta.Uniformization (10s)
✔ [8712/8735] Built Iut.Cor312.Procession (10s)
✔ [8713/8765] Built Iut.Cor312.RationalPlace (7.3s)
✔ [8714/8765] Built Iut.Cor312.PacketPresentation (9.3s)
✔ [8715/8765] Built IUTThreeClosures.ABCStatement (3.2s)
⚠ [8716/8765] Built IUTThreeClosures.HonestFinitePositiveLogVolume (8.4s)
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:126:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8717/8787] Built IUTThreeClosures.FullPolyCore (7.7s)
✔ [8719/8787] Built TateCurvesTheta.Theta.PuncturedProduct (51s)
⚠ [8720/8787] Built IUTThreeClosures.Cor312CoefficientAlgebra (7.0s)
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
✔ [8721/8787] Built Iut.Cor312.Container (5.0s)
✔ [8722/8787] Built Iut.Cor312.HolomorphicHull (6.2s)
⚠ [8723/8787] Built IUTThreeClosures.HonestPilotWitness (6.6s)
warning: IUTThreeClosures/HonestPilotWitness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestPilotWitness.lean:86:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8724/8787] Built IUTThreeClosures.WeakCompatibilityCountermodel (5.8s)
⚠ [8725/8787] Built IUTThreeClosures.ExplicitSemistableCurve (6.9s)
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:95:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8726/8787] Built Heights.WeilHeight (8.8s)
⚠ [8727/8787] Built IUTThreeClosures.SolvableRestrictionImage (7.4s)
warning: IUTThreeClosures/SolvableRestrictionImage.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/SolvableRestrictionImage.lean:121:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8728/8787] Built IUTThreeClosures.QPilotNormalizationAudit (6.0s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8729/8787] Built IUTThreeClosures.RootQPilotDivisor (6.4s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8730/8787] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (6.2s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8731/8787] Built IUTThreeClosures.RamificationCorrectedQPilot (7.0s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8732/8787] Built IUTThreeClosures.ProductWeightMarginalization (7.8s)
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
⚠ [8734/8787] Built IUTThreeClosures.AdmissiblePrimeSelection (6.6s)
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:104:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8735/8787] Built IUTThreeClosures.FiniteExceptionalSet (5.0s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8736/8787] Built IUTThreeClosures.GeneratedUnionCompactness (5.8s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8737/8787] Built Iut.Cor312.LogVolume (6.6s)
✔ [8738/8787] Built TateCurvesTheta.TateCurve.DefectVanishing (107s)
✔ [8739/8798] Built Iut.Cor312.ContainerHull (6.2s)
⚠ [8740/8798] Built IUTThreeClosures.HonestGeneratedSource (6.6s)
warning: IUTThreeClosures/HonestGeneratedSource.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8742/8802] Built IUTThreeClosures.ZModSL2Perfect (6.1s)
warning: IUTThreeClosures/ZModSL2Perfect.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZModSL2Perfect.lean:62:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8743/8802] Built IUTThreeClosures.QPilotNormalizationFork (6.3s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8744/8802] Built Genl.Mathlib.Order.BoundedDiscrepancy (3.6s)
⚠ [8745/8802] Built IUTThreeClosures.PrimePowerQPilotRegion (7.0s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8746/8802] Built TateCurvesTheta.TateCurve.TatePointOnCurve (7.3s)
⚠ [8747/8802] Built IUTThreeClosures.TateParameterUnitBallRegion (3.0s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8748/8802] Built IUTThreeClosures.FiniteExponentHull (6.0s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8749/8802] Built IUTThreeClosures.StandardZeroLabel (5.8s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8750/8802] Built IUTThreeClosures.DiagonalPacketNoGo (5.9s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8751/8802] Built IUTThreeClosures.BarycentricPacketReading (6.1s)
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
✔ [8752/8802] Built Genl.GeneralPosition.HeightTheory (1.8s)
⚠ [8753/8802] Built IUTThreeClosures.PublicNormalizationObstruction (6.9s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8754/8802] Built Iut4Sec1.Global.ArithmeticDivisor (6.3s)
⚠ [8755/8802] Built IUTThreeClosures.IUTIVAbsorption (8.9s)
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
⚠ [8756/8802] Built IUTThreeClosures.DistinguishedLabelQPilot (6.3s)
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:52:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8757/8802] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (10s)
⚠ [8758/8802] Built IUTThreeClosures.ZeroLabelBarycentric (9.4s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
✔ [8759/8802] Built TateCurvesTheta.TateCurve.AdditionLaw (12s)
✔ [8760/8802] Built TateCurvesTheta.TateCurve.LargePointParametrization (16s)
⚠ [8761/8802] Built IUTThreeClosures.StatementIIOutsideFinite (6.7s)
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
✔ [8762/8802] Built TateCurvesTheta.TateCurve.AbelStep (6.9s)
✔ [8763/8802] Built TateCurvesTheta.TateCurve.GroupLaw (11s)
✔ [8764/8802] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (25s)
✔ [8765/8802] Built TateCurvesTheta.TateCurve.SurjectivitySphere (25s)
✔ [8766/8802] Built TateCurvesTheta.TateCurve.TateUniformization (4.2s)
✔ [8767/8802] Built TateCurvesTheta (3.3s)
✔ [8768/8802] Built Iut.Cor312.ThetaData.AdmissiblePrime (4.5s)
✔ [8769/8802] Built Iut.Cor312.ThetaData.Orbicurve (4.4s)
✔ [8770/8802] Built Iut.Cor312.ThetaData.LocalConditions (7.6s)
✔ [8771/8802] Built Iut.Cor312.ThetaData.Basic (4.6s)
✔ [8772/8802] Built Iut.Cor312.LeftHandSide (3.9s)
✔ [8773/8802] Built Iut.Cor312.RightHandSide (4.1s)
✔ [8774/8802] Built Iut.Cor312.Statement (3.9s)
⚠ [8775/8802] Built IUTThreeClosures.CorrectedQPilotDivisor (5.7s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8776/8802] Built IUTThreeClosures.NativeQPilotCalibration (5.8s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8777/8802] Built IUTThreeClosures.ActualPilotWitness (4.1s)
✔ [8778/8802] Built IUTThreeClosures.GeneratedSource (4.3s)
✔ [8779/8802] Built IUTThreeClosures.QuantifierCorrectClosure (3.8s)
✔ [8780/8802] Built IUTThreeClosures.ABCClosure (3.0s)
⚠ [8781/8802] Built IUTThreeClosures.PublicLogVolumeInconsistency (4.2s)
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8782/8802] Built IUTThreeClosures.ThreeClosureTheorems (3.7s)
✔ [8783/8802] Built IUTThreeClosures.InhabitationBoundary (3.8s)
✔ [8784/8802] Built IUTThreeClosures.CircularityAudit (3.8s)
✔ [8785/8802] Built IUTThreeClosures.NonCircularDownstream (4.9s)
✔ [8786/8802] Built IUTThreeClosures.FourOpenConstructions (4.0s)
⚠ [8787/8802] Built IUTThreeClosures.ABCPointLegendreCurve (4.4s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8788/8802] Built IUTThreeClosures.BridgeInhabitationAudit (4.6s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
⚠ [8789/8802] Built IUTThreeClosures.PublicProgramUninhabited (5.5s)
warning: IUTThreeClosures/PublicProgramUninhabited.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8790/8802] Built IUTThreeClosures.LegendreArithmetic (6.2s)
warning: IUTThreeClosures/LegendreArithmetic.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8791/8802] Built IUTThreeClosures.BridgeInhabitationExact (5.1s)
⚠ [8792/8802] Built IUTThreeClosures.ABCFreyCurve (5.4s)
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
⚠ [8793/8802] Built IUTThreeClosures.TripodWeilHeight (5.6s)
warning: IUTThreeClosures/TripodWeilHeight.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/TripodWeilHeight.lean:94:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8794/8802] Built IUTThreeClosures.CanonicalQPilotCorridor (4.7s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8795/8802] Built IUTThreeClosures.LegendreHeightCorridor (5.1s)
warning: IUTThreeClosures/LegendreHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8796/8802] Built IUTThreeClosures.CanonicalCorridorAudit (5.4s)
⚠ [8797/8802] Built IUTThreeClosures.SourceDerivedIUTIVBridge (5.4s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8798/8802] Built IUTThreeClosures.FreyJReducedData (4.6s)
warning: IUTThreeClosures/FreyJReducedData.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✖ [8799/8802] Building IUTThreeClosures.FreyJHeightCorridor (4.2s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/FreyJHeightCorridor.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/FreyJHeightCorridor.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/FreyJHeightCorridor.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/FreyJHeightCorridor.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/FreyJHeightCorridor.setup.json --json
warning: IUTThreeClosures/FreyJHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/FreyJHeightCorridor.lean:48:26: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`
warning: IUTThreeClosures/FreyJHeightCorridor.lean:48:26: 'ring' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
error: IUTThreeClosures/FreyJHeightCorridor.lean:77:2: mod_cast has type
  (↑(NNRat.divNat P.freyJReducedNum P.freyJReducedDen)).den = P.freyJReducedDen
but is expected to have type
  (↑P.freyJReducedNum / ↑P.freyJReducedDen).den = P.freyJReducedDen
error: IUTThreeClosures/FreyJHeightCorridor.lean:111:2: linarith failed to find a contradiction
P : ABCPoint
M : ℕ := max P.freyJReducedNum P.freyJReducedDen
hM : 0 < M
hnat : P.c ^ 6 ≤ 8 * M
hcR : 0 < ↑P.c
hMR : 0 < ↑M
hreal : ↑P.c ^ 6 ≤ 8 * ↑M
hlog : 6 * Real.log ↑P.c ≤ Real.log 8 + Real.log ↑M
a✝ : Real.log (max ↑P.freyJReducedNum ↑P.freyJReducedDen) / 6 + Real.log 8 / 6 < Real.log ↑P.c
⊢ False
failed
error: IUTThreeClosures/FreyJHeightCorridor.lean:135:2: linarith failed to find a contradiction
P : ABCPoint
M : ℕ := max P.freyJReducedNum P.freyJReducedDen
hM : 0 < M
hnat : M ≤ 256 * P.c ^ 6
hMR : 0 < ↑M
hcR : 0 < ↑P.c
hreal : ↑M ≤ 256 * ↑P.c ^ 6
hlog : Real.log ↑M ≤ Real.log 256 + 6 * Real.log ↑P.c
a✝ : Real.log ↑P.c + Real.log 256 / 6 < Real.log (max ↑P.freyJReducedNum ↑P.freyJReducedDen) / 6
⊢ False
failed
error: Lean exited with code 1
Some required targets logged failures:
- IUTThreeClosures.FreyJHeightCorridor
error: build failed
```
