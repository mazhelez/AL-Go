Param(
    [Parameter(HelpMessage = "A list of AL-Go projects for which to generate build dimensions", Mandatory = $true)]
    [string] $projects
)

# Creates a list of build dimensions based on the projects settings
# For each project, it will generate a build dimension for each build mode that is enabled for that project
function New-BuildDimensions(
    [Parameter(HelpMessage = "A list of AL-Go projects for which to generate build dimensions", Mandatory = $true)]
    $projects,
    $baseFolder = '.'
)
{
    $buildDimensions = @()
    
    $projects | ForEach-Object {
        $project = $_
        
        $projectSettings = ReadSettings -project $project -baseFolder $baseFolder
        $buildModes = @($projectSettings.buildModes)
        
        $buildModes | ForEach-Object {
            $buildMode = $_
            $buildDimensions += [PSCustomObject] @{
                project = $project
                buildMode = $buildMode
            }
        }
    }
    
    return $buildDimensions
}

# IMPORTANT: No code that can fail should be outside the try/catch
try {
    . (Join-Path -Path $PSScriptRoot -ChildPath "..\AL-Go-Helper.ps1" -Resolve)

    $baseFolder = $ENV:GITHUB_WORKSPACE
    $buildDimensions = New-BuildDimensions -projects $projects -baseFolder $baseFolder

    if ($buildDimensions.Count -eq 1) {
        $buildDimensionsJson = "[$($buildProjects | ConvertTo-Json -compress)]"
    }
    else {
        $buildDimensionsJson = $buildProjects | ConvertTo-Json -compress
    }

    Add-Content -Path $env:GITHUB_OUTPUT -Value "BuildDimensions=$buildDimensionsJson"
    Add-Content -Path $env:GITHUB_ENV -Value "BuildDimensions=$buildDimensionsJson"
    Write-Host "BuildDimensions=$buildDimensionsJson"
}
catch {
    OutputError -message "ReadSettings action failed.$([environment]::Newline)Error: $($_.Exception.Message)$([environment]::Newline)Stacktrace: $($_.scriptStackTrace)"
    exit
}
