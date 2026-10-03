locals {
  defaults = {
    zone_id = var.zone_id
    type    = "A"
    content = var.public_ip
    proxied = true
    ttl     = 1
  }
  # -------------------
  dns_records = {
    ad = {
      target = "smith-lab"
    }
    # ------------------
    git = {
      target = "smith-lab"
    }
    # ------------
    nvr = {
      target = "nvr"
    }
    # -----------------------
    vault = {
      target = "smith-lab"
    }
    # ---------------------
    ansible = {
      target = "smith-lab"
    }
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
