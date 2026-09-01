[CmdletBinding()]
param(
  [string[]]$Directories = @(
    'research/sources/mersenne_prime_layer_radical_2026_09_01',
    'research/computation/2026_09_01_mersenne_prime_layer_radical'
  )
)

$failed = $false
foreach ($directory in $Directories) {
  $root = (Resolve-Path -LiteralPath $directory).Path
  $manifest = Join-Path $root 'SHA256SUMS'
  foreach ($line in Get-Content -LiteralPath $manifest) {
    if ($line -notmatch '^([0-9a-f]{64})  (.+)$') {
      throw "Malformed SHA256SUMS line in ${manifest}: $line"
    }
    $expected = $Matches[1]
    $name = $Matches[2]
    $path = Join-Path $root $name
    $actual = (Get-FileHash -Algorithm SHA256 -LiteralPath $path).Hash.ToLower()
    if ($actual -ne $expected) {
      Write-Error "SHA-256 mismatch: $path"
      $failed = $true
    }
  }
  Write-Output "verified $manifest"
}

if ($failed) {
  exit 1
}

