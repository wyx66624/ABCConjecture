# Reproduction

From the repository root, run:

```powershell
$pythonExe = (Get-Command python -All |
  Where-Object Source -NotLike '*WindowsApps*' |
  Select-Object -First 1 -ExpandProperty Source)
& $pythonExe research/computation/2026_09_01_affine_template_entropy/verify_template_entropy.py
```

Compare standard output with `OUTPUT.txt`, then verify the file hashes with
the repository's usual SHA-256 tooling.  The verifier uses only Python's
standard library and performs all inequalities with integers.
