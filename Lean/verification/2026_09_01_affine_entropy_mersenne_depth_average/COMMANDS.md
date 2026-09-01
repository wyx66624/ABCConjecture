# Reproduction commands

Run from the repository root in PowerShell.

Before freezing, stage every intended checkpoint input so that the working
bytes equal the stage-zero Git index:

```powershell
git add -- Lean/IUTThreeClosures.lean `
  Lean/IUTThreeClosures/AffineTemplateEntropy20260901.lean `
  Lean/IUTThreeClosures/MersenneWeightedOrderTail20260901.lean `
  Lean/IUTThreeClosures/MersenneSuperWieferichDepth20260901.lean `
  Lean/RESEARCH_ROUTE_REGISTRY.md Lean/RESEARCH_STATUS.md `
  research/ABC_AFFINE_TEMPLATE_ENTROPY_2026_09_01.md `
  research/ABC_MERSENNE_WEIGHTED_ORDER_TAIL_2026_09_01.md `
  research/ABC_MERSENNE_SUPER_WIEFERICH_DEPTH_2026_09_01.md `
  research/ABC_AFFINE_ENTROPY_MERSENNE_DEPTH_AVERAGE_2026_09_01.md `
  research/computation/2026_09_01_affine_template_entropy `
  research/computation/2026_09_01_mersenne_super_wieferich_depth `
  paper/ChatGPT_ABC_Uniformity_2026.tex `
  paper/affine_template_entropy_2026.tex `
  paper/mersenne_weighted_order_tail_2026.tex `
  paper/mersenne_super_wieferich_depth_2026.tex `
  paper/mersenne_super_wieferich_depth_section_2026.tex
```

Then freeze, run live validation, record, seal, and verify:

```powershell
& Lean/verification/2026_09_01_affine_entropy_mersenne_depth_average/validate.ps1 -FreezeInputs
& Lean/verification/2026_09_01_affine_entropy_mersenne_depth_average/validate.ps1
& Lean/verification/2026_09_01_affine_entropy_mersenne_depth_average/validate.ps1 -Record
& Lean/verification/2026_09_01_affine_entropy_mersenne_depth_average/freeze-package.ps1
& Lean/verification/2026_09_01_affine_entropy_mersenne_depth_average/verify-package.ps1
```

After sealing, rerun ordinary validation and verify the immutable package:

```powershell
& Lean/verification/2026_09_01_affine_entropy_mersenne_depth_average/validate.ps1
& Lean/verification/2026_09_01_affine_entropy_mersenne_depth_average/verify-package.ps1
```
