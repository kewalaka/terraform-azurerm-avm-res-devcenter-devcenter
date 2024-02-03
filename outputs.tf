# Module owners should include the full resource via a 'resource' output
# https://azure.github.io/Azure-Verified-Modules/specs/terraform/#id-tffr2---category-outputs---additional-terraform-outputs
output "resource" {
  value       = azurerm_dev_center.this
  description = "This is the full output for the resource."
}

output "id" {
  description = "The ID of the resource."
  value       = azurerm_dev_center.this.id
}

output "name" {
  description = "The name of the resource"
  value       = azurerm_dev_center.this.id
}
