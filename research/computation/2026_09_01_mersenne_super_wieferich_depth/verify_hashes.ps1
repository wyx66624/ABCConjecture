$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$manifest = Join-Path $root 'SHA256SUMS'
$failures = @()
foreach ($line in Get-Content -LiteralPath $manifest) {
    if ([string]::IsNullOrWhiteSpace($line)) { continue }
    $parts = $line -split '  ', 2
    if ($parts.Count -ne 2) { throw "Malformed SHA256SUMS line: $line" }
    $expected = $parts[0].ToLowerInvariant()
    $relative = $parts[1]
    $path = Join-Path $root $relative
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        $failures += "missing: $relative"
        continue
    }
    $actual = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($actual -ne $expected) {
        $failures += "hash mismatch: $relative"
    }
}
if ($failures.Count -ne 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}
Write-Output 'PASS: all finite super-Wieferich depth artifacts match SHA256SUMS.'
