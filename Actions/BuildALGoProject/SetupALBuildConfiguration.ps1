using module .\ALCompilerConfiguration.class.psm1

function New-ALBuildConfiguration {
    param (
        [Parameter(Mandatory = $true)]
        [hashtable]$settings
    )

    $alBuildConfigurationSource = 'BCArtifact' # This can be extended to support other sources in the future
    Write-Host "Setting up AL build configuration using: $alBuildConfigurationSource"

    switch ($alCompilerSource) {
        'BCArtifact' {
            $alBuildConfiguration = [ALBuildConfiguration]::FromBCArtifact($settings)
        }
        default {
            Write-Error "Unsupported AL build configuration source: $alBuildConfigurationSource"
            return ""
        }
    }

    if (-not $alBuildConfiguration) {
        Write-Error "Failed to create AL Development Environment."
        return ""
    }

    return $alBuildConfiguration.ToJSONString()
}

if($env:ALBuildConfiguration -ne "") {
    Write-Host "AL build configuration already exists: $($env:ALBuildConfiguration | Format-Table)"
    return
}

$settings = $env:Settings | ConvertFrom-Json | ConvertTo-HashTable

$env:ALBuildConfiguration = New-ALBuildConfiguration -settings $settings
if ($env:ALBuildConfiguration -eq "") {
    Write-Error "Failed to setup AL build configuration."
    exit 1
}
else {
    Write-Host "AL build configuration created: $($env:ALBuildConfiguration | Format-Table)"
}