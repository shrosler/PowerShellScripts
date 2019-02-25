# Update Git Remote

a PowerShell script for updating the remote URL for several Git repositories at once.

## Parameters:

**RemoteName** - the name of the remote you wish to update (mandatory).

**OldUrlPrefix** - the url you wish to change. Can also be a part of the URL (mandatory).

**NewUrlPrefix** - the new URL you wish to update. Can also be a part of the URL (mandatory).

**WorkingDirectory** - the root directory for the script to search for Git repositories recursive. When not provided the current directory will be the working directory (optional).

## Examples:

PS C:\Windows\system32> UpdateGitRemote.ps1 "origin" "https://github.com/shrosler/PowerShellScripts.git" "https://github.com/shrosler/Scripts.git" "c:\repos"

PS C:\Repos> UpdateGitRemote.ps1 "origin" "PowerShellScripts" "Scripts"
