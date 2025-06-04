variable "container_name" {
  type        = string
  description = "Name des Containers"
  default     = "my-flex-nginx-container"
}

variable "external_port" {
  type        = number
  description = "Externer Port für Nginx"
  default     = 8080
}

variable "nginx_html_content" {
  type        = string
  description = "HTML-Inhalt, der in /usr/share/nginx/html/index.html geschrieben wird"
  default     = "<h1>Hello from Terraform!</h1><p>Container: my-flex-nginx-container</p>"
}

