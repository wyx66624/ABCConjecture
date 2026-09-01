[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$root = (Resolve-Path -LiteralPath $PSScriptRoot).Path
$manifest = Join-Path $root 'SHA256SUMS'
if (-not (Test-Path -LiteralPath $manifest -PathType Leaf)) {
  throw "Missing package checksum manifest: $manifest"
}
$reparsePoints = @(Get-ChildItem -LiteralPath $root -Recurse -Force |
  Where-Object {
    ($_.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0
  })
if ($reparsePoints.Count -ne 0) { throw 'Sealed package contains reparse points' }
$artifacts = @(Get-ChildItem -LiteralPath $root -Recurse -Force |
  Where-Object {
    ($_.PSIsContainer -and $_.Name -eq '__pycache__') -or
    (-not $_.PSIsContainer -and
      ($_.Extension -iin @('.pyc', '.pyo', '.exe')))
  })
if ($artifacts.Count -ne 0) { throw 'Sealed package contains replay artifacts' }
$expected = @()
$previousRelative = $null
foreach ($line in Get-Content -LiteralPath $manifest) {
  $match = [regex]::Match($line, '^([0-9a-f]{64})  (.+)$')
  if (-not $match.Success) { throw "Malformed checksum line: $line" }
  $relative = $match.Groups[2].Value
  if ($relative -cne $relative.Trim() -or $relative.Contains('\')) {
    throw "Noncanonical checksum path: $relative"
  }
  if ($null -ne $previousRelative -and
      [StringComparer]::Ordinal.Compare([string]$previousRelative, $relative) -ge 0) {
    throw "Checksum paths are duplicated or not in ordinal order: $relative"
  }
  $previousRelative = $relative
  if ([IO.Path]::IsPathRooted($relative)) { throw "Absolute checksum path: $relative" }
  $absolute = [IO.Path]::GetFullPath((Join-Path $root $relative))
  $prefix = $root.TrimEnd([IO.Path]::DirectorySeparatorChar,
    [IO.Path]::AltDirectorySeparatorChar) + [IO.Path]::DirectorySeparatorChar
  if (-not $absolute.StartsWith($prefix, [StringComparison]::OrdinalIgnoreCase)) {
    throw "Checksum path escapes package: $relative"
  }
  if (-not (Test-Path -LiteralPath $absolute -PathType Leaf)) {
    throw "Missing package file: $relative"
  }
  $actualHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $absolute).Hash.ToLowerInvariant()
  if ($actualHash -cne $match.Groups[1].Value) {
    throw "Checksum mismatch: $relative"
  }
  $expected += $relative
}
if ($expected.Count -eq 0) { throw 'SHA256SUMS has no entries' }
$actual = [string[]]@(Get-ChildItem -LiteralPath $root -Recurse -File -Force |
  Where-Object { $_.FullName -ne $manifest } |
  ForEach-Object { ([IO.Path]::GetRelativePath($root, $_.FullName)).Replace('\', '/') })
[Array]::Sort($actual, [StringComparer]::Ordinal)
if ($actual.Count -ne $expected.Count) {
  throw "Package file-set count mismatch: actual=$($actual.Count), expected=$($expected.Count)"
}
for ($index = 0; $index -lt $expected.Count; $index++) {
  if ($actual[$index] -cne $expected[$index]) {
    throw "Package file-set mismatch at index $index`: actual='$($actual[$index])', expected='$($expected[$index])'"
  }
}
. (Join-Path $root 'package-validation-common.ps1')
$audit = Test-RecordedValidationPackage $root
Write-Output "PASS: $($expected.Count) package files, $($audit.moduleCount) modules, and $($audit.runCount) recorded runs match the sealed manifests."
