#Requires -Modules Pester

Describe "JSON Schema Compliance" {
    BeforeAll {
        $script:RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
        . (Join-Path $PSScriptRoot 'Schema-Validation.ps1')
        function Assert-True {
            param(
                [bool] $Condition,
                [string] $Message
            )
            if (-not $Condition) {
                throw $Message
            }
        }

        function Assert-Equal {
            param(
                $Actual,
                $Expected,
                [string] $Message
            )
            if ($Actual -ne $Expected) {
                throw "$Message Actual: $Actual Expected: $Expected"
            }
        }
    }
    Context "Validating JSON files" {
        It "Should return a boolean for a valid Scoop manifest JSON" {
            $manifest = Join-Path $script:RepoRoot 'bucket\010editor.json'
            $result = Test-SchemaCompliance -Path $manifest
            Assert-True ($result -is [bool]) "Expected schema validation to return a Boolean."
        }

        It "Should fail for malformed JSON" {
            $testJson = '{ malformed json }'
            $tempFile = [System.IO.Path]::GetTempFileName()
            Set-Content -Path $tempFile -Value $testJson

            try {
                $result = Test-SchemaCompliance -Path $tempFile
                Assert-Equal $result $false "Expected malformed JSON to fail schema validation."
            } finally {
                Remove-Item -Path $tempFile -ErrorAction SilentlyContinue
            }
        }
    }
}
