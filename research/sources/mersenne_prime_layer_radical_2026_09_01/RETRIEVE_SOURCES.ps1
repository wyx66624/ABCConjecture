[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)]
  [string]$Destination
)

$target = [System.IO.Path]::GetFullPath($Destination)
New-Item -ItemType Directory -Force -Path $target | Out-Null

Invoke-WebRequest `
  -Uri 'https://www.impan.pl/shop/en/publication/transaction/download/product/101030' `
  -OutFile (Join-Path $target 'Erdos_Shorey_1976_greatest_prime_factor.pdf') `
  -AllowInsecureRedirect

Invoke-WebRequest `
  -Uri 'https://www.ford126.web.illinois.edu/wwwpapers/P2n-1.pdf' `
  -OutFile (Join-Path $target 'Ford_Luca_Shparlinski_2009_largest_prime_factor.pdf')

Invoke-WebRequest `
  -Uri 'https://arxiv.org/pdf/1606.08690' `
  -OutFile (Join-Path $target 'Cambraia_et_al_2021_prime_factors_Mersenne.pdf')

Invoke-WebRequest `
  -Uri 'https://mast.queensu.ca/~murty/murty-wong.pdf' `
  -OutFile (Join-Path $target 'Murty_Wong_2002_ABC_Lucas_Lehmer.pdf')

Invoke-WebRequest `
  -Uri 'https://mast.queensu.ca/~murty/erdos-ram.pdf' `
  -OutFile (Join-Path $target 'Erdos_Murty_1999_order_mod_p.pdf')

Invoke-WebRequest `
  -Uri 'https://arxiv.org/pdf/2508.08472v2' `
  -OutFile (Join-Path $target 'Fellini_Murty_2026_Wieferich_number_fields.pdf')

Invoke-WebRequest `
  -Uri 'https://math.dartmouth.edu/~carlp/cyclotomicprimesfinal.pdf' `
  -OutFile (Join-Path $target 'Pomerance_2025_Cyclotomic_Primes.pdf')

Invoke-WebRequest `
  -Uri 'https://mast.queensu.ca/~murty/murty-seguin-jnt.pdf' `
  -OutFile (Join-Path $target 'Murty_Seguin_2019_Cyclotomic_Wieferich.pdf')

Get-ChildItem -LiteralPath $target -Filter '*.pdf' -File |
  Get-FileHash -Algorithm SHA256 |
  Sort-Object Path |
  Format-Table -AutoSize
