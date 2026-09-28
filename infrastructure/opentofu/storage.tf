locals {
  storage_root = "/srv/infra"
  storage = {
    backups = {
      path = "${local.storage_root}/backups"
    }
    media = {
      path = "${local.storage_root}/media"
    }
    containers = {
      path = "${local.storage_root}/containers"
    }
  }
}

output "storage" {
    value = local.storage
}
