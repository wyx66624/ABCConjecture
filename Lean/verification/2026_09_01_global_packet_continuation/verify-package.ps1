[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$packageRoot = $PSScriptRoot
$manifestPath = Join-Path $packageRoot 'SHA256SUMS'
if (-not (Test-Path -LiteralPath $manifestPath -PathType Leaf)) {
    throw "Missing package checksum manifest: $manifestPath"
}

$expectedPaths = @()
foreach ($line in Get-Content -LiteralPath $manifestPath) {
    if ([string]::IsNullOrWhiteSpace($line) -or $line.TrimStart().StartsWith('#')) {
        continue
    }
    $match = [regex]::Match($line, '^([0-9A-Fa-f]{64})\s+\*?(.+?)\s*$')
    if (-not $match.Success) {
        throw "Malformed checksum line: $line"
    }
    $expectedHash = $match.Groups[1].Value.ToLowerInvariant()
    $relative = $match.Groups[2].Value.Replace('\', '/')
    if ([IO.Path]::IsPathRooted($relative)) {
        throw "Checksum path must be relative: $relative"
    }

    $rootFull = [IO.Path]::GetFullPath($packageRoot)
    $absolute = [IO.Path]::GetFullPath((Join-Path $rootFull $relative))
    $comparison = if ($env:OS -eq 'Windows_NT') {
        [StringComparison]::OrdinalIgnoreCase
    } else {
        [StringComparison]::Ordinal
    }
    $prefix = $rootFull.TrimEnd(
        [IO.Path]::DirectorySeparatorChar,
        [IO.Path]::AltDirectorySeparatorChar
    ) + [IO.Path]::DirectorySeparatorChar
    if (-not $absolute.StartsWith($prefix, $comparison)) {
        throw "Checksum path escapes the package: $relative"
    }
    if (-not (Test-Path -LiteralPath $absolute -PathType Leaf)) {
        throw "Missing package file: $relative"
    }

    $actualHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $absolute).Hash.ToLowerInvariant()
    if ($actualHash -ne $expectedHash) {
        throw "Checksum mismatch: $relative"
    }
    $expectedPaths += $relative
}

if ($expectedPaths.Count -eq 0) {
    throw 'SHA256SUMS has no entries'
}
if (@($expectedPaths | Sort-Object -Unique).Count -ne $expectedPaths.Count) {
    throw 'SHA256SUMS contains duplicate paths'
}

$actualPaths = @(
    Get-ChildItem -LiteralPath $packageRoot -Recurse -File -Force |
        Where-Object { $_.FullName -ne $manifestPath } |
        ForEach-Object {
            ([IO.Path]::GetRelativePath($packageRoot, $_.FullName)).Replace('\', '/')
        } |
        Sort-Object
)
$difference = @(Compare-Object -ReferenceObject @($expectedPaths | Sort-Object) -DifferenceObject $actualPaths)
if ($difference.Count -ne 0) {
    throw ('Package file-set mismatch' + [Environment]::NewLine + (($difference | Out-String).Trim()))
}

Write-Output "PASS: $($expectedPaths.Count) package files match SHA256SUMS."
