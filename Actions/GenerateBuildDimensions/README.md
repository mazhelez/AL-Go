# Generate Build Dimensions
Creates an array of {project, buildMode} couples to use as build dimensions.
Every AL-Go projects is paired with all the build modes, supported for that project.

## Parameters
### projects
An array of AL-Go projects for which to generate the dimentions

## Example output
```
[{ project: "AL-Go-1", buildMode: "Default" }, { project: "AL-Go-1", buildMode: "Clean" }, { project: "AL-Go-2", buildMode: "Default" }, { project: "AL-Go-3", buildMode: "Default" }]
```
