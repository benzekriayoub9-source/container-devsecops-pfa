# Guide de soutenance — DevSecOps PFA

## Pitch (30 secondes)

> Ce projet illustre l'intégration de la sécurité dès la conception (*Shift Left*) dans une chaîne CI/CD conteneurisée. L'application est durcie au niveau code, image Docker et pipeline automatisé, avec des gates bloquantes sur les vulnérabilités CRITICAL et HIGH.

## Démo recommandée (5 min)

1. **Application** — `.\scripts\run-docker.ps1` ou ouvrir GitHub Actions
2. **Pipeline vert** — montrer Hadolint → Trivy FS → Tests → Build → Trivy Image
3. **Sécurité** — onglet GitHub → Security → Code scanning (SARIF Trivy)

## Bonus (impact jury)

Introduire une dépendance vulnérable dans `app/requirements.txt`, pousser sur GitHub, montrer le pipeline **rouge**, corriger, montrer le retour au **vert**.

## Questions fréquentes du jury

| Question | Réponse |
|----------|---------|
| Pourquoi Trivy ? | Open-source, SCA + image + secrets, gratuit en CI GitHub |
| Pourquoi non-root ? | Moindre privilège — conteneur compromis ≠ root sur l'hôte |
| Que faire si HIGH bloque ? | `ignore-unfixed: true` + documenter dans `.trivyignore` |
| Pourquoi multi-stage ? | Image plus légère, moins de CVE (pas de gcc en runtime) |
| SBOM / SLSA ? | Évolution possible avec Trivy CycloneDX + labels OCI |

## Commandes rapides

```powershell
# Tests
python -m pytest tests/ -v

# App locale
.\scripts\run-local.ps1

# Docker
.\scripts\run-docker.ps1
```
