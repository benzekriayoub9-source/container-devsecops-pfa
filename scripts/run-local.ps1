# Lance l'application en mode développement local
Set-Location $PSScriptRoot\..

Write-Host "Installation des dependances..." -ForegroundColor Cyan
python -m pip install -r app/requirements.txt pytest

Write-Host "Execution des tests..." -ForegroundColor Cyan
python -m pytest tests/ -v
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "Demarrage de l'application sur http://localhost:8080" -ForegroundColor Green
$env:FLASK_ENV = "development"
python -m app.wsgi
