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
    'AffineDensityAttack20260901',
    'DanilovWSSEscape20260901',
    'IUTCorrectedVolumeHolonomy20260901',
    'PellFourPrimeCoupling20260901'
)
$moduleFiles = @($modules | ForEach-Object { "IUTThreeClosures/$_.lean" })

$expectedDeclarations = [ordered]@{
    AffineDensityAttack20260901 = [ordered]@{
        theorems = 19; lemmas = 0; definitions = 3; abbreviations = 2
        structures = 0; classes = 0; inductives = 0; instances = 0
        printAxiomsCommands = 14; countedTopLevelDeclarations = 24
    }
    DanilovWSSEscape20260901 = [ordered]@{
        theorems = 14; lemmas = 0; definitions = 4; abbreviations = 2
        structures = 0; classes = 0; inductives = 0; instances = 0
        printAxiomsCommands = 14; countedTopLevelDeclarations = 20
    }
    IUTCorrectedVolumeHolonomy20260901 = [ordered]@{
        theorems = 26; lemmas = 0; definitions = 10; abbreviations = 0
        structures = 5; classes = 0; inductives = 0; instances = 0
        printAxiomsCommands = 24; countedTopLevelDeclarations = 41
    }
    PellFourPrimeCoupling20260901 = [ordered]@{
        theorems = 6; lemmas = 0; definitions = 1; abbreviations = 0
        structures = 0; classes = 0; inductives = 0; instances = 0
        printAxiomsCommands = 6; countedTopLevelDeclarations = 7
    }
}
$expectedTotals = [ordered]@{
    theoremsOrLemmas = 65
    definitions = 18
    abbreviations = 4
    definitionsOrAbbreviations = 22
    structuresClassesOrInductives = 5
    instances = 0
    countedTopLevelDeclarations = 92
    printAxiomsCommands = 58
}

$inputPaths = @($moduleFiles | ForEach-Object { "Lean/$_" })
$inputPaths += @(
    'Lean/IUTThreeClosures.lean',
    'Lean/lean-toolchain',
    'Lean/lakefile.toml',
    'research/ABC_AFFINE_DENSITY_ATTACK_2026_09_01.md',
    'research/ABC_DANILOV_WSS_ESCAPE_2026_09_01.md',
    'research/ABC_IUT_CORRECTED_VOLUME_HOLONOMY_2026_09_01.md',
    'research/ABC_PELL_FOUR_PRIME_COUPLING_2026_09_01.md',
    'research/ABC_MULTI_ROUTE_HOLONOMY_DEPTH_CONTINUATION_2026_09_01.md',
    'paper/ChatGPT_ABC_Uniformity_2026.tex',
    'paper/holonomy_density_depth_2026.tex',
    'research/computation/2026_09_01_affine_density_attack/SHA256SUMS',
    'research/computation/2026_09_01_danilov_wss_escape/FILE_MANIFEST.json',
    'research/computation/2026_09_01_danilov_wss_escape/SHA256SUMS',
    'research/computation/2026_09_01_danilov_wss_escape/UPSTREAM_INPUTS.json',
    'research/computation/2026_09_01_pell_four_prime_coupling/SHA256SUMS',
    'research/sources/affine_density_attack_2026_09_01/SHA256SUMS',
    'research/sources/affine_density_attack_2026_09_01/SOURCE_MANIFEST.md',
    'research/sources/iut_corrected_volume_holonomy_2026_09_01/source-metadata.json',
    'research/sources/iut_corrected_volume_holonomy_2026_09_01/SHA256SUMS',
    'research/sources/pell_packet_global_attack_2026_09_01/SHA256SUMS'
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
            Where-Object { $Exclusions -notcontains $_ } |
            Sort-Object
    )
}

function Assert-NoReplayArtifacts {
    param([Parameter(Mandatory = $true)][string[]]$Roots)
    $violations = @()
    foreach ($root in $Roots) {
        if (-not (Test-Path -LiteralPath $root -PathType Container)) {
            throw "Evidence root is missing: $root"
        }
        $violations += @(
            Get-ChildItem -LiteralPath $root -Recurse -Force |
                Where-Object {
                    ($_.PSIsContainer -and $_.Name -eq '__pycache__') -or
                    (-not $_.PSIsContainer -and $_.Extension -ieq '.exe')
                } |
                ForEach-Object { Get-RepoRelativePath -Path $_.FullName }
        )
    }
    if ($violations.Count -ne 0) {
        throw "Replay by-products are forbidden in frozen evidence roots: $($violations -join ', ')"
    }
    return @($violations)
}

function Remove-LeanComments {
    param([Parameter(Mandatory = $true)][string]$Text)

    # Lean block comments nest.  Preserve all newlines so later diagnostics retain
    # their original line numbers; replace other comment characters by spaces.
    $builder = [Text.StringBuilder]::new($Text.Length)
    $blockDepth = 0
    $lineComment = $false
    $inString = $false
    $escaped = $false
    for ($index = 0; $index -lt $Text.Length; $index += 1) {
        $character = $Text[$index]
        $next = if ($index + 1 -lt $Text.Length) { $Text[$index + 1] } else { [char]0 }

        if ($lineComment) {
            if ($character -eq "`r" -or $character -eq "`n") {
                $lineComment = $false
                $null = $builder.Append($character)
            } else {
                $null = $builder.Append(' ')
            }
            continue
        }

        if ($blockDepth -gt 0) {
            if ($character -eq '/' -and $next -eq '-') {
                $blockDepth += 1
                $null = $builder.Append(' ')
                $null = $builder.Append(' ')
                $index += 1
            } elseif ($character -eq '-' -and $next -eq '/') {
                $blockDepth -= 1
                $null = $builder.Append(' ')
                $null = $builder.Append(' ')
                $index += 1
            } elseif ($character -eq "`r" -or $character -eq "`n") {
                $null = $builder.Append($character)
            } else {
                $null = $builder.Append(' ')
            }
            continue
        }

        if ($inString) {
            $null = $builder.Append($character)
            if ($escaped) {
                $escaped = $false
            } elseif ($character -eq '\') {
                $escaped = $true
            } elseif ($character -eq '"') {
                $inString = $false
            }
            continue
        }

        if ($character -eq '"') {
            $inString = $true
            $null = $builder.Append($character)
        } elseif ($character -eq '-' -and $next -eq '-') {
            $lineComment = $true
            $null = $builder.Append(' ')
            $null = $builder.Append(' ')
            $index += 1
        } elseif ($character -eq '/' -and $next -eq '-') {
            $blockDepth = 1
            $null = $builder.Append(' ')
            $null = $builder.Append(' ')
            $index += 1
        } else {
            $null = $builder.Append($character)
        }
    }
    if ($blockDepth -ne 0) {
        throw 'Unterminated Lean block comment encountered during source scan'
    }
    return $builder.ToString()
}

function Find-PythonExecutable {
    $candidates = @()
    foreach ($commandName in @('python', 'python3')) {
        $candidates += @(
            Get-Command $commandName -All -ErrorAction SilentlyContinue |
                Where-Object { $_.CommandType -eq 'Application' } |
                ForEach-Object { $_.Source }
        )
    }
    $candidates += @(
        (Join-Path $env:USERPROFILE '.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe'),
        'D:\anaconda3\python.exe'
    )
    foreach ($candidate in @($candidates | Where-Object { $_ } | Select-Object -Unique)) {
        if ($candidate -like '*\WindowsApps\*' -or
            -not (Test-Path -LiteralPath $candidate -PathType Leaf)) {
            continue
        }
        & $candidate -c 'import sys; assert sys.version_info >= (3, 10)' *> $null
        if ($LASTEXITCODE -eq 0) {
            return [IO.Path]::GetFullPath($candidate)
        }
    }
    throw 'No usable Python 3.10+ interpreter was found'
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
$pythonCommand = Find-PythonExecutable
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
$pythonVersion = (& $pythonCommand --version 2>&1 | Out-String).Trim()
if ($LASTEXITCODE -ne 0) {
    throw 'python --version failed'
}
$gitHead = (& git -C $repoRoot rev-parse HEAD 2>&1 | Out-String).Trim()
if ($LASTEXITCODE -ne 0) {
    throw 'git rev-parse HEAD failed'
}
@(
    "lake: $lakeVersion"
    "lean: $leanVersion"
    "python: $pythonVersion"
    "pythonExecutable: $pythonCommand"
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
    $directRun = Invoke-NativeLogged @invokeParameters
    $directLogText = Get-Content -Raw -LiteralPath (Join-Path $repoRoot $directRun.log)
    $directWarnings = [regex]::Matches($directLogText, '(?im)\bwarning:').Count
    if ($directWarnings -ne 0) {
        throw "Direct Lean compilation emitted $directWarnings warning(s): $module"
    }
    $directRun | Add-Member -NotePropertyName warnings -NotePropertyValue $directWarnings
    $directRuns += $directRun
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
$definitionsOnlyTotal = 0
$abbreviationsTotal = 0
$definitionTotal = 0
$structureTotal = 0
$otherDeclarationTotal = 0
$printAxiomsTotal = 0
foreach ($module in $modules) {
    $relative = "IUTThreeClosures/$module.lean"
    $absolute = Join-Path $leanRoot $relative
    $sourceText = Get-Content -Raw -LiteralPath $absolute
    $codeText = Remove-LeanComments -Text $sourceText
    $lines = @($codeText -split '\r?\n')
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
    $prefix = '(?m)^[\t ]*(?:(?:private|protected|noncomputable)\s+)*'
    $theorems = [regex]::Matches($codeText, $prefix + 'theorem\b').Count
    $lemmas = [regex]::Matches($codeText, $prefix + 'lemma\b').Count
    $definitions = [regex]::Matches($codeText, $prefix + 'def\b').Count
    $abbreviations = [regex]::Matches($codeText, $prefix + 'abbrev\b').Count
    $structures = [regex]::Matches($codeText, $prefix + 'structure\b').Count
    $classes = [regex]::Matches($codeText, $prefix + 'class\b').Count
    $inductives = [regex]::Matches($codeText, $prefix + 'inductive\b').Count
    $instances = [regex]::Matches($codeText, $prefix + 'instance\b').Count
    $printAxioms = [regex]::Matches($codeText, '(?m)^[\t ]*#print\s+axioms\b').Count
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
    $definitionsOnlyTotal += $definitions
    $abbreviationsTotal += $abbreviations
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
    'comments: stripped with nested /- ... -/ support before scanning and counting'
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
    $definitionsOnlyTotal -ne $expectedTotals.definitions -or
    $abbreviationsTotal -ne $expectedTotals.abbreviations -or
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

$affineBase = Join-Path $bundleRoot '2026_09_01_affine_density_attack'
$pellBase = Join-Path $bundleRoot '2026_09_01_pell_four_prime_coupling'
$danilovBase = Join-Path $bundleRoot '2026_09_01_danilov_wss_escape'
$iutSourceRoot = Join-Path $repoRoot 'research\sources\iut_corrected_volume_holonomy_2026_09_01'
$affineSourceRoot = Join-Path $repoRoot 'research\sources\affine_density_attack_2026_09_01'
$pellSourceRoot = Join-Path $repoRoot 'research\sources\pell_packet_global_attack_2026_09_01'
$evidenceRoots = @(
    $affineBase, $pellBase, $danilovBase,
    $iutSourceRoot, $affineSourceRoot, $pellSourceRoot
)
$null = Assert-NoReplayArtifacts -Roots $evidenceRoots

$affineSums = Test-ChecksumManifest -Base $affineBase -ChecksumName 'SHA256SUMS' -Strict -StrictExclusions @('SHA256SUMS')
$affineReplay = Invoke-NativeLogged `
    -Name 'affine-square-conic-replay' `
    -Executable $pythonCommand `
    -Arguments @((Join-Path $affineBase 'verify_square_conic.py')) `
    -WorkingDirectory $affineBase
$affineSumsAfter = Test-ChecksumManifest -Base $affineBase -ChecksumName 'SHA256SUMS' -Strict -StrictExclusions @('SHA256SUMS')
if ($affineSumsAfter.sha256 -ne $affineSums.sha256) {
    throw 'Affine-density evidence changed during replay'
}
$affineOutput = Get-Content -Raw -LiteralPath (Join-Path $affineBase 'OUTPUT.txt')
if ($affineOutput -notmatch '(?m)^seed_count=20$' -or
    $affineOutput -notmatch '(?m)^total_rows=49671$' -or
    $affineOutput -notmatch '(?m)^total_exceptions=0$' -or
    $affineOutput -notmatch '(?m)^scope=finite_no_hit_only$') {
    throw 'Affine-density frozen result does not have the audited finite-search totals'
}
$affineReplayText = Get-Content -Raw -LiteralPath (Join-Path $repoRoot $affineReplay.log)
if ($affineReplayText -notmatch '(?m)^captured_output_match=true\r?$') {
    throw 'Affine-density replay did not confirm the captured output'
}
$bundleResults += [pscustomobject][ordered]@{
    name = 'affine_density_attack'
    checksumManifest = $affineSumsAfter
    replays = @($affineReplay)
    recordedEvidence = [pscustomobject][ordered]@{
        seeds = 20
        admissibleRows = 49671
        exceptions = 0
        scope = 'finite_no_hit_only'
    }
}

$pellSums = Test-ChecksumManifest -Base $pellBase -ChecksumName 'SHA256SUMS' -Strict -StrictExclusions @('SHA256SUMS')
$pellManifestReplay = Invoke-NativeLogged `
    -Name 'pell-manifest-replay' `
    -Executable $pythonCommand `
    -Arguments @((Join-Path $pellBase 'verify_manifest.py')) `
    -WorkingDirectory $pellBase
$pellBigintReplay = Invoke-NativeLogged `
    -Name 'pell-bigint-hit-replay' `
    -Executable $pythonCommand `
    -Arguments @((Join-Path $pellBase 'verify_hits_bigint.py')) `
    -WorkingDirectory $pellBase
$pellCouplingReplay = Invoke-NativeLogged `
    -Name 'pell-coupling-replay' `
    -Executable $pythonCommand `
    -Arguments @((Join-Path $pellBase 'verify_coupling_examples.py')) `
    -WorkingDirectory $pellBase
$pellSumsAfter = Test-ChecksumManifest -Base $pellBase -ChecksumName 'SHA256SUMS' -Strict -StrictExclusions @('SHA256SUMS')
if ($pellSumsAfter.sha256 -ne $pellSums.sha256) {
    throw 'Pell four-prime evidence changed during lightweight replay'
}
$pellScanText = Get-Content -Raw -LiteralPath (Join-Path $pellBase 'depth3_scan_1b_stdout.txt')
$pellDenseText = Get-Content -Raw -LiteralPath (Join-Path $pellBase 'depth3_scan_1b_verify_stdout.txt')
$pellBigintData = Get-Content -Raw -LiteralPath (Join-Path $pellBase 'depth3_scan_1b_verification.json') | ConvertFrom-Json
$pellCouplingData = Get-Content -Raw -LiteralPath (Join-Path $pellBase 'coupling_examples_verification.json') | ConvertFrom-Json
if ($pellScanText -notmatch '(?m)^limit=1000000000\r?$' -or
    $pellScanText -notmatch '(?m)^odd_primes_tested=50847533\r?$' -or
    $pellScanText -notmatch '(?m)^wieferich_hits=3\r?$' -or
    $pellScanText -notmatch '(?m)^valuation_at_least_3_hits=0\r?$' -or
    $pellDenseText -notmatch '(?m)^odd_primes_tested=50847533\r?$' -or
    $pellDenseText -notmatch '(?m)^hit_list=13,31,1546463\r?$' -or
    [string]$pellBigintData.verification -ne 'PASS' -or
    @($pellBigintData.rows).Count -ne 3 -or
    ((@($pellBigintData.rows | ForEach-Object { [int]$_.q }) -join ',') -ne '13,31,1546463') -or
    [string]$pellCouplingData.verification -ne 'PASS' -or
    @($pellCouplingData.rows).Count -ne 13) {
    throw 'Pell four-prime frozen scan or lightweight replay totals disagree with the audit baseline'
}
$bundleResults += [pscustomobject][ordered]@{
    name = 'pell_four_prime_coupling'
    checksumManifest = $pellSumsAfter
    replays = @($pellManifestReplay, $pellBigintReplay, $pellCouplingReplay)
    fullScanRerun = $false
    recordedEvidence = [pscustomobject][ordered]@{
        limit = 1000000000
        oddPrimesTested = 50847533
        exactDepthTwoPrimes = @(13, 31, 1546463)
        valuationAtLeastThreeHits = 0
        couplingRows = 13
    }
}

$danilovJson = Test-JsonManifest -Base $danilovBase -ManifestName 'FILE_MANIFEST.json' -Strict -StrictExclusions @('FILE_MANIFEST.json', 'SHA256SUMS')
$danilovSums = Test-ChecksumManifest -Base $danilovBase -ChecksumName 'SHA256SUMS' -Strict -StrictExclusions @('SHA256SUMS')
$danilovManifestReplay = Invoke-NativeLogged `
    -Name 'danilov-manifest-replay' `
    -Executable $pythonCommand `
    -Arguments @((Join-Path $danilovBase 'verify_manifest.py')) `
    -WorkingDirectory $danilovBase
$danilovClaimsReplay = Invoke-NativeLogged `
    -Name 'danilov-wss-claims-replay' `
    -Executable $pythonCommand `
    -Arguments @((Join-Path $danilovBase 'verify_wss_escape_claims.py')) `
    -WorkingDirectory $danilovBase
$danilovJsonAfter = Test-JsonManifest -Base $danilovBase -ManifestName 'FILE_MANIFEST.json' -Strict -StrictExclusions @('FILE_MANIFEST.json', 'SHA256SUMS')
$danilovSumsAfter = Test-ChecksumManifest -Base $danilovBase -ChecksumName 'SHA256SUMS' -Strict -StrictExclusions @('SHA256SUMS')
if ($danilovJsonAfter.sha256 -ne $danilovJson.sha256 -or
    $danilovSumsAfter.sha256 -ne $danilovSums.sha256) {
    throw 'Danilov WSS-escape evidence changed during replay'
}
$danilovData = Get-Content -Raw -LiteralPath (Join-Path $danilovBase 'wss_escape_verification.json') | ConvertFrom-Json
if ([string]$danilovData.status -ne 'PASS' -or
    [int]$danilovData.cross_bundle_input_hashes_verified -ne 8 -or
    [int]$danilovData.final_Q_digits -ne 4398 -or
    [int]$danilovData.final_Q_distinct_prime_factors -ne 638 -or
    -not [bool]$danilovData.final_Q_squarefree -or
    [int]$danilovData.factor_bound_amplification.exceptional_divisors_e_with_10e_le_B -ne 622 -or
    [string]$danilovData.factor_bound_amplification.forced_distinct_WSS_lower_bound_expression -ne '2^638-622' -or
    [int]$danilovData.bounded_full_hypothesis_search.actual_top_indices -ne 121 -or
    [int]$danilovData.bounded_full_hypothesis_search.ruled_out_by_exact_simple_primitive_certificate -ne 105 -or
    @($danilovData.bounded_full_hypothesis_search.unresolved_not_counterexamples).Count -ne 16) {
    throw 'Danilov WSS-escape replay totals disagree with the audit baseline'
}
$bundleResults += [pscustomobject][ordered]@{
    name = 'danilov_wss_escape'
    jsonManifest = $danilovJsonAfter
    checksumManifest = $danilovSumsAfter
    replays = @($danilovManifestReplay, $danilovClaimsReplay)
    recordedEvidence = [pscustomobject][ordered]@{
        upstreamInputsVerified = 8
        qDigits = 4398
        qDistinctPrimeFactors = 638
        factorBoundLowerExpression = '2^638-622'
        excludedSmallDivisors = 622
        boundedActualTopIndices = 121
        boundedRuledOut = 105
        boundedUnresolvedNotCounterexamples = 16
    }
}

$null = Assert-NoReplayArtifacts -Roots $evidenceRoots
$bundleResults | ConvertTo-Json -Depth 10 |
    Set-Content -LiteralPath (Join-Path $logRoot 'bundle-manifests.log') -Encoding utf8
@(
    'PASS'
    "roots checked: $($evidenceRoots.Count)"
    'forbidden file suffix: .exe'
    'forbidden directory name: __pycache__'
    'matches before replay: 0'
    'matches after replay: 0'
) | Set-Content -LiteralPath (Join-Path $logRoot 'replay-artifact-scan.log') -Encoding utf8

$affineSourceSums = Test-ChecksumManifest -Base $affineSourceRoot -ChecksumName 'SHA256SUMS' -Strict -StrictExclusions @('SHA256SUMS', 'SOURCE_MANIFEST.md')
$pellSourceSums = Test-ChecksumManifest -Base $pellSourceRoot -ChecksumName 'SHA256SUMS' -Strict -StrictExclusions @('SHA256SUMS')
$iutLedgerSums = Test-ChecksumManifest -Base $iutSourceRoot -ChecksumName 'SHA256SUMS' -Strict -StrictExclusions @('SHA256SUMS')
$iutMetadataPath = Join-Path $iutSourceRoot 'source-metadata.json'
$iutMetadata = Get-Content -Raw -LiteralPath $iutMetadataPath | ConvertFrom-Json
$expectedCommit = 'ddaddc274281adb5674d647e24fa478745ac6d40'
if ([string]$iutMetadata.projectLana.mainCommit -ne $expectedCommit) {
    throw 'Corrected IUT source-ledger Project LANA commit mismatch'
}
if (@($iutMetadata.projectLana.files).Count -ne 3 -or @($iutMetadata.papers).Count -ne 2) {
    throw 'Corrected IUT source ledger must reference three Project LANA files and two papers'
}
$iutSourceReplay = Invoke-NativeLogged `
    -Name 'iut-corrected-source-ledger-replay' `
    -Executable $pythonCommand `
    -Arguments @((Join-Path $iutSourceRoot 'verify_source_metadata.py')) `
    -WorkingDirectory $iutSourceRoot
$iutLedgerSumsAfter = Test-ChecksumManifest -Base $iutSourceRoot -ChecksumName 'SHA256SUMS' -Strict -StrictExclusions @('SHA256SUMS')
if ($iutLedgerSumsAfter.sha256 -ne $iutLedgerSums.sha256) {
    throw 'Corrected IUT source ledger changed during replay'
}
$iutReplayText = Get-Content -Raw -LiteralPath (Join-Path $repoRoot $iutSourceReplay.log)
if ($iutReplayText -notmatch 'PASS 5 referenced primary-source files' -or
    $iutReplayText -notmatch [regex]::Escape($expectedCommit)) {
    throw 'Corrected IUT source-ledger replay did not verify all five sources and pinned commit'
}
$sourceLedgers = @(
    [pscustomobject][ordered]@{
        name = 'affine_density_attack'
        checksumManifest = $affineSourceSums
        referencedPrimarySources = 2
    },
    [pscustomobject][ordered]@{
        name = 'pell_packet_global_attack'
        checksumManifest = $pellSourceSums
        referencedPrimarySources = 2
    },
    [pscustomobject][ordered]@{
        name = 'iut_corrected_volume_holonomy'
        pinnedProjectLanaCommit = $expectedCommit
        sourceMetadata = [pscustomobject][ordered]@{
            path = Get-RepoRelativePath -Path $iutMetadataPath
            sha256 = Get-Sha256Lower -Path $iutMetadataPath
        }
        checksumManifest = $iutLedgerSumsAfter
        referencedPrimarySources = 5
        replay = $iutSourceReplay
    }
)
$sourceLedgers | ConvertTo-Json -Depth 8 |
    Set-Content -LiteralPath (Join-Path $logRoot 'source-ledgers.log') -Encoding utf8

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
        python = $pythonVersion
        pythonExecutable = $pythonCommand
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
            definitions = $definitionsOnlyTotal
            abbreviations = $abbreviationsTotal
            definitionsOrAbbreviations = $definitionTotal
            structuresClassesOrInductives = $structureTotal
            instances = $otherDeclarationTotal
            countedTopLevelDeclarations = $totalDeclarations
        }
    }
    computationBundles = $bundleResults
    sourceLedgers = $sourceLedgers
    replayArtifactScan = [pscustomobject][ordered]@{
        rootsChecked = @($evidenceRoots | ForEach-Object { Get-RepoRelativePath -Path $_ })
        forbiddenExeFiles = 0
        forbiddenPycacheDirectories = 0
    }
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
    "definitions: $definitionsOnlyTotal"
    "abbreviations: $abbreviationsTotal"
    "definitions/abbreviations: $definitionTotal"
    "structures/classes/inductives: $structureTotal"
    "instances: $otherDeclarationTotal"
    "counted top-level declarations: $totalDeclarations"
    "print-axioms commands: $printAxiomsTotal"
    "observed axiom union: $($observedAxioms -join ', ')"
    "computation bundles verified: $($bundleResults.Count)"
    'replay artifacts (.exe/__pycache__): 0'
    "source ledgers verified: $($sourceLedgers.Count)"
    "corrected IUT Project LANA commit: $expectedCommit"
    'corrected IUT source-ledger replay: exit 0'
    'Pell q<=1e9 full C++ scan rerun: no (frozen dual-output evidence plus bigint hit replay)'
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
    "{2} counted declarations; three computation bundles and three source ledgers verified."
) -f $modules.Count, $aggregateJobs, $totalDeclarations)
