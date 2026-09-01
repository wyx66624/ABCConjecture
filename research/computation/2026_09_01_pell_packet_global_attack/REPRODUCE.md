# Reproduction

Run from the repository root in PowerShell.

```powershell
$taskDir = 'research/computation/2026_09_01_pell_packet_global_attack'
$taskPython = (Get-Command python -ErrorAction Stop).Source
```

Compile and rerun the exhaustive scan:

```powershell
g++ -O3 -std=c++17 -Wall -Wextra -pedantic `
  "$taskDir/depth3_scan_extended.cpp" `
  -o "$taskDir/depth3_scan_extended.exe"

& "$taskDir/depth3_scan_extended.exe" 100000000 `
  "$taskDir/depth3_scan_100m.csv" |
  Tee-Object -FilePath "$taskDir/depth3_scan_100m_stdout.txt"
```

Independently replay all 5,761,454 odd primes with Python arbitrary-precision
integers:

```powershell
& $taskPython "$taskDir/verify_depth3_scan_extended.py" 100000000 |
  Tee-Object -FilePath "$taskDir/depth3_scan_100m_verify_stdout.txt"
```

Regenerate the exact minimal-class and derivative counterexamples:

```powershell
& $taskPython "$taskDir/exact_counterexample_certificates.py" |
  Tee-Object -FilePath "$taskDir/exact_counterexample_stdout.txt"
```

Freeze and verify the artifact manifest after all output files have their
final bytes:

```powershell
& $taskPython "$taskDir/make_manifest.py"
& $taskPython "$taskDir/verify_manifest.py"
```

The verifier makes no network request.  The full scan CSV must have SHA-256
`f9845505638883ee92027b778f7de4b39582736a3f9ba931756eb3e55b765c95`.
