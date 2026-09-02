# Reproduction commands

Run these commands from the repository root in PowerShell.

```powershell
& Lean/verification/2026_09_01_period_shadow_multiplier_odd_kernel/validate.ps1 -FreezeInputs
& Lean/verification/2026_09_01_period_shadow_multiplier_odd_kernel/validate.ps1 -Record
& Lean/verification/2026_09_01_period_shadow_multiplier_odd_kernel/validate.ps1 -SealPackage
& Lean/verification/2026_09_01_period_shadow_multiplier_odd_kernel/validate.ps1 -VerifyPackage
```

After sealing, the ordinary replay writes only to the ignored
`tmp/verification/2026_09_01_period_shadow_multiplier_odd_kernel/` tree:

```powershell
& Lean/verification/2026_09_01_period_shadow_multiplier_odd_kernel/validate.ps1
```

The freeze command records SHA-256 hashes for all configured inputs and
regenerates `axiom-audit.lean` deterministically.  The record command compiles
the four target modules with `-DwarningAsError=true`, compiles the generated
same-scope axiom audit, independently replays the Pell certificate verifier,
and runs `lake build IUTThreeClosures`, requiring exactly 9,224 jobs.  The seal
hashes every package artifact; the verify command checks the sealed file set,
recorded run logs, replay output, declaration coverage, and hashes without
mutating the package.
