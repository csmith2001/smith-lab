locals {
    hosts = {
        smith-lab = {
            ip        = "SMITH_LAB_HOST_IP"
            network   = "lan"
            managed   = true
            host_type = "server"
            critical  = true
        }
        fedora-desktop = {
            ip        = "FEDORA_DESKTOP_HOST_IP"
            network   = "lan"
            managed   = true
            host_type = "workstation"
            critical  = false
        }
        fedora-dell = {
            mobile    = true
            managed   = true
            host_type = "workstation"
            critical  = false
        }
        nvr = {
            ip        = "NVR_HOST_IP"
            network   = "lan"
            managed   = false
            host_type = "security"
            critical  = true
        }
    }
}

output "hosts" {
    value = local.hosts
}
