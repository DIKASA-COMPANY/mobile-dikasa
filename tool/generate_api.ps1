param(
    [string]$BackendSpec = ""
)

$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $PSScriptRoot
$localSpec = Join-Path $projectRoot "openapi\dikasa.openapi.yaml"
$generatorPackage = "@openapitools/openapi-generator-cli@2.41.0"
$packageRoot = Join-Path $projectRoot "packages\dikasa_api"
# Generate into an empty directory so renamed models and serializers cannot survive.
$stagingParent = Join-Path $projectRoot ".dart_tool\api-generation"
$stagingRelative = ".dart_tool/api-generation/" + [Guid]::NewGuid().ToString("N")
$stagingRoot = Join-Path $projectRoot $stagingRelative

if ($BackendSpec) {
    $resolvedBackendSpec = (Resolve-Path -LiteralPath $BackendSpec).Path
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $localSpec) | Out-Null
    Copy-Item -LiteralPath $resolvedBackendSpec -Destination $localSpec -Force
    Write-Host "OpenAPI synced from $resolvedBackendSpec"
}

if (-not (Test-Path -LiteralPath $localSpec)) {
    throw "OpenAPI snapshot not found at $localSpec. Pass -BackendSpec with the backend api/openapi.yaml path."
}

if (-not (Get-Command java -ErrorAction SilentlyContinue)) {
    $androidStudioJava = "C:\Program Files\Android\Android Studio\jbr\bin"
    if (Test-Path -LiteralPath (Join-Path $androidStudioJava "java.exe")) {
        $env:Path = "$androidStudioJava;$env:Path"
    } else {
        throw "Java 11+ is required by OpenAPI Generator and was not found on PATH."
    }
}

Push-Location $projectRoot
try {
    New-Item -ItemType Directory -Force -Path $stagingRoot | Out-Null
    $specHash = (Get-FileHash -LiteralPath $localSpec -Algorithm SHA256).Hash
    Write-Host "OpenAPI SHA-256: $specHash"
    & npx.cmd --yes $generatorPackage generate --config openapi-generator-config.yaml --output $stagingRelative
    if ($LASTEXITCODE -ne 0) {
        throw "OpenAPI Generator failed with exit code $LASTEXITCODE."
    }

    $generatedPubspec = Join-Path $stagingRoot "pubspec.yaml"
    $generatedPubspecContent = Get-Content -LiteralPath $generatedPubspec -Raw
    $generatedPubspecContent = $generatedPubspecContent.Replace(
        "sdk: '>=3.5.0 <4.0.0'",
        "sdk: '>=3.8.0 <4.0.0'"
    )
    [System.IO.File]::WriteAllText(
        $generatedPubspec,
        $generatedPubspecContent,
        [System.Text.UTF8Encoding]::new($false)
    )

    $generatedAnalysisOptions = Join-Path $stagingRoot "analysis_options.yaml"
    $analysisOptionsContent = Get-Content -LiteralPath $generatedAnalysisOptions -Raw
    $analysisOptionsContent = $analysisOptionsContent.Replace(
        "deprecated_member_use_from_same_package: ignore",
        "deprecated_member_use_from_same_package: ignore`n    unused_import: ignore"
    )
    [System.IO.File]::WriteAllText(
        $generatedAnalysisOptions,
        $analysisOptionsContent,
        [System.Text.UTF8Encoding]::new($false)
    )

    Push-Location $stagingRoot
    try {
        & dart pub get
        if ($LASTEXITCODE -ne 0) { throw "dart pub get failed for generated client." }
        & dart run build_runner build --delete-conflicting-outputs
        if ($LASTEXITCODE -ne 0) { throw "build_runner failed for generated client." }
    } finally {
        Pop-Location
    }

    & dart format (Join-Path $stagingRoot "lib")
    if ($LASTEXITCODE -ne 0) { throw "dart format failed for generated client." }
    $generatedReadme = Join-Path $stagingRoot "README.md"
    $readmeText = [IO.File]::ReadAllText($generatedReadme)
    $readmeText = [regex]::Replace($readmeText, '(?m)[\t ]+\r?$', '')
    [IO.File]::WriteAllText($generatedReadme, $readmeText, [Text.UTF8Encoding]::new($false))

    $targetLib = Join-Path $packageRoot "lib"
    $stagedLib = Join-Path $stagingRoot "lib"
    # Remove only obsolete generated files inside this package's lib directory.
    # This also removes serializers whose source model was renamed or deleted.
    Get-ChildItem -LiteralPath $targetLib -File -Recurse | ForEach-Object {
        $relative = [IO.Path]::GetRelativePath($targetLib, $_.FullName)
        if (-not (Test-Path -LiteralPath (Join-Path $stagedLib $relative))) {
            Remove-Item -LiteralPath $_.FullName
        }
    }
    Get-ChildItem -LiteralPath $stagedLib -File -Recurse | ForEach-Object {
        $relative = [IO.Path]::GetRelativePath($stagedLib, $_.FullName)
        $target = Join-Path $targetLib $relative
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $target) | Out-Null
        Copy-Item -LiteralPath $_.FullName -Destination $target -Force
    }
    foreach ($supportFile in @(".gitignore", "README.md", "analysis_options.yaml", "build.yaml", "pubspec.yaml")) {
        Copy-Item -LiteralPath (Join-Path $stagingRoot $supportFile) -Destination (Join-Path $packageRoot $supportFile) -Force
    }
    Push-Location $packageRoot
    try {
        & dart pub get
        if ($LASTEXITCODE -ne 0) { throw "dart pub get failed for generated client." }
    } finally {
        Pop-Location
    }
    & flutter pub get
    if ($LASTEXITCODE -ne 0) { throw "flutter pub get failed for mobile application." }
} finally {
    Pop-Location
    if (Test-Path -LiteralPath $stagingRoot) {
        $resolvedStaging = (Resolve-Path -LiteralPath $stagingRoot).Path
        $resolvedParent = [IO.Path]::GetFullPath($stagingParent) + [IO.Path]::DirectorySeparatorChar
        if (-not $resolvedStaging.StartsWith($resolvedParent, [StringComparison]::OrdinalIgnoreCase)) {
            throw "Refusing cleanup outside the API generation staging directory."
        }
        Remove-Item -LiteralPath $resolvedStaging -Recurse -Force
    }
}

Write-Host "DIKASA API client generated successfully."
