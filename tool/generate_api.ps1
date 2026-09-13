param(
    [string]$BackendSpec = ""
)

$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $PSScriptRoot
$localSpec = Join-Path $projectRoot "openapi\dikasa.openapi.yaml"
$generatorPackage = "@openapitools/openapi-generator-cli@2.41.0"

if ($BackendSpec) {
    $resolvedBackendSpec = (Resolve-Path -LiteralPath $BackendSpec).Path
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
    & npx.cmd --yes $generatorPackage generate --config openapi-generator-config.yaml
    if ($LASTEXITCODE -ne 0) {
        throw "OpenAPI Generator failed with exit code $LASTEXITCODE."
    }

    # OpenAPI Generator 7.24 still emits an SDK floor of 3.5, while its
    # generated json_serializable setup uses null-aware collection elements
    # introduced in Dart 3.8. Keep regeneration deterministic until the
    # upstream dart-dio template raises its SDK constraint.
    $generatedPubspec = Join-Path $projectRoot "packages\dikasa_api\pubspec.yaml"
    $generatedPubspecContent = Get-Content -LiteralPath $generatedPubspec -Raw
    $generatedPubspecContent = $generatedPubspecContent.Replace(
        "sdk: '>=3.5.0 <4.0.0'",
        "sdk: '>=3.8.0 <4.0.0'"
    )
    Set-Content -LiteralPath $generatedPubspec -Value $generatedPubspecContent -Encoding utf8NoBOM

    # Error response models are referenced in the OpenAPI response map but the
    # generated Dio methods surface non-2xx responses as DioException, leaving
    # those imports unused by design.
    $generatedAnalysisOptions = Join-Path $projectRoot "packages\dikasa_api\analysis_options.yaml"
    $analysisOptionsContent = Get-Content -LiteralPath $generatedAnalysisOptions -Raw
    $analysisOptionsContent = $analysisOptionsContent.Replace(
        "deprecated_member_use_from_same_package: ignore",
        "deprecated_member_use_from_same_package: ignore`n    unused_import: ignore"
    )
    Set-Content -LiteralPath $generatedAnalysisOptions -Value $analysisOptionsContent -Encoding utf8NoBOM

    Push-Location (Join-Path $projectRoot "packages\dikasa_api")
    try {
        & dart pub get
        if ($LASTEXITCODE -ne 0) {
            throw "dart pub get failed for the generated client."
        }

        & dart run build_runner build --delete-conflicting-outputs
        if ($LASTEXITCODE -ne 0) {
            throw "build_runner failed for the generated client."
        }
    } finally {
        Pop-Location
    }

    & dart format packages/dikasa_api/lib
    if ($LASTEXITCODE -ne 0) {
        throw "dart format failed for the generated client."
    }

    & flutter pub get
    if ($LASTEXITCODE -ne 0) {
        throw "flutter pub get failed for the mobile application."
    }
} finally {
    Pop-Location
}

Write-Host "DIKASA API client generated successfully."
