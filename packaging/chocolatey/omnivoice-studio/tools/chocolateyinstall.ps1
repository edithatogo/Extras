$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$downloadPath = Join-Path $toolsDir 'omnivoice-studio.msi'
$extractRoot = Join-Path $toolsDir '_extract'
$appDir = Join-Path $toolsDir 'app'
$sevenZip = Join-Path $env:ChocolateyInstall 'tools\7z.exe'

Get-ChocolateyWebFile `
    -PackageName 'omnivoice-studio' `
    -FileFullPath $downloadPath `
    -Url64bit 'https://github.com/debpalash/OmniVoice-Studio/releases/download/v0.3.5/OmniVoice.Studio_0.3.5_x64_en-US.msi' `
    -Checksum64 '39529182a1c61a561fffc82c82c5886b8e4c640bf153c6134d9570099192e906' `
    -ChecksumType64 'sha256'

Remove-Item -LiteralPath $extractRoot -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $extractRoot | Out-Null
& $sevenZip x $downloadPath "-o$extractRoot" -y | Out-Null

$candidate = Get-ChildItem -LiteralPath $extractRoot -Recurse -Filter 'omnivoice-studio.exe' -File | Select-Object -First 1
if (-not $candidate) {
    throw 'Expected omnivoice-studio.exe was not found after MSI extraction.'
}

Remove-Item -LiteralPath $appDir -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $appDir | Out-Null
Copy-Item -Path (Join-Path (Split-Path -Parent $candidate.FullName) '*') -Destination $appDir -Recurse -Force
Install-BinFile -Name 'omnivoice-studio' -Path (Join-Path $appDir 'omnivoice-studio.exe')

Remove-Item -LiteralPath $downloadPath -Force -ErrorAction SilentlyContinue
Remove-Item -LiteralPath $extractRoot -Recurse -Force -ErrorAction SilentlyContinue
