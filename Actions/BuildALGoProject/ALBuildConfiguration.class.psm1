class ALBuildConfiguration {
    $compilerFolder
    $cacheFolder
    $assemblyProbingPaths

    hidden ALBuildConfiguration([string] $compilerFolder, [string] $cacheFolder, [string[]] $assemblyProbingPaths) {
        $this.compilerFolder = $compilerFolder
        $this.cacheFolder = $cacheFolder
        $this.assemblyProbingPaths = $assemblyProbingPaths
    }

    static [ALBuildConfiguration] FromBCArtifact([PSCustomObject] $settings) {
        $result = [ALBuildConfiguration]::new() # TODO Add logic to initialize the compiler folder, cache folder, and assembly probing paths

        return $result
    }

    [string] ToJSONString() {
        # COnvert to JSON format for easy serialization
        $json = @{
            compilerFolder = $this.compilerFolder
            cacheFolder = $this.cacheFolder
            assemblyProbingPaths = $this.assemblyProbingPaths
        } | ConvertTo-Json -Depth 10

        return $json
    }

    [ALBuildConfiguration] FromJSONString([string] $jsonString) {
        $data = $jsonString | ConvertFrom-Json
        return [ALBuildConfiguration]::new($data.compilerFolder, $data.cacheFolder, $data.assemblyProbingPaths)
    }
}