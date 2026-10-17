# ----------------------------------------------------------------
resource "local_file" "staging_inventory" {
  filename = "${path.root}/../ansible/inventories/staging/hosts.yml"
  # -----------------------------------
  content = yamlencode(local.inventory)
}
# ----------------------------------------------------------------
resource "local_file" "production_inventory" {
  filename = "${path.root}/../ansible/inventories/production/hosts.yml"
  # -----------------------------------
  content = yamlencode(local.inventory)
}
# --------------------------------------------------------------
resource "local_file" "host_vars" {
  for_each = local.hosts
  filename = "${path.root}/../ansible/inventories/production/host_vars/${each.key}.yml"
  # ----------------------------------------------------------
  content = yamlencode({
    host_ip                      = try(each.value.host_ip, null)
    host_type                    = try(each.value.host_type, null)
    ansible_host                 = try(each.value.ansible_host, "${each.key}.${local.networks.lan.domain.ad_name}")
    ansible_user                 = "admin"
    ansible_group                = "infra_staff"
    ansible_ssh_private_key_file = try(each.value.ansible_ssh_private_key_file, null)
    samba_ad_dc                  = try(each.value.samba_ad_dc, false)
    network                      = try(each.value.network, null)
    managed                      = try(each.value.managed, false)
    ansible_runner               = try(each.value.ansible_runner, false)
    critical                     = try(each.value.critical, false)
    firewall                     = try(each.value.firewall, null)
    disks                        = try(each.value.disks, {})
  })
}
# ------------------------------------------------------------------------------
resource "local_file" "group_vars" {
  filename = "${path.root}/../ansible/inventories/production/group_vars/all.yml"
  # ---------------------------------
  content = yamlencode ({
    endpoints    = local.dns_records
    networks     = local.networks
    repositories = local.repositories
    services     = local.services
    volumes      = local.volumes
  })
}
