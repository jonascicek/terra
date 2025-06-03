```md
# Terraform First Steps

Dieses Repository enthält eine einfache Terraform-Konfiguration, um die Grundlagen von Infrastructure as Code (IaC) mit Terraform und Docker praktisch zu erlernen.

## 📁 Verzeichnisstruktur

```

terraform/
└── first-steps/
├── provider.tf
├── main.tf
├── .gitignore

````

## 📄 Inhalt

- `provider.tf`: Definiert den Terraform-Block, required_providers und den docker Provider.
- `main.tf`: Erstellt ein Docker-Image (nginx:latest) und startet daraus einen Container.

## ▶️ Schritte

1. Verzeichnis öffnen:

```bash
cd terraform/first-steps/
````

2. Terraform initialisieren:

```bash
terraform init
```

3. Plan anzeigen:

```bash
terraform plan
```

## ✅ Erwarteter Output

* `terraform init`: Erfolgreiche Initialisierung, Provider wird heruntergeladen.
* `terraform plan`: Zeigt geplante Erstellung von `docker_image` und `docker_container`.

## 🧠 Reflexion

**Was ist die Rolle des `provider` Blocks in deiner Konfiguration?**
Der `provider` Block konfiguriert Terraform so, dass es mit einer bestimmten Plattform (hier: Docker) interagiert.

**Warum ist er notwendig?**
Ohne Provider kann Terraform keine Ressourcen verwalten. Er stellt die Verbindung zur Zielumgebung her.

**Was ist die Rolle des `resource` Blocks?**
Er definiert die konkreten Infrastrukturkomponenten, die Terraform verwalten soll – hier z. B. ein Docker-Image oder ein Container.

**Was repräsentiert er im Vergleich zu einem Provider?**
Der Provider ist die Schnittstelle zur Plattform, während die Resource ein konkretes Objekt auf dieser Plattform ist.

**Wie hast du in deiner Konfiguration eine implizite Abhängigkeit zwischen der `docker_container` Ressource und der `docker_image` Ressource erstellt?**
Durch die Referenz `image = docker_image.nginx_image.latest`. Terraform erkennt, dass das Image zuerst erstellt werden muss.

**Warum ist es wichtig, dass Terraform diese Abhängigkeit versteht?**
Damit Terraform die Ressourcen in der richtigen Reihenfolge erstellt und keine Fehler auftreten (z. B. Container vor Image).

**Was genau bewirkt der Befehl `terraform init`, wenn du ihn zum ersten Mal in einem Verzeichnis ausführst?**
Er initialisiert das Arbeitsverzeichnis, lädt die angegebenen Provider herunter und erstellt das `.terraform/` Verzeichnis.

**Was genau zeigt der Output von `terraform plan` an?**
Er zeigt eine Vorschau der geplanten Änderungen (z. B. welche Ressourcen neu erstellt werden) – ohne sie tatsächlich anzuwenden.

**Welche Informationen liefert er, bevor du die Infrastruktur tatsächlich erstellst?**
Er listet alle Änderungen (z. B. `+` für neue Ressourcen) samt ihren Attributen auf, sodass man prüfen kann, ob die Konfiguration korrekt ist.
