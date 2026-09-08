# Cree le repo GitHub et pousse le code (apres gh auth login)
Set-Location $PSScriptRoot\..

$gh = "C:\Program Files\GitHub CLI\gh.exe"
$git = "C:\Program Files\Git\bin\git.exe"
$repoName = "container-devsecops-pfa"

& $gh auth status 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "Connexion GitHub requise. Lancez :" -ForegroundColor Yellow
    Write-Host "  gh auth login --hostname github.com --git-protocol https --web" -ForegroundColor Cyan
    exit 1
}

Write-Host "Creation du repo GitHub $repoName..." -ForegroundColor Cyan
& $gh repo create $repoName --public --source=. --remote=origin --push --description "PFA DevSecOps - Securisation de la chaine de conteneurisation"
if ($LASTEXITCODE -eq 0) {
    $url = & $gh repo view --json url -q .url
    Write-Host "Repo cree : $url" -ForegroundColor Green
    Write-Host "Pipeline CI/CD : $url/actions" -ForegroundColor Green
}
