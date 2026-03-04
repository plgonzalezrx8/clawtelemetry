# ClawTelemetry installer for Windows (PowerShell)
# GitHub-only distribution: installs from a GitHub tag/ref archive.
# Usage: irm https://raw.githubusercontent.com/plgonzalezrx8/clawtelemetry/main/install.ps1 | iex
$ErrorActionPreference = "Stop"

$repo = if ($env:CLAWTELEMETRY_REPO) { $env:CLAWTELEMETRY_REPO } else { "plgonzalezrx8/clawtelemetry" }
$version = $env:CLAWTELEMETRY_VERSION
$ref = $env:CLAWTELEMETRY_REF
$installDir = if ($env:CLAWTELEMETRY_INSTALL_DIR) { $env:CLAWTELEMETRY_INSTALL_DIR } else { "$env:LOCALAPPDATA\clawtelemetry" }

Write-Host "🔭 Installing ClawTelemetry from GitHub" -ForegroundColor Cyan
Write-Host ""

# Locate Python 3.
$python = $null
foreach ($candidate in @("python", "python3")) {
    try {
        $ver = & $candidate --version 2>&1
        if ($ver -match "Python 3") {
            $python = $candidate
            break
        }
    } catch {}
}

if (-not $python) {
    Write-Host "❌ Python 3 is required but was not found." -ForegroundColor Red
    exit 1
}

if (-not $version -and -not $ref) {
    Write-Host "→ Resolving latest release tag from GitHub..."
    try {
        $latest = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/releases/latest"
        $version = $latest.tag_name
    } catch {
        Write-Host "❌ Could not resolve latest release tag." -ForegroundColor Red
        Write-Host "   Set CLAWTELEMETRY_VERSION=<tag> or CLAWTELEMETRY_REF=<branch-or-sha> and retry." -ForegroundColor Red
        exit 1
    }
}

$tmpDir = Join-Path $env:TEMP ("clawtelemetry-install-" + [Guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Path $tmpDir | Out-Null
$archive = Join-Path $tmpDir "clawtelemetry.zip"

if ($ref) {
    $archiveUrl = "https://github.com/$repo/archive/$ref.zip"
    Write-Host "→ Installing from ref: $ref"
} else {
    $archiveUrl = "https://github.com/$repo/archive/refs/tags/$version.zip"
    Write-Host "→ Installing from release tag: $version"
}

Write-Host "→ Downloading source archive..."
if ($ref) {
    # GitHub supports SHA refs at /archive/<sha>.zip and branches at
    # /archive/refs/heads/<branch>.zip. Try both for reliability.
    try {
        Invoke-WebRequest -Uri $archiveUrl -OutFile $archive
    } catch {
        $archiveUrl = "https://github.com/$repo/archive/refs/heads/$ref.zip"
        Invoke-WebRequest -Uri $archiveUrl -OutFile $archive
    }
} else {
    Invoke-WebRequest -Uri $archiveUrl -OutFile $archive
}

Write-Host "→ Extracting archive..."
Expand-Archive -Path $archive -DestinationPath $tmpDir -Force
$srcDir = Get-ChildItem -Path $tmpDir -Directory | Select-Object -First 1
if (-not $srcDir) {
    Write-Host "❌ Failed to locate extracted source directory." -ForegroundColor Red
    exit 1
}

if (Test-Path $installDir) {
    Remove-Item -Recurse -Force $installDir
}

Write-Host "→ Creating virtual environment at $installDir..."
& $python -m venv $installDir
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Failed to create virtual environment." -ForegroundColor Red
    exit 1
}

& "$installDir\Scripts\pip.exe" install --upgrade pip | Out-Null
Write-Host "→ Installing ClawTelemetry from local source archive"
& "$installDir\Scripts\pip.exe" install --no-cache-dir $srcDir.FullName | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Failed to install ClawTelemetry from GitHub source." -ForegroundColor Red
    exit 1
}

# Add venv scripts dir to user PATH if missing.
$binDir = "$installDir\Scripts"
$userPath = [System.Environment]::GetEnvironmentVariable("PATH", "User")
if ($userPath -notlike "*$binDir*") {
    [System.Environment]::SetEnvironmentVariable("PATH", "$binDir;$userPath", "User")
}
$env:PATH = "$binDir;$env:PATH"

$versionOutput = & "$binDir\clawtelemetry.exe" --version 2>&1

Write-Host ""
Write-Host "✅ ClawTelemetry installed successfully" -ForegroundColor Green
Write-Host "  Version: $versionOutput"
Write-Host ""
Write-Host "  Run: clawtelemetry --host 0.0.0.0 --port 8900"
Write-Host "  Docs: https://github.com/plgonzalezrx8/clawtelemetry/tree/main/docs"

Remove-Item -Recurse -Force $tmpDir
