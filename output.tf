output "info1" {
  value = join(" - ",[docker_container.nodered_container[0].ip_address, docker_container.nodered_container[0].name])
}

#output "info2" {
#  value = join(" - ",[docker_container.nodered_container[1].ip_address, docker_container.nodered_container[1].name])
#}

output "all_info" {
  value = [for i in docker_container.nodered_container[*]: join(":",[i.name],[i.ip_address],i.ports[*]["external"])]
  description = "all_info: name, ip_address, ports"
}


