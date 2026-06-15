$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$downloadPath = Join-Path $toolsDir 'tightvnc-viewer.msi'
$extractRoot = Join-Path $toolsDir '_extract'
$appDir = Join-Path $toolsDir 'app'
$sevenZip = Join-Path $env:ChocolateyInstall 'tools\7z.exe'

Get-ChocolateyWebFile `
    -PackageName 'tightvnc-viewer' `
    -FileFullPath $downloadPath `
    -Url64bit 'https://www.tightvnc.com/download/2.8.87/tightvnc-2.8.87-gpl-setup-64bit.msi' `
    -Checksum64 'aa256612c5b8bb387355e9c4bce6068bf9ba77ef849f54efcf6087d86b86f52a' `
    -ChecksumType64 'sha256'

Remove-Item -LiteralPath $extractRoot -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $extractRoot | Out-Null
& $sevenZip x $downloadPath "-o$extractRoot" -y | Out-Null

$viewer = Get-ChildItem -LiteralPath $extractRoot -Recurse -Filter 'tvnviewer.exe' -File | Select-Object -First 1
if (-not $viewer) {
    throw 'Expected tvnviewer.exe was not found after MSI extraction.'
}

Remove-Item -LiteralPath $appDir -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $appDir | Out-Null
Copy-Item -LiteralPath $viewer.FullName -Destination (Join-Path $appDir 'tvnviewer.exe') -Force
Install-BinFile -Name 'tvnviewer' -Path (Join-Path $appDir 'tvnviewer.exe')
Install-BinFile -Name 'tightvnc-viewer' -Path (Join-Path $appDir 'tvnviewer.exe')

Remove-Item -LiteralPath $downloadPath -Force -ErrorAction SilentlyContinue
Remove-Item -LiteralPath $extractRoot -Recurse -Force -ErrorAction SilentlyContinue
