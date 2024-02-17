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
}

