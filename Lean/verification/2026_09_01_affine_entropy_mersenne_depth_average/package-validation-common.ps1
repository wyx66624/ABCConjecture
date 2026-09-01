[CmdletBinding()]
param()

Set-StrictMode -Version Latest

function Get-RequiredProperty {
  param(
    [Parameter(Mandatory = $true)][AllowNull()][object]$Object,
    [Parameter(Mandatory = $true)][string]$Name,
    [Parameter(Mandatory = $true)][string]$Context
  )
  if ($null -eq $Object) { throw "$Context is null" }
  $property = $Object.PSObject.Properties[$Name]
  if ($null -eq $property) { throw "$Context is missing property '$Name'" }
  return $property.Value
}

function Convert-RequiredInt {
  param(
    [Parameter(Mandatory = $true)][AllowNull()][object]$Value,
    [Parameter(Mandatory = $true)][string]$Context
  )
  $parsed = 0
  if ($null -eq $Value -or
      -not [int]::TryParse([string]$Value, [Globalization.NumberStyles]::Integer,
        [Globalization.CultureInfo]::InvariantCulture, [ref]$parsed)) {
    throw "$Context is not an integer"
  }
  return $parsed
}

function Assert-ExactStringSequence {
  param(
    [Parameter(Mandatory = $true)][AllowEmptyCollection()][object[]]$Actual,
    [Parameter(Mandatory = $true)][AllowEmptyCollection()][string[]]$Expected,
    [Parameter(Mandatory = $true)][string]$Context
  )
  if ($Actual.Count -ne $Expected.Count) {
    throw "$Context count mismatch: actual=$($Actual.Count), expected=$($Expected.Count)"
  }
  for ($index = 0; $index -lt $Expected.Count; $index++) {
    if ([string]$Actual[$index] -cne $Expected[$index]) {
      throw "$Context mismatch at index $index`: actual='$($Actual[$index])', expected='$($Expected[$index])'"
    }
  }
}

function Assert-LowerSha256 {
  param(
    [Parameter(Mandatory = $true)][AllowNull()][object]$Value,
    [Parameter(Mandatory = $true)][string]$Context
  )
  if ($null -eq $Value -or [string]$Value -cnotmatch '^[0-9a-f]{64}$') {
    throw "$Context is not a lowercase SHA-256 digest"
  }
}

function Get-OrdinalSortedStrings {
  param([Parameter(Mandatory = $true)][AllowEmptyCollection()][object[]]$Values)
  [string[]]$result = @($Values | ForEach-Object { [string]$_ })
  [Array]::Sort($result, [StringComparer]::Ordinal)
  return $result
}

function Get-OrdinalUniqueStrings {
  param([Parameter(Mandatory = $true)][AllowEmptyCollection()][object[]]$Values)
  $seen = [Collections.Generic.HashSet[string]]::new([StringComparer]::Ordinal)
  foreach ($value in $Values) { [void]$seen.Add([string]$value) }
  [string[]]$result = @($seen)
  [Array]::Sort($result, [StringComparer]::Ordinal)
  return $result
}

function Assert-UniqueStrings {
  param(
    [Parameter(Mandatory = $true)][AllowEmptyCollection()][object[]]$Values,
    [Parameter(Mandatory = $true)][string]$Context
  )
  if (@(Get-OrdinalUniqueStrings $Values).Count -ne $Values.Count) {
    throw "$Context contains duplicates"
  }
}

function Test-RecordedRun {
  param(
    [Parameter(Mandatory = $true)][object]$Run,
    [Parameter(Mandatory = $true)][string]$ExpectedName,
    [Parameter(Mandatory = $true)][string]$Root,
    [Parameter(Mandatory = $true)][string]$PackageName
  )
  $name = [string](Get-RequiredProperty $Run 'name' "run '$ExpectedName'")
  if ($name -cne $ExpectedName) {
    throw "run-name mismatch: actual='$name', expected='$ExpectedName'"
  }
  $exitCode = Convert-RequiredInt (Get-RequiredProperty $Run 'exitCode' "run '$name'") "run '$name' exitCode"
  if ($exitCode -ne 0) { throw "recorded run is not successful: $name" }

  $recordedLog = [string](Get-RequiredProperty $Run 'log' "run '$name'")
  $expectedRecordedLog = "Lean/verification/$PackageName/logs/$name.log"
  if ($recordedLog -cne $expectedRecordedLog) {
    throw "run '$name' has unexpected log path '$recordedLog'"
  }
  $recordedHash = Get-RequiredProperty $Run 'logSha256' "run '$name'"
  Assert-LowerSha256 $recordedHash "run '$name' logSha256"

  $logPath = Join-Path $Root "logs\$name.log"
  $exitPath = "$logPath.exitcode"
  if (-not (Test-Path -LiteralPath $logPath -PathType Leaf)) {
    throw "missing recorded log for $name"
  }
  if (-not (Test-Path -LiteralPath $exitPath -PathType Leaf)) {
    throw "missing recorded exit-code file for $name"
  }
  $actualHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $logPath).Hash.ToLowerInvariant()
  if ($actualHash -cne [string]$recordedHash) {
    throw "recorded log hash mismatch for $name"
  }
  $exitText = [IO.File]::ReadAllText($exitPath)
  if ($exitText -cne "0`n") { throw "recorded exit-code bytes are not exact for $name" }
  $logText = [IO.File]::ReadAllText($logPath)
  if (-not $logText.EndsWith("EXIT_CODE: 0`n", [StringComparison]::Ordinal)) {
    throw "recorded log does not end in an exact successful exit marker for $name"
  }
}

function Test-RecordedValidationPackage {
  param([Parameter(Mandatory = $true)][string]$Root)

  $expectedSchema = 'abc-affine-entropy-mersenne-depth-average-validation-v1'
  $expectedModules = @(
    'AffineTemplateEntropy20260901',
    'MersenneWeightedOrderTail20260901',
    'MersenneSuperWieferichDepth20260901'
  )
  $expectedReplayRuns = @(
    'affine-template-entropy-replay',
    'mersenne-super-wieferich-scan',
    'mersenne-super-wieferich-verify'
  )
  $expectedEvidenceDirectories = @(
    'research/computation/2026_09_01_affine_template_entropy',
    'research/computation/2026_09_01_mersenne_super_wieferich_depth'
  )
  $allowedUnhashedByDirectory = @{}
  $allowedAxioms = @('Classical.choice', 'Quot.sound', 'propext')
  $expectedTheorems = 74
  $expectedDefinitions = 21
  $expectedDeclarations = 95
  $expectedPrints = 74
  $expectedAggregateJobs = 9209
  $declarationKinds = @(
    'theorem', 'lemma', 'def', 'abbrev', 'structure', 'class', 'inductive', 'instance'
  )
  $packageName = [IO.Path]::GetFileName($Root.TrimEnd(
      [IO.Path]::DirectorySeparatorChar, [IO.Path]::AltDirectorySeparatorChar))
  $inputManifest = Join-Path $Root 'input-manifest.json'
  $validationPath = Join-Path $Root 'validation-run.json'
  $summaryPath = Join-Path $Root 'logs\SUMMARY.txt'
  foreach ($required in @($inputManifest, $validationPath, $summaryPath)) {
    if (-not (Test-Path -LiteralPath $required -PathType Leaf)) {
      throw "incomplete recorded package; missing $required"
    }
  }

  $inputs = @(Get-Content -Raw -LiteralPath $inputManifest | ConvertFrom-Json)
  if ($inputs.Count -lt 20) { throw 'frozen input manifest is unexpectedly small' }
  $inputPaths = @()
  $inputHashByPath = [Collections.Generic.Dictionary[string,string]]::new(
    [StringComparer]::Ordinal)
  foreach ($row in $inputs) {
    $path = [string](Get-RequiredProperty $row 'path' 'input-manifest row')
    if ([string]::IsNullOrWhiteSpace($path) -or
        $path -cne $path.Trim() -or
        [IO.Path]::IsPathRooted($path) -or
        $path.Contains('\') -or
        $path -match '[\x00-\x1f\x7f]' -or
        @($path.Split('/') | Where-Object { $_ -in @('', '.', '..') }).Count -ne 0) {
      throw "input-manifest contains a noncanonical path '$path'"
    }
    $inputSha = [string](Get-RequiredProperty $row 'sha256' "input '$path'")
    Assert-LowerSha256 $inputSha "input '$path' sha256"
    $gitBlob = [string](Get-RequiredProperty $row 'gitBlob' "input '$path'")
    if ($gitBlob -cnotmatch '^(?:[0-9a-f]{40}|[0-9a-f]{64})$') {
      throw "input '$path' does not record a lowercase Git blob object id"
    }
    $bytes = Convert-RequiredInt (Get-RequiredProperty $row 'bytes' "input '$path'") "input '$path' bytes"
    if ($bytes -lt 0) { throw "input '$path' has negative byte length" }
    $inputPaths += $path
    if (-not $inputHashByPath.TryAdd($path, $inputSha)) {
      throw "input-manifest contains duplicate path '$path'"
    }
  }
  Assert-UniqueStrings $inputPaths 'input-manifest path list'
  Assert-ExactStringSequence $inputPaths @(Get-OrdinalSortedStrings $inputPaths) 'input-manifest path order'

  $validation = Get-Content -Raw -LiteralPath $validationPath | ConvertFrom-Json
  if ([string](Get-RequiredProperty $validation 'schema' 'validation') -cne $expectedSchema) {
    throw 'validation-run.json has an unexpected schema'
  }
  if ([string](Get-RequiredProperty $validation 'status' 'validation') -cne 'PASS') {
    throw 'validation-run.json is not PASS'
  }
  $expectedDriverFiles = @('validate.py', 'validate.ps1')
  $driverRows = @(Get-RequiredProperty $validation 'validationDrivers' 'validation')
  $actualDriverFiles = @($driverRows | ForEach-Object {
      [string](Get-RequiredProperty $_ 'path' 'validation driver')
    })
  Assert-ExactStringSequence $actualDriverFiles $expectedDriverFiles 'validation-driver inventory'
  for ($driverIndex = 0; $driverIndex -lt $driverRows.Count; $driverIndex++) {
    $driver = $driverRows[$driverIndex]
    $name = $expectedDriverFiles[$driverIndex]
    $driverPath = Join-Path $Root $name
    if (-not (Test-Path -LiteralPath $driverPath -PathType Leaf)) {
      throw "validation driver is missing: $name"
    }
    $recordedBytes = Convert-RequiredInt (Get-RequiredProperty $driver 'bytes' "validation driver '$name'") "validation driver '$name' bytes"
    if ($recordedBytes -ne (Get-Item -LiteralPath $driverPath).Length) {
      throw "validation driver byte length mismatch: $name"
    }
    $recordedDriverSha = [string](Get-RequiredProperty $driver 'sha256' "validation driver '$name'")
    Assert-LowerSha256 $recordedDriverSha "validation driver '$name' sha256"
    $actualDriverSha = (Get-FileHash -Algorithm SHA256 -LiteralPath $driverPath).Hash.ToLowerInvariant()
    if ($recordedDriverSha -cne $actualDriverSha) {
      throw "validation driver hash mismatch: $name"
    }
  }
  $lakeDependencies = Get-RequiredProperty $validation 'lakeDependencies' 'validation'
  $lakeManifestPath = [string](Get-RequiredProperty $lakeDependencies 'manifestPath' 'Lake dependencies')
  if ($lakeManifestPath -cne 'Lean/lake-manifest.json') {
    throw 'Lake dependency manifest path is unexpected'
  }
  $lakeManifestSha = [string](Get-RequiredProperty $lakeDependencies 'manifestSha256' 'Lake dependencies')
  Assert-LowerSha256 $lakeManifestSha 'Lake dependency manifest sha256'
  if (-not $inputHashByPath.ContainsKey($lakeManifestPath) -or
      $inputHashByPath[$lakeManifestPath] -cne $lakeManifestSha) {
    throw 'Lake dependency manifest hash does not match frozen inputs'
  }
  $dependencyRows = @(Get-RequiredProperty $lakeDependencies 'packages' 'Lake dependencies')
  if ($dependencyRows.Count -ne 14) { throw 'Lake dependency package count is not exact' }
  $dependencyNames = @()
  $dependencyDirectories = @()
  foreach ($dependency in $dependencyRows) {
    $dependencyName = [string](Get-RequiredProperty $dependency 'name' 'Lake dependency')
    $dependencyDirectory = [string](Get-RequiredProperty $dependency 'directory' "Lake dependency '$dependencyName'")
    $dependencyRevision = [string](Get-RequiredProperty $dependency 'revision' "Lake dependency '$dependencyName'")
    $dependencyUrl = [string](Get-RequiredProperty $dependency 'url' "Lake dependency '$dependencyName'")
    if ([string]::IsNullOrWhiteSpace($dependencyName) -or
        [string]::IsNullOrWhiteSpace($dependencyDirectory) -or
        [string]::IsNullOrWhiteSpace($dependencyUrl) -or
        $dependencyRevision -cnotmatch '^[0-9a-f]{40,64}$') {
      throw "Lake dependency '$dependencyName' has malformed metadata"
    }
    $dependencyNames += $dependencyName
    $dependencyDirectories += $dependencyDirectory
  }
  Assert-UniqueStrings $dependencyNames 'Lake dependency names'
  Assert-UniqueStrings $dependencyDirectories 'Lake dependency directories'
  $frozenInputs = Get-RequiredProperty $validation 'frozenInputs' 'validation'
  $expectedInputPath = "Lean/verification/$packageName/input-manifest.json"
  if ([string](Get-RequiredProperty $frozenInputs 'path' 'frozenInputs') -cne $expectedInputPath) {
    throw 'validation-run.json has an unexpected input-manifest path'
  }
  $frozenEntryCount = Convert-RequiredInt (Get-RequiredProperty $frozenInputs 'entries' 'frozenInputs') 'frozenInputs entries'
  if ($frozenEntryCount -ne $inputs.Count) { throw 'frozen input entry count mismatch' }
  $inputHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $inputManifest).Hash.ToLowerInvariant()
  if ([string](Get-RequiredProperty $frozenInputs 'sha256' 'frozenInputs') -cne $inputHash) {
    throw 'validation-run.json does not identify the current input manifest'
  }

  $moduleRows = @(Get-RequiredProperty $validation 'modules' 'validation')
  $actualModules = @($moduleRows | ForEach-Object {
      [string](Get-RequiredProperty $_ 'module' 'module inventory')
    })
  Assert-ExactStringSequence $actualModules $expectedModules 'module inventory'

  $summedCounts = @{}
  foreach ($kind in $declarationKinds) { $summedCounts[$kind] = 0 }
  $summedDeclarations = 0
  $summedPrints = 0
  $moduleAxioms = @()
  for ($moduleIndex = 0; $moduleIndex -lt $moduleRows.Count; $moduleIndex++) {
    $row = $moduleRows[$moduleIndex]
    $module = [string](Get-RequiredProperty $row 'module' 'module inventory')
    $moduleSha = [string](Get-RequiredProperty $row 'sha256' "module '$module'")
    Assert-LowerSha256 $moduleSha "module '$module' sha256"
    $modulePath = "Lean/IUTThreeClosures/$module.lean"
    if (-not $inputHashByPath.ContainsKey($modulePath) -or
        $inputHashByPath[$modulePath] -cne $moduleSha) {
      throw "module '$module' hash does not match the frozen input manifest"
    }
    $counts = Get-RequiredProperty $row 'counts' "module '$module'"
    $rowDeclarationCount = 0
    foreach ($kind in $declarationKinds) {
      $count = Convert-RequiredInt (Get-RequiredProperty $counts $kind "module '$module' counts") "module '$module' $kind count"
      if ($count -lt 0) { throw "module '$module' has a negative declaration count" }
      $summedCounts[$kind] += $count
      $rowDeclarationCount += $count
    }
    $recordedDeclarationCount = Convert-RequiredInt (Get-RequiredProperty $row 'countedTopLevelDeclarations' "module '$module'") "module '$module' declaration total"
    if ($recordedDeclarationCount -ne $rowDeclarationCount) {
      throw "module '$module' declaration total is inconsistent"
    }
    $summedDeclarations += $rowDeclarationCount

    $namedDeclarations = @(Get-RequiredProperty $row 'namedDeclarations' "module '$module'")
    $proofs = @(Get-RequiredProperty $row 'proofDeclarations' "module '$module'")
    $prints = @(Get-RequiredProperty $row 'printAxiomsTargets' "module '$module'")
    $printCount = Convert-RequiredInt (Get-RequiredProperty $row 'printAxiomsCommands' "module '$module'") "module '$module' print count"
    $expectedProofCount = (Convert-RequiredInt (Get-RequiredProperty $counts 'theorem' "module '$module' counts") "module '$module' theorem count") +
      (Convert-RequiredInt (Get-RequiredProperty $counts 'lemma' "module '$module' counts") "module '$module' lemma count")
    if ($expectedProofCount -le 0 -or $proofs.Count -ne $expectedProofCount -or
        $printCount -ne $prints.Count) {
      throw "module '$module' has empty or inconsistent theorem-level axiom coverage"
    }
    Assert-UniqueStrings $namedDeclarations "module '$module' named declarations"
    $instanceCount = Convert-RequiredInt (Get-RequiredProperty $counts 'instance' "module '$module' counts") "module '$module' instance count"
    if ($namedDeclarations.Count -ne ($rowDeclarationCount - $instanceCount)) {
      throw "module '$module' named-declaration inventory is inconsistent"
    }
    Assert-UniqueStrings $proofs "module '$module' proof declarations"
    Assert-UniqueStrings $prints "module '$module' axiom-report targets"
    $namedSet = [Collections.Generic.HashSet[string]]::new([StringComparer]::Ordinal)
    foreach ($declaration in $namedDeclarations) { [void]$namedSet.Add([string]$declaration) }
    $proofSet = [Collections.Generic.HashSet[string]]::new([StringComparer]::Ordinal)
    foreach ($proof in $proofs) { [void]$proofSet.Add([string]$proof) }
    $printSet = [Collections.Generic.HashSet[string]]::new([StringComparer]::Ordinal)
    foreach ($print in $prints) { [void]$printSet.Add([string]$print) }
    foreach ($proof in $proofs) {
      if (-not $namedSet.Contains([string]$proof)) {
        throw "module '$module' proof inventory contains a nonlocal declaration '$proof'"
      }
      if (-not $printSet.Contains([string]$proof)) {
        throw "module '$module' has an unaudited theorem/lemma '$proof'"
      }
    }
    foreach ($print in $prints) {
      if (-not $namedSet.Contains([string]$print)) {
        throw "module '$module' axiom-report inventory contains a nonlocal declaration '$print'"
      }
    }
    $recordedExtras = @(Get-RequiredProperty $row 'extraPrintedDefinitions' "module '$module'")
    $expectedExtras = @($prints | Where-Object { -not $proofSet.Contains([string]$_) })
    Assert-ExactStringSequence @(Get-OrdinalSortedStrings $recordedExtras) `
      @(Get-OrdinalSortedStrings $expectedExtras) "module '$module' extra printed declarations"
    $summedPrints += $printCount

    $axioms = @(Get-RequiredProperty $row 'axioms' "module '$module'")
    foreach ($axiom in $axioms) {
      if ([string]$axiom -cnotin $allowedAxioms) {
        throw "module '$module' records an unexpected axiom '$axiom'"
      }
      $moduleAxioms += [string]$axiom
    }
  }

  $totals = Get-RequiredProperty $validation 'totals' 'validation'
  foreach ($kind in $declarationKinds) {
    $recorded = Convert-RequiredInt (Get-RequiredProperty $totals $kind 'validation totals') "validation total $kind"
    if ($recorded -ne $summedCounts[$kind]) { throw "validation total '$kind' is inconsistent" }
  }
  if ((Convert-RequiredInt (Get-RequiredProperty $totals 'countedTopLevelDeclarations' 'validation totals') 'validation declaration total') -ne $summedDeclarations) {
    throw 'validation declaration total is inconsistent'
  }
  if ((Convert-RequiredInt (Get-RequiredProperty $totals 'printAxiomsCommands' 'validation totals') 'validation print total') -ne $summedPrints) {
    throw 'validation print total is inconsistent'
  }
  if ($summedCounts['theorem'] -ne $expectedTheorems -or
      $summedCounts['lemma'] -ne 0 -or
      $summedCounts['def'] -ne $expectedDefinitions -or
      $summedCounts['abbrev'] -ne 0 -or
      $summedCounts['structure'] -ne 0 -or
      $summedCounts['class'] -ne 0 -or
      $summedCounts['inductive'] -ne 0 -or
      $summedCounts['instance'] -ne 0) {
    throw 'exact declaration-kind counts changed'
  }
  if ($summedDeclarations -ne $expectedDeclarations) {
    throw 'exact counted declaration total changed'
  }
  if ($summedPrints -ne $expectedPrints) {
    throw 'exact #print axioms total changed'
  }
  $recordedAxiomUnion = @(Get-RequiredProperty $validation 'axiomUnion' 'validation')
  Assert-ExactStringSequence $recordedAxiomUnion $allowedAxioms 'validation axiom union'
  Assert-ExactStringSequence @(Get-OrdinalUniqueStrings $moduleAxioms) $allowedAxioms 'module axiom union'

  $manifestRows = @(Get-RequiredProperty $validation 'manifests' 'validation')
  $actualEvidenceDirectories = @($manifestRows | ForEach-Object {
      [string](Get-RequiredProperty $_ 'directory' 'evidence manifest')
    })
  Assert-ExactStringSequence $actualEvidenceDirectories $expectedEvidenceDirectories 'evidence-manifest inventory'
  for ($manifestIndex = 0; $manifestIndex -lt $manifestRows.Count; $manifestIndex++) {
    $row = $manifestRows[$manifestIndex]
    $directory = [string](Get-RequiredProperty $row 'directory' 'evidence manifest')
    if ((Get-RequiredProperty $row 'strict' "evidence manifest '$directory'") -isnot [bool] -or
        -not [bool](Get-RequiredProperty $row 'strict' "evidence manifest '$directory'")) {
      throw "evidence manifest '$directory' is not strict"
    }
    $entries = Convert-RequiredInt (Get-RequiredProperty $row 'entries' "evidence manifest '$directory'") "evidence manifest '$directory' entries"
    if ($entries -le 0) { throw "evidence manifest '$directory' is empty" }
    $allowedUnhashed = @(Get-RequiredProperty $row 'allowedUnhashed' "evidence manifest '$directory'")
    [object[]]$expectedAllowed = @()
    if ($allowedUnhashedByDirectory.ContainsKey($directory)) {
      $expectedAllowed = @($allowedUnhashedByDirectory[$directory])
    }
    Assert-ExactStringSequence $allowedUnhashed $expectedAllowed "evidence manifest '$directory' allowed-unhashed list"
    $manifestSha = [string](Get-RequiredProperty $row 'manifestSha256' "evidence manifest '$directory'")
    Assert-LowerSha256 $manifestSha "evidence manifest '$directory' hash"
    $manifestPath = "$directory/SHA256SUMS"
    if (-not $inputHashByPath.ContainsKey($manifestPath) -or
        $inputHashByPath[$manifestPath] -cne $manifestSha) {
      throw "evidence manifest '$directory' hash does not match the frozen input manifest"
    }
  }

  $crossRows = @(Get-RequiredProperty $validation 'crossReferences' 'validation')
  if ($crossRows.Count -ne 0) { throw 'cross-reference inventory must be empty' }

  $directRuns = @(Get-RequiredProperty $validation 'directRuns' 'validation')
  $expectedDirectRuns = @($expectedModules | ForEach-Object { "$_-direct" })
  $actualDirectRuns = @($directRuns | ForEach-Object {
      [string](Get-RequiredProperty $_ 'name' 'direct run')
    })
  Assert-ExactStringSequence $actualDirectRuns $expectedDirectRuns 'direct-run inventory'

  $aggregateBuild = Get-RequiredProperty $validation 'aggregateBuild' 'validation'
  $aggregateDirect = Get-RequiredProperty $validation 'aggregateDirect' 'validation'
  $replayRuns = @(Get-RequiredProperty $validation 'replays' 'validation')
  $actualReplayRuns = @($replayRuns | ForEach-Object {
      [string](Get-RequiredProperty $_ 'name' 'replay run')
    })
  Assert-ExactStringSequence $actualReplayRuns $expectedReplayRuns 'replay-run inventory'

  for ($index = 0; $index -lt $directRuns.Count; $index++) {
    Test-RecordedRun $directRuns[$index] $expectedDirectRuns[$index] $Root $packageName
    $warnings = Convert-RequiredInt (Get-RequiredProperty $directRuns[$index] 'warnings' "direct run '$($expectedDirectRuns[$index])'") "direct run '$($expectedDirectRuns[$index])' warnings"
    if ($warnings -ne 0) { throw "direct run '$($expectedDirectRuns[$index])' records warnings" }
  }
  Test-RecordedRun $aggregateBuild 'aggregate-lake-build' $Root $packageName
  Test-RecordedRun $aggregateDirect 'aggregate-direct' $Root $packageName
  for ($index = 0; $index -lt $replayRuns.Count; $index++) {
    Test-RecordedRun $replayRuns[$index] $expectedReplayRuns[$index] $Root $packageName
  }

  $aggregateJobs = Convert-RequiredInt (Get-RequiredProperty $aggregateBuild 'jobs' 'aggregate build') 'aggregate build jobs'
  if ($aggregateJobs -ne $expectedAggregateJobs) {
    throw "aggregate build job count changed: actual=$aggregateJobs, expected=$expectedAggregateJobs"
  }
  $aggregateWarnings = Convert-RequiredInt (Get-RequiredProperty $aggregateBuild 'warnings' 'aggregate build') 'aggregate build warnings'
  if ($aggregateWarnings -lt 0) { throw 'aggregate build warning count is negative' }
  $toolVersions = Get-RequiredProperty $validation 'toolVersions' 'validation'
  foreach ($tool in @('python', 'lake', 'lean')) {
    if ([string]::IsNullOrWhiteSpace([string](Get-RequiredProperty $toolVersions $tool 'tool versions'))) {
      throw "validation tool version '$tool' is empty"
    }
  }
  if ([string](Get-RequiredProperty $validation 'gitHeadBeforeCheckpointCommit' 'validation') -cnotmatch '^[0-9a-fA-F]{40,64}$') {
    throw 'validation Git HEAD is malformed'
  }
  $scope = Get-RequiredProperty $validation 'scope' 'validation'
  foreach ($flag in @('finiteNoHitIsAsymptoticEvidence', 'provesOrDisprovesStandardABC')) {
    $value = Get-RequiredProperty $scope $flag 'validation scope'
    if ($value -isnot [bool] -or [bool]$value) { throw "validation scope '$flag' is not exactly false" }
  }

  $expectedSummary = (
    "PASS`n" +
    "modules=$($expectedModules.Count)`n" +
    "declarations=$summedDeclarations`n" +
    "print_axioms=$summedPrints`n" +
    "axiom_union=$($allowedAxioms -join ',')`n" +
    "aggregate_jobs=$aggregateJobs`n" +
    "standard_abc_closed=false`n"
  )
  if ([IO.File]::ReadAllText($summaryPath) -cne $expectedSummary) {
    throw 'logs/SUMMARY.txt is inconsistent with validation-run.json'
  }

  $expectedRunNames = @($expectedDirectRuns) + @('aggregate-lake-build', 'aggregate-direct') + @($expectedReplayRuns)
  $expectedLogFiles = @('SUMMARY.txt')
  foreach ($runName in $expectedRunNames) {
    $expectedLogFiles += @("$runName.log", "$runName.log.exitcode")
  }
  $logRoot = Join-Path $Root 'logs'
  $actualLogFiles = @(Get-OrdinalSortedStrings @(Get-ChildItem -LiteralPath $logRoot -Recurse -File -Force |
      ForEach-Object { ([IO.Path]::GetRelativePath($logRoot, $_.FullName)).Replace('\', '/') }))
  Assert-ExactStringSequence $actualLogFiles @(Get-OrdinalSortedStrings $expectedLogFiles) 'recorded log file set'

  $expectedPackageFiles = @(
    'COMMANDS.md',
    'README.md',
    'freeze-package.ps1',
    'input-manifest.json',
    'package-validation-common.ps1',
    'validate.ps1',
    'validate.py',
    'validation-run.json',
    'verify-package.ps1'
  )
  foreach ($logFile in $expectedLogFiles) {
    $expectedPackageFiles += "logs/$logFile"
  }
  $actualPackageFiles = @(Get-OrdinalSortedStrings @(Get-ChildItem -LiteralPath $Root -Recurse -File -Force |
      ForEach-Object { ([IO.Path]::GetRelativePath($Root, $_.FullName)).Replace('\', '/') } |
      Where-Object { $_ -cne 'SHA256SUMS' }))
  Assert-ExactStringSequence $actualPackageFiles `
    @(Get-OrdinalSortedStrings $expectedPackageFiles) 'verification-package file set'

  return [pscustomobject]@{
    validation = $validation
    inputs = $inputs
    runCount = $expectedRunNames.Count
    moduleCount = $expectedModules.Count
  }
}
