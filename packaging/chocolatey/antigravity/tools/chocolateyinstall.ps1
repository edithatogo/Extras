$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$downloadPath = Join-Path $toolsDir 'Antigravity.exe'
$extractRoot = Join-Path $toolsDir '_extract'
$appDir = Join-Path $toolsDir 'app'
$dataDir = Join-Path $toolsDir 'data'
$sevenZip = Join-Path $env:ChocolateyInstall 'tools\7z.exe'

Get-ChocolateyWebFile `
    -PackageName 'antigravity' `
    -FileFullPath $downloadPath `
    -Url64bit 'https://storage.googleapis.com/antigravity-public/antigravity-hub/2.1.4-6481382726303744/windows-x64/Antigravity-x64.exe' `
    -Checksum64 'c5e547978398b0a9870b111a75df27ac720eae254e2c55ac53b2e7f865b7659e' `
    -ChecksumType64 'sha256'

Remove-Item -LiteralPath $extractRoot -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $extractRoot | Out-Null
& $sevenZip x $downloadPath "-o`"$extractRoot`"" -y | Out-Null

$candidate = Get-ChildItem -LiteralPath $extractRoot -Recurse -Filter 'antigravity.exe' -File | Select-Object -First 1
if (-not $candidate) {
    throw 'Expected antigravity.exe was not found after installer extraction.'
}

Remove-Item -LiteralPath $appDir -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $appDir | Out-Null
$sourceDir = Split-Path -Parent $candidate.FullName
Copy-Item -Path (Join-Path $sourceDir '*') -Destination $appDir -Recurse -Force
New-Item -ItemType Directory -Force -Path (Join-Path $dataDir 'user-data'), (Join-Path $dataDir 'extensions') | Out-Null

Remove-Item -LiteralPath $downloadPath -Force -ErrorAction SilentlyContinue
Remove-Item -LiteralPath $extractRoot -Recurse -Force -ErrorAction SilentlyContinue
