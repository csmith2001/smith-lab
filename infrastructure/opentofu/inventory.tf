locals {
  inventory = {
    for host_type, config in local.host_types :
    config.group => {
      hosts = {
        for host_name, host in local.hosts :
        host_name => {
          ansible_host = try(host.ip, null)
        }
        if host.host_type == host_type
      }
    }
  }
}

resource "local_file" "ansible_inventory" {
  filename = "${path.root}/../ansible/inventory/inventory.yml"

  content = yamlencode(local.inventory)
}
