[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$root = (Resolve-Path -LiteralPath $PSScriptRoot).Path
$manifest = Join-Path $root 'SHA256SUMS'
if (Test-Path -LiteralPath $manifest) {
  throw 'Refusing to overwrite an existing sealed SHA256SUMS'
}
. (Join-Path $root 'package-validation-common.ps1')
$audit = Test-RecordedValidationPackage $root

$reparsePoints = @(Get-ChildItem -LiteralPath $root -Recurse -Force |
  Where-Object {
    ($_.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0
  })
if ($reparsePoints.Count -ne 0) { throw 'Refusing to seal package reparse points' }
$artifacts = @(Get-ChildItem -LiteralPath $root -Recurse -Force |
  Where-Object {
    ($_.PSIsContainer -and $_.Name -eq '__pycache__') -or
    (-not $_.PSIsContainer -and
      ($_.Extension -iin @('.pyc', '.pyo', '.exe')))
  })
if ($artifacts.Count -ne 0) { throw 'Refusing to seal replay artifacts' }
$relativePaths = [string[]]@(Get-ChildItem -LiteralPath $root -Recurse -File -Force |
  Where-Object { $_.FullName -ne $manifest } |
  ForEach-Object { ([IO.Path]::GetRelativePath($root, $_.FullName)).Replace('\', '/') })
[Array]::Sort($relativePaths, [StringComparer]::Ordinal)
$lines = foreach ($relative in $relativePaths) {
  if ($relative.Contains("`r") -or $relative.Contains("`n")) {
    throw 'Package path contains a newline and cannot be sealed'
  }
  $file = Join-Path $root $relative
  $hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $file).Hash.ToLowerInvariant()
  "$hash  $relative"
}
[IO.File]::WriteAllLines($manifest, $lines, [Text.UTF8Encoding]::new($false))
Write-Output "WROTE $manifest with $($relativePaths.Count) entries; audited $($audit.moduleCount) modules and $($audit.runCount) runs"
