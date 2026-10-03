locals {
  networks = {
    lan = {
      cidr    = "192.168.0.0/24"
      gateway = "192.168.0.1"
      # ----------------------------
      domain = {
        name     = "smith-lab.local"
        dns_host = "smith-lab"
      }
    }
  }
}

