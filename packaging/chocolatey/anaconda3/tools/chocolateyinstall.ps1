$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$downloadPath = Join-Path $toolsDir 'Anaconda3-2025.12-2-Windows-x86_64.exe'
$appDir = Join-Path $toolsDir 'App'

if ($toolsDir -match '\s') {
    throw 'Anaconda installer is not reliable when the install path contains spaces.'
}

Get-ChocolateyWebFile `
    -PackageName 'anaconda3' `
    -FileFullPath $downloadPath `
    -Url64bit 'https://repo.anaconda.com/archive/Anaconda3-2025.12-2-Windows-x86_64.exe' `
    -Checksum64 '2e0b8e40ec7600793f116250f5c1775c866833bac32d184ad575ecc0d360a88f' `
    -ChecksumType64 'sha256'

$arguments = @(
    '/S',
    '/InstallationType=JustMe',
    '/RegisterPython=0',
    '/AddToPath=0',
    '/NoRegistry=1',
    "/D=$appDir"
)

$process = Start-Process -FilePath $downloadPath -ArgumentList $arguments -Wait -PassThru
if ($process.ExitCode -ne 0) {
    throw "Anaconda installer failed with exit code $($process.ExitCode)."
}

Install-BinFile -Name 'python-anaconda' -Path (Join-Path $appDir 'python.exe')
Install-BinFile -Name 'conda' -Path (Join-Path $appDir 'Scripts\conda.exe')

Remove-Item -LiteralPath $downloadPath -Force -ErrorAction SilentlyContinue
