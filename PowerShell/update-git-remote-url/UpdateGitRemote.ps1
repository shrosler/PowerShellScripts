param(
    [Parameter(mandatory=$true)]
    [string]$RemoteName,
    [Parameter(,mandatory=$true)]
    [string]$OldUrlPrefix,
    [Parameter(,mandatory=$true)]
    [string]$NewUrlPrefix,
    [string]$WorkingDirectory
)

$currentDirectory = Get-Location

if (![string]::IsNullOrEmpty($WorkingDirectory)){
    cd $WorkingDirectory
}
else{
    $WorkingDirectory = $currentDirectory
}

$paths = Get-ChildItem -Path "$(Get-Location)\**\.git" -Force

Write-Host "Found $($paths.Count) git directories`n"

foreach($path in $paths){
    $parentPath = (Get-Item -Force -Path $path).Parent.FullName
    Write-Host "Set working directory to $parentPath"
    Set-Location -Path $parentPath
    
    $isFound = $false
    $remotes = git remote -v

    Write-Host $remotes

    foreach($line in $remotes){
        if ($line.Contains($RemoteName) -and $line.Contains($OldUrlPrefix)) {
            $isFound = $true
            break
        }
    }

    if ($isFound -eq $true){
        try{
            $index = $line.IndexOf("http")
            $line = $line.Remove(0, $index)
        
            $index = $line.IndexOf(" ")
            $line = $line.Remove($index, $line.Length - $index)
        
            $newUrl = $line -replace $OldUrlPrefix, $NewUrlPrefix
            Write-Host "Changing $line to $newUrl`n"
            git remote set-url $RemoteName $newUrl
        }
        catch [Exception]{
            Write-Host $_.Exception.Message -ForegroundColor Red
        }
    }
    else{
        Write-Host "Remote $RemoteName that contains $OldUrlPrefix was not found`n"
    }
}


cd $currentDirectory
