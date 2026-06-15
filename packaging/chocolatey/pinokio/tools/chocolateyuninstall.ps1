$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

Uninstall-BinFile -Name 'pinokio' -ErrorAction SilentlyContinue
Remove-Item -LiteralPath (Join-Path $toolsDir 'app') -Recurse -Force -ErrorAction SilentlyContinue
