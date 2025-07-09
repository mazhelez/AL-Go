Param(
    [Parameter(HelpMessage = "AL-Go project folder", Mandatory = $false)]
    [string] $project = "",
    [Parameter(HelpMessage = "Specifies a mode to use for the build steps", Mandatory = $false)]
    [string] $buildMode = 'Default',
    [Parameter(HelpMessage = "RunId of the baseline workflow run", Mandatory = $false)]
    [string] $baselineWorkflowRunId = '0',
    [Parameter(HelpMessage = "SHA of the baseline workflow run", Mandatory = $false)]
    [string] $baselineWorkflowSHA = ''
)

. (Join-Path -Path $PSScriptRoot -ChildPath "..\AL-Go-Helper.ps1" -Resolve)

Write-Host "::group::Determine apps to build"
Write-Host "::endgroup::"

Write-Host "::group::Setup AL Build Configuration"
. $PSScriptRoot\SetupALBuildConfiguration.ps1
Write-Host "::endgroup::"

Write-Host "::group::Apps dependency resolution"
Write-Host "::endgroup::"

Write-Host "::group::Build apps"
. $PSScriptRoot\BuildApps.ps1 -Project $project -BuildMode $buildMode
Write-Host "::endgroup::"

Write-Host "::group::Build test apps"
Write-Host "::endgroup::"

Write-Host "::group::Build BCPT test apps"
Write-Host "::endgroup::"

Write-Host "::group::Create AL test environment" # TODO: run in parallel as build steps?
Write-Host "::endgroup::"

Write-Host "::group::Run AL test"
Write-Host "::endgroup::"

Write-Host "::group::Run BCPT test"
Write-Host "::endgroup::"

Write-Host "::group::Run recorded test"
Write-Host "::endgroup::"