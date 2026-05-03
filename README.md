# gcp-terraform-infra

Terraform infrastructure na GCP (GKE). 

## Pipeline

Początkowo CI i CD były w jednym `cloudbuild.yaml` odpalającym się na każdy push do `main`. Rozbito to na dwa osobne triggery żeby trzymać się GitOps — każda zmiana idzie przez Pull Request, a apply dzieje się dopiero po merge.

| Trigger | Kiedy | Co robi |
|---|---|---|
| `cloudbuild-ci.yaml` | Otwarcie/update PR | fmt check + validate + plan |
| `cloudbuild-cd.yaml` | Merge do `main` | apply |

## Flow

```
nowy branch → push → PR → CI (plan) → merge → CD (apply)
```

Bezpośrednie pushe na `main` zablokowane przez branch protection.