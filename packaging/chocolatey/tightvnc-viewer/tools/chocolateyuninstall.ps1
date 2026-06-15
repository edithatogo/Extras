$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

Uninstall-BinFile -Name 'tvnviewer' -ErrorAction SilentlyContinue
Uninstall-BinFile -Name 'tightvnc-viewer' -ErrorAction SilentlyContinue
Remove-Item -LiteralPath (Join-Path $toolsDir 'app') -Recurse -Force -ErrorAction SilentlyContinue
