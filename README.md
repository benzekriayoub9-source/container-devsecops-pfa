# Sécurisation de la chaîne de conteneurisation (DevSecOps)

## Contexte

Ce projet démontre l'intégration de la sécurité dans le cycle de vie DevOps d'une application conteneurisée, conformément aux principes **DevSecOps** : *Shift Left Security*.

## Objectifs

- Développer une application web minimaliste et sécurisée
- Construire une image Docker durcie (hardening)
- Automatiser les contrôles de sécurité via GitHub Actions :
  - **Hadolint** : linting du Dockerfile
  - **Trivy** : SCA (code) + scan d'image
  - **Build & Push** : construction et publication conditionnelle

## Architecture

```
[Développeur] → [Git Push] → [GitHub Actions]
                                    │
                    ┌───────────────┼───────────────┐
                    ▼               ▼               ▼
              [Hadolint]      [Trivy FS]      [Tests]
                    │               │               │
                    └───────────────┼───────────────┘
                                    ▼
                            [Docker Build]
                                    ▼
                            [Trivy Image]
                                    ▼
                         [Push GHCR] (si main)
```

## Prérequis

- Docker 24+
- Python 3.12+
- Compte GitHub (pour CI/CD)

## Démarrage local

```bash
# Sans Docker
pip install -r app/requirements.txt pytest
set FLASK_ENV=development
python -m app.wsgi

# Avec Docker
docker build -t secure-webapp:latest .
docker run --rm -p 8080:8080 secure-webapp:latest
```

Accès : http://localhost:8080

## Pipeline CI/CD

| Étape | Outil | Critère d'échec |
|-------|-------|-----------------|
| Lint Dockerfile | Hadolint | Erreurs Hadolint |
| Scan code | Trivy (filesystem) | CRITICAL / HIGH |
| Tests | pytest | Échec des tests |
| Build image | docker/build-push-action | Échec build |
| Scan image | Trivy (image) | CRITICAL / HIGH |
| Push | GHCR | Branche `main` uniquement |

## Choix de sécurité

Voir [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)

## Auteur

Benzekri Ayoub 

