terraform {
  required_version = ">= 1.7.0"
}

module "springapps" {
  source = "../.."

  resource_group_name = "rg-example"
  location            = "eastus"
  tags = {
    environment = "dev"
  }

  spring_cloud_services = {} # see README Inputs table for the per-entry schema
}
