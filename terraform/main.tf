terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

provider "docker" {}

# Construcción de la imagen para el frontend
resource "docker_image" "frontend" {
  name = "frontend:latest"
  build {
    path = "/home/monty/Documentos/Cubos/desafio-tecnico-main/frontend"  # Ruta actualizada para el frontend
  }
}

# Construcción de la imagen para el backend
resource "docker_image" "backend" {
  name = "backend:latest"
  build {
    path = "/home/monty/Documentos/Cubos/desafio-tecnico-main/backend"  # Ruta actualizada para el backend
  }
}

# Red interna para contenedores
resource "docker_network" "internal_net" {
  name = "internal_net"
}

# Red externa (opcional, puede eliminarse si no la necesitas)
resource "docker_network" "external_net" {
  name = "external_net"
}

# Contenedor de frontend
resource "docker_container" "frontend" {
  name  = "frontend_container"
  image = docker_image.frontend.name
  networks_advanced {
    name = docker_network.external_net.name
  }
  ports {
    internal = 80
    external = 8080
  }
  restart = "always"
}

# Contenedor de backend
resource "docker_container" "backend" {
  name  = "backend_container"
  image = docker_image.backend.name
  networks_advanced {
    name = docker_network.internal_net.name
  }
  ports {
    internal = 3000
    external = 3000
  }
  depends_on = [docker_container.frontend]
  restart = "always"
}

# Contenedor de PostgreSQL
resource "docker_container" "postgres" {
  name  = "postgres_container"
  image = "postgres:15.8"
  networks_advanced {
    name = docker_network.internal_net.name
  }
  env = [
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}",
    "POSTGRES_DB=${var.db_name}"
  ]
  volumes {
    host_path      = "/home/monty/Documentos/Cubos/desafio-tecnico-main/postgres/data"  # Ruta actualizada para los datos de postgres
    container_path = "/var/lib/postgresql/data"
  }
  restart = "always"
}
