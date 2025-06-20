param ()
{
    if($env:ALDevEnv -ne "") {
        Write-Host "AL Development Environment already exists: $env:ALDevEnv"
        return
    }

    Import-Module (Join-Path -Path $PSScriptRoot -ChildPath "CreateALDevelopmentEnvironment.psm1" -Resolve) -DisableNameChecking

    $settings = $env:Settings | ConvertFrom-Json | ConvertTo-HashTable

    $env:ALDevEnv = New-ALDevelopmentEnvironment -settings $settings
    if ($env:ALDevEnv -eq "") {
        Write-Error "Failed to create AL Development Environment."
        exit 1
    }
    else {
        Write-Host "AL Development Environment created at: $env:ALDevEnv"
    }
}