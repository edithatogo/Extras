$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

Get-ChocolateyWebFile `
    -PackageName 'codex' `
    -FileFullPath (Join-Path $toolsDir 'codex.exe') `
    -Url64bit 'https://github.com/openai/codex/releases/download/rust-v0.139.0/codex-x86_64-pc-windows-msvc.exe' `
    -Checksum64 '77a84f8078400467ade4301d827b8bcea2d29b6838c9cd162bf3573b7ef97e10' `
    -ChecksumType64 'sha256'

Get-ChocolateyWebFile `
    -PackageName 'codex-command-runner' `
    -FileFullPath (Join-Path $toolsDir 'codex-command-runner.exe') `
    -Url64bit 'https://github.com/openai/codex/releases/download/rust-v0.139.0/codex-command-runner-x86_64-pc-windows-msvc.exe' `
    -Checksum64 '16efe4854dfb31f584430ce2c0d25c1c42d5fd5298b6d8cda827141638928a3f' `
    -ChecksumType64 'sha256'

Get-ChocolateyWebFile `
    -PackageName 'codex-windows-sandbox-setup' `
    -FileFullPath (Join-Path $toolsDir 'codex-windows-sandbox-setup.exe') `
    -Url64bit 'https://github.com/openai/codex/releases/download/rust-v0.139.0/codex-windows-sandbox-setup-x86_64-pc-windows-msvc.exe' `
    -Checksum64 'd6349976daeaec8539857ba777b807f8565c09512811b4fe0678c1545213b1b1' `
    -ChecksumType64 'sha256'

Install-BinFile -Name 'codex' -Path (Join-Path $toolsDir 'codex.exe')
