terraform {
  required_providers {
    docker = {
      source = "terraform-providers/docker"
    }
  }
}

provider "docker" {
  host    = "npipe:////.//pipe//docker_engine"
}

resource "docker_image" "app" {
  name = "denis78/compose-main:latest"
  keep_locally = false
}
resource "docker_image" "app-sonar" {
  name = "denis78/compose-first:latest"
  keep_locally = false
}
resource "docker_image" "app-radar" {
  name = "denis78/compose-second:latest"
  keep_locally = false
}

resource "docker_container" "app" {
  image = docker_image.app.latest
  name  = "app"
  restart = "always"
  ports {
    internal = 9000
    external = 9000
  }
}

resource "docker_container" "sonar" {
  image = docker_image.app-sonar.latest
  name  = "sonar"
  restart = "always"
  ports {
    internal = 9001
    external = 9001
  }
}

resource "docker_container" "radar" {
  image = docker_image.app-radar.latest
  name  = "radar"
  restart = "always"
  ports {
    internal = 9002
    external = 9002
  }
}