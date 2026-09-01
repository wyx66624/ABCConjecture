# Reproduction commands

Run these commands from the repository root in PowerShell.

```powershell
& Lean/verification/2026_09_01_determinant_totient_refined_signature/validate.ps1 -FreezeInputs
& Lean/verification/2026_09_01_determinant_totient_refined_signature/validate.ps1 -Record
& Lean/verification/2026_09_01_determinant_totient_refined_signature/validate.ps1 -SealPackage
& Lean/verification/2026_09_01_determinant_totient_refined_signature/validate.ps1 -VerifyPackage
```

After sealing, the ordinary replay writes only to the ignored
`tmp/verification/2026_09_01_determinant_totient_refined_signature/` tree:

```powershell
& Lean/verification/2026_09_01_determinant_totient_refined_signature/validate.ps1
```

The first command freezes SHA-256 hashes for every Git-tracked local Lean
source, the three new modules, and the Lake configuration. It also regenerates
`axiom-audit.lean` byte-for-byte from the three target sources. The record run
compiles the three modules directly, compiles the independent axiom audit,
and runs `lake build IUTThreeClosures`, requiring exactly 9,212 jobs.
