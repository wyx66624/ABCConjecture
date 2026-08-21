# Lean CI result

- Tested commit: `7275497e2da2b861325f4f5ab809175af696e87e`
- Lean setup: `success`
- Dependency resolution/cache: `success`
- `lake build`: `failure`

## Error summary

```text
===== lean-dependencies.log =====
===== lean-build.log =====
538:✖ [8799/8802] Building IUTThreeClosures.FreyJHeightCorridor (4.7s)
545:error: IUTThreeClosures/FreyJHeightCorridor.lean:118:4: linarith failed to find a contradiction
557:error: IUTThreeClosures/FreyJHeightCorridor.lean:145:4: linarith failed to find a contradiction
569:error: Lean exited with code 1
570:Some required targets logged failures:
572:error: build failed
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
✔ [2/6] Built Cache.Cli (368ms)
✔ [3/6] Built Cache.Lean (469ms)
✔ [8/27] Built Cache.Cli:c.o (182ms)
✔ [10/27] Built Cache.Lean:c.o (282ms)
✔ [11/27] Built Cache.Infra (492ms)
✔ [12/27] Built Cache.Infra:c.o (212ms)
✔ [13/27] Built Cache.IO (1.5s)
✔ [14/27] Built Cache.Hashing (851ms)
✔ [15/27] Built Cache.Hashing:c.o (427ms)
✔ [16/27] Built Cache.IO:c.o (1.7s)
✔ [17/27] Built Cache.Requests (2.1s)
✔ [18/27] Built Cache.Marker (644ms)
✔ [19/27] Built Cache.Marker:c.o (126ms)
✔ [20/27] Built Cache.Query (813ms)
✔ [21/27] Built Cache.Query:c.o (301ms)
✔ [22/27] Built Cache.Warning (857ms)
✔ [23/27] Built Cache.Warning:c.o (258ms)
✔ [24/27] Built Cache.Requests:c.o (3.0s)
✔ [25/27] Built Cache.Main (1.6s)
✔ [26/27] Built Cache.Main:c.o (879ms)
✔ [27/27] Built cache:exe (742ms)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
Attempting to download 8639 file(s) from leanprover-community/mathlib4 cache at https://lakecache.blob.core.windows.net/mathlib4-master
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 16 KB/s], Decompressed: 0Downloaded: 94 file(s) [attempted 94/8639 = 1%, 92 KB/s], Decompressed: 16Downloaded: 202 file(s) [attempted 202/8639 = 2%, 2079 KB/s], Decompressed: 44Downloaded: 318 file(s) [attempted 318/8639 = 3%, 580 KB/s], Decompressed: 44Downloaded: 442 file(s) [attempted 442/8639 = 5%, 1659 KB/s], Decompressed: 44Downloaded: 565 file(s) [attempted 565/8639 = 6%, 992 KB/s], Decompressed: 150Downloaded: 700 file(s) [attempted 700/8639 = 8%, 607 KB/s], Decompressed: 150Downloaded: 836 file(s) [attempted 836/8639 = 9%, 2561 KB/s], Decompressed: 150Downloaded: 962 file(s) [attempted 962/8639 = 11%, 624 KB/s], Decompressed: 150Downloaded: 1100 file(s) [attempted 1100/8639 = 12%, 316 KB/s], Decompressed: 150Downloaded: 1237 file(s) [attempted 1237/8639 = 14%, 619 KB/s], Decompressed: 150Downloaded: 1372 file(s) [attempted 1372/8639 = 15%, 3794 KB/s], Decompressed: 150Downloaded: 1502 file(s) [attempted 1502/8639 = 17%, 1590 KB/s], Decompressed: 150Downloaded: 1636 file(s) [attempted 1636/8639 = 18%, 191 KB/s], Decompressed: 150Downloaded: 1741 file(s) [attempted 1741/8639 = 20%, 619 KB/s], Decompressed: 150Downloaded: 1876 file(s) [attempted 1876/8639 = 21%, 2889 KB/s], Decompressed: 150Downloaded: 2006 file(s) [attempted 2006/8639 = 23%, 163 KB/s], Decompressed: 150Downloaded: 2130 file(s) [attempted 2130/8639 = 24%, 1247 KB/s], Decompressed: 150Downloaded: 2256 file(s) [attempted 2256/8639 = 26%, 406 KB/s], Decompressed: 150Downloaded: 2391 file(s) [attempted 2391/8639 = 27%, 823 KB/s], Decompressed: 150Downloaded: 2510 file(s) [attempted 2510/8639 = 29%, 228 KB/s], Decompressed: 561Downloaded: 2622 file(s) [attempted 2622/8639 = 30%, 1218 KB/s], Decompressed: 561Downloaded: 2764 file(s) [attempted 2764/8639 = 31%, 630 KB/s], Decompressed: 561Downloaded: 2878 file(s) [attempted 2878/8639 = 33%, 2098 KB/s], Decompressed: 561Downloaded: 2978 file(s) [attempted 2978/8639 = 34%, 300 KB/s], Decompressed: 561Downloaded: 3051 file(s) [attempted 3051/8639 = 35%, 5569 KB/s], Decompressed: 561Downloaded: 3151 file(s) [attempted 3151/8639 = 36%, 634 KB/s], Decompressed: 561Downloaded: 3269 file(s) [attempted 3269/8639 = 37%, 818 KB/s], Decompressed: 561Downloaded: 3398 file(s) [attempted 3398/8639 = 39%, 2229 KB/s], Decompressed: 561Downloaded: 3515 file(s) [attempted 3515/8639 = 40%, 1682 KB/s], Decompressed: 561Downloaded: 3636 file(s) [attempted 3636/8639 = 42%, 237 KB/s], Decompressed: 561Downloaded: 3762 file(s) [attempted 3762/8639 = 43%, 772 KB/s], Decompressed: 561Downloaded: 3904 file(s) [attempted 3904/8639 = 45%, 3667 KB/s], Decompressed: 561Downloaded: 4039 file(s) [attempted 4039/8639 = 46%, 435 KB/s], Decompressed: 561Downloaded: 4107 file(s) [attempted 4107/8639 = 47%, 1074 KB/s], Decompressed: 561Downloaded: 4229 file(s) [attempted 4229/8639 = 48%, 177 KB/s], Decompressed: 561Downloaded: 4352 file(s) [attempted 4352/8639 = 50%, 6071 KB/s], Decompressed: 561Downloaded: 4459 file(s) [attempted 4459/8639 = 51%, 3909 KB/s], Decompressed: 561Downloaded: 4578 file(s) [attempted 4578/8639 = 52%, 404 KB/s], Decompressed: 561Downloaded: 4682 file(s) [attempted 4682/8639 = 54%, 124 KB/s], Decompressed: 561Downloaded: 4764 file(s) [attempted 4764/8639 = 55%, 193 KB/s], Decompressed: 561Downloaded: 4860 file(s) [attempted 4860/8639 = 56%, 743 KB/s], Decompressed: 561Downloaded: 4960 file(s) [attempted 4960/8639 = 57%, 3343 KB/s], Decompressed: 561Downloaded: 5090 file(s) [attempted 5090/8639 = 58%, 4743 KB/s], Decompressed: 561Downloaded: 5198 file(s) [attempted 5198/8639 = 60%, 1283 KB/s], Decompressed: 561Downloaded: 5312 file(s) [attempted 5312/8639 = 61%, 945 KB/s], Decompressed: 561Downloaded: 5445 file(s) [attempted 5445/8639 = 63%, 1586 KB/s], Decompressed: 561Downloaded: 5568 file(s) [attempted 5568/8639 = 64%, 2792 KB/s], Decompressed: 561Downloaded: 5682 file(s) [attempted 5682/8639 = 65%, 1480 KB/s], Decompressed: 561Downloaded: 5814 file(s) [attempted 5814/8639 = 67%, 1217 KB/s], Decompressed: 561Downloaded: 5927 file(s) [attempted 5927/8639 = 68%, 2359 KB/s], Decompressed: 561Downloaded: 6015 file(s) [attempted 6015/8639 = 69%, 1888 KB/s], Decompressed: 561Downloaded: 6139 file(s) [attempted 6139/8639 = 71%, 420 KB/s], Decompressed: 561Downloaded: 6251 file(s) [attempted 6251/8639 = 72%, 523 KB/s], Decompressed: 561Downloaded: 6384 file(s) [attempted 6384/8639 = 73%, 711 KB/s], Decompressed: 561Downloaded: 6505 file(s) [attempted 6505/8639 = 75%, 1105 KB/s], Decompressed: 561Downloaded: 6607 file(s) [attempted 6607/8639 = 76%, 225 KB/s], Decompressed: 561Downloaded: 6671 file(s) [attempted 6671/8639 = 77%, 2094 KB/s], Decompressed: 561Downloaded: 6787 file(s) [attempted 6787/8639 = 78%, 862 KB/s], Decompressed: 561Downloaded: 6904 file(s) [attempted 6904/8639 = 79%, 3910 KB/s], Decompressed: 561Downloaded: 7042 file(s) [attempted 7042/8639 = 81%, 1031 KB/s], Decompressed: 561Downloaded: 7160 file(s) [attempted 7160/8639 = 82%, 398 KB/s], Decompressed: 561Downloaded: 7291 file(s) [attempted 7291/8639 = 84%, 5388 KB/s], Decompressed: 561Downloaded: 7421 file(s) [attempted 7421/8639 = 85%, 383 KB/s], Decompressed: 561Downloaded: 7557 file(s) [attempted 7557/8639 = 87%, 2207 KB/s], Decompressed: 561Downloaded: 7675 file(s) [attempted 7675/8639 = 88%, 834 KB/s], Decompressed: 561Downloaded: 7808 file(s) [attempted 7808/8639 = 90%, 602 KB/s], Decompressed: 561Downloaded: 7925 file(s) [attempted 7925/8639 = 91%, 2513 KB/s], Decompressed: 561Downloaded: 8060 file(s) [attempted 8060/8639 = 93%, 858 KB/s], Decompressed: 561Downloaded: 8186 file(s) [attempted 8186/8639 = 94%, 989 KB/s], Decompressed: 561Downloaded: 8321 file(s) [attempted 8321/8639 = 96%, 100 KB/s], Decompressed: 561Downloaded: 8445 file(s) [attempted 8445/8639 = 97%, 1930 KB/s], Decompressed: 561Downloaded: 8503 file(s) [attempted 8503/8639 = 98%, 6675 KB/s], Decompressed: 561Downloaded: 8610 file(s) [attempted 8610/8639 = 99%, 4485 KB/s], Decompressed: 561Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 4485 KB/s], Decompressed: 561
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (455ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.MaxTerm (2.0s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.UltrametricSum (3.5s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (3.8s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (8.2s)
✔ [8661/8673] Built TateCurvesTheta.AnalyticQuotient (8.6s)
✔ [8662/8673] Built Iut.Cor312.ThetaData.Places (7.4s)
✔ [8663/8675] Built TateCurvesTheta.QParameter.BaseChange (3.6s)
✔ [8664/8675] Built TateCurvesTheta.Analysis.Strassmann (4.6s)
✔ [8665/8675] Built TateCurvesTheta.TateCurve.Weierstrass (3.7s)
✔ [8666/8678] Built TateCurvesTheta.QParameter.PrimeToOrder (3.0s)
✔ [8667/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (5.7s)
✔ [8668/8680] Built TateCurvesTheta.TateCurve.Discriminant (5.2s)
✔ [8669/8680] Built TateCurvesTheta.QParameter.NormalizedOrder (4.2s)
✔ [8670/8680] Built TateCurvesTheta.TateCurve.Parametrization (4.3s)
✔ [8671/8680] Built TateCurvesTheta.TateCurve.JInvariant (3.4s)
✔ [8672/8684] Built TateCurvesTheta.TateCurve.SplitReduction (4.7s)
✔ [8673/8684] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (2.9s)
✔ [8674/8692] Built Iut.Cor312.ThetaData.GlobalField (15s)
✔ [8675/8696] Built TateCurvesTheta.TateCurve.CoordinateExpansion (4.0s)
✔ [8676/8696] Built TateCurvesTheta.Theta.Basic (4.4s)
✔ [8677/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (6.2s)
✔ [8678/8696] Built TateCurvesTheta.QParameter.JParametrization (9.5s)
✔ [8679/8696] Built TateCurvesTheta.Theta.Periodicity (4.2s)
✔ [8680/8696] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (10s)
✔ [8681/8704] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (9.6s)
✔ [8682/8705] Built TateCurvesTheta.QParameter.Characterization (4.1s)
✔ [8683/8708] Built TateCurvesTheta.Theta.Product (5.9s)
✔ [8684/8708] Built TateCurvesTheta.TateCurve.EisensteinSeries (13s)
✔ [8685/8708] Built TateCurvesTheta.TateCurve.CoordinateInversion (5.9s)
✔ [8686/8708] Built TateCurvesTheta.Theta.QBinomial (7.1s)
✔ [8687/8712] Built TateCurvesTheta.Theta.Divisor (5.3s)
✔ [8688/8713] Built TateCurvesTheta.Theta.Uniqueness (3.5s)
✔ [8689/8714] Built TateCurvesTheta.Theta.FactorSeries (5.3s)
✔ [8690/8714] Built TateCurvesTheta.TateCurve.IntegralModel (5.4s)
✔ [8691/8714] Built TateCurvesTheta.TateCurve.Quotient (7.8s)
✔ [8692/8715] Built TateCurvesTheta.Theta.LaurentSphere (4.0s)
✔ [8693/8715] Built TateCurvesTheta.TateCurve.SphereBounds (7.2s)
✔ [8694/8717] Built TateCurvesTheta.TateCurve.TatePointMem (4.3s)
✔ [8695/8719] Built TateCurvesTheta.Theta.ThetaProdLaurent (4.0s)
✔ [8696/8719] Built TateCurvesTheta.Theta.LaurentSphereReduce (3.6s)
✔ [8697/8721] Built TateCurvesTheta.Theta.FactorReciprocal (3.6s)
✔ [8698/8721] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (4.7s)
✔ [8699/8721] Built TateCurvesTheta.Theta.LaurentUnique (3.9s)
✔ [8700/8729] Built TateCurvesTheta.TateCurve.PointMap (7.8s)
✔ [8701/8729] Built TateCurvesTheta.Theta.LaurentUnitSphere (3.4s)
✔ [8702/8729] Built TateCurvesTheta.Theta.RatioAnnulus (3.4s)
✔ [8703/8729] Built TateCurvesTheta.Theta.SeriesZero (3.0s)
✔ [8704/8729] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (4.2s)
✔ [8705/8729] Built TateCurvesTheta.Theta.TripleProduct (5.4s)
✔ [8706/8731] Built TateCurvesTheta.Theta.StrictDominant (9.0s)
✔ [8707/8733] Built TateCurvesTheta.Theta.Normalization (4.8s)
✔ [8708/8735] Built TateCurvesTheta.Uniformization (10s)
✔ [8709/8735] Built TateCurvesTheta.Theta.Durfee (4.4s)
✔ [8710/8765] Built Iut.Cor312.Procession (6.6s)
✔ [8711/8765] Built Iut.Cor312.RationalPlace (6.3s)
✔ [8712/8765] Built TateCurvesTheta.Theta.Inversion (3.9s)
✔ [8713/8765] Built Iut.Cor312.PacketPresentation (7.5s)
✔ [8714/8765] Built TateCurvesTheta.Theta.WeightSpace (14s)
⚠ [8715/8765] Built IUTThreeClosures.HonestFinitePositiveLogVolume (10s)
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestFinitePositiveLogVolume.lean:126:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8716/8765] Built IUTThreeClosures.ABCStatement (4.7s)
✔ [8717/8787] Built IUTThreeClosures.FullPolyCore (9.4s)
⚠ [8719/8787] Built IUTThreeClosures.Cor312CoefficientAlgebra (9.9s)
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
✔ [8720/8787] Built Iut.Cor312.Container (9.6s)
✔ [8721/8787] Built Iut.Cor312.HolomorphicHull (9.1s)
⚠ [8722/8787] Built IUTThreeClosures.HonestPilotWitness (7.8s)
warning: IUTThreeClosures/HonestPilotWitness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/HonestPilotWitness.lean:86:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8723/8787] Built IUTThreeClosures.WeakCompatibilityCountermodel (7.8s)
✔ [8724/8787] Built TateCurvesTheta.Theta.PuncturedProduct (44s)
✔ [8725/8787] Built Heights.WeilHeight (9.1s)
⚠ [8726/8787] Built IUTThreeClosures.ExplicitSemistableCurve (7.4s)
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ExplicitSemistableCurve.lean:95:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8727/8787] Built IUTThreeClosures.SolvableRestrictionImage (7.1s)
warning: IUTThreeClosures/SolvableRestrictionImage.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/SolvableRestrictionImage.lean:121:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8728/8787] Built IUTThreeClosures.RootQPilotDivisor (6.6s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8729/8787] Built IUTThreeClosures.QPilotNormalizationAudit (6.7s)
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:155:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8730/8787] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (6.3s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8731/8787] Built IUTThreeClosures.RamificationCorrectedQPilot (7.0s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8732/8787] Built IUTThreeClosures.ProductWeightMarginalization (7.6s)
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
✔ [8735/8787] Built TateCurvesTheta.TateCurve.DefectVanishing (92s)
⚠ [8736/8787] Built IUTThreeClosures.FiniteExceptionalSet (6.5s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8737/8787] Built IUTThreeClosures.GeneratedUnionCompactness (6.2s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8738/8787] Built Iut.Cor312.LogVolume (6.6s)
✔ [8739/8787] Built Iut.Cor312.ContainerHull (6.1s)
⚠ [8740/8798] Built IUTThreeClosures.HonestGeneratedSource (6.4s)
warning: IUTThreeClosures/HonestGeneratedSource.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8742/8802] Built IUTThreeClosures.ZModSL2Perfect (6.1s)
warning: IUTThreeClosures/ZModSL2Perfect.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZModSL2Perfect.lean:62:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8743/8802] Built IUTThreeClosures.QPilotNormalizationFork (6.1s)
warning: IUTThreeClosures/QPilotNormalizationFork.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8744/8802] Built Genl.Mathlib.Order.BoundedDiscrepancy (2.7s)
⚠ [8745/8802] Built IUTThreeClosures.TateParameterUnitBallRegion (4.2s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8746/8802] Built TateCurvesTheta.TateCurve.TatePointOnCurve (7.3s)
⚠ [8747/8802] Built IUTThreeClosures.PrimePowerQPilotRegion (7.1s)
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:108:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8748/8802] Built IUTThreeClosures.FiniteExponentHull (6.8s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8749/8802] Built IUTThreeClosures.StandardZeroLabel (5.8s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8750/8802] Built IUTThreeClosures.BarycentricPacketReading (6.1s)
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
⚠ [8751/8802] Built IUTThreeClosures.DiagonalPacketNoGo (5.0s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8752/8802] Built Genl.GeneralPosition.HeightTheory (1.8s)
⚠ [8753/8802] Built IUTThreeClosures.PublicNormalizationObstruction (6.8s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8754/8802] Built IUTThreeClosures.IUTIVAbsorption (9.2s)
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
✔ [8755/8802] Built Iut4Sec1.Global.ArithmeticDivisor (6.2s)
✔ [8756/8802] Built TateCurvesTheta.TateCurve.AdditionLaw (11s)
⚠ [8757/8802] Built IUTThreeClosures.DistinguishedLabelQPilot (9.4s)
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/DistinguishedLabelQPilot.lean:52:7: '' starts on column 7, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8758/8802] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (9.5s)
✔ [8759/8802] Built TateCurvesTheta.TateCurve.LargePointParametrization (14s)
⚠ [8760/8802] Built IUTThreeClosures.ZeroLabelBarycentric (7.5s)
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ZeroLabelBarycentric.lean:24:0: `product_weight_pointMass` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
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
✔ [8762/8802] Built TateCurvesTheta.TateCurve.AbelStep (7.9s)
✔ [8763/8802] Built TateCurvesTheta.TateCurve.GroupLaw (10s)
✔ [8764/8802] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (21s)
✔ [8765/8802] Built TateCurvesTheta.TateCurve.SurjectivitySphere (26s)
✔ [8766/8802] Built TateCurvesTheta.TateCurve.TateUniformization (4.5s)
✔ [8767/8802] Built TateCurvesTheta (3.7s)
✔ [8768/8802] Built Iut.Cor312.ThetaData.AdmissiblePrime (4.0s)
✔ [8769/8802] Built Iut.Cor312.ThetaData.Orbicurve (4.8s)
✔ [8770/8802] Built Iut.Cor312.ThetaData.LocalConditions (7.9s)
✔ [8771/8802] Built Iut.Cor312.ThetaData.Basic (4.7s)
✔ [8772/8802] Built Iut.Cor312.LeftHandSide (4.2s)
✔ [8773/8802] Built Iut.Cor312.RightHandSide (4.5s)
⚠ [8774/8802] Built IUTThreeClosures.NativeQPilotCalibration (4.7s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8775/8802] Built Iut.Cor312.Statement (5.1s)
⚠ [8776/8802] Built IUTThreeClosures.CorrectedQPilotDivisor (5.7s)
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:122:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
✔ [8777/8802] Built IUTThreeClosures.ActualPilotWitness (4.2s)
✔ [8778/8802] Built IUTThreeClosures.GeneratedSource (4.6s)
✔ [8779/8802] Built IUTThreeClosures.QuantifierCorrectClosure (4.1s)
✔ [8780/8802] Built IUTThreeClosures.ABCClosure (4.2s)
⚠ [8781/8802] Built IUTThreeClosures.PublicLogVolumeInconsistency (4.6s)
warning: IUTThreeClosures/PublicLogVolumeInconsistency.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8782/8802] Built IUTThreeClosures.ThreeClosureTheorems (4.1s)
✔ [8783/8802] Built IUTThreeClosures.InhabitationBoundary (4.2s)
✔ [8784/8802] Built IUTThreeClosures.CircularityAudit (4.3s)
✔ [8785/8802] Built IUTThreeClosures.NonCircularDownstream (5.3s)
✔ [8786/8802] Built IUTThreeClosures.FourOpenConstructions (4.3s)
⚠ [8787/8802] Built IUTThreeClosures.ABCPointLegendreCurve (4.7s)
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/ABCPointLegendreCurve.lean:130:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8788/8802] Built IUTThreeClosures.BridgeInhabitationAudit (5.1s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
⚠ [8789/8802] Built IUTThreeClosures.PublicProgramUninhabited (5.7s)
warning: IUTThreeClosures/PublicProgramUninhabited.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8790/8802] Built IUTThreeClosures.LegendreArithmetic (6.3s)
warning: IUTThreeClosures/LegendreArithmetic.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8791/8802] Built IUTThreeClosures.BridgeInhabitationExact (5.3s)
⚠ [8792/8802] Built IUTThreeClosures.ABCFreyCurve (5.6s)
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
⚠ [8793/8802] Built IUTThreeClosures.TripodWeilHeight (5.8s)
warning: IUTThreeClosures/TripodWeilHeight.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/TripodWeilHeight.lean:94:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8794/8802] Built IUTThreeClosures.CanonicalQPilotCorridor (4.8s)
warning: IUTThreeClosures/CanonicalQPilotCorridor.lean:109:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8795/8802] Built IUTThreeClosures.LegendreHeightCorridor (5.1s)
warning: IUTThreeClosures/LegendreHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8796/8802] Built IUTThreeClosures.CanonicalCorridorAudit (5.0s)
⚠ [8797/8802] Built IUTThreeClosures.SourceDerivedIUTIVBridge (6.1s)
warning: IUTThreeClosures/SourceDerivedIUTIVBridge.lean:88:20: '' starts on column 20, but all commands should start at the beginning of the line.

Note: This linter can be disabled with `set_option linter.style.whitespace false`
⚠ [8798/8802] Built IUTThreeClosures.FreyJReducedData (4.0s)
warning: IUTThreeClosures/FreyJReducedData.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✖ [8799/8802] Building IUTThreeClosures.FreyJHeightCorridor (4.7s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/heights/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/FreyJHeightCorridor.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/FreyJHeightCorridor.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/FreyJHeightCorridor.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/FreyJHeightCorridor.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/FreyJHeightCorridor.setup.json --json
warning: IUTThreeClosures/FreyJHeightCorridor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/FreyJHeightCorridor.lean:118:4: linarith failed to find a contradiction
P : ABCPoint
M : ℕ := max P.freyJReducedNum P.freyJReducedDen
hM : 0 < M
hnat : P.c ^ 6 ≤ 8 * M
hcR : 0 < ↑P.c
hMR : 0 < ↑M
hreal : ↑P.c ^ 6 ≤ 8 * ↑M
hlog : ↑6 * Real.log ↑P.c ≤ Real.log 8 + Real.log ↑M
a✝ : Real.log ↑M / 6 + Real.log 8 / 6 < Real.log ↑P.c
⊢ False
failed
error: IUTThreeClosures/FreyJHeightCorridor.lean:145:4: linarith failed to find a contradiction
P : ABCPoint
M : ℕ := max P.freyJReducedNum P.freyJReducedDen
hM : 0 < M
hnat : M ≤ 256 * P.c ^ 6
hMR : 0 < ↑M
hcR : 0 < ↑P.c
hreal : ↑M ≤ 256 * ↑P.c ^ 6
hlog : Real.log ↑M ≤ Real.log 256 + ↑6 * Real.log ↑P.c
a✝ : Real.log ↑P.c + Real.log 256 / 6 < Real.log ↑M / 6
⊢ False
failed
error: Lean exited with code 1
Some required targets logged failures:
- IUTThreeClosures.FreyJHeightCorridor
error: build failed
```
