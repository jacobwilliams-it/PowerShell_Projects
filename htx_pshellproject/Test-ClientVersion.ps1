#Test-ClientVersion.ps1

param(
    [Parameter(Mandatory=$true)][string]$Version

)

if (!($Version -match "^(?:(\d+)\.){2}(\*|\d+)$")) {
    Write-Output "Version string is in wrong format!"
    exit
}

$myJson = Get-Content .\made-up.json -Raw | ConvertFrom-Json 

$maxClientVersion = $myJson.ClientRequirements.Version.LessThan
$minClientVersion = $myJson.ClientRequirements.Version.GreaterThan


if (($version -gt $minClientVersion) -AND ($version -lt $maxClientVersion)) {
    Write-Output "DLC is compatible with a client at version $version"
}else{
    Write-Output "DLC is NOT compatible with a client at version $version"
    Write-Output "DLC version must be between $minClientVersion and $maxClientVersion"
}
