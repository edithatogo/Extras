$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$downloadPath = Join-Path $toolsDir 'Pencil-3.1.1.ga.exe'
$extractRoot = Join-Path $toolsDir '_extract'
$appDir = Join-Path $toolsDir 'app'
$sevenZip = Join-Path $env:ChocolateyInstall 'tools\7z.exe'

Get-ChocolateyWebFile `
    -PackageName 'pencil' `
    -FileFullPath $downloadPath `
    -Url64bit 'https://pencil.evolus.vn/dl/V3.1.1.ga/Pencil-3.1.1.ga.exe' `
    -Checksum64 '190663eb496c54db43f303d1e91d8e974b580875' `
    -ChecksumType64 'sha1'

Remove-Item -LiteralPath $extractRoot -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $extractRoot | Out-Null

& $sevenZip x $downloadPath "-o$extractRoot" -y | Out-Null
$payloadArchive = Join-Path $extractRoot '$PLUGINSDIR\app-64.7z'
if (-not (Test-Path -LiteralPath $payloadArchive)) {
    throw 'Expected Pencil app-64.7z payload was not found.'
}

Remove-Item -LiteralPath $appDir -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $appDir | Out-Null
& $sevenZip x $payloadArchive "-o$appDir" -y | Out-Null

if (-not (Test-Path -LiteralPath (Join-Path $appDir 'Pencil.exe'))) {
    throw 'Expected Pencil.exe was not found after extraction.'
}

Install-BinFile -Name 'pencil' -Path (Join-Path $appDir 'Pencil.exe')

Remove-Item -LiteralPath $downloadPath -Force -ErrorAction SilentlyContinue
Remove-Item -LiteralPath $extractRoot -Recurse -Force -ErrorAction SilentlyContinue
