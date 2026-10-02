locals {
    host_types = {
        server = {
            group = "servers"
        }

        workstation = {
            group = "workstations"
        }

        security = {
            group = "security"
        }

        virtual-machine = {
            group = "virtual_machines"
        }
    }
}

locals {
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

locals {
  invalid_host_types = {
    for host_name, host in local.hosts :
    host_name => host.host_type
    if !contains(keys(local.host_types), host.host_type)
  }
}

resource "terraform_data" "validate_groups" {
  lifecycle {
    precondition {
      condition     = length(local.invalid_host_types) == 0
      error_message = join("\n", [
        for host_name, host_type in local.invalid_host_types :
        "${host_name} has an invalid host_type: ${host_type}"
      ])
    }
  }
}

resource "local_file" "ansible_hosts" {
  filename = "${path.root}/../ansible/inventory/hosts.yml"

  content = yamlencode ({
    smith_hosts  = local.hosts
  })
}
