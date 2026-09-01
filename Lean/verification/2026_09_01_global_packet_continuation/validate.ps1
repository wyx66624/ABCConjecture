[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$packageRoot = $PSScriptRoot
$repoRoot = (Resolve-Path -LiteralPath (Join-Path $packageRoot '..\..\..')).Path
$leanRoot = Join-Path $repoRoot 'Lean'
$logRoot = Join-Path $packageRoot 'logs'
$null = New-Item -ItemType Directory -Force -Path $logRoot

$modules = @(
    'AffineRadicalStep20260901',
    'DanilovRecursiveLift20260901',
    'DanilovSimplePrimitiveNoGo20260901',
    'IUTLanaSpecificationNoGo20260901',
    'PellPrimeRankCounterexamples20260901'
)
$moduleFiles = @($modules | ForEach-Object { "IUTThreeClosures/$_.lean" })

$expectedDeclarations = [ordered]@{
    AffineRadicalStep20260901 = [ordered]@{
        theorems = 41; lemmas = 0; definitions = 14; abbreviations = 1
        structures = 2; classes = 0; inductives = 0; instances = 0
        printAxiomsCommands = 21; countedTopLevelDeclarations = 58
    }
    DanilovRecursiveLift20260901 = [ordered]@{
        theorems = 23; lemmas = 0; definitions = 9; abbreviations = 0
        structures = 0; classes = 0; inductives = 0; instances = 0
        printAxiomsCommands = 15; countedTopLevelDeclarations = 32
    }
    DanilovSimplePrimitiveNoGo20260901 = [ordered]@{
        theorems = 28; lemmas = 0; definitions = 12; abbreviations = 0
        structures = 1; classes = 0; inductives = 0; instances = 0
        printAxiomsCommands = 22; countedTopLevelDeclarations = 41
    }
    IUTLanaSpecificationNoGo20260901 = [ordered]@{
        theorems = 11; lemmas = 0; definitions = 0; abbreviations = 0
        structures = 2; classes = 0; inductives = 0; instances = 0
        printAxiomsCommands = 11; countedTopLevelDeclarations = 13
    }
    PellPrimeRankCounterexamples20260901 = [ordered]@{
        theorems = 19; lemmas = 0; definitions = 1; abbreviations = 0
        structures = 0; classes = 0; inductives = 0; instances = 0
        printAxiomsCommands = 14; countedTopLevelDeclarations = 20
    }
}
$expectedTotals = [ordered]@{
    theoremsOrLemmas = 122
    definitionsOrAbbreviations = 37
    structuresClassesOrInductives = 5
    instances = 0
    countedTopLevelDeclarations = 164
    printAxiomsCommands = 83
}

$inputPaths = @($moduleFiles | ForEach-Object { "Lean/$_" })
$inputPaths += @(
    'Lean/IUTThreeClosures.lean',
    'Lean/lean-toolchain',
    'Lean/lakefile.toml',
    'research/computation/2026_09_01_affine_matching_lower_gate/SHA256SUMS',
    'research/computation/2026_09_01_affine_matching_lower_gate/INPUT_SHA256SUMS.txt',
    'research/computation/2026_09_01_danilov_recursive_lift/FILE_MANIFEST.json',
    'research/computation/2026_09_01_danilov_recursive_lift/SHA256SUMS',
    'research/computation/2026_09_01_danilov_simple_primitive_divisor/FILE_MANIFEST.json',
    'research/computation/2026_09_01_danilov_simple_primitive_divisor/SHA256SUMS',
    'research/computation/2026_09_01_pell_packet_global_attack/FILE_MANIFEST.json',
    'research/sources/iut_lana_2026_09_01/source-metadata.json',
    'research/sources/iut_lana_2026_09_01/lana_ddaddc2_audit_sources/SHA256SUMS',
    'Lean/verification/2026_09_01_iut_lana_specification_nogo/SHA256SUMS'
)

function Get-Sha256Lower {
    param([Parameter(Mandatory = $true)][string]$Path)
    return (Get-FileHash -Algorithm SHA256 -LiteralPath $Path).Hash.ToLowerInvariant()
}

function Get-RepoRelativePath {
    param([Parameter(Mandatory = $true)][string]$Path)
    return ([IO.Path]::GetRelativePath($repoRoot, [IO.Path]::GetFullPath($Path))).Replace('\', '/')
}

function Resolve-ContainedFile {
    param(
        [Parameter(Mandatory = $true)][string]$Base,
        [Parameter(Mandatory = $true)][string]$Relative
    )
    if ([IO.Path]::IsPathRooted($Relative)) {
        throw "Manifest path must be relative: $Relative"
    }
    $baseFull = [IO.Path]::GetFullPath($Base)
    $candidate = [IO.Path]::GetFullPath((Join-Path $baseFull $Relative))
    $comparison = if ($env:OS -eq 'Windows_NT') {
        [StringComparison]::OrdinalIgnoreCase
    } else {
        [StringComparison]::Ordinal
    }
    $prefix = $baseFull.TrimEnd([IO.Path]::DirectorySeparatorChar, [IO.Path]::AltDirectorySeparatorChar) +
        [IO.Path]::DirectorySeparatorChar
    if (-not $candidate.StartsWith($prefix, $comparison)) {
        throw "Manifest path escapes its bundle: $Relative"
    }
    if (-not (Test-Path -LiteralPath $candidate -PathType Leaf)) {
        throw "Manifest file is missing: $candidate"
    }
    return $candidate
}

function Get-RelativeFileSet {
    param(
        [Parameter(Mandatory = $true)][string]$Base,
        [string[]]$Exclusions = @()
    )
    $baseFull = [IO.Path]::GetFullPath($Base)
    return @(
        Get-ChildItem -LiteralPath $baseFull -Recurse -File -Force |
            ForEach-Object {
                ([IO.Path]::GetRelativePath($baseFull, $_.FullName)).Replace('\', '/')
            } |
            Where-Object { $_ -notmatch '(^|/)__pycache__/' } |
            Where-Object { [IO.Path]::GetExtension($_) -ne '.exe' } |
            Where-Object { $Exclusions -notcontains $_ } |
            Sort-Object
    )
}

function Assert-ExactRelativeFileSet {
    param(
        [Parameter(Mandatory = $true)][string]$Base,
        [Parameter(Mandatory = $true)][string[]]$Expected,
        [string[]]$Exclusions = @()
    )
    $actual = @(Get-RelativeFileSet -Base $Base -Exclusions $Exclusions)
    $expectedSorted = @($Expected | Sort-Object)
    $difference = @(Compare-Object -ReferenceObject $expectedSorted -DifferenceObject $actual)
    if ($difference.Count -ne 0) {
        $rendered = ($difference | Out-String).Trim()
        throw ("Manifest file-set mismatch under $Base" + [Environment]::NewLine + $rendered)
    }
}

function Test-ChecksumManifest {
    param(
        [Parameter(Mandatory = $true)][string]$Base,
        [Parameter(Mandatory = $true)][string]$ChecksumName,
        [switch]$Strict,
        [string[]]$StrictExclusions = @()
    )
    $checksumPath = Join-Path $Base $ChecksumName
    if (-not (Test-Path -LiteralPath $checksumPath -PathType Leaf)) {
        throw "Checksum manifest is missing: $checksumPath"
    }
    $entries = @()
    foreach ($line in Get-Content -LiteralPath $checksumPath) {
        if ([string]::IsNullOrWhiteSpace($line) -or $line.TrimStart().StartsWith('#')) {
            continue
        }
        $match = [regex]::Match($line, '^([0-9A-Fa-f]{64})\s+\*?(.+?)\s*$')
        if (-not $match.Success) {
            throw "Malformed checksum line in $($checksumPath): $line"
        }
        $expectedHash = $match.Groups[1].Value.ToLowerInvariant()
        $relative = $match.Groups[2].Value.Replace('\', '/')
        $absolute = Resolve-ContainedFile -Base $Base -Relative $relative
        $actualHash = Get-Sha256Lower -Path $absolute
        if ($actualHash -ne $expectedHash) {
            throw "Checksum mismatch for $absolute"
        }
        $entries += $relative
    }
    if ($entries.Count -eq 0) {
        throw "Checksum manifest has no entries: $checksumPath"
    }
    if (@($entries | Sort-Object -Unique).Count -ne $entries.Count) {
        throw "Duplicate checksum paths in $checksumPath"
    }
    if ($Strict) {
        Assert-ExactRelativeFileSet -Base $Base -Expected $entries -Exclusions $StrictExclusions
    }
    return [pscustomobject][ordered]@{
        path = Get-RepoRelativePath -Path $checksumPath
        entries = $entries.Count
        sha256 = Get-Sha256Lower -Path $checksumPath
    }
}

function Test-JsonManifest {
    param(
        [Parameter(Mandatory = $true)][string]$Base,
        [Parameter(Mandatory = $true)][string]$ManifestName,
        [switch]$Strict,
        [string[]]$StrictExclusions = @()
    )
    $manifestPath = Join-Path $Base $ManifestName
    if (-not (Test-Path -LiteralPath $manifestPath -PathType Leaf)) {
        throw "JSON manifest is missing: $manifestPath"
    }
    $data = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
    $records = @($data.files)
    if ($records.Count -eq 0) {
        throw "JSON manifest has no files: $manifestPath"
    }
    $paths = @()
    foreach ($record in $records) {
        $relative = ([string]$record.path).Replace('\', '/')
        $absolute = Resolve-ContainedFile -Base $Base -Relative $relative
        if ((Get-Item -LiteralPath $absolute).Length -ne [int64]$record.bytes) {
            throw "Byte-size mismatch for $absolute"
        }
        if ((Get-Sha256Lower -Path $absolute) -ne ([string]$record.sha256).ToLowerInvariant()) {
            throw "JSON-manifest checksum mismatch for $absolute"
        }
        $paths += $relative
    }
    if (@($paths | Sort-Object -Unique).Count -ne $paths.Count) {
        throw "Duplicate paths in $manifestPath"
    }
    if ($data.PSObject.Properties.Name -contains 'file_count') {
        if ([int]$data.file_count -ne $records.Count) {
            throw "file_count mismatch in $manifestPath"
        }
    }
    if ($data.PSObject.Properties.Name -contains 'file_count_excluding_manifest_and_sums') {
        if ([int]$data.file_count_excluding_manifest_and_sums -ne $records.Count) {
            throw "file_count_excluding_manifest_and_sums mismatch in $manifestPath"
        }
    }
    if ($Strict) {
        Assert-ExactRelativeFileSet -Base $Base -Expected $paths -Exclusions $StrictExclusions
    }
    return [pscustomobject][ordered]@{
        path = Get-RepoRelativePath -Path $manifestPath
        entries = $records.Count
        sha256 = Get-Sha256Lower -Path $manifestPath
    }
}

function Test-FrozenInputManifest {
    $manifestPath = Join-Path $packageRoot 'input-manifest.json'
    if (-not (Test-Path -LiteralPath $manifestPath -PathType Leaf)) {
        throw "Frozen input manifest is missing: $manifestPath"
    }
    $records = @(Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json)
    if ($records.Count -ne $inputPaths.Count) {
        throw "Frozen input count mismatch: expected $($inputPaths.Count), found $($records.Count)"
    }
    $recordPaths = @($records | ForEach-Object { ([string]$_.path).Replace('\', '/') })
    if (@($recordPaths | Sort-Object -Unique).Count -ne $recordPaths.Count) {
        throw 'Frozen input manifest contains duplicate paths'
    }
    $difference = @(
        Compare-Object -ReferenceObject @($inputPaths | Sort-Object) -DifferenceObject @($recordPaths | Sort-Object)
    )
    if ($difference.Count -ne 0) {
        throw ('Frozen input path-set mismatch' + [Environment]::NewLine + (($difference | Out-String).Trim()))
    }
    foreach ($record in $records) {
        $relative = ([string]$record.path).Replace('\', '/')
        $absolute = Resolve-ContainedFile -Base $repoRoot -Relative $relative
        if ((Get-Item -LiteralPath $absolute).Length -ne [int64]$record.bytes) {
            throw "Frozen input byte-size mismatch: $relative"
        }
        if ((Get-Sha256Lower -Path $absolute) -ne ([string]$record.sha256).ToLowerInvariant()) {
            throw "Frozen input hash mismatch: $relative"
        }
    }
    return [pscustomobject][ordered]@{
        path = Get-RepoRelativePath -Path $manifestPath
        entries = $records.Count
        sha256 = Get-Sha256Lower -Path $manifestPath
    }
}

function Invoke-NativeLogged {
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][string]$Executable,
        [Parameter(Mandatory = $true)][string[]]$Arguments,
        [Parameter(Mandatory = $true)][string]$WorkingDirectory
    )
    $logPath = Join-Path $logRoot "$Name.log"
    @(
        "WORKDIR: $WorkingDirectory"
        "COMMAND: $Executable $($Arguments -join ' ')"
    ) | Set-Content -LiteralPath $logPath -Encoding utf8
    Push-Location $WorkingDirectory
    try {
        & $Executable @Arguments *>&1 | Add-Content -LiteralPath $logPath -Encoding utf8
        $exitCode = $LASTEXITCODE
    } finally {
        Pop-Location
    }
    "EXIT_CODE: $exitCode" | Add-Content -LiteralPath $logPath -Encoding utf8
    Set-Content -LiteralPath "$logPath.exitcode" -Value $exitCode -Encoding ascii
    if ($exitCode -ne 0) {
        throw "$Name failed with exit code $exitCode; inspect $logPath"
    }
    return [pscustomobject][ordered]@{
        name = $Name
        exitCode = $exitCode
        log = Get-RepoRelativePath -Path $logPath
        logSha256 = Get-Sha256Lower -Path $logPath
    }
}

$inputSnapshotStart = Test-FrozenInputManifest

$lakeCommand = (Get-Command lake -ErrorAction Stop).Source
Push-Location $leanRoot
try {
    $lakeVersion = (& $lakeCommand --version 2>&1 | Out-String).Trim()
    if ($LASTEXITCODE -ne 0) {
        throw 'lake --version failed'
    }
    $leanVersion = (& $lakeCommand env lean --version 2>&1 | Out-String).Trim()
    if ($LASTEXITCODE -ne 0) {
        throw 'lake env lean --version failed'
    }
} finally {
    Pop-Location
}
$gitHead = (& git -C $repoRoot rev-parse HEAD 2>&1 | Out-String).Trim()
if ($LASTEXITCODE -ne 0) {
    throw 'git rev-parse HEAD failed'
}
@(
    "lake: $lakeVersion"
    "lean: $leanVersion"
    "gitHead: $gitHead"
) | Set-Content -LiteralPath (Join-Path $logRoot 'tool-versions.log') -Encoding utf8

$sourceStart = [ordered]@{}
foreach ($relative in $moduleFiles + @('IUTThreeClosures.lean')) {
    $absolute = Join-Path $leanRoot $relative
    if (-not (Test-Path -LiteralPath $absolute -PathType Leaf)) {
        throw "Lean source is missing: $absolute"
    }
    $sourceStart[$relative] = Get-Sha256Lower -Path $absolute
}

$aggregateSource = Get-Content -Raw -LiteralPath (Join-Path $leanRoot 'IUTThreeClosures.lean')
foreach ($module in $modules) {
    $pattern = "(?m)^import\s+IUTThreeClosures\.$([regex]::Escape($module))\s*$"
    if (-not [regex]::IsMatch($aggregateSource, $pattern)) {
        throw "Aggregate import is missing for $module"
    }
}

$directRuns = @()
foreach ($module in $modules) {
    $invokeParameters = @{
        Name = "$module-direct"
        Executable = $lakeCommand
        Arguments = @('env', 'lean', "IUTThreeClosures/$module.lean")
        WorkingDirectory = $leanRoot
    }
    $directRuns += Invoke-NativeLogged @invokeParameters
}

$aggregateArguments = @('build', 'IUTThreeClosures')
$aggregateParameters = @{
    Name = 'aggregate-lake-build'
    Executable = $lakeCommand
    Arguments = $aggregateArguments
    WorkingDirectory = $leanRoot
}
$aggregateRun = Invoke-NativeLogged @aggregateParameters
$aggregateLogPath = Join-Path $logRoot 'aggregate-lake-build.log'
$aggregateText = Get-Content -Raw -LiteralPath $aggregateLogPath
$jobMatch = [regex]::Match($aggregateText, 'Build completed successfully \((\d+) jobs\)\.')
if (-not $jobMatch.Success) {
    throw 'Aggregate Lake success marker was not found'
}
$aggregateJobs = [int]$jobMatch.Groups[1].Value
$aggregateWarnings = [regex]::Matches($aggregateText, '(?im)\bwarning:').Count

$forbiddenMatches = @()
$declarationRecords = @()
$theoremTotal = 0
$definitionTotal = 0
$structureTotal = 0
$otherDeclarationTotal = 0
$printAxiomsTotal = 0
foreach ($module in $modules) {
    $relative = "IUTThreeClosures/$module.lean"
    $absolute = Join-Path $leanRoot $relative
    $lines = @(Get-Content -LiteralPath $absolute)
    $lineNumber = 0
    foreach ($line in $lines) {
        $lineNumber += 1
        if ($line -match '^\s*(?:(?:private|protected|noncomputable)\s+)*(axiom|axioms|opaque|unsafe)\b' -or
            $line -match '\b(sorry|admit|native_decide|sorryAx)\b') {
            $forbiddenMatches += [pscustomobject][ordered]@{
                file = "Lean/$relative"
                line = $lineNumber
                text = $line
            }
        }
    }
    $prefix = '^\s*(?:(?:private|protected|noncomputable)\s+)*'
    $theorems = @($lines | Where-Object { $_ -match ($prefix + 'theorem\s+') }).Count
    $lemmas = @($lines | Where-Object { $_ -match ($prefix + 'lemma\s+') }).Count
    $definitions = @($lines | Where-Object { $_ -match ($prefix + 'def\s+') }).Count
    $abbreviations = @($lines | Where-Object { $_ -match ($prefix + 'abbrev\s+') }).Count
    $structures = @($lines | Where-Object { $_ -match ($prefix + 'structure\s+') }).Count
    $classes = @($lines | Where-Object { $_ -match ($prefix + 'class\s+') }).Count
    $inductives = @($lines | Where-Object { $_ -match ($prefix + 'inductive\s+') }).Count
    $instances = @($lines | Where-Object { $_ -match ($prefix + 'instance\s+') }).Count
    $printAxioms = @($lines | Where-Object { $_ -match '^\s*#print\s+axioms\s+' }).Count
    if ($printAxioms -eq 0) {
        throw "No #print axioms audit commands found in $relative"
    }
    $counted = $theorems + $lemmas + $definitions + $abbreviations +
        $structures + $classes + $inductives + $instances
    $declarationRecords += [pscustomobject][ordered]@{
        file = "Lean/$relative"
        theorems = $theorems
        lemmas = $lemmas
        definitions = $definitions
        abbreviations = $abbreviations
        structures = $structures
        classes = $classes
        inductives = $inductives
        instances = $instances
        printAxiomsCommands = $printAxioms
        countedTopLevelDeclarations = $counted
    }
    $expected = $expectedDeclarations[$module]
    foreach ($property in @(
        'theorems', 'lemmas', 'definitions', 'abbreviations',
        'structures', 'classes', 'inductives', 'instances',
        'printAxiomsCommands', 'countedTopLevelDeclarations'
    )) {
        $actualValue = $declarationRecords[-1].$property
        $expectedValue = $expected[$property]
        if ($actualValue -ne $expectedValue) {
            throw "Declaration baseline mismatch for ${module}.${property}: expected $expectedValue, found $actualValue"
        }
    }
    $theoremTotal += $theorems + $lemmas
    $definitionTotal += $definitions + $abbreviations
    $structureTotal += $structures + $classes + $inductives
    $otherDeclarationTotal += $instances
    $printAxiomsTotal += $printAxioms
}
if ($forbiddenMatches.Count -ne 0) {
    $forbiddenMatches | ConvertTo-Json -Depth 5 |
        Set-Content -LiteralPath (Join-Path $logRoot 'source-scan.log') -Encoding utf8
    throw 'Forbidden Lean source declaration or proof placeholder found'
}
@(
    'PASS'
    "files: $($modules.Count)"
    'forbidden declarations: axiom/axioms, opaque, unsafe'
    'forbidden proof tokens: sorry, admit, native_decide, sorryAx'
    'matches: 0'
) | Set-Content -LiteralPath (Join-Path $logRoot 'source-scan.log') -Encoding utf8

$directText = ($directRuns | ForEach-Object {
    Get-Content -Raw -LiteralPath (Join-Path $repoRoot $_.log)
}) -join [Environment]::NewLine
$forbiddenKernelNames = @('sorryAx', 'Lean.ofReduceBool', 'Lean.trustCompiler', 'ofReduceBool')
$kernelViolations = @($forbiddenKernelNames | Where-Object { $directText.Contains($_) })
if ($kernelViolations.Count -ne 0) {
    throw "Forbidden kernel dependency found: $($kernelViolations -join ', ')"
}
$observedAxioms = @()
$axiomMatches = [regex]::Matches(
    $directText,
    'depends on axioms:\s*\[([^\]]*)\]',
    [Text.RegularExpressions.RegexOptions]::Singleline
)
foreach ($match in $axiomMatches) {
    foreach ($name in $match.Groups[1].Value.Split(',')) {
        $normalized = ($name -replace '\s+', '').Trim()
        if ($normalized.Length -gt 0) {
            $observedAxioms += $normalized
        }
    }
}
if ($axiomMatches.Count -ne $printAxiomsTotal) {
    throw "Expected $printAxiomsTotal #print axioms reports but parsed $($axiomMatches.Count)"
}
if ($theoremTotal -ne $expectedTotals.theoremsOrLemmas -or
    $definitionTotal -ne $expectedTotals.definitionsOrAbbreviations -or
    $structureTotal -ne $expectedTotals.structuresClassesOrInductives -or
    $otherDeclarationTotal -ne $expectedTotals.instances -or
    ($theoremTotal + $definitionTotal + $structureTotal + $otherDeclarationTotal) -ne
        $expectedTotals.countedTopLevelDeclarations -or
    $printAxiomsTotal -ne $expectedTotals.printAxiomsCommands) {
    throw 'Aggregate declaration baseline mismatch'
}
$observedAxioms = @($observedAxioms | Sort-Object -Unique)
$allowedAxioms = @('Classical.choice', 'Quot.sound', 'propext')
$unexpectedAxioms = @($observedAxioms | Where-Object { $allowedAxioms -notcontains $_ })
if ($unexpectedAxioms.Count -ne 0) {
    throw "Unexpected axiom dependency: $($unexpectedAxioms -join ', ')"
}

$declarationRecords | ConvertTo-Json -Depth 5 |
    Set-Content -LiteralPath (Join-Path $logRoot 'declaration-counts.log') -Encoding utf8

$bundleRoot = Join-Path $repoRoot 'research\computation'
$bundleResults = @()

$affineBase = Join-Path $bundleRoot '2026_09_01_affine_matching_lower_gate'
$affineSums = Test-ChecksumManifest -Base $affineBase -ChecksumName 'SHA256SUMS' -Strict -StrictExclusions @('SHA256SUMS')
$bundleResults += [pscustomobject][ordered]@{
    name = 'affine_matching_lower_gate'
    jsonManifest = $null
    checksumManifest = $affineSums
}

$recursiveBase = Join-Path $bundleRoot '2026_09_01_danilov_recursive_lift'
$recursiveJson = Test-JsonManifest -Base $recursiveBase -ManifestName 'FILE_MANIFEST.json' -Strict -StrictExclusions @('FILE_MANIFEST.json', 'SHA256SUMS', 'manifest_build_stdout.json')
$recursiveSums = Test-ChecksumManifest -Base $recursiveBase -ChecksumName 'SHA256SUMS' -Strict -StrictExclusions @('SHA256SUMS', 'manifest_build_stdout.json')
$recursiveData = Get-Content -Raw -LiteralPath (Join-Path $recursiveBase 'FILE_MANIFEST.json') | ConvertFrom-Json
if ($recursiveData.PSObject.Properties.Name -contains 'external_primary_source') {
    $external = $recursiveData.external_primary_source
    $externalPath = Join-Path $repoRoot ([string]$external.path)
    if (-not (Test-Path -LiteralPath $externalPath -PathType Leaf)) {
        throw "Recursive-lift external source is missing: $externalPath"
    }
    if ((Get-Item -LiteralPath $externalPath).Length -ne [int64]$external.bytes -or
        (Get-Sha256Lower -Path $externalPath) -ne ([string]$external.sha256).ToLowerInvariant()) {
        throw 'Recursive-lift external primary-source hash mismatch'
    }
}
$bundleResults += [pscustomobject][ordered]@{
    name = 'danilov_recursive_lift'
    jsonManifest = $recursiveJson
    checksumManifest = $recursiveSums
}

$simpleBase = Join-Path $bundleRoot '2026_09_01_danilov_simple_primitive_divisor'
$simpleJson = Test-JsonManifest -Base $simpleBase -ManifestName 'FILE_MANIFEST.json' -Strict -StrictExclusions @('FILE_MANIFEST.json', 'SHA256SUMS')
$simpleSums = Test-ChecksumManifest -Base $simpleBase -ChecksumName 'SHA256SUMS' -Strict -StrictExclusions @('SHA256SUMS')
$bundleResults += [pscustomobject][ordered]@{
    name = 'danilov_simple_primitive_divisor'
    jsonManifest = $simpleJson
    checksumManifest = $simpleSums
}

$pellBase = Join-Path $bundleRoot '2026_09_01_pell_packet_global_attack'
$pellJson = Test-JsonManifest -Base $pellBase -ManifestName 'FILE_MANIFEST.json' -Strict -StrictExclusions @('FILE_MANIFEST.json')
$bundleResults += [pscustomobject][ordered]@{
    name = 'pell_packet_global_attack'
    jsonManifest = $pellJson
    checksumManifest = $null
}

$bundleResults | ConvertTo-Json -Depth 8 |
    Set-Content -LiteralPath (Join-Path $logRoot 'bundle-manifests.log') -Encoding utf8

$iutSourceRoot = Join-Path $repoRoot 'research\sources\iut_lana_2026_09_01'
$iutSnapshotRoot = Join-Path $iutSourceRoot 'lana_ddaddc2_audit_sources'
$iutSnapshotSums = Test-ChecksumManifest -Base $iutSnapshotRoot -ChecksumName 'SHA256SUMS' -Strict -StrictExclusions @('SHA256SUMS')
$iutMetadataPath = Join-Path $iutSourceRoot 'source-metadata.json'
$iutMetadata = Get-Content -Raw -LiteralPath $iutMetadataPath | ConvertFrom-Json
$expectedCommit = 'ddaddc274281adb5674d647e24fa478745ac6d40'
if ([string]$iutMetadata.lean_repository.commit -ne $expectedCommit) {
    throw 'IUT source snapshot commit mismatch'
}
if ((Get-Sha256Lower -Path (Join-Path $iutSnapshotRoot 'SHA256SUMS')) -ne
    ([string]$iutMetadata.lean_repository.audit_source_snapshot.sha256sums_sha256).ToLowerInvariant()) {
    throw 'IUT source snapshot SHA256SUMS hash disagrees with source-metadata.json'
}
if ([int]$iutMetadata.lean_repository.audit_source_snapshot.files_including_snapshot_note_excluding_manifest -ne
    [int]$iutSnapshotSums.entries) {
    throw 'IUT source snapshot entry count disagrees with source-metadata.json'
}
$iutPdf = Join-Path $iutSourceRoot ([string]$iutMetadata.interim_report.local_file)
if ((Get-Item -LiteralPath $iutPdf).Length -ne [int64]$iutMetadata.interim_report.bytes -or
    (Get-Sha256Lower -Path $iutPdf) -ne ([string]$iutMetadata.interim_report.sha256).ToLowerInvariant()) {
    throw 'IUT interim-report PDF snapshot mismatch'
}
$iutTex = Join-Path $iutSourceRoot ([string]$iutMetadata.interim_report.tex_local_file)
if ((Get-Sha256Lower -Path $iutTex) -ne ([string]$iutMetadata.interim_report.tex_sha256).ToLowerInvariant()) {
    throw 'IUT interim-report TeX snapshot mismatch'
}

$iutAuditBundle = Join-Path $repoRoot 'Lean\verification\2026_09_01_iut_lana_specification_nogo'
$iutAuditSums = Test-ChecksumManifest -Base $iutAuditBundle -ChecksumName 'SHA256SUMS' -Strict -StrictExclusions @('SHA256SUMS')
$powerShellCommand = (Get-Process -Id $PID).Path
$iutReplayParameters = @{
    Name = 'iut-specialized-replay'
    Executable = $powerShellCommand
    Arguments = @('-NoProfile', '-File', (Join-Path $iutAuditBundle 'replay.ps1'))
    WorkingDirectory = $repoRoot
}
$iutReplayRun = Invoke-NativeLogged @iutReplayParameters
$iutAuditSumsAfter = Test-ChecksumManifest -Base $iutAuditBundle -ChecksumName 'SHA256SUMS' -Strict -StrictExclusions @('SHA256SUMS')
if ($iutAuditSumsAfter.sha256 -ne $iutAuditSums.sha256) {
    throw 'IUT specialized replay package changed during replay'
}
$iutResult = [pscustomobject][ordered]@{
    pinnedCommit = $expectedCommit
    sourceMetadata = [pscustomobject][ordered]@{
        path = Get-RepoRelativePath -Path $iutMetadataPath
        sha256 = Get-Sha256Lower -Path $iutMetadataPath
    }
    sourceSnapshot = $iutSnapshotSums
    priorAuditReplaySnapshot = $iutAuditSums
    specializedReplay = $iutReplayRun
}
$iutResult | ConvertTo-Json -Depth 7 |
    Set-Content -LiteralPath (Join-Path $logRoot 'iut-snapshot.log') -Encoding utf8

foreach ($relative in $moduleFiles + @('IUTThreeClosures.lean')) {
    $absolute = Join-Path $leanRoot $relative
    $after = Get-Sha256Lower -Path $absolute
    if ($after -ne $sourceStart[$relative]) {
        throw "Lean source changed during validation: $relative"
    }
}
$inputSnapshotEnd = Test-FrozenInputManifest
if ($inputSnapshotEnd.sha256 -ne $inputSnapshotStart.sha256) {
    throw 'Frozen input manifest changed during validation'
}

$totalDeclarations = $theoremTotal + $definitionTotal + $structureTotal + $otherDeclarationTotal
$result = [pscustomobject][ordered]@{
    generatedAt = (Get-Date).ToString('o')
    status = 'PASS'
    repositoryHead = $gitHead
    tools = [pscustomobject][ordered]@{
        lake = $lakeVersion
        lean = $leanVersion
    }
    modules = $modules
    directRuns = $directRuns
    aggregateBuild = [pscustomobject][ordered]@{
        exitCode = 0
        jobs = $aggregateJobs
        warnings = $aggregateWarnings
        log = Get-RepoRelativePath -Path $aggregateLogPath
        logSha256 = Get-Sha256Lower -Path $aggregateLogPath
    }
    sourceScan = [pscustomobject][ordered]@{
        forbiddenMatches = @()
        printAxiomsCommands = $printAxiomsTotal
        observedAxioms = $observedAxioms
        allowedAxioms = $allowedAxioms
        unexpectedAxioms = @()
        forbiddenKernelNames = @()
    }
    declarations = [pscustomobject][ordered]@{
        files = $declarationRecords
        expectedTotals = $expectedTotals
        totals = [pscustomobject][ordered]@{
            theoremsOrLemmas = $theoremTotal
            definitionsOrAbbreviations = $definitionTotal
            structuresClassesOrInductives = $structureTotal
            instances = $otherDeclarationTotal
            countedTopLevelDeclarations = $totalDeclarations
        }
    }
    computationBundles = $bundleResults
    iutSnapshot = $iutResult
    frozenInputManifest = $inputSnapshotEnd
}
$result | ConvertTo-Json -Depth 12 |
    Set-Content -LiteralPath (Join-Path $packageRoot 'validation-run.json') -Encoding utf8

$summary = @(
    'PASS'
    "direct Lean compilations: $($modules.Count)"
    "aggregate Lake jobs: $aggregateJobs"
    "aggregate warnings: $aggregateWarnings"
    "theorems/lemmas: $theoremTotal"
    "definitions/abbreviations: $definitionTotal"
    "structures/classes/inductives: $structureTotal"
    "instances: $otherDeclarationTotal"
    "counted top-level declarations: $totalDeclarations"
    "print-axioms commands: $printAxiomsTotal"
    "observed axiom union: $($observedAxioms -join ', ')"
    "computation bundle manifests: $($bundleResults.Count)"
    "IUT pinned snapshot: $expectedCommit"
    'IUT specialized replay: exit 0'
    "frozen input manifest entries: $($inputSnapshotEnd.entries)"
)
$summary | Set-Content -LiteralPath (Join-Path $logRoot 'validation-summary.log') -Encoding utf8

$checksumPath = Join-Path $packageRoot 'SHA256SUMS'
$packageFiles = @(
    Get-ChildItem -LiteralPath $packageRoot -Recurse -File -Force |
        Where-Object { $_.FullName -ne $checksumPath } |
        Sort-Object FullName
)
$checksumLines = @($packageFiles | ForEach-Object {
    $relative = ([IO.Path]::GetRelativePath($packageRoot, $_.FullName)).Replace('\', '/')
    "$(Get-Sha256Lower -Path $_.FullName)  $relative"
})
$checksumLines | Set-Content -LiteralPath $checksumPath -Encoding utf8
$null = Test-ChecksumManifest -Base $packageRoot -ChecksumName 'SHA256SUMS' -Strict -StrictExclusions @('SHA256SUMS')

Write-Output ((
    "PASS: {0} direct Lean compilations; aggregate {1} jobs; " +
    "{2} counted declarations; four computation manifests and IUT snapshots verified."
) -f $modules.Count, $aggregateJobs, $totalDeclarations)
