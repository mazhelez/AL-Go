using module .\ALBuildConfiguration.class.psm1
using module .\ALGoProjectInfo.class.psm1

class ALGoProjectBuild {
    [ALGoProjectInfo] $ProjectInfo
    [string] $BuildMode

    ALGoProjectBuild([string] $project, [string] $buildMode = 'Default', [PSCustomObject] $settings) {
        $this.Project = $project
        $this.BuildMode = $buildMode
        $this.ProjectInfo = [ALGoProjectInfo]::Load($project, $settings)
    }

    [void] BuildApps([ALBuildConfiguration] $compilerConfiguration) {
        #TODO: Implement the build logic using the provided compiler configuration

        Write-Host "Building project '$($this.ProjectInfo.Name)' in mode '$($this.BuildMode)'"

        $appFolders = this.$ProjectInfo.GetAppFolders($true)

        $appFolders = this.SortAppFolders($appFolders)

        foreach ($appFolder in $appFolders) {
            $this.BuildApp($appFolder, $compilerConfiguration)
        }
    }

    hidden [void] BuildApp([string] $appFolder, [ALBuildConfiguration] $compilerConfiguration) {
        Write-Host "Building app in folder: $appFolder"

        if($this.ProjectInfo.GetPreCompileAppScript())  {
            Write-Host "Running pre-compile script for app in folder: $appFolder"
            . ($this.ProjectInfo.GetPreCompileAppScript())
        }

        # Here you would implement the actual build logic for the app
        # This could involve invoking the AL compiler with the appropriate parameters
        # For now, we will just simulate a build with a placeholder message

        Write-Host "Simulated build for app in folder: $appFolder using compiler configuration: $($compilerConfiguration.ToJSONString())"
    }
}