locals {
    services = {
        samba            = {
            dns          = "ad"
            targets      = ["smith-lab"]
            deployment   = "host"
            # group        = "domain-staff"
            service_type = "identity"
            critical     = true
            backup       = true
        }
        # --------------------------------
        caddy            = {
            targets      = ["smith-lab"]
            deployment   = "container"
            # group        = "caddy-staff"
            service_type = "reverse-proxy"
            critical     = true
            backup       = true
        }
        # -----------------------------------
        vaultwarden      = {
            dns          = "vault"
            targets      = ["smith-lab"]
            deployment   = "container"
            # group        = "vaultwarden-staff"
            service_type = "password-manager"
            critical     = true
            backup       = true
        }
        # ----------------------------------
        gitlab           = {
            dns          = "git"
            targets      = ["smith-lab"]
            deployment   = "container"
            # group        = "gitlab-staff"
            service_type = "version-control"
            critical     = false
            backup       = true
        }
        # -----------------------------
        gitlab_runner    = {
            targets      = ["smith-lab"]
            deployment   = "container"
            # group        = "gitlab-staff"
            service_type = "ci-runner"
            critical     = true
            backup       = true
        }
        # -----------------------------
        semaphore        = {
            dns          = "ansible"
            targets      = ["smith-lab"]
            deployment   = "container"
            # group        = "ansible-staff"
            service_type = "automation"
            critical     = true
            backup       = true
        }
    }
}

