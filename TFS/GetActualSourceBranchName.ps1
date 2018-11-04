$sourceAlias = $env:Release_TriggeringArtifact_Alias
$sourceBranchVariable = "Release_Artifacts_{alias}_SourceBranchName"

$sourceBranchNameVariable = $sourceBranchVariable.Replace("{alias}", $sourceAlias)

Write-Host $sourceBranchNameVariable 

$actualBranchName = (Get-Item env:$sourceBranchNameVariable).Value

Write-Host $actualBranchName
Write-Output ("##vso[task.setvariable variable=sourceBranchName;]$actualBranchName")