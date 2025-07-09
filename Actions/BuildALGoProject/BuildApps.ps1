using module .\ALGoProjectBuild.class.psm1
using module .\ALBuildConfiguration.class.psm1

param (
    [Parameter(Mandatory = $true)]
    [string] $Project,
    [string] $BuildMode = 'Default'
)
{
    $settings = $env:settings | ConvertFrom-Json
    $compilerConfiguration = [ALBuildConfiguration]::fromJSONString($env:ALBuildConfiguration)

    $projectBuild = [ALGoProjectBuild]::new($Project, $BuildMode, $settings)
    $projectBuild.BuildApps($compilerConfiguration)
}