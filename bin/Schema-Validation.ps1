function Test-SchemaCompliance {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    if (-not $env:SCOOP_HOME) {
        $env:SCOOP_HOME = scoop prefix scoop
    }

    $validatorDll = "$env:SCOOP_HOME\supporting\validator\bin\Scoop.Validator.dll"
    $schemaJson = "$env:SCOOP_HOME\schema.json"

    if (-not (Test-Path $validatorDll)) {
        Write-Error "Scoop validator DLL not found at $validatorDll"
        return $false
    }

    if (-not (Test-Path $schemaJson)) {
        Write-Error "Scoop schema JSON not found at $schemaJson"
        return $false
    }

    try {
        Add-Type -Path $validatorDll -ErrorAction SilentlyContinue
        $validator = New-Object Scoop.Validator($schemaJson, $true)
        $null = $validator.Validate($Path)
        return ($validator.Errors.Count -eq 0)
    }
    catch {
        return $false
    }
}
