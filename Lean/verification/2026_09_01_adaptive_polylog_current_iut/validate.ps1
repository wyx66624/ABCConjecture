[CmdletBinding()]
param(
  [switch]$FreezeInputs,
  [switch]$Record,
  [switch]$SealPackage,
  [switch]$VerifyPackage
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$selected = @($FreezeInputs, $Record, $SealPackage, $VerifyPackage |
  Where-Object { $_ }).Count
if ($selected -gt 1) { throw 'Choose at most one validation mode' }

$candidates = @()
foreach ($name in @('python', 'python3')) {
  $candidates += @(Get-Command $name -All -ErrorAction SilentlyContinue |
    Where-Object { $_.CommandType -eq 'Application' } |
    ForEach-Object { $_.Source })
}
$candidates += @(
  (Join-Path $env:USERPROFILE '.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe'),
  'D:\anaconda3\python.exe'
)
$python = $null
foreach ($candidate in @($candidates | Where-Object { $_ } | Select-Object -Unique)) {
  if ($candidate -like '*\WindowsApps\*' -or
      -not (Test-Path -LiteralPath $candidate -PathType Leaf)) { continue }
  & $candidate -c 'import sys; assert sys.version_info >= (3, 10)' *> $null
  if ($LASTEXITCODE -eq 0) { $python = $candidate; break }
}
if ($null -eq $python) { throw 'No usable Python 3.10+ interpreter was found' }

$arguments = @((Join-Path $PSScriptRoot 'validate.py'))
if ($FreezeInputs) { $arguments += '--freeze-inputs' }
elseif ($Record) { $arguments += '--record' }
elseif ($SealPackage) { $arguments += '--seal-package' }
elseif ($VerifyPackage) { $arguments += '--verify-package' }

& $python -B @arguments
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
