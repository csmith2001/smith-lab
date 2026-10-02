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

resource "local_file" "ansible_storage_pools" {
  filename = "${path.root}/outputs/storage.yml"

  content   = yamlencode ({
    volumes = local.storage
  })
}
