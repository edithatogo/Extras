# Installed Scoop App Coverage Review

Generated: 2026-06-13T20:10:42Z
Source: `scoop list` (from `C:\\Users\\60217257\\scoop\\shims\\pwsh.exe`).

## Superseded

This report is retained for historical reference.
Current cross-manager signal decisions now use:

`packaging/reports/installed-candidates-review.md`

Run:
`pwsh ./tools/package-audit/Find-InstalledCandidates.ps1`

## Scope
This is a legacy Scoop-only scope snapshot; it may be stale relative to current manager state.

- Total installed apps observed: `65`
- Contracts found among installed apps: `1`
- Additional requested Android mirroring candidates from contracts that are installed: `0`
- Status: only `NoMachine Enterprise Client` has both an installed instance and a maintained contract in this repository.

## Notes
- Reviewed installed apps against candidates `scrcpy`, `SCRCPY+`, `DroidVNC-NG`, `TighVNC`, `Android Studio`, and `Microsoft Phone Link`.
- No additional mirroring candidates from this article set are installed, so `installed-app` signal does not force an additional priority bump.
- `NoMachine Enterprise Client` remains relevant because it has both installed presence and contract coverage.

## Full Installed App List (Scoop)
- 7zip
- adb
- aria2
- bat
- chatgpt
- cursor-latest
- cygwin
- dark
- delta
- docker
- docker-buildx
- docker-compose
- doctl
- dotnet-sdk-preview
- duckdb
- eza
- fd
- ffmpeg
- figma
- firefox
- fzf
- gcc
- gh
- git
- go
- go-sqlcmd
- graphviz
- imagemagick-lean
- inkscape
- innounp
- JetBrainsMono-NF
- jq
- julia
- just
- kdeconnect
- krita
- lazygit
- libreoffice
- localsend
- lsd
- mingw
- msys2
- nanazip
- nodejs-lts
- nomachine-enterprise-client
- notion
- nvm
- obsidian
- oh-my-posh
- opencode
- opencode-desktop
- outlook-google-calendar-sync
- pandoc
- parsec
- pdfgear
- pdfsam
- pipx
- pwsh
- pwsh-beta
- quarto
- r
- ripgrep
- sharex
- spotify
- starship
- syft
- tesseract
- tldr
- typst
- uv
- vale
- vcredist2022
- vlc
- vncviewer
- wifiinfoview
- windows-terminal
- zed
- zotero
- zoxide
