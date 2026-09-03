$ErrorActionPreference = 'Stop'

$auditDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = (Resolve-Path (Join-Path $auditDir '../../..')).Path
$leanDir = Join-Path $repoRoot 'Lean'
$sourceDir = Join-Path $repoRoot 'research/sources/alternative_quality_metrics_2026_09_03'

function Invoke-Recorded {
    param(
        [Parameter(Mandatory = $true)][string]$Label,
        [Parameter(Mandatory = $true)][string]$WorkingDirectory,
        [Parameter(Mandatory = $true)][string]$Executable,
        [Parameter(Mandatory = $true)][string[]]$Arguments
    )
    Push-Location $WorkingDirectory
    try {
        $output = & $Executable @Arguments 2>&1
        $code = $LASTEXITCODE
    }
    finally {
        Pop-Location
    }
    $output | Set-Content -LiteralPath (Join-Path $auditDir ($Label + '_stdout.txt')) -Encoding utf8
    Set-Content -LiteralPath (Join-Path $auditDir ($Label + '.exitcode.txt')) -Value $code -Encoding ascii
    if ($code -ne 0) {
        throw ($Label + ' failed with exit code ' + $code)
    }
}

Invoke-Recorded 'mersenne_main' $leanDir 'lake' @(
    'env', 'lean', '-DwarningAsError=true',
    'IUTThreeClosures/MersenneFareyQuantitativeSwarm20260903.lean'
)
Invoke-Recorded 'mersenne_audit' $leanDir 'lake' @(
    'env', 'lean', '-DwarningAsError=true',
    'IUTThreeClosures/MersenneFareyQuantitativeSwarm20260903AxiomAudit.lean'
)
Invoke-Recorded 'alternative_main' $leanDir 'lake' @(
    'env', 'lean', '-DwarningAsError=true',
    'IUTThreeClosures/AlternativeQualityPackingBridge20260903.lean'
)
Invoke-Recorded 'alternative_audit' $leanDir 'lake' @(
    'env', 'lean', '-DwarningAsError=true',
    'IUTThreeClosures/AlternativeQualityPackingBridge20260903AxiomAudit.lean'
)
Invoke-Recorded 'source_verifier' $sourceDir 'python' @('verify_source.py')
Invoke-Recorded 'cross_audit' $auditDir 'python' @('verify_cross_audit.py')

Write-Output 'root-route cross-audit: PASS'
