$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$appDir = Join-Path $toolsDir 'app'

Remove-Item -LiteralPath $appDir -Recurse -Force -ErrorAction SilentlyContinue
