$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

Uninstall-BinFile -Name 'omnivoice-studio' -ErrorAction SilentlyContinue
Remove-Item -LiteralPath (Join-Path $toolsDir 'app') -Recurse -Force -ErrorAction SilentlyContinue
