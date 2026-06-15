$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$appDir = Join-Path $toolsDir 'App'
$uninstaller = Join-Path $appDir 'Uninstall-Anaconda3.exe'

if (Test-Path -LiteralPath $uninstaller) {
    $process = Start-Process -FilePath $uninstaller -ArgumentList '/S' -Wait -PassThru
    if ($process.ExitCode -ne 0) {
        throw "Anaconda uninstaller failed with exit code $($process.ExitCode)."
    }
}

Remove-Item -LiteralPath $appDir -Recurse -Force -ErrorAction SilentlyContinue
