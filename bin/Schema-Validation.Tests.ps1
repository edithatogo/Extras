#Requires -Modules Pester

Describe "JSON Schema Compliance" {
    BeforeAll {
        # Dot-source the schema validator script (which we haven't implemented yet, or has a stub)
        . "$PSScriptRoot/Schema-Validation.ps1"
    }
    Context "Validating JSON files" {
        It "Should succeed for a valid Scoop manifest JSON" {
            $testJson = '{
                "version": "1.0.0",
                "description": "Test App",
                "homepage": "https://example.com",
                "license": "MIT",
                "url": "https://example.com/test.zip",
                "hash": "1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef"
            }'
            $tempFile = [System.IO.Path]::GetTempFileName()
            Set-Content -Path $tempFile -Value $testJson
            
            try {
                $result = Test-SchemaCompliance -Path $tempFile
                $result | Should Be $true
            } finally {
                Remove-Item -Path $tempFile -ErrorAction SilentlyContinue
            }
        }

        It "Should fail for malformed JSON" {
            $testJson = '{ malformed json }'
            $tempFile = [System.IO.Path]::GetTempFileName()
            Set-Content -Path $tempFile -Value $testJson
            
            try {
                $result = Test-SchemaCompliance -Path $tempFile
                $result | Should Be $false
            } finally {
                Remove-Item -Path $tempFile -ErrorAction SilentlyContinue
            }
        }
    }
}
