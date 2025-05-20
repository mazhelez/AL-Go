Param(
    [Parameter(HelpMessage = "The GitHub token running the action", Mandatory = $false)]
    [string] $token,
    [Parameter(HelpMessage = "ArtifactUrl to use for the build", Mandatory = $false)]
    [string] $artifact = "",
    [Parameter(HelpMessage = "AL-Go project folder", Mandatory = $false)]
    [string] $project = "",
    [Parameter(HelpMessage = "Specifies a mode to use for the build steps", Mandatory = $false)]
    [string] $buildMode = 'Default'
)

$settings = $env:Settings | ConvertFrom-Json | ConvertTo-HashTable

Write-Host "::group::Determine apps to build"
Write-Host "::endgroup::"

Write-Host "::group::Create AL development environment"
Write-Host "::endgroup::"

Write-Host "::group::Apps dependency resolution"
Write-Host "::endgroup::"

Write-Host "::group::Build apps"
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