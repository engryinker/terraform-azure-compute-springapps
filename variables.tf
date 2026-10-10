variable "resource_group_name" {
  description = "Name of the existing resource group to deploy every resource in this module call into. This module does not create the resource group itself."
  type        = string
}

variable "location" {
  description = "Azure region for every resource created by this module call."
  type        = string
}

variable "tags" {
  description = "Default tags applied to every resource created by this module call (e.g. the output of terraform-azure-tags). Overridden per-resource by that resource's own `tags` attribute, if set."
  type        = map(string)
  default     = {}
}

variable "spring_cloud_services" {
  description = <<-EOT
    Map of Azure Spring Apps (Spring Cloud) services to create, keyed by an arbitrary caller-chosen map key.

    NOTE: as of this writing there is no published Azure Verified Module for Azure Spring Apps, so this wraps
    the native `azurerm_spring_cloud_service` resource directly instead of an AVM module like every other
    repo in this org's module set. Swap this for an AVM module if/when Microsoft publishes one. See
    https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/spring_cloud_service
  EOT
  type = map(object({
    name                      = string
    sku_name                  = optional(string, "S0")
    zone_redundant            = optional(bool, false)
    network                   = optional(any, null)
    config_server_git_setting = optional(any, null)
    trace                     = optional(any, null)
    tags                      = optional(map(string))
  }))
  default = {}
}
