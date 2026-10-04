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
      ansible_host                 = "SMITH_LAB_HOST_IP"
      ansible_host_type            = "server"
      ansible_network              = "lan"
      ansible_user                 = "svc_infra"
      ansible_ssh_private_key_file = "/root/.ssh/svc_infra.smith_lab.key"
      ansible_managed              = true
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
      ansible_host                 = "FEDORA_DESKTOP_HOST_IP"
      ansible_host_type            = "workstation"
      ansible_network              = "lan"
      ansible_user                 = "csmith-admin"
      ansible_ssh_private_key_file = "/root/.ssh/ansible.key"
      ansible_managed              = true
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
      ansible_user                 = "csmith-admin"
      ansible_host_type            = "workstation"
      ansible_ssh_private_key_file = "/root/.ssh/ansible.key"
      ansible_managed              = true
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
      ansible_host      = "NVR_HOST_IP"
      ansible_network   = "lan"
      ansible_host_type = "security"
      critical          = true
    }
  }
  # ----------------------------------------------------
  invalid_host_types = {
    for host_name, host in local.hosts :
    host_name => host.ansible_host_type
    if !contains(keys(local.host_types), host.ansible_host_type)
  }
  # -------------------------------------------------------
  inventory = {
    all = {
      children = {
        for ansible_host_type, config in local.host_types :
        config.group => {
          hosts = {
            for host_name, host in local.hosts :
            host_name => { }
            if host.ansible_host_type == ansible_host_type
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
        for host_name, ansible_host_type in local.invalid_host_types :
        "${host_name} has an invalid ansible_host_type: ${ansible_host_type}"
      ])
    }
  }
}

