[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)]
  [string]$Destination
)

$target = [System.IO.Path]::GetFullPath($Destination)
New-Item -ItemType Directory -Force -Path $target | Out-Null

Invoke-WebRequest `
  -Uri 'https://arxiv.org/pdf/math/0607072' `
  -OutFile (Join-Path $target 'Yamada_2006_p_adic_Fermat_quotient_bound.pdf')

Invoke-WebRequest `
  -Uri 'https://arxiv.org/pdf/2601.12753' `
  -OutFile (Join-Path $target 'Li_Zhao_2026_higher_Wieferich_prime_ideals.pdf')

Get-ChildItem -LiteralPath $target -Filter '*.pdf' -File |
  Get-FileHash -Algorithm SHA256 |
  Sort-Object Path |
  Format-Table -AutoSize

