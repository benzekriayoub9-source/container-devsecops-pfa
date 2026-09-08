# Documentation technique — Justifications sécurité

## 1. Application Flask

| Mesure | Justification |
|--------|---------------|
| En-têtes HTTP (CSP, X-Frame-Options…) | OWASP Secure Headers — protection XSS, clickjacking |
| SECRET_KEY via env ou génération aléatoire | Évite les secrets en dur dans le code |
| gunicorn en production | Le serveur de dev Flask n'est pas conçu pour la prod |
| MAX_CONTENT_LENGTH | Limite les attaques par déni de service (upload massif) |

## 2. Dockerfile

| Mesure | Justification |
|--------|---------------|
| Multi-stage build | Réduit la surface d'attaque (pas de gcc/compilateurs en runtime) |
| python:3.12-slim-bookworm | Image minimale vs full, moins de CVE |
| USER non-root (UID 10001) | Principe du moindre privilège — conteneur compromis ≠ root host |
| PIP_NO_CACHE_DIR | Réduit la taille et les fuites d'info dans les layers |
| HEALTHCHECK | Orchestration (K8s/Docker Swarm) détecte les conteneurs morts |
| chmod restrictifs | Defense in depth sur le filesystem |
| Labels OCI | Traçabilité, conformité supply chain (SLSA) |

## 3. Pipeline CI/CD

| Outil | Rôle | Shift Left |
|-------|------|------------|
| Hadolint | Bonnes pratiques Dockerfile (DL3006, DL3008…) | Dès le commit |
| Trivy FS | SCA + secrets + misconfig (IaC) | Avant le build |
| pytest | Régression fonctionnelle | Qualité + confiance |
| Trivy Image | CVE dans l'image finale (OS + deps) | Post-build, pré-deploy |
| SARIF upload | Visibilité dans l'onglet Security GitHub | Gouvernance |

## 4. Modèle DevSecOps

Le pipeline implémente le modèle **Plan → Code → Build → Test → Release** avec sécurité intégrée à chaque étape, et non en fin de cycle (approche "bolting on" rejetée en DevSecOps moderne).
