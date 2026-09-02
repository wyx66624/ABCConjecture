# Reproduction

From the repository root in PowerShell:

```powershell
python research\computation\2026_09_01_affine_signed_ray_caps\verify_signed_ray_caps.py |
  Tee-Object research\computation\2026_09_01_affine_signed_ray_caps\OUTPUT.txt
```

The final line must be:

```text
PASS: all signed-ray, arm-cap, owner-global, and actual-box checks
```

The command rewrites `verification.json` deterministically.  It requires no
network access and no third-party Python package.

To verify the recorded file hashes after replay:

```powershell
Get-Content research\computation\2026_09_01_affine_signed_ray_caps\SHA256SUMS
```

Compare each listed digest with `Get-FileHash -Algorithm SHA256` on the named
file.  `SHA256SUMS` intentionally does not hash itself.
