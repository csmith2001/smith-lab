locals {
  networks = {
    lan = {
      cidr    = "192.168.0.0/24"
      gateway = "192.168.0.1"

      domain = {
        name     = "smith-lab.local"
        dns_host = "smith-lab"
      }
    }
  }
}

resource "local_file" "ansible_networks" {
  filename = "${path.root}/../ansible/inventory/networks.yml"

  content    = yamlencode ({
    networks = local.networks
  })
}
