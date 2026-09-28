variable "cloudflare_api_token" {
  sensitive = true
}

variable "public_ip" {}
variable "zone_id" {}
variable "domain_name" {}
variable "storage_root" {}

terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}

resource "local_file" "ansible_hosts" {
  filename = "${path.root}/../ansible/inventory/outputs/hosts.yml"

  content = yamlencode ({
    hosts  = local.hosts
  })
}

resource "local_file" "ansible_services" {
  filename = "${path.root}/../ansible/inventory/outputs/services.yml"

  content    = yamlencode ({
    services = local.services
  })
}

resource "local_file" "ansible_storage_pools" {
  filename = "${path.root}/../ansible/inventory/outputs/storage.yml"

  content   = yamlencode ({
    volumes = local.storage
  })
}

resource "local_file" "ansible_networks" {
  filename = "${path.root}/../ansible/inventory/outputs/networks.yml"

  content    = yamlencode ({
    networks = local.networks
  })
}
    
resource "local_file" "ansible_dns_names" {
  filename = "${path.root}/../ansible/inventory/outputs/dns.yml"

  content        = yamlencode ({
    dns  = local.dns_records
  })
}
