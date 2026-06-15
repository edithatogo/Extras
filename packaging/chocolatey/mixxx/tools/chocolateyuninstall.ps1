$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$appDir = Join-Path $toolsDir 'app'

Uninstall-BinFile -Name 'mixxx' -ErrorAction SilentlyContinue
Remove-Item -LiteralPath $appDir -Recurse -Force -ErrorAction SilentlyContinue
