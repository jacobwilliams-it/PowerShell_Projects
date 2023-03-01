#Add-DeployedVersion.ps1

param(
    [Parameter(Mandatory=$true)][string]$Version,
    [string]$DeployedOn = $(Get-Date -Format "yyyy-MM-dd'T'HH:mm:ssK")
)

if (!($Version -match "^(?:(\d+)\.){2}(\*|\d+)$")) {
    Write-Output "Version string is in wrong format!"
    exit
}

if (!($DeployedOn -match "(\d{4})-(\d{2})-(\d{2})T(\d{2})\:(\d{2})\:(\d{2})[+-](\d{2})\:(\d{2})")) {
    Write-Output "Date-Time string is in wrong format!"
    exit
}

$myJson = Get-Content .\made-up.json -Raw | ConvertFrom-Json 

$ServicesObjects = [System.Collections.Generic.List[PSCustomObject]]$myJson.Versions;
$ServicesObjects.Add(([PSCustomObject] @{"Version"="$($Version)";"DeployedOn"="$($DeployedOn)";}));

$myJson.Versions = $ServicesObjects

$myJson | ConvertTo-Json -Depth 3 | Out-File ".\new-made-up.json"

