[CmdletBinding()]
param(
  [switch]$Prepare,
  [switch]$Record,
  [switch]$Check
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$selected = @(@($Prepare, $Record, $Check) | Where-Object { $_ }).Count
if ($selected -gt 1) { throw 'Choose at most one validation mode' }

$pythonCandidates = @(
  (Join-Path $env:USERPROFILE '.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe')
)
$pythonCandidates += @(Get-Command python, python3 -ErrorAction SilentlyContinue |
  Where-Object { $_.CommandType -eq 'Application' } |
  ForEach-Object { $_.Source })

$python = $null
foreach ($candidate in @($pythonCandidates | Select-Object -Unique)) {
  if (-not $candidate -or -not (Test-Path -LiteralPath $candidate -PathType Leaf)) {
    continue
  }
  & $candidate -c 'import sys; assert sys.version_info >= (3, 10)' *> $null
  if ($LASTEXITCODE -eq 0) { $python = $candidate; break }
}
if ($null -eq $python) { throw 'No usable Python 3.10+ interpreter was found' }

$mode = if ($Prepare) { '--prepare' } elseif ($Record) { '--record' } else { '--check' }
& $python -B (Join-Path $PSScriptRoot 'validate.py') $mode
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
