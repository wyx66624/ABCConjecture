# Lean CI result

- Tested commit: `ec6783510bbe289bb43e5055f01474d3bc0aaba6`
- Lean setup: `success`
- Dependency resolution/cache: `success`
- `lake build`: `failure`

## Error summary

```text
===== lean-dependencies.log =====
===== lean-build.log =====
105:✖ [8719/8769] Building IUTThreeClosures.QPilotNormalizationAudit (8.6s)
112:error: IUTThreeClosures/QPilotNormalizationAudit.lean:122:7: unexpected token ':'; expected 'add_aesop_rules', 'binder_predicate', 'builtin_cbv_simproc', 'builtin_dsimproc', 'builtin_simproc', 'cbv_simproc', 'def_eval_config_item', 'dsimproc', 'elab', 'elab_rules', 'grind_pattern', 'infix', 'infixl', 'infixr', 'instance', 'macro', 'macro_rules', 'notation', 'notation3', 'postfix', 'prefix', 'simproc', 'syntax' or 'unif_hint'
113:error: IUTThreeClosures/QPilotNormalizationAudit.lean:128:10: Invalid field `local`: The environment does not contain `IUTThreeClosures.GlobalQPilotNormalizationDatum.local`, so it is not possible to project the field `local` from an expression
117:error: IUTThreeClosures/QPilotNormalizationAudit.lean:132:10: Invalid field `local`: The environment does not contain `IUTThreeClosures.GlobalQPilotNormalizationDatum.local`, so it is not possible to project the field `local` from an expression
121:error: IUTThreeClosures/QPilotNormalizationAudit.lean:136:10: Invalid field `local`: The environment does not contain `IUTThreeClosures.GlobalQPilotNormalizationDatum.local`, so it is not possible to project the field `local` from an expression
125:warning: IUTThreeClosures/QPilotNormalizationAudit.lean:138:8: declaration uses `sorry`
147:error: Lean exited with code 1
184:✖ [8726/8769] Building IUTThreeClosures.AdmissiblePrimeSelection (5.7s)
191:error: IUTThreeClosures/AdmissiblePrimeSelection.lean:16:11: unexpected token 'in'; expected ','
192:error: IUTThreeClosures/AdmissiblePrimeSelection.lean:32:23: unexpected token 'in'; expected ','
193:error: Lean exited with code 1
224:✖ [8738/8784] Building IUTThreeClosures.BarycentricPacketReading (5.7s)
231:error: IUTThreeClosures/BarycentricPacketReading.lean:36:14: Tactic `rewrite` failed: Did not find an occurrence of the pattern
258:error: Lean exited with code 1
333:✖ [8748/8784] Building IUTThreeClosures.PrimePowerQPilotRegion (6.6s)
340:error: IUTThreeClosures/PrimePowerQPilotRegion.lean:30:6: mod_cast has type
344:error: Lean exited with code 1
387:✖ [8767/8784] Building IUTThreeClosures.CorrectedQPilotDivisor (5.4s)
402:error: IUTThreeClosures/CorrectedQPilotDivisor.lean:88:6: Tactic `rewrite` failed: Did not find an occurrence of the pattern
419:error: Lean exited with code 1
441:✖ [8780/8784] Building IUTThreeClosures.CanonicalQPilotCorridor (3.9s)
443:error: IUTThreeClosures/CanonicalQPilotCorridor.lean:89:2: Type mismatch: After simplification, term
449:error: Lean exited with code 1
450:Some required targets logged failures:
457:error: build failed
```

## Dependency log tail

```text
info: toolchain not updated; already up-to-date
info: mathlib: running post-update hooks
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
Attempting to download 8639 file(s) from leanprover-community/mathlib4 cache at https://lakecache.blob.core.windows.net/mathlib4-master
Downloaded: 1 file(s) [attempted 1/8639 = 0%, 17 KB/s], Decompressed: 0Downloaded: 99 file(s) [attempted 99/8639 = 1%, 1043 KB/s], Decompressed: 97Downloaded: 227 file(s) [attempted 227/8639 = 2%, 225 KB/s], Decompressed: 225Downloaded: 362 file(s) [attempted 362/8639 = 4%, 103 KB/s], Decompressed: 355Downloaded: 502 file(s) [attempted 502/8639 = 5%, 868 KB/s], Decompressed: 498Downloaded: 642 file(s) [attempted 642/8639 = 7%, 599 KB/s], Decompressed: 635Downloaded: 788 file(s) [attempted 788/8639 = 9%, 827 KB/s], Decompressed: 785Downloaded: 932 file(s) [attempted 932/8639 = 10%, 2348 KB/s], Decompressed: 929Downloaded: 1080 file(s) [attempted 1080/8639 = 12%, 2542 KB/s], Decompressed: 1076Downloaded: 1224 file(s) [attempted 1224/8639 = 14%, 3626 KB/s], Decompressed: 1216Downloaded: 1368 file(s) [attempted 1368/8639 = 15%, 298 KB/s], Decompressed: 1365Downloaded: 1511 file(s) [attempted 1511/8639 = 17%, 918 KB/s], Decompressed: 1505Downloaded: 1660 file(s) [attempted 1660/8639 = 19%, 4062 KB/s], Decompressed: 1654Downloaded: 1808 file(s) [attempted 1808/8639 = 20%, 785 KB/s], Decompressed: 1801Downloaded: 1945 file(s) [attempted 1945/8639 = 22%, 415 KB/s], Decompressed: 1939Downloaded: 2090 file(s) [attempted 2090/8639 = 24%, 1396 KB/s], Decompressed: 2083Downloaded: 2232 file(s) [attempted 2232/8639 = 25%, 420 KB/s], Decompressed: 2228Downloaded: 2382 file(s) [attempted 2382/8639 = 27%, 314 KB/s], Decompressed: 2377Downloaded: 2525 file(s) [attempted 2525/8639 = 29%, 11157 KB/s], Decompressed: 2519Downloaded: 2664 file(s) [attempted 2664/8639 = 30%, 3219 KB/s], Decompressed: 2659Downloaded: 2814 file(s) [attempted 2814/8639 = 32%, 1523 KB/s], Decompressed: 2808Downloaded: 2957 file(s) [attempted 2957/8639 = 34%, 2579 KB/s], Decompressed: 2953Downloaded: 3102 file(s) [attempted 3102/8639 = 35%, 5196 KB/s], Decompressed: 3097Downloaded: 3250 file(s) [attempted 3250/8639 = 37%, 839 KB/s], Decompressed: 3246Downloaded: 3398 file(s) [attempted 3398/8639 = 39%, 276 KB/s], Decompressed: 3393Downloaded: 3550 file(s) [attempted 3550/8639 = 41%, 1612 KB/s], Decompressed: 3542Downloaded: 3696 file(s) [attempted 3696/8639 = 42%, 1310 KB/s], Decompressed: 3692Downloaded: 3838 file(s) [attempted 3838/8639 = 44%, 477 KB/s], Decompressed: 3836Downloaded: 3923 file(s) [attempted 3923/8639 = 45%, 517 KB/s], Decompressed: 3920Downloaded: 3995 file(s) [attempted 3995/8639 = 46%, 1650 KB/s], Decompressed: 3981Downloaded: 4139 file(s) [attempted 4139/8639 = 47%, 222 KB/s], Decompressed: 4135Downloaded: 4288 file(s) [attempted 4288/8639 = 49%, 1847 KB/s], Decompressed: 4286Downloaded: 4438 file(s) [attempted 4438/8639 = 51%, 202 KB/s], Decompressed: 4435Downloaded: 4584 file(s) [attempted 4584/8639 = 53%, 4150 KB/s], Decompressed: 4580Downloaded: 4737 file(s) [attempted 4737/8639 = 54%, 4199 KB/s], Decompressed: 4729Downloaded: 4883 file(s) [attempted 4883/8639 = 56%, 486 KB/s], Decompressed: 4878Downloaded: 5027 file(s) [attempted 5027/8639 = 58%, 113 KB/s], Decompressed: 5025Downloaded: 5172 file(s) [attempted 5172/8639 = 59%, 166 KB/s], Decompressed: 5167Downloaded: 5315 file(s) [attempted 5315/8639 = 61%, 729 KB/s], Decompressed: 5307Downloaded: 5463 file(s) [attempted 5463/8639 = 63%, 3098 KB/s], Decompressed: 5454Downloaded: 5613 file(s) [attempted 5613/8639 = 64%, 489 KB/s], Decompressed: 5610Downloaded: 5761 file(s) [attempted 5761/8639 = 66%, 2985 KB/s], Decompressed: 5754Downloaded: 5915 file(s) [attempted 5915/8639 = 68%, 620 KB/s], Decompressed: 5911Downloaded: 6062 file(s) [attempted 6062/8639 = 70%, 95 KB/s], Decompressed: 6060Downloaded: 6214 file(s) [attempted 6214/8639 = 71%, 3338 KB/s], Decompressed: 6207Downloaded: 6361 file(s) [attempted 6361/8639 = 73%, 775 KB/s], Decompressed: 6356Downloaded: 6507 file(s) [attempted 6507/8639 = 75%, 419 KB/s], Decompressed: 6505Downloaded: 6657 file(s) [attempted 6657/8639 = 77%, 354 KB/s], Decompressed: 6654Downloaded: 6809 file(s) [attempted 6809/8639 = 78%, 294 KB/s], Decompressed: 6801Downloaded: 6950 file(s) [attempted 6950/8639 = 80%, 2267 KB/s], Decompressed: 6943Downloaded: 7104 file(s) [attempted 7104/8639 = 82%, 1785 KB/s], Decompressed: 7099Downloaded: 7253 file(s) [attempted 7253/8639 = 83%, 883 KB/s], Decompressed: 7249Downloaded: 7402 file(s) [attempted 7402/8639 = 85%, 763 KB/s], Decompressed: 7398Downloaded: 7549 file(s) [attempted 7549/8639 = 87%, 901 KB/s], Decompressed: 7545Downloaded: 7698 file(s) [attempted 7698/8639 = 89%, 2041 KB/s], Decompressed: 7696Downloaded: 7845 file(s) [attempted 7845/8639 = 90%, 218 KB/s], Decompressed: 7838Downloaded: 7991 file(s) [attempted 7991/8639 = 92%, 2659 KB/s], Decompressed: 7983Downloaded: 8141 file(s) [attempted 8141/8639 = 94%, 3716 KB/s], Decompressed: 8134Downloaded: 8283 file(s) [attempted 8283/8639 = 95%, 850 KB/s], Decompressed: 8277Downloaded: 8429 file(s) [attempted 8429/8639 = 97%, 1223 KB/s], Decompressed: 8423Downloaded: 8577 file(s) [attempted 8577/8639 = 99%, 3489 KB/s], Decompressed: 8573Downloaded: 8638 file(s) [attempted 8638/8639 = 99%, 476 KB/s], Decompressed: 8635Downloaded: 8639 file(s) [attempted 8639/8639 = 100%, 476 KB/s], Decompressed: 8635
Decompressed 8639 file(s)
Already decompressed 8639 file(s)
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
No files to download
Already decompressed 8639 file(s)
```

## Build log tail

```text
✔ [8656/8667] Built TateCurvesTheta.Basic (447ms)
✔ [8657/8667] Built TateCurvesTheta.Analysis.UltrametricSum (3.3s)
✔ [8658/8667] Built TateCurvesTheta.Analysis.MaxTerm (3.5s)
✔ [8659/8667] Built TateCurvesTheta.QParameter.Basic (3.7s)
✔ [8660/8667] Built TateCurvesTheta.Arithmetic.DivisorConvolution (7.9s)
✔ [8661/8673] Built TateCurvesTheta.AnalyticQuotient (8.2s)
✔ [8662/8675] Built Iut.Cor312.ThetaData.Places (7.0s)
✔ [8663/8675] Built TateCurvesTheta.QParameter.BaseChange (3.1s)
✔ [8664/8675] Built TateCurvesTheta.Analysis.Strassmann (4.6s)
✔ [8665/8675] Built TateCurvesTheta.TateCurve.Weierstrass (4.1s)
✔ [8666/8675] Built TateCurvesTheta.QParameter.PrimeToOrder (2.7s)
✔ [8667/8679] Built TateCurvesTheta.Analysis.StrassmannSphere (5.5s)
✔ [8668/8684] Built TateCurvesTheta.QParameter.NormalizedOrder (4.2s)
✔ [8669/8689] Built TateCurvesTheta.TateCurve.Discriminant (5.5s)
✔ [8670/8689] Built TateCurvesTheta.TateCurve.Parametrization (4.3s)
✔ [8671/8689] Built TateCurvesTheta.Theta.Basic (3.9s)
✔ [8672/8689] Built TateCurvesTheta.TateCurve.SplitReduction (4.5s)
✔ [8673/8693] Built Iut.Cor312.ThetaData.GlobalField (14s)
✔ [8674/8693] Built TateCurvesTheta.TateCurve.JInvariant (3.3s)
✔ [8675/8693] Built TateCurvesTheta.TateCurve.WeierstrassIdentity (3.0s)
✔ [8676/8696] Built TateCurvesTheta.TateCurve.CoordinateExpansion (3.9s)
✔ [8677/8696] Built TateCurvesTheta.Theta.Periodicity (3.4s)
✔ [8678/8696] Built TateCurvesTheta.TateCurve.EisensteinKernels (4.8s)
✔ [8679/8696] Built TateCurvesTheta.QParameter.JParametrization (10s)
✔ [8680/8699] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurentY (8.9s)
✔ [8681/8704] Built TateCurvesTheta.Theta.Product (6.6s)
✔ [8682/8704] Built TateCurvesTheta.TateCurve.CoordinateAnnulusLaurent (9.8s)
✔ [8683/8704] Built TateCurvesTheta.QParameter.Characterization (3.3s)
✔ [8684/8704] Built TateCurvesTheta.Theta.Divisor (4.8s)
✔ [8685/8704] Built TateCurvesTheta.Theta.Uniqueness (5.8s)
✔ [8686/8705] Built TateCurvesTheta.Theta.FactorSeries (7.9s)
✔ [8687/8705] Built TateCurvesTheta.TateCurve.EisensteinSeries (12s)
✔ [8688/8705] Built TateCurvesTheta.Theta.QBinomial (7.1s)
✔ [8689/8708] Built TateCurvesTheta.Theta.LaurentSphere (5.6s)
✔ [8690/8708] Built TateCurvesTheta.TateCurve.TatePointMem (3.3s)
✔ [8691/8712] Built TateCurvesTheta.TateCurve.CoordinateInversion (3.4s)
✔ [8692/8713] Built TateCurvesTheta.Theta.ThetaProdLaurent (5.2s)
✔ [8693/8714] Built TateCurvesTheta.Theta.LaurentSphereReduce (3.6s)
✔ [8694/8715] Built TateCurvesTheta.TateCurve.IntegralModel (5.3s)
✔ [8695/8716] Built TateCurvesTheta.Theta.ThetaProdGlobalLaurent (4.9s)
✔ [8696/8716] Built TateCurvesTheta.TateCurve.Quotient (8.4s)
✔ [8697/8717] Built TateCurvesTheta.TateCurve.SphereBounds (7.1s)
✔ [8698/8718] Built TateCurvesTheta.Theta.LaurentUnitSphere (3.6s)
✔ [8699/8719] Built TateCurvesTheta.TateCurve.DefectAnnulusLaurent (4.0s)
✔ [8700/8719] Built TateCurvesTheta.Theta.FactorReciprocal (4.2s)
✔ [8701/8720] Built TateCurvesTheta.Theta.Normalization (5.4s)
✔ [8702/8720] Built TateCurvesTheta.Theta.LaurentUnique (5.0s)
✔ [8703/8721] Built TateCurvesTheta.TateCurve.PointMap (10s)
✔ [8704/8722] Built TateCurvesTheta.Theta.RatioAnnulus (5.4s)
✔ [8705/8729] Built TateCurvesTheta.Theta.Durfee (5.2s)
✔ [8706/8729] Built TateCurvesTheta.Theta.SeriesZero (3.3s)
✔ [8707/8729] Built TateCurvesTheta.Theta.TripleProduct (3.6s)
✔ [8708/8729] Built TateCurvesTheta.Theta.Inversion (4.0s)
✔ [8709/8729] Built TateCurvesTheta.Theta.StrictDominant (7.1s)
✔ [8710/8731] Built TateCurvesTheta.Uniformization (14s)
✔ [8711/8733] Built TateCurvesTheta.Theta.WeightSpace (17s)
✔ [8712/8735] Built Iut.Cor312.RationalPlace (7.8s)
✔ [8713/8744] Built Iut.Cor312.Procession (10s)
✔ [8714/8769] Built IUTThreeClosures.ABCStatement (4.1s)
✔ [8715/8769] Built Iut.Cor312.PacketPresentation (9.5s)
✔ [8716/8769] Built IUTThreeClosures.FullPolyCore (7.1s)
⚠ [8717/8769] Built IUTThreeClosures.Cor312CoefficientAlgebra (8.2s)
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
✔ [8718/8769] Built TateCurvesTheta.Theta.PuncturedProduct (46s)
✖ [8719/8769] Building IUTThreeClosures.QPilotNormalizationAudit (8.6s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/QPilotNormalizationAudit.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/QPilotNormalizationAudit.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/QPilotNormalizationAudit.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/QPilotNormalizationAudit.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/QPilotNormalizationAudit.setup.json --json
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/QPilotNormalizationAudit.lean:122:7: unexpected token ':'; expected 'add_aesop_rules', 'binder_predicate', 'builtin_cbv_simproc', 'builtin_dsimproc', 'builtin_simproc', 'cbv_simproc', 'def_eval_config_item', 'dsimproc', 'elab', 'elab_rules', 'grind_pattern', 'infix', 'infixl', 'infixr', 'instance', 'macro', 'macro_rules', 'notation', 'notation3', 'postfix', 'prefix', 'simproc', 'syntax' or 'unif_hint'
error: IUTThreeClosures/QPilotNormalizationAudit.lean:128:10: Invalid field `local`: The environment does not contain `IUTThreeClosures.GlobalQPilotNormalizationDatum.local`, so it is not possible to project the field `local` from an expression
  D
of type
  GlobalQPilotNormalizationDatum V
error: IUTThreeClosures/QPilotNormalizationAudit.lean:132:10: Invalid field `local`: The environment does not contain `IUTThreeClosures.GlobalQPilotNormalizationDatum.local`, so it is not possible to project the field `local` from an expression
  D
of type
  GlobalQPilotNormalizationDatum V
error: IUTThreeClosures/QPilotNormalizationAudit.lean:136:10: Invalid field `local`: The environment does not contain `IUTThreeClosures.GlobalQPilotNormalizationDatum.local`, so it is not possible to project the field `local` from an expression
  D
of type
  GlobalQPilotNormalizationDatum V
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:138:8: declaration uses `sorry`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:143:2: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:144:2: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:138:0: `correctedPacketLogQ_eq_divisorLogQ` does not use the following hypothesis in its type:
  • [Fintype V] (#2)

Consider replacing this hypothesis with the corresponding instance of `Finite` and using `Fintype.ofFinite` in the proof, or removing it entirely.

Note: This linter can be disabled with `set_option linter.unusedFintypeInType false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:142:2: 'apply Finset.sum_congr rfl' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:143:2: 'intro v hv' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/QPilotNormalizationAudit.lean:144:2: 'exact (D.local v).correctedPacketTerm_eq_divisorTerm' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
error: Lean exited with code 1
⚠ [8720/8769] Built IUTThreeClosures.RootQPilotDivisor (7.1s)
warning: IUTThreeClosures/RootQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8721/8769] Built IUTThreeClosures.FinitePositiveLogVolumeMonotonicity (6.8s)
warning: IUTThreeClosures/FinitePositiveLogVolumeMonotonicity.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8722/8769] Built IUTThreeClosures.RamificationCorrectedQPilot (7.1s)
warning: IUTThreeClosures/RamificationCorrectedQPilot.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8724/8769] Built IUTThreeClosures.ProductWeightMarginalization (7.8s)
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
✖ [8726/8769] Building IUTThreeClosures.AdmissiblePrimeSelection (5.7s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/AdmissiblePrimeSelection.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/AdmissiblePrimeSelection.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/AdmissiblePrimeSelection.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/AdmissiblePrimeSelection.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/AdmissiblePrimeSelection.setup.json --json
warning: IUTThreeClosures/AdmissiblePrimeSelection.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/AdmissiblePrimeSelection.lean:16:11: unexpected token 'in'; expected ','
error: IUTThreeClosures/AdmissiblePrimeSelection.lean:32:23: unexpected token 'in'; expected ','
error: Lean exited with code 1
⚠ [8727/8769] Built IUTThreeClosures.FiniteExceptionalSet (6.3s)
warning: IUTThreeClosures/FiniteExceptionalSet.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8728/8769] Built Iut.Cor312.Container (6.5s)
✔ [8730/8784] Built Iut.Cor312.HolomorphicHull (6.9s)
✔ [8731/8784] Built TateCurvesTheta.TateCurve.DefectVanishing (85s)
✔ [8732/8784] Built IUTThreeClosures.WeakCompatibilityCountermodel (6.5s)
✔ [8733/8784] Built Genl.Mathlib.Order.BoundedDiscrepancy (2.6s)
⚠ [8734/8784] Built IUTThreeClosures.TateParameterUnitBallRegion (3.2s)
warning: IUTThreeClosures/TateParameterUnitBallRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8735/8784] Built IUTThreeClosures.GeneratedUnionCompactness (6.5s)
warning: IUTThreeClosures/GeneratedUnionCompactness.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8736/8784] Built Iut.Cor312.LogVolume (6.6s)
⚠ [8737/8784] Built IUTThreeClosures.FiniteExponentHull (5.7s)
warning: IUTThreeClosures/FiniteExponentHull.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✖ [8738/8784] Building IUTThreeClosures.BarycentricPacketReading (5.7s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/BarycentricPacketReading.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/BarycentricPacketReading.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/BarycentricPacketReading.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/BarycentricPacketReading.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/BarycentricPacketReading.setup.json --json
warning: IUTThreeClosures/BarycentricPacketReading.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/BarycentricPacketReading.lean:36:14: Tactic `rewrite` failed: Did not find an occurrence of the pattern
  ∑ x ∈ ?m.166, ∑ y ∈ ?m.167, ?m.168 x y
in the target expression
  ∑ c, (∏ j, weight (c j)) * ∑ j, coeff j * value (c j) = ∑ j, coeff j * ∑ c, (∏ k, weight (c k)) * value (c j)

L : Type u
V : Type v
inst✝³ : Fintype L
inst✝² : DecidableEq L
inst✝¹ : Fintype V
inst✝ : DecidableEq V
coeff : L → ℝ
weight value : V → ℝ
hweight : ∑ v, weight v = 1
⊢ ∑ c, (∏ j, weight (c j)) * ∑ j, coeff j * value (c j) = ∑ j, coeff j * ∑ c, (∏ k, weight (c k)) * value (c j)
warning: IUTThreeClosures/BarycentricPacketReading.lean:21:0: `product_weight_barycentric` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
warning: IUTThreeClosures/BarycentricPacketReading.lean:50:0: `product_weight_barycentric_of_sum_one` does not use the following hypothesis in its type:
  • [DecidableEq V] (#6)

Consider removing this hypothesis and using `classical` in the proof instead. For terms, consider using `open scoped Classical in` at the term level (not the command level).

Note: This linter can be disabled with `set_option linter.unusedDecidableInType false`
error: Lean exited with code 1
⚠ [8739/8784] Built IUTThreeClosures.StandardZeroLabel (6.0s)
warning: IUTThreeClosures/StandardZeroLabel.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8741/8784] Built IUTThreeClosures.DiagonalPacketNoGo (6.0s)
warning: IUTThreeClosures/DiagonalPacketNoGo.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✔ [8742/8784] Built Iut.Cor312.ContainerHull (6.2s)
⚠ [8743/8784] Built IUTThreeClosures.PublicNormalizationObstruction (7.2s)
warning: IUTThreeClosures/PublicNormalizationObstruction.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
⚠ [8744/8784] Built IUTThreeClosures.IUTIVAbsorption (9.1s)
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
✔ [8745/8784] Built Genl.GeneralPosition.HeightTheory (1.9s)
✔ [8746/8784] Built Iut4Sec1.Global.ArithmeticDivisor (6.6s)
✔ [8747/8784] Built TateCurvesTheta.TateCurve.TatePointOnCurve (6.0s)
✖ [8748/8784] Building IUTThreeClosures.PrimePowerQPilotRegion (6.6s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/PrimePowerQPilotRegion.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/PrimePowerQPilotRegion.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/PrimePowerQPilotRegion.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/PrimePowerQPilotRegion.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/PrimePowerQPilotRegion.setup.json --json
warning: IUTThreeClosures/PrimePowerQPilotRegion.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
error: IUTThreeClosures/PrimePowerQPilotRegion.lean:30:6: mod_cast has type
  ¬Eq.{1} (↑p) 0
but is expected to have type
  ¬Eq.{u_1 + 1} (↑↑p) 0
error: Lean exited with code 1
⚠ [8750/8784] Built IUTThreeClosures.StatementIIOutsideFinite (7.2s)
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
✔ [8751/8784] Built TateCurvesTheta.TateCurve.DefectCoeffBaseChange (8.4s)
✔ [8752/8784] Built TateCurvesTheta.TateCurve.AdditionLaw (10s)
✔ [8753/8784] Built TateCurvesTheta.TateCurve.LargePointParametrization (14s)
✔ [8754/8784] Built TateCurvesTheta.TateCurve.AbelStep (6.2s)
✔ [8755/8784] Built TateCurvesTheta.TateCurve.GroupLaw (10s)
✔ [8756/8784] Built TateCurvesTheta.TateCurve.SurjectivityAnnulus (20s)
✔ [8757/8784] Built TateCurvesTheta.TateCurve.SurjectivitySphere (28s)
✔ [8758/8784] Built TateCurvesTheta.TateCurve.TateUniformization (4.6s)
✔ [8759/8784] Built TateCurvesTheta (3.9s)
✔ [8760/8784] Built Iut.Cor312.ThetaData.AdmissiblePrime (5.1s)
✔ [8761/8784] Built Iut.Cor312.ThetaData.Orbicurve (4.0s)
✔ [8762/8784] Built Iut.Cor312.ThetaData.LocalConditions (8.2s)
✔ [8763/8784] Built Iut.Cor312.ThetaData.Basic (4.9s)
✔ [8764/8784] Built Iut.Cor312.LeftHandSide (4.3s)
✔ [8765/8784] Built Iut.Cor312.RightHandSide (4.6s)
⚠ [8766/8784] Built IUTThreeClosures.NativeQPilotCalibration (4.8s)
warning: IUTThreeClosures/NativeQPilotCalibration.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
✖ [8767/8784] Building IUTThreeClosures.CorrectedQPilotDivisor (5.4s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/CorrectedQPilotDivisor.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/CorrectedQPilotDivisor.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/CorrectedQPilotDivisor.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/CorrectedQPilotDivisor.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/CorrectedQPilotDivisor.setup.json --json
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:1:1: * '-/':
Copyright too short!


Note: This linter can be disabled with `set_option linter.style.header false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:45:7: Variable name `hw` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
warning: IUTThreeClosures/CorrectedQPilotDivisor.lean:87:29: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
error: IUTThreeClosures/CorrectedQPilotDivisor.lean:88:6: Tactic `rewrite` failed: Did not find an occurrence of the pattern
  Iut4Sec1.arithmeticPlaceWeight (Sum.inl ↑w) / ↑(Module.finrank ℚ D.F)
in the target expression
  ↑(D.prime.qOrder ↑w ⋯) * Iut4Sec1.arithmeticPlaceWeight (Sum.inl ↑w) / ↑(Module.finrank ℚ D.F) =
    Q.weight ↑w * ↑(D.prime.qOrder ↑w ⋯) * Real.log ↑(Iut.residueChar ↑w)

AG : Iut.AnabelianGeometry
TG : Iut.TemperedGeometry AG
D : Iut.InitialThetaData AG TG
Q : Iut.QPilotData D
hcompat : QPilotWeightDegreeCompatible Q
w : ↥Q.badFinset
hw : w ∈ Q.badFinset.attach
hc :
  Q.weight ↑w * Real.log ↑(Iut.residueChar ↑w) = Iut4Sec1.arithmeticPlaceWeight (Sum.inl ↑w) / ↑(Module.finrank ℚ D.F)
⊢ ↑(D.prime.qOrder ↑w ⋯) * Iut4Sec1.arithmeticPlaceWeight (Sum.inl ↑w) / ↑(Module.finrank ℚ D.F) =
    Q.weight ↑w * ↑(D.prime.qOrder ↑w ⋯) * Real.log ↑(Iut.residueChar ↑w)
error: Lean exited with code 1
✔ [8768/8784] Built Iut.Cor312.Statement (5.6s)
✔ [8769/8784] Built IUTThreeClosures.ActualPilotWitness (4.4s)
✔ [8770/8784] Built IUTThreeClosures.GeneratedSource (4.8s)
✔ [8771/8784] Built IUTThreeClosures.QuantifierCorrectClosure (4.3s)
✔ [8772/8784] Built IUTThreeClosures.ABCClosure (4.2s)
✔ [8773/8784] Built IUTThreeClosures.ThreeClosureTheorems (4.2s)
✔ [8774/8784] Built IUTThreeClosures.InhabitationBoundary (4.3s)
✔ [8775/8784] Built IUTThreeClosures.CircularityAudit (4.4s)
✔ [8776/8784] Built IUTThreeClosures.NonCircularDownstream (5.3s)
✔ [8777/8784] Built IUTThreeClosures.FourOpenConstructions (4.1s)
⚠ [8778/8784] Built IUTThreeClosures.BridgeInhabitationAudit (4.6s)
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:55:4: 'change P.height ≤ (6 : ℝ) * P.height / 6 + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:60:4: 'change (0 : ℝ) ≤ 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
warning: IUTThreeClosures/BridgeInhabitationAudit.lean:64:4: 'change P.conductor ≤ P.conductor + 0' tactic does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
✔ [8779/8784] Built IUTThreeClosures.BridgeInhabitationExact (3.0s)
✖ [8780/8784] Building IUTThreeClosures.CanonicalQPilotCorridor (3.9s)
trace: .> LEAN_PATH=/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Cli/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/formal-schemes/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/batteries/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/Qq/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/aesop/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/importGraph/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/plausible/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/tate-curves-theta/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/mathlib/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/iut/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/packages/genl/.lake/build/lib/lean:/home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean /home/runner/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean /home/runner/work/ABCConjecture/ABCConjecture/Lean/IUTThreeClosures/CanonicalQPilotCorridor.lean -o /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/CanonicalQPilotCorridor.olean -i /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/lib/lean/IUTThreeClosures/CanonicalQPilotCorridor.ilean -c /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/CanonicalQPilotCorridor.c --setup /home/runner/work/ABCConjecture/ABCConjecture/Lean/.lake/build/ir/IUTThreeClosures/CanonicalQPilotCorridor.setup.json --json
error: IUTThreeClosures/CanonicalQPilotCorridor.lean:89:2: Type mismatch: After simplification, term
  hraw
 has type
  @LE.le ℝ Real.instLE (-C.qLog P) (F.source (C.encode P)).toVariantData.rhsData.rhs
but is expected to have type
  @LE.le ℝ Real.partialOrder.toLE (-(F.qPilot (C.encode P)).absLogQ) (F.source (C.encode P)).toVariantData.rhsData.rhs
error: Lean exited with code 1
Some required targets logged failures:
- IUTThreeClosures.QPilotNormalizationAudit
- IUTThreeClosures.AdmissiblePrimeSelection
- IUTThreeClosures.BarycentricPacketReading
- IUTThreeClosures.PrimePowerQPilotRegion
- IUTThreeClosures.CorrectedQPilotDivisor
- IUTThreeClosures.CanonicalQPilotCorridor
error: build failed
```
