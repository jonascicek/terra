locals {
  html_file = "${path.module}/temp_index.html"
}

resource "null_resource" "generate_html_file" {
  provisioner "local-exec" {
    interpreter = ["PowerShell", "-Command"]
    command     = "Set-Content -Path ${local.html_file} -Value '${var.nginx_html_content}'"
  }
}

resource "docker_container" "simple_nginx" {
  name  = var.container_name
  image = "nginx:latest"

  ports {
    internal = 80
    external = var.external_port
  }

  depends_on = [null_resource.generate_html_file]

  provisioner "local-exec" {
    command = "docker cp ${local.html_file} ${self.name}:/usr/share/nginx/html/index.html"
  }
}
