FROM mcr.microsoft.com/windows/servercore:ltsc2019

WORKDIR c:/azdo/work

WORKDIR c:/azdo/agent
COPY agent .

WORKDIR c:/azdo
COPY Start-Up.ps1 .

CMD powershell c:/azdo/Start-Up.ps1