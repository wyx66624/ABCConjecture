$ErrorActionPreference = 'Stop'

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$manifest = Join-Path $PSScriptRoot 'ABC_BALANCED_PERSISTENCE_RELEASE_2026_09_01_SHA256SUMS'
$lines = Get-Content -LiteralPath $manifest
$verified = 0

foreach ($line in $lines) {
    if ($line -notmatch '^([0-9a-f]{64})  (.+)$') {
        throw "Malformed manifest line: $line"
    }
    $expected = $Matches[1]
    $relative = $Matches[2].Replace('/', [IO.Path]::DirectorySeparatorChar)
    $absolute = Join-Path $repoRoot $relative
    if (-not (Test-Path -LiteralPath $absolute -PathType Leaf)) {
        throw "Missing release artifact: $relative"
    }
    $actual = (Get-FileHash -Algorithm SHA256 -LiteralPath $absolute).Hash.ToLowerInvariant()
    if ($actual -ne $expected) {
        throw "SHA-256 mismatch for $relative`: expected $expected, got $actual"
    }
    $verified += 1
}

$manifestHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $manifest).Hash.ToLowerInvariant()
Write-Output "PASS: verified $verified release artifacts"
Write-Output "MANIFEST_SHA256=$manifestHash"
