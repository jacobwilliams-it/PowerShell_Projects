#Get-CurrentlyDeployedVersion.ps1

$myJson = Get-Content .\made-up.json -Raw | ConvertFrom-Json 

$latestDate = 0

foreach ($element in $myjson.versions) { 
    if ($element.DeployedOn -gt $latestDate) { 
        $latestDate = $element.DeployedOn
        $latestVersion = $element.Version 
    }    
}

Write-Output "Currently deployed version is $latestVersion, deployed on $latestDate"