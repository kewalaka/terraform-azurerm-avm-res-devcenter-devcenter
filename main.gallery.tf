resource "azurerm_dev_center_gallery" "this" {
  for_each = var.galleries

  dev_center_id = azurerm_dev_center.this.id
  # use the map key as the name of the resource
  name              = each.key
  shared_gallery_id = each.value.shared_gallery_id

  dynamic "timeouts" {
    for_each = each.value.timeouts == null ? [] : [each.value.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
    }
  }

  lifecycle {
    precondition {
      condition     = length(var.galleries) == 0 || (length(var.managed_identities.user_assigned_resource_ids) > 0 || var.managed_identities.system_assigned)
      error_message = "If specifying any gallery resources, the dev center must be configured with either a user assigned or system assigned managed identity."
    }
  }
}

