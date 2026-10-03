variable "cloudflare_api_token" {
  sensitive = true
}
# ------------------------
variable "public_ip" {}
variable "zone_id" {}
variable "domain_name" {}
variable "storage_root" {}
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
