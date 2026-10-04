locals {
  host_types = {
    server = {
        group = "servers"
    }
    # ------------------------
    workstation = {
        group = "workstations"
    }
    # --------------------
    security = {
        group = "security"
    }
    # ----------------------------------
    virtual-machine = {
        group = "virtual_machines"
    }
  }
  # ----------------------
  disk_types = {
    system = {
      mount = "/"
    }
    # ------------------
    backups = {
      mount = "/backups"
    }
    # ------------------
    storage = {
      mount = "/storage"
    }
    # ----------------
    games = {
      mount = "/games"
    }
  }
  # ---------------------------------------------------------
  hosts = {
    smith-lab = {
      host_ip                      = "SMITH_LAB_HOST_IP"
      ansible_host                 = "host.containers.internal"
      ansible_ssh_private_key_file = "/root/.ssh/svc_infra.key"
      host_type                    = "server"
      network                      = "lan"
      managed                      = true
      ansible_runner               = true
      critical                     = true
      # --------------------
      firewall = {
        redirects = [
          {
            protocol = "tcp"
            from_port = 80
            to_port = 8080
          },
          {
            protocol = "tcp"
            from_port = 443
            to_port = 8443
          }
        ]
      }
      # ------------------
      disks    = {
        system = {
          size = "931.5G"
        }
        # ----------------
        backups = {
          size  = "931.5G"
        }
        # ----------------
        storage = {
          size  = "3.6T"
        }
      }
    }
    # ------------------------------------------------------
    fedora-desktop = {
      host_ip                      = "FEDORA_DESKTOP_HOST_IP"
      host_type                    = "workstation"
      network                      = "lan"
      ansible_ssh_private_key_file = "/root/.ssh/ansible.key"
      managed                      = true
      ansible_runner               = true
      # ---------------
      disks    = {
        system = {
          size = "1.8T"
        }
        # ---------------
        backups = {
          size  = "931.5G"
        }
        # ---------------
        storage = {
          size  = "931.5G"
        }
        # ---------------
        games  = {
          size = "931.5G"
        }
      }
    }
    # -------------------------
    fedora-dell = {
      host_type                    = "workstation"
      ansible_ssh_private_key_file = "/root/.ssh/ansible.key"
      managed                      = true
      ansible_runner               = true
      mobile                       = true
      # -----------------
      disks = {
        system = {
          size = "931.5G"
        }
      }
    }
    # ---------------------------
    nvr  = {
      host_ip           = "NVR_HOST_IP"
      network           = "lan"
      host_type         = "security"
      critical          = true
    }
  }
  # ----------------------------------------------------
  invalid_host_types = {
    for host_name, host in local.hosts :
    host_name => host.host_type
    if !contains(keys(local.host_types), host.host_type)
  }
  # -------------------------------------------------------
  inventory = {
    all = {
      children = {
        for host_type, config in local.host_types :
        config.group => {
          hosts = {
            for host_name, host in local.hosts :
            host_name => {}
            if host.host_type == host_type
          }
        }
      }
    }
  }
}
# ------------------------------------------------------------
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

