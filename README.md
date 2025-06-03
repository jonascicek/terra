# Terraform First Steps

Dieses Repository enthält die erste Terraform-Konfiguration für Docker-Container.

## Ort der Terraform-Dateien

Alle relevanten Dateien befinden sich im Verzeichnis: `terraform/first-steps/`.

## Inhalt

- `provider.tf`: Definition des Providers (Docker)
- `main.tf`: Definition eines nginx-Images und -Containers

## Befehle

```bash
cd terraform/first-steps/
terraform init
terraform plan
