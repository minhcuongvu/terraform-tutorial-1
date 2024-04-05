output "container_url" {
  description = "Name"
  value = docker_container.nginx.ports
}

output "container_image_name" {
  description = "Name"
  value = docker_container.nginx.name
}

output "container_network_data" {
  description = "Name"
  value = docker_container.nginx.network_data
}
