resource "azurerm_spring_cloud_service" "this" {
  for_each = var.spring_cloud_services

  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = each.value.sku_name
  zone_redundant      = each.value.zone_redundant

  dynamic "network" {
    for_each = each.value.network == null ? [] : [each.value.network]
    content {
      app_subnet_id                          = network.value.app_subnet_id
      service_runtime_subnet_id              = network.value.service_runtime_subnet_id
      cidr_ranges                            = network.value.cidr_ranges
      app_network_resource_group             = try(network.value.app_network_resource_group, null)
      outbound_type                          = try(network.value.outbound_type, null)
      service_runtime_network_resource_group = try(network.value.service_runtime_network_resource_group, null)
    }
  }

  dynamic "config_server_git_setting" {
    for_each = each.value.config_server_git_setting == null ? [] : [each.value.config_server_git_setting]
    content {
      uri          = config_server_git_setting.value.uri
      label        = try(config_server_git_setting.value.label, null)
      search_paths = try(config_server_git_setting.value.search_paths, null)
    }
  }

  dynamic "trace" {
    for_each = each.value.trace == null ? [] : [each.value.trace]
    content {
      connection_string = trace.value.connection_string
    }
  }

  tags = coalesce(each.value.tags, var.tags)
}
