
resource "azurerm_container_group" "aci_jobs" {
  name                = "blog-batch-jobs"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"

  container {
    name   = "job-runner"
    image  = "mcr.microsoft.com/azuredocs/aci-helloworld"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  ip_address_type = "Public"
  dns_name_label  = "blogbatchjob-${random_id.dns.hex}"
}

resource "random_id" "dns" {
  byte_length = 4
}
