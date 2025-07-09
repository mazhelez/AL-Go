<#
.SYNOPSIS
    This class is used to store information about an AL-Go project.
#>
class ALGoProjectInfo {
    [string] $ProjectFolder
    [PSCustomObject] $Settings

    hidden ALGoProjectInfo([string] $projectFolder, [PSCustomObject] $settings = $null) {
        $alGoFolder = Join-Path $projectFolder '.AL-Go'

        if (-not (Test-Path -Path $alGoFolder -PathType Container)) {
            throw "Could not find .AL-Go folder in $projectFolder"
        }

        $settingsJsonFile = Join-Path $alGoFolder 'settings.json'

        if (-not (Test-Path -Path $settingsJsonFile -PathType Leaf)) {
            throw "Could not find settings.json in $alGoFolder"
        }

        $this.ProjectFolder = $projectFolder

        if ($null -ne $settings) {
            $this.Settings = $settings
        } else {
            # Read settings from the settings.json file
            $this.Settings = Get-Content -Path $settingsJsonFile -Raw | ConvertFrom-Json
        }
    }

    <#
        Gets the AL-Go project info from the specified folder and settings
    #>
    static [ALGoProjectInfo] Load([string] $projectFolder, [PSCustomObject] $settings) {
        $alGoProjectInfo = [ALGoProjectInfo]::new($projectFolder)

        return $alGoProjectInfo
    }

    [string] GetPreCompileAppScript() {
        $precompileScript = 'PreCompileApp.ps1'

        $precompileScriptPath = Join-Path $this.ProjectFolder $precompileScript
        if (Test-Path -Path $precompileScriptPath -PathType Leaf) {
            return $precompileScriptPath
        }

        return ''
    }

    <#
        Finds all AL-Go projects in the specified folder.
    #>
    static [ALGoProjectInfo[]] FindAll([string] $folder) {
        $alGoProjects = @()

        $alGoProjectFolders = Get-ChildItem -Path $folder -Filter '.AL-Go' -Recurse -Directory | Select-Object -ExpandProperty Parent | Select-Object -ExpandProperty FullName

        foreach($alGoProjectFolder in $alGoProjectFolders) {
            $alGoProjects += [ALGoProjectInfo]::Load($alGoProjectFolder)
        }

        return $alGoProjects
    }

    <#
        Gets the app folders.
    #>
    [string[]] GetAppFolders([switch] $Resolve) {
        $appFolders = $this.Settings.appFolders

        if ($Resolve) {
            $appFolders = $appFolders | ForEach-Object { Join-Path $this.ProjectFolder $_ -Resolve -ErrorAction SilentlyContinue } | Where-Object { (Test-Path -Path (Join-Path $_ 'app.json') -PathType Leaf) }| Select-Object -Unique
        }

        return $appFolders
    }

    <#
        Gets the test folders.
    #>
    [string[]] GetTestFolders([switch] $Resolve) {
        $testFolders = $this.Settings.testFolders

        if ($Resolve) {
            $testFolders = $testFolders | ForEach-Object { Join-Path $this.ProjectFolder $_ -Resolve -ErrorAction SilentlyContinue } | Where-Object { (Test-Path -Path (Join-Path $folder 'app.json') -PathType Leaf) }| Select-Object -Unique
        }

        return $testFolders
    }
}