#Unpublish-LatestDeployedVersion.ps1

param(
    [string]$DeployedOn = $(Get-Date -Format "yyyy-MM-dd'T'HH:mm:ssK")
)

if (!($DeployedOn -match "(\d{4})-(\d{2})-(\d{2})T(\d{2})\:(\d{2})\:(\d{2})[+-](\d{2})\:(\d{2})")) {
    Write-Output "Date-Time string is in wrong format!"
    exit
}

$myJson = Get-Content .\made-up.json -Raw | ConvertFrom-Json 

$latestVersion = 0
$previousVersion = 0

foreach ($element in $myjson.versions) { 
    if ($element.version -gt $latestVersion) { 
        $latestVersion = $element.Version 
    }    
}

foreach ($element in $myjson.versions) { 
    if (($element.Version -gt $previousVersion) -AND ($element.Version -lt $latestVersion) ) { 
        $previousVersion = $element.Version 
    }    
}

$ServicesObjects = [System.Collections.Generic.List[PSCustomObject]]$myJson.Versions;

$element = $ServicesObjects.FindIndex({ param($myJson); $myJson.Version.Equals("$($previousVersion)") })
$myJson.Versions[$element].DeployedOn = $DeployedOn

$myJson | ConvertTo-Json -Depth 3 | Out-File ".\made-up.json"


