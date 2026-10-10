# terraform-azure-compute-springapps

Org-standard Terraform wrapper for **Azure Spring Apps (Spring Cloud) services**.

⚠️ **No AVM module exists for this resource** as of this writing. Every other repo in this org's module set wraps an official Azure Verified Module; this one wraps the native `azurerm_spring_cloud_service` resource directly, following the same conventions (`resource_group_name`/`location`/`tags` at the module level, a `map(object(...))` of instances). Swap this for an AVM module if/when Microsoft publishes one for Azure Spring Apps.

Deploys into an existing resource group -- this module does not create the resource group itself. Compose with [terraform-azure-naming](https://github.com/<org>/terraform-azure-naming) and [terraform-azure-tags](https://github.com/<org>/terraform-azure-tags).

## Usage

```hcl
module "springapps" {
  source = "git::https://github.com/<org>/terraform-azure-compute-springapps.git?ref=v1.0.0"

  resource_group_name = azurerm_resource_group.this.name
  location             = azurerm_resource_group.this.location
  tags                 = module.tags.tags

  spring_cloud_services = {
    main = {
      name     = "spring-app1-prod"
      sku_name = "S0"
    }
  }
}
```

See [`examples/basic`](examples/basic).

## Inputs

### `spring_cloud_services`

| Field | Type | Required | Notes |
| --- | --- | --- | --- |
| `name` | `string` | yes | |
| `sku_name` | `string` | no | Default `"S0"`. |
| `zone_redundant` | `bool` | no | Default `false`. |
| `network` | `any` | no | See [`azurerm_spring_cloud_service` docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/spring_cloud_service) for the `network` block schema. |
| `config_server_git_setting` | `any` | no | See upstream docs for the block schema. |
| `trace` | `any` | no | See upstream docs for the block schema. |
| `tags` | `map(string)` | no | Overrides the module-level `tags` for this entry only. |

## Outputs

- `spring_cloud_services` -- map (same keys as the input) of the created `azurerm_spring_cloud_service` resources.
