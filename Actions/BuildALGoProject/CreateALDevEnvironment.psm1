function InitializeALDevEnv {
    param (
        [Parameter(Mandatory = $true)]
        [hashtable] $settings
    )

    # TODO: Remove reference to BCContainerHelper
    DownloadAndImportBcContainerHelper # TODO: How about simply Import-Module BCContainerHelper -DisableNameChecking

    #Get version from artifact
    $artifactUrl = $settings.artifact
    $parts = $artifactUrl.Split('?')[0].Split('/')
    $version = $version = [System.Version] ($parts[4])

    $folderName = "ALDevEnv-$($version.ToString().Replace('.','-'))"

    $compilerFolder = New-BcCompilerFolder `
            -artifactUrl $settings.artifact `
            -cacheFolder $artifactCachePath `
            -vsixFile $settings.vsixFile `
            -containerName $folderName

    return $compilerFolder
}

<#
.SYNOPSIS
Creates a new AL Development Environment based on the specified AL Compiler Source.
.DESCRIPTION
Creates a new AL Development Environment based on the specified AL Compiler Source.
The AL Compiler Source can be 'BCArtifact', which uses the Business Central artifact to set up the environment.
.PARAMETER alCompilerSource
Specifies the source of the AL compiler. Currently, only 'BCArtifact' is supported.
.PARAMETER settings
A hashtable containing settings for the AL Development Environment, including the artifact URL and VSIX file.
.EXAMPLE
New-ALDevelopmentEnvironment -alCompilerSource 'BCArtifact' -settings @{ artifact = 'https://example.com/artifact'; vsixFile = 'path/to/vsix' }
#>
function New-ALDevelopmentEnvironment {
    param (
        [Parameter(Mandatory = $true)]
        [hashtable]$settings
    )

    $alCompilerSource = 'BCArtifact' # This can be extended to support other sources in the future
    Write-Host "Creating AL Development Environment using AL Compiler Source: $alCompilerSource"

    switch ($alCompilerSource) {
        'BCArtifact' {
            $result = InitializeALDevEnv -settings $settings
        }
        default {
            Write-Error "Unsupported AL Compiler Source: $alCompilerSource"
            return ""
        }
    }

    if (-not $result) {
        Write-Error "Failed to create AL Development Environment."
        return ""
    }

    return $result
}

Export-ModuleMember -Function New-ALDevelopmentEnvironment