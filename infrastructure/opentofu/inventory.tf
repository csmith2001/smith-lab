locals {
  inventory = {
    all = {
      children = {
        for ansible_host_type, config in local.host_types :
        config.group => {
          hosts = {
            for host_name, host in local.hosts :
            host_name => { }
            if host.ansible_host_type == ansible_host_type
          }
        }
      }
    }
  }
}
