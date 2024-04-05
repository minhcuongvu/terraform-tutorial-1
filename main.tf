terraform {
  backend "remote" {
    organization = "noedigsti"
    workspaces {
      name = "workspace1"
    }
  }
  required_providers {
    docker = {
      # https://github.com/kreuzwerker/terraform-provider-docker
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  # https://github.com/kreuzwerker/terraform-provider-docker/blob/54685a5fb9b375961620d2c555c7f3925327112c/internal/provider/provider.go#L50
  host = "npipe:////.//pipe//docker_engine"
  # host = "unix:///var/run/docker.sock"

  # for private docker registry
  # registry_auth {
  #   address  = "https://index.docker.io/v1/"
  #   username = var.docker_hub_username
  #   password = var.docker_hub_password
  # }
}

resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = var.container_name

  ports {
    internal = 80
    external = 8000
  }
}