locals {
    services = {
        caddy = {
            host         = "smith-lab"           
            service_type = "reverse-proxy"
            storage      = "containers"
            critical     = true
            backup       = true
        }

        vaultwarden = {
            host         = "smith-lab"
            dns          = "vault"           
            service_type = "password-manager"
            storage      = "containers"
            critical     = true
            backup       = true
        }
        
        samba = {
            host         = "smith-lab"
            dns          = "ad"           
            service_type = "identity"
            storage      = "containers"
            critical     = true
            backup       = true
        }
        
        gitlab = {
            host         = "smith-lab"
            dns          = "git"
            service_type = "version-control"
            storage      = "containers"
            critical     = false
            backup       = true
        }
    }
}

resource "local_file" "ansible_services" {
  filename = "${path.root}/../ansible/inventory/services.yml"

  content    = yamlencode ({
    services = local.services
  })
}
