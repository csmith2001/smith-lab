# ----------------------------------------------------------------
resource "local_file" "staging_inventory" {
  filename = "${path.root}/../ansible/inventories/staging/hosts.yml"
  # -----------------------------------
  content = yamlencode(local.inventory)
}
# ----------------------------------------------------------------
resource "local_file" "production_inventory" {
  filename = "${path.root}/../ansible/inventories/staging/hosts.yml"
  # -----------------------------------
  content = yamlencode(local.inventory)
}
# --------------------------------------------------------------
resource "local_file" "host_vars" {
  for_each = local.hosts
  filename = "${path.root}/../ansible/inventories/production/host_vars/${each.key}.yml"
  # ----------------------------------------------------------
  content = yamlencode({
    ansible_network   = try(each.value.ansible_network, null)
    ansible_managed   = try(each.value.ansible_managed, false)
    ansible_runner    = try(each.value.ansible_runner, false)
    critical          = try(each.value.critical, false)
    ansible_host_type = each.value.ansible_host_type
    disks             = try(each.value.disks, {})
  })
}
# ------------------------------------------------------------------------------
resource "local_file" "group_vars" {
  filename = "${path.root}/../ansible/inventories/production/group_vars/all.yml"
  # ---------------------------------
  content = yamlencode ({
    dns          = local.dns_records
    networks     = local.networks
    repositories = local.repositories
    services     = local.services
  })
}
