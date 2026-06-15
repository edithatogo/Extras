$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$downloadPath = Join-Path $toolsDir 'voicebox.msi'
$extractRoot = Join-Path $toolsDir '_extract'
$appDir = Join-Path $toolsDir 'app'
$sevenZip = Join-Path $env:ChocolateyInstall 'tools\7z.exe'

Get-ChocolateyWebFile `
    -PackageName 'voicebox' `
    -FileFullPath $downloadPath `
    -Url64bit 'https://github.com/jamiepine/voicebox/releases/download/v0.5.0/Voicebox_0.5.0_x64_en-US.msi' `
    -Checksum64 '6242007dcee2c7127b687873c0d97d02958d6d5b3bb304dca70439ecf595cdd0' `
    -ChecksumType64 'sha256'

Remove-Item -LiteralPath $extractRoot -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $extractRoot | Out-Null
& $sevenZip x $downloadPath "-o$extractRoot" -y | Out-Null

$candidate = Get-ChildItem -LiteralPath $extractRoot -Recurse -Filter 'voicebox.exe' -File | Select-Object -First 1
if (-not $candidate) {
    throw 'Expected voicebox.exe was not found after MSI extraction.'
}

Remove-Item -LiteralPath $appDir -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $appDir | Out-Null
Copy-Item -Path (Join-Path (Split-Path -Parent $candidate.FullName) '*') -Destination $appDir -Recurse -Force

Install-BinFile -Name 'voicebox' -Path (Join-Path $appDir 'voicebox.exe')
Install-BinFile -Name 'voicebox-server' -Path (Join-Path $appDir 'voicebox-server.exe')
Install-BinFile -Name 'voicebox-mcp' -Path (Join-Path $appDir 'voicebox-mcp.exe')

Remove-Item -LiteralPath $downloadPath -Force -ErrorAction SilentlyContinue
Remove-Item -LiteralPath $extractRoot -Recurse -Force -ErrorAction SilentlyContinue
