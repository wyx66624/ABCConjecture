$ErrorActionPreference = 'Stop'

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..')).Path
$leanRoot = Join-Path $repoRoot 'Lean'
$targets = @(
    [ordered]@{ Name = 'Danilov'; File = 'IUTThreeClosures\DanilovGlobalIndexSieve20260831.lean'; Log = 'danilov-direct.log' },
    [ordered]@{ Name = 'DanilovAudit'; File = 'IUTThreeClosures\DanilovGlobalIndexSieve20260831Audit.lean'; Log = 'danilov-audit-direct.log' },
    [ordered]@{ Name = 'Pell'; File = 'IUTThreeClosures\PellPrimeIndexDichotomy20260831.lean'; Log = 'pell-direct.log' },
    [ordered]@{ Name = 'Affine'; File = 'IUTThreeClosures\AffineExcessUpperBound20260831.lean'; Log = 'affine-direct.log' }
)
$sourceFiles = @(
    'IUTThreeClosures\DanilovGlobalIndexSieve20260831.lean',
    'IUTThreeClosures\DanilovGlobalIndexSieve20260831Audit.lean',
    'IUTThreeClosures\PellPrimeIndexDichotomy20260831.lean',
    'IUTThreeClosures\AffineExcessUpperBound20260831.lean'
)

$toolVersions = [ordered]@{}
$toolVersions.lean = (& lake env lean --version | Out-String).Trim()
$toolVersions.lake = (& lake --version | Out-String).Trim()

$directRuns = @()
Push-Location $leanRoot
try {
    foreach ($target in $targets) {
        $logPath = Join-Path $PSScriptRoot $target.Log
        & lake env lean $target.File *>&1 | Set-Content -LiteralPath $logPath -Encoding utf8
        $code = $LASTEXITCODE
        Set-Content -LiteralPath ($logPath + '.exitcode') -Value $code -Encoding ascii
        $directRuns += [ordered]@{
            name = $target.Name
            file = ('Lean/' + $target.File.Replace('\', '/'))
            exitCode = $code
            log = $target.Log
        }
        if ($code -ne 0) {
            throw "Direct Lean compilation failed for $($target.File) with exit code $code"
        }
    }

    $aggregateLog = Join-Path $PSScriptRoot 'aggregate-lake-build.log'
    & lake build `
        IUTThreeClosures.DanilovGlobalIndexSieve20260831 `
        IUTThreeClosures.PellPrimeIndexDichotomy20260831 `
        IUTThreeClosures.AffineExcessUpperBound20260831 `
        IUTThreeClosures *>&1 | Set-Content -LiteralPath $aggregateLog -Encoding utf8
    $aggregateCode = $LASTEXITCODE
    Set-Content -LiteralPath ($aggregateLog + '.exitcode') -Value $aggregateCode -Encoding ascii
    if ($aggregateCode -ne 0) {
        throw "Aggregate Lake build failed with exit code $aggregateCode"
    }
}
finally {
    Pop-Location
}

$declarationCounts = @()
$theoremTotal = 0
$definitionStructureTotal = 0
foreach ($relative in $sourceFiles[0], $sourceFiles[2], $sourceFiles[3]) {
    $absolute = Join-Path $leanRoot $relative
    $lines = Get-Content -LiteralPath $absolute
    $theorems = @($lines | Where-Object { $_ -match '^\s*theorem\s+' }).Count
    $definitions = @($lines | Where-Object { $_ -match '^\s*def\s+' }).Count
    $structures = @($lines | Where-Object { $_ -match '^\s*structure\s+' }).Count
    $axioms = @($lines | Where-Object { $_ -match '^\s*axiom\s+' }).Count
    $declarationCounts += [ordered]@{
        file = ('Lean/' + $relative.Replace('\', '/'))
        theorems = $theorems
        definitions = $definitions
        structures = $structures
        axioms = $axioms
        countedDeclarations = $theorems + $definitions + $structures
    }
    $theoremTotal += $theorems
    $definitionStructureTotal += $definitions + $structures
}

$forbiddenMatches = @()
foreach ($relative in $sourceFiles) {
    $absolute = Join-Path $leanRoot $relative
    $lineNumber = 0
    foreach ($line in Get-Content -LiteralPath $absolute) {
        $lineNumber += 1
        if ($line -match '^\s*(axiom|opaque|unsafe)\b' -or
            $line -match '\b(sorry|admit|native_decide)\b') {
            $forbiddenMatches += [ordered]@{
                file = ('Lean/' + $relative.Replace('\', '/'))
                line = $lineNumber
                text = $line
            }
        }
    }
}
if ($forbiddenMatches.Count -ne 0) {
    throw 'Forbidden proof token or declaration found; inspect source-scan.json'
}

$axiomLogs = @(
    (Join-Path $PSScriptRoot 'danilov-direct.log'),
    (Join-Path $PSScriptRoot 'danilov-audit-direct.log'),
    (Join-Path $PSScriptRoot 'pell-direct.log'),
    (Join-Path $PSScriptRoot 'affine-direct.log')
)
$axiomText = ($axiomLogs | ForEach-Object { Get-Content -Raw -LiteralPath $_ }) -join "`n"
$forbiddenKernelNames = @('sorryAx', 'Lean.ofReduceBool', 'Lean.trustCompiler', 'ofReduceBool')
$kernelViolations = @($forbiddenKernelNames | Where-Object { $axiomText.Contains($_) })
if ($kernelViolations.Count -ne 0) {
    throw "Forbidden kernel dependency names found: $($kernelViolations -join ', ')"
}

$aggregateText = Get-Content -Raw -LiteralPath (Join-Path $PSScriptRoot 'aggregate-lake-build.log')
$jobMatch = [regex]::Match($aggregateText, 'Build completed successfully \((\d+) jobs\)\.')
if (-not $jobMatch.Success) {
    throw 'Aggregate success marker was not found'
}

$result = [ordered]@{
    generatedAt = (Get-Date).ToString('o')
    status = 'PASS'
    tools = $toolVersions
    directRuns = $directRuns
    aggregateBuild = [ordered]@{
        exitCode = $aggregateCode
        jobs = [int]$jobMatch.Groups[1].Value
        log = 'aggregate-lake-build.log'
    }
    sourceScan = [ordered]@{
        forbiddenMatches = $forbiddenMatches
        forbiddenKernelNames = $kernelViolations
    }
    declarationCounts = $declarationCounts
    totals = [ordered]@{
        theorems = $theoremTotal
        definitionsOrStructures = $definitionStructureTotal
        countedDeclarations = $theoremTotal + $definitionStructureTotal
    }
}
$result | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath (Join-Path $PSScriptRoot 'validation-run.json') -Encoding utf8

$manifestPaths = @(
    'Lean\IUTThreeClosures\DanilovGlobalIndexSieve20260831.lean',
    'Lean\IUTThreeClosures\DanilovGlobalIndexSieve20260831Audit.lean',
    'Lean\IUTThreeClosures\PellPrimeIndexDichotomy20260831.lean',
    'Lean\IUTThreeClosures\AffineExcessUpperBound20260831.lean',
    'Lean\IUTThreeClosures.lean',
    'Lean\lean-toolchain',
    'Lean\lakefile.toml',
    'research\ABC_AFFINE_EXCESS_LOWER_BOUND_2026_08_31.md',
    'research\ABC_PELL_PRIME_INDEX_DICHOTOMY_2026_08_31.md',
    'research\ABC_DANILOV_GLOBAL_INDEX_SIEVE_2026_08_31.md',
    'research\ABC_BALANCED_PERSISTENCE_CONTINUATION_2026_09_01.md',
    'paper\ChatGPT_ABC_Uniformity_2026.tex',
    'paper\balanced_persistence_2026.tex'
)
$manifest = foreach ($relative in $manifestPaths) {
    $absolute = Join-Path $repoRoot $relative
    $item = Get-Item -LiteralPath $absolute
    [ordered]@{
        path = $relative.Replace('\', '/')
        sha256 = (Get-FileHash -Algorithm SHA256 -LiteralPath $absolute).Hash.ToLowerInvariant()
        bytes = $item.Length
    }
}
$manifest | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath (Join-Path $PSScriptRoot 'artifact-manifest.json') -Encoding utf8

Write-Output "PASS: 4 direct Lean compilations, aggregate $($jobMatch.Groups[1].Value)-job build, $theoremTotal theorems, $definitionStructureTotal definitions/structures, no forbidden proof tokens."
