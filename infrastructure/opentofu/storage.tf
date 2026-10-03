locals {
  infra_root = "/srv/infra"
  storage = {
    containers = {
      path = "${local.infra_root}/containers"
    }

    configs = {
      path = "${local.infra_root}/configs"
    }

    media = {
      path = "${local.infra_root}/media"
    }

    logs = {
      path = "${local.infra_root}/logs"
    }

    backups = {
      path = "${local.infra_root}/backups"
    }

    samba = {
      path = "${local.infra_root}/samba"
    }
  }
}
