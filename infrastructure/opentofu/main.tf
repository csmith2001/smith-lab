variable "public_ip" {}
variable "domain_ip" {}
variable "zone_id" {}
# -------------------------------------
terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
    # --------------------------
    local = {
      source = "hashicorp/local"
    }
  }
}
