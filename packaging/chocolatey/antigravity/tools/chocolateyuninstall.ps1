$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

Remove-Item -LiteralPath (Join-Path $toolsDir 'app') -Recurse -Force -ErrorAction SilentlyContinue
