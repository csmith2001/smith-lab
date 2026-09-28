locals {
    networks = {
        lan = {
            cidr    = "192.168.0.0/24"
            gateway = "192.168.0.1"
        }
    }
}

output "networks" {
    value = local.networks
}
