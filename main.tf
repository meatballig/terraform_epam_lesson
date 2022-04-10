#terraform {
#  required_providers {
#    docker = {
#      source = "kreuzwerker/docker"
#      version = "2.16.0"
#    }
#  }
#}


#variable "external_port" {
#type = number
#default = "1680"
#}

#variable "internal_port" {
#type = number
#default = "1600"
#}

#variable "count_docker" {
#type = number
#default = "2"
#}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "docker_container" "nodered_container" {
  count = var.count_docker
  image = docker_image.nodered_image.latest
  name  = join("-",["nodered",random_string.random[count.index].result])
  ports {
    internal = var.internal_port
    external = var.external_port
  }
}

#resource "docker_container" "nodered_conteiner2" {
#  image = docker_image.nodered_image.latest
#  name  = "tutorial2"
#  ports {
#    internal = 1700
#    external = 1700
#  }
#}
#

resource "random_string" "random" {
  count = 2
  length = 4
  special = false
  upper = false
}


#output "info1" {
#  value = join(" - ",[docker_container.nodered_container[0].ip_address, docker_container.nodered_container[0].name])
#} 

#output "info2" {
#  value = join(" - ",[docker_container.nodered_container[1].ip_address, docker_container.nodered_container[1].name])
#}

#output "all_info" {
#  value = [for i in docker_container.nodered_container[*]: join(":",[i.name],[i.ip_address],i.ports[*]["external"])]
#  description = "all_info: name, ip_address, ports"
#}


#join(":",[docker_container.nodered_container.ip_address,docker_container.ports[0].external])
#  value = docker_container.nodered_container[count.index]
#  description = "ip address of our container."
#}

#output "containet_id" {
#  description = "ID of the Docker container"
#  value       = docker_container.nodered_container[count.index]
#docker_container.nodered_container.id#
#}
