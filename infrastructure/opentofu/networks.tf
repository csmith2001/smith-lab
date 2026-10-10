locals {
  networks = {
    lan = {
      cidr    = "192.168.0.0/24"
      gateway = "192.168.0.1"
      # --------------------------------
      domain = {
        ad_name     = "dev.smith-lab.xyz"
        public_name = "smith-lab.xyz"
        dns_host    = "smith-lab"
        host_ip     = var.domain_ip
      }
    }
  }
  # ----------------------
  dns_records = {
    ad = {
      targets = ["smith-lab"]
    }
    # --------------------
    git = {
      targets = ["smith-lab"]
    }
    # --------------
    nvr = {
      targets = ["nvr"]
      port    = 80
    }
    # --------------------
    vault = {
      targets = ["smith-lab"]
      port    = 8081
      headers = true
    }
    # --------------------
    ansible = {
      targets = ["smith-lab"]
    }
  }
  # -----------------------
  defaults = {
    zone_id = var.zone_id
    type    = "A"
    content = var.public_ip
    proxied = true
    ttl     = 1
  }
}
# ----------------------------------------------------------
resource "cloudflare_dns_record" "dns" {
  for_each = local.dns_records
  name     = each.key
  zone_id  = try(each.value.zone_id, local.defaults.zone_id)
  type     = try(each.value.type, local.defaults.type)
  content  = try(each.value.content, local.defaults.content)
  proxied  = try(each.value.proxied, local.defaults.proxied)
  ttl      = try(each.value.ttl, local.defaults.ttl)
}
