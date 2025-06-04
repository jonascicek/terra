output "container_name_output" {
  description = "Name des erstellten Containers"
  value       = var.container_name
}

output "container_external_port" {
  description = "Externer Port des Containers"
  value       = var.external_port
}

output "html_content_used" {
  description = "HTML-Inhalt, der in index.html verwendet wird"
  value       = var.nginx_html_content
}
