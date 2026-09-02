# Reproduction commands

Run the main-checkpoint commands from the repository root in PowerShell:

```powershell
& Lean/verification/2026_09_01_adaptive_polylog_current_iut/validate.ps1 -FreezeInputs
& Lean/verification/2026_09_01_adaptive_polylog_current_iut/validate.ps1 -Record
& Lean/verification/2026_09_01_adaptive_polylog_current_iut/validate.ps1 -SealPackage
& Lean/verification/2026_09_01_adaptive_polylog_current_iut/validate.ps1 -VerifyPackage
```

After sealing, an ordinary replay writes only to the ignored
`tmp/verification/2026_09_01_adaptive_polylog_current_iut/` directory:

```powershell
& Lean/verification/2026_09_01_adaptive_polylog_current_iut/validate.ps1
```

To reproduce the detached current-IUT check, obtain the exact public commit,
copy `detached-current-iut-audit.lean` into its root as
`CurrentLocalTheoryNoGoAudit.lean`, and run:

```powershell
git clone https://github.com/lana-agents/iut tmp/lana_iut_current_6e963070_replay
git -C tmp/lana_iut_current_6e963070_replay checkout --detach 6e963070c73c5defd1012320deccc777e2555d22
Copy-Item Lean/verification/2026_09_01_adaptive_polylog_current_iut/detached-current-iut-audit.lean tmp/lana_iut_current_6e963070_replay/CurrentLocalTheoryNoGoAudit.lean
Push-Location tmp/lana_iut_current_6e963070_replay
lake build Iut
lake env lean CurrentLocalTheoryNoGoAudit.lean
Pop-Location
```

The recorded main run requires exactly 9,216 aggregate jobs. The detached
public library build requires exactly 8,758 jobs.

