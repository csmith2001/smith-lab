storage "postgresql" {
  connection_url = "postgresql://openbao:password@postgres:5432/openbao?sslmode=disable"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

ui = true