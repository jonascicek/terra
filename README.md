# Terraform First Steps

Dieses Repository enthält eine einfache Terraform-Konfiguration, um die Grundlagen von Infrastructure as Code (IaC) mit Terraform und Docker praktisch zu erlernen.

## Inhalt

- `provider.tf`: Definiert den Terraform-Block, required_providers und den docker Provider.
- `main.tf`: Erstellt ein Docker-Image (nginx:latest) und startet daraus einen Container.

## Schritte

1. Verzeichnis öffnen:

```bash
cd terra
````

2. Terraform initialisieren:

```bash
terraform init
```

3. Plan anzeigen:

```bash
terraform plan
```

## Erwarteter Output

* `terraform init`: Erfolgreiche Initialisierung, Provider wird heruntergeladen.
* `terraform plan`: Zeigt geplante Erstellung von `docker_image` und `docker_container`.

## Reflexion

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

# Terraform First Steps – Teil 2

## Ziel dieser Aufgabe

In dieser erweiterten Terraform-Übung wurde eine bestehende Konfiguration so angepasst, dass sie flexibler und wiederverwendbarer wird. Der Fokus lag auf dem vollständigen Terraform-Workflow (`init`, `plan`, `apply`, `destroy`) sowie auf der Nutzung von **Variablen**, **Outputs** und einem **Provisioner**, um dynamisch HTML-Inhalte in einen Nginx-Docker-Container zu schreiben.

##  Struktur der Terraform-Dateien

```

terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── test.tfvars
├── provider.tf
└── .gitignore

````

---

## Beschreibung der Dateien

| Datei         | Zweck |
|--------------|-------|
| `provider.tf` | Definiert Terraform-Version & Docker-Provider |
| `main.tf`     | Erstellt einen Nginx-Container & kopiert HTML-Inhalt per Provisioner |
| `variables.tf`| Enthält drei Input-Variablen: Container-Name, Port, HTML-Inhalt |
| `outputs.tf`  | Gibt Container-Name, Port und verwendeten HTML-Inhalt aus |
| `test.tfvars` | Alternative Konfigurationswerte für Testzwecke |
| `.gitignore`  | Ignoriert `.terraform/` und `terraform.tfstate` |

---

## Terraform-Workflow

### 1. Initialisieren

```bash
terraform init
````

### 2. Plan anzeigen

```bash
terraform plan -var-file="test.tfvars"
```

### 3. Anwenden (Apply)

```bash
terraform apply -var-file="test.tfvars"
```

→ Browser: [http://localhost:8888](http://localhost:8888)
Du solltest den HTML-Inhalt aus `test.tfvars` sehen.

### 4. CLI-Override (Optional)

```bash
terraform apply -var 'container_name="my-cli-container"' -var-file="test.tfvars"
```

→ Der Name des Containers wird überschrieben, Port bleibt 8888.

### 5. Default-Variable verwenden

Entferne `container_name` aus `test.tfvars`, führe erneut `apply` aus – der Default-Wert aus `variables.tf` wird verwendet.

### 6. Ressourcen löschen

```bash
terraform destroy -var-file="test.tfvars"
```

---

## Verwendete Outputs

Nach dem `apply` zeigt Terraform automatisch:

* `container_name_output` – Der Containername
* `container_external_port` – Der gemappte Port
* `html_content_used` – Der tatsächlich verwendete HTML-Inhalt

---

## Beispiel test.tfvars

```hcl
container_name     = "my-test-container"
external_port      = 8888
nginx_html_content = "<h1>Test Umgebung</h1><p>Dieser Inhalt kommt aus der test.tfvars Datei.</p>"
```

## Lernziele dieser Aufgabe (erfüllt)

* `terraform apply` & `destroy` korrekt ausgeführt
* Dynamischer HTML-Inhalt über Variable gesteuert
* Provisioner (`local-exec`) verwendet
* Variable-Werte über:

  * Default-Wert (`variables.tf`)
  * `.tfvars`-Datei (`test.tfvars`)
  * CLI (`-var`) übergeben
* Outputs zur Kontrolle genutzt