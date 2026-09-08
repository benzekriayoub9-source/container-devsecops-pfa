# Build et lancement Docker
Set-Location $PSScriptRoot\..

$docker = "C:\Program Files\Docker\Docker\resources\bin\docker.exe"
if (-not (Test-Path $docker)) { $docker = "docker" }

Write-Host "Build de l'image secure-webapp:latest..." -ForegroundColor Cyan
& $docker build -t secure-webapp:latest .
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "Lancement du conteneur sur http://localhost:8080" -ForegroundColor Green
& $docker run --rm -p 8080:8080 secure-webapp:latest
