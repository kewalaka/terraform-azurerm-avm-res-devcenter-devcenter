variable "galleries" {
  type = map(object({
    shared_gallery_id = string
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
    }))
  }))
  description = <<-EOT
  - `shared_gallery_id` - (Required) The ID of the Shared Gallery which should be connected to the Dev Center Gallery. Changing this forces a new Dev Center Gallery to be created.

 ---
 `timeouts` block supports the following:
 - `create` - (Defaults to 30 minutes) Used when creating this Dev Center Gallery.
 - `delete` - (Defaults to 30 minutes) Used when deleting this Dev Center Gallery.
 - `read` - (Defaults to 5 minutes) Used when retrieving this Dev Center Gallery.
EOT
  nullable    = false
  default     = {}
}
