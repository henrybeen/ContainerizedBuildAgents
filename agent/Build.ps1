param (
    [Parameter(Mandatory=$true)]
    [string]
    $AZDO_URL,

    [Parameter(Mandatory=$true)]
    [string]
    $AZDO_TOKEN
)

if (-not $(Test-Path "agent.zip" -PathType Leaf))
{
    Write-Host "1. Determining matching Azure Pipelines agent..." -ForegroundColor Cyan

    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$AZDO_TOKEN"))
    $package = Invoke-RestMethod -Headers @{Authorization=("Basic $base64AuthInfo")} "$AZDO_URL/_apis/distributedtask/packages/agent?platform=win-x64&`$top=1"
    $packageUrl = $package[0].Value.downloadUrl
    Write-Host "Package URL: $packageUrl"

    Write-Host "2. Downloading the Azure Pipelines agent..." -ForegroundColor Cyan

    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile($packageUrl, "$(Get-Location)\agent.zip")
}
else {
    Write-Host "1-2. Skipping downloading the agent, found an agent.zip right here" -ForegroundColor Cyan
}

Write-Host "3. Unzipping the Azure Pipelines agent" -ForegroundColor Cyan
Expand-Archive -Path "agent.zip" -DestinationPath "agent"