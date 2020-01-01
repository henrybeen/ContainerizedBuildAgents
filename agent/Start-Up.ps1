if (-not (Test-Path Env:AZDO_URL)) {
  Write-Error "error: missing AZDO_URL environment variable"
  exit 1
}

if (-not (Test-Path Env:AZDO_TOKEN)) {
  Write-Error "error: missing AZDO_TOKEN environment variable"
  exit 1
}

if (-not (Test-Path Env:AZDO_POOL)) {
  Write-Error "error: missing AZDO_POOL environment variable"
  exit 1
}

if (-not (Test-Path Env:AZDO_AGENT_NAME)) {
  Write-Error "error: missing AZDO_AGENT_NAME environment variable"
  exit 1
}

$Env:VSO_AGENT_IGNORE = "AZDO_TOKEN"

Set-Location c:\azdo\agent

Write-Host "1. Configuring Azure Pipelines agent..." -ForegroundColor Cyan
Write-Host "Agent name: ${Env:AZDO_AGENT_NAME}"

.\config.cmd --unattended `
  --agent "${Env:AZDO_AGENT_NAME}" `
  --url "${Env:AZDO_URL}" `
  --auth PAT `
  --token "${Env:AZDO_TOKEN}" `
  --pool "${Env:AZDO_POOL}" `
  --work "c:\azdo\work" `
  --replace

Remove-Item Env:AZDO_TOKEN

Write-Host "2. Running Azure Pipelines agent..." -ForegroundColor Cyan

.\run.cmd --once