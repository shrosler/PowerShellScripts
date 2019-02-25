param(
	[string]$source = ".\",
	[string]$target
)

Get-ChildItem -Path $source -Recurse -Force | Move-Item -Destination $target