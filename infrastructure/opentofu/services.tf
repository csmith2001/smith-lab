locals {
	services = {
		# ----------------------------------------
		caddy = {
			dns                    = "proxy"
			targets                = ["smith-lab"]
			deployment             = "container"
			service_type           = "reverse-proxy"
			critical               = true
			backup                 = true
			lifecycle = {
        bootstrap_required   = true
        managed_secrets      = true
			}
			depends_on             = {}
		}
    # --------------------------------------
    samba = {
      dns                    = "ad"
      targets                = ["smith-lab"]
      deployment             = "host"
      service_type           = "identity"
      critical               = true
      backup                 = true
      lifecycle = {
        bootstrap_required   = true
        managed_secrets      = true
      }
      # -----------------------------
      provides = {
        ldap = {
          protocol           = "ldap"
        }
        # -------------------------------
        kerberos = {
          protocol           = "kerberos"
        }
        # --------------------------
        dns = {
          protocol           = "dns"
        }
      }
      # -------------------------
      depends_on             = {}
    }
    # --------------------------------------
    postgres = {
      dns                    = "postgres"
      targets                = ["smith-lab"]
      deployment             = "container"
      service_type           = "database"
      # ---------------------------
      critical               = true
      backup                 = true
      lifecycle = {
        bootstrap_required   = true
        managed_secrets      = true
      }
      # ---------------------------------
      provides = {
        database = {
          protocol           = "postgres"
        }
      }
      # ----------------------------------
      bootstrap = {
        database             = "postgres"
        username             = "postgres"
        password             = "bootstrap"
      }
      # -------------------------
      databases = {
        openbao              = {}
        semaphore            = {}
        gitlab               = {}
      }
      # -------------------------
      depends_on             = {}
    }
    # ------------------------------------------
    openbao = {
        dns                  = "secret"
        targets              = ["smith-lab"]
        deployment           = "container"
        service_type         = "secrets-manager"
        critical             = true
        backup               = true
        lifecycle = {
          bootstrap_required = true
          managed_secrets    = true
        }
        # ----------------------------
        provides = {
          secrets = {
            protocol         = "https"
          }
        }
        # -------------------------------
        depends_on = {
          database = {
            service          = "postgres"
            capability       = "database"
          }
        }
    }
    # -------------------------------------------
    vaultwarden = {
      dns                    = "vault"
      targets                = ["smith-lab"]
      deployment             = "container"
      service_type           = "password-manager"
      critical               = true
      backup                 = true
      lifecycle = {
        bootstrap_required   = true
        managed_secrets      = true
      }
      # --------------------------------
      depends_on = {
        secrets = {
          service            = "openbao"
          capability         = "secrets"
        }
      }
    }
    # ------------------------------------------
    gitlab = {
      dns                    = "git"
      targets                = ["smith-lab"]
      deployment             = "container"
      service_type           = "version-control"
      critical               = false
      backup                 = true
      lifecycle = {
        bootstrap_required   = true
        managed_secrets      = true
      }
      # ------------------------------
      provides = {
        api = {
          protocol           = "https"
        }
      }
      # ---------------------------------
      depends_on = {
        database = {
          service            = "postgres"
          capability         = "database"
        }
        # ------------------------------
        secrets = {
          service            = "openbao"
          capability         = "secrets"
        }
      }
    }
    # --------------------------------------
    gitlab_runner = {
      targets                = ["smith-lab"]
      deployment             = "container"
      service_type           = "ci-runner"
      critical               = true
      backup                 = true
      lifecycle = {
        bootstrap_required   = true
        managed_secrets      = true
      }
      # -------------------------------
      depends_on = {
        gitlab = {
          service            = "gitlab"
          capability         = "api"
        }
      }
    }
    # --------------------------------------
    semaphore = {
      dns                    = "ansible"
      targets                = ["smith-lab"]
      deployment             = "container"
      service_type           = "automation"
      critical               = true
      backup                 = true
      lifecycle = {
        bootstrap_required   = true
        managed_secrets      = true
      }
      # ---------------------------------
      depends_on = {
        database = {
          service            = "postgres"
          capability         = "database"
        }
        # ------------------------------
        secrets = {
          service            = "openbao"
          capability         = "secrets"
        }
      }
    }
  }
}
# ----------------------------------------------------------------
resource "terraform_data" "validate_services" {
  lifecycle {
    precondition {
      condition = alltrue(flatten([
        for _, service in local.services : [
          for _, dependency in lookup(service, "depends_on", {}) :
          contains(keys(local.services), dependency.service)
        ]
      ]))
      # -------------------------------------------------------------------------
      error_message = "A service depends on another service that does not exist."
    }
    # ------------------------------------------------------------
    precondition {
      condition = alltrue(flatten([
        for _, service in local.services : [
          for _, dependency in lookup(service, "depends_on", {}) :
          # -----------------------------------------------------------------
          !contains(keys(local.services), dependency.service)
          ? true
          : contains(
            keys(lookup(local.services[dependency.service], "provides", {})),
            dependency.capability
          )
        ]
      ]))
      # -----------------------------------------------------------------------
      error_message = "A service depends on a capability that does not exist."
    }
  }
}
