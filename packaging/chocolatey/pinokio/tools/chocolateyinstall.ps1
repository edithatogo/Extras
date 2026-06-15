$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$downloadPath = Join-Path $toolsDir 'Pinokio.exe'
$extractRoot = Join-Path $toolsDir '_extract'
$appDir = Join-Path $toolsDir 'app'
$sevenZip = Join-Path $env:ChocolateyInstall 'tools\7z.exe'

Get-ChocolateyWebFile `
    -PackageName 'pinokio' `
    -FileFullPath $downloadPath `
    -Url64bit 'https://github.com/pinokiocomputer/pinokio/releases/download/v7.2.6/Pinokio.exe' `
    -Checksum64 '84cfb1d47fdc05f5b7968e7b7751243a24ae4ef97b0f5daf9f4bf6e5b1f93db4' `
    -ChecksumType64 'sha256'

Remove-Item -LiteralPath $extractRoot -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $extractRoot | Out-Null
& $sevenZip x $downloadPath "-o$extractRoot" -y | Out-Null

$payload = Join-Path $extractRoot '$PLUGINSDIR\app-64.7z'
if (-not (Test-Path -LiteralPath $payload)) {
    throw 'Expected NSIS app-64.7z payload was not found.'
}

Remove-Item -LiteralPath $appDir -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $appDir | Out-Null
& $sevenZip x $payload "-o$appDir" -y | Out-Null

$appExe = Join-Path $appDir 'Pinokio.exe'
if (-not (Test-Path -LiteralPath $appExe)) {
    throw 'Expected Pinokio.exe was not found after payload extraction.'
}

Install-BinFile -Name 'pinokio' -Path $appExe

Remove-Item -LiteralPath $downloadPath -Force -ErrorAction SilentlyContinue
Remove-Item -LiteralPath $extractRoot -Recurse -Force -ErrorAction SilentlyContinue
