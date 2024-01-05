Param(
    [Parameter(HelpMessage = "The path to the output SARIF file", Mandatory = $false)]
    [string] $output
)

$alCodeAnalysisArtifacts = Join-Path $ENV:GITHUB_WORKSPACE '.alcodeanalysis'

$errorLogFiles = Get-ChildItem -Path $alCodeAnalysisArtifacts -Filter "CodeAnalysis_*" -Containter | ForEach-Object {
    $errorLogFile = Join-Path $_.FullName '*.errorLog.json'
    if (Test-Path $errorLogFile) {
        return (Resolve-Path $errorLogFile).Path
    }
}



