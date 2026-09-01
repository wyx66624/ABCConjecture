# Reproduction

Run from the repository root in PowerShell.  The generated executables are
deliberately excluded from the frozen manifest.

```powershell
$taskDir = 'research/computation/2026_09_01_pell_four_prime_coupling'
$taskPython = (Get-Command python -All -ErrorAction Stop |
  Where-Object { $_.Source -notlike '*WindowsApps*' } |
  Select-Object -First 1).Source
if (-not $taskPython) { throw 'No working Python interpreter found' }

g++ -O3 -std=c++17 -Wall -Wextra -pedantic `
  "$taskDir/depth3_scan_segmented.cpp" `
  -o "$taskDir/depth3_scan_segmented.exe"

& "$taskDir/depth3_scan_segmented.exe" 1000000000 `
  "$taskDir/depth3_scan_1b.csv" |
  Tee-Object -FilePath "$taskDir/depth3_scan_1b_stdout.txt"

g++ -O3 -std=c++17 -Wall -Wextra -pedantic `
  "$taskDir/verify_depth3_scan_dense.cpp" `
  -o "$taskDir/verify_depth3_scan_dense.exe"

& "$taskDir/verify_depth3_scan_dense.exe" 1000000000 `
  "$taskDir/depth3_scan_1b.csv" |
  Tee-Object -FilePath "$taskDir/depth3_scan_1b_verify_stdout.txt"

& $taskPython "$taskDir/verify_hits_bigint.py" |
  Tee-Object -FilePath "$taskDir/depth3_scan_1b_bigint_stdout.txt"

& $taskPython "$taskDir/verify_coupling_examples.py" |
  Tee-Object -FilePath "$taskDir/coupling_examples_stdout.txt"
```

Kernel-check the independent Lean module:

```powershell
Push-Location Lean
lake env lean IUTThreeClosures/PellFourPrimeCoupling20260901.lean
if ($LASTEXITCODE -ne 0) { throw 'Lean validation failed' }
Pop-Location
```

The first full pass uses a segmented sieve and Lucas fast doubling.  The
second full pass uses a dense sieve and binary powering in
`Z[T]/(T^2-6T+1)`.  The Python pass independently replays every rare hit
modulo `q^3` with arbitrary-precision integers.
