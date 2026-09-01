$ErrorActionPreference = 'Stop'

$workspace = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..\..\..')).Path
$upstream = Join-Path $workspace 'tmp\lana_iut_2026_09_01'
$mainProject = Join-Path $workspace 'Lean'
$expectedUpstream = 'ddaddc274281adb5674d647e24fa478745ac6d40'

if (Test-Path -LiteralPath (Join-Path $upstream '.git')) {
  $actualUpstream = (& git -C $upstream rev-parse HEAD).Trim()
  if ($actualUpstream -ne $expectedUpstream) {
    throw "Pinned LANA mismatch: expected $expectedUpstream, found $actualUpstream"
  }

  Push-Location $upstream
  try {
    & lake build Iut.Cor312.Statement
    if ($LASTEXITCODE -ne 0) { throw 'LANA statement build failed' }
    & lake build Iut.Cor312.SpecificationNoGoAudit
    if ($LASTEXITCODE -ne 0) { throw 'LANA audit build failed' }
    & lake env lean Iut/Cor312/SpecificationNoGoAudit.lean
    if ($LASTEXITCODE -ne 0) { throw 'LANA direct Lean check failed' }
  } finally {
    Pop-Location
  }
} else {
  Write-Warning 'Pinned full LANA checkout absent; preserving archived upstream source and validation logs.'
}

Push-Location $mainProject
try {
  & lake build IUTThreeClosures.IUTLanaSpecificationNoGo20260901
  if ($LASTEXITCODE -ne 0) { throw 'Main audit module build failed' }
  & lake env lean IUTThreeClosures/IUTLanaSpecificationNoGo20260901.lean
  if ($LASTEXITCODE -ne 0) { throw 'Main direct Lean check failed' }
  & lake build IUTThreeClosures
  if ($LASTEXITCODE -ne 0) { throw 'Main aggregate build failed' }
} finally {
  Pop-Location
}

Write-Output 'All LANA same-pilot specification audit checks passed.'
