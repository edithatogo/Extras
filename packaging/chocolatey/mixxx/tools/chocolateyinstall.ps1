$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$packageDir = Split-Path -Parent $toolsDir
$downloadPath = Join-Path $toolsDir 'mixxx.msi'
$appDir = Join-Path $toolsDir 'app'
$extractRoot = Join-Path $toolsDir '_extract'

$packageArgs = @{
    PackageName  = 'mixxx'
    FileFullPath = $downloadPath
    Url64bit     = 'https://downloads.mixxx.org/releases/2.5.6/mixxx-2.5.6-win64.msi'
    Checksum64   = '0d1f01a1f5c2e4d4180cd462e60365d0230b405808e7bd2b6625b62a53a29c72'
    ChecksumType64 = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Remove-Item -LiteralPath $extractRoot -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $extractRoot | Out-Null

$arguments = @('/a', "`"$downloadPath`"", '/qn', "TARGETDIR=`"$extractRoot`"")
$process = Start-Process -FilePath 'msiexec.exe' -ArgumentList $arguments -Wait -PassThru
if ($process.ExitCode -ne 0) {
    throw "MSI administrative extraction failed with exit code $($process.ExitCode)."
}

$payload = Join-Path $extractRoot 'SourceDir\Mixxx'
if (-not (Test-Path -LiteralPath (Join-Path $payload 'mixxx.exe'))) {
    throw "Expected mixxx.exe was not found after MSI extraction."
}

Remove-Item -LiteralPath $appDir -Recurse -Force -ErrorAction SilentlyContinue
Move-Item -LiteralPath $payload -Destination $appDir
Remove-Item -LiteralPath $downloadPath -Force -ErrorAction SilentlyContinue
Remove-Item -LiteralPath $extractRoot -Recurse -Force -ErrorAction SilentlyContinue
