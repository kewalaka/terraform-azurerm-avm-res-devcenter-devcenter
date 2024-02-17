terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0, < 4.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = ">= 0.3.0"
}

# This is required for resource modules
resource "azurerm_resource_group" "this" {
  name     = module.naming.resource_group.name_unique
  location = "australiaeast"
}

# this is a pre-requisite for adding a gallery to a dev center
resource "azurerm_shared_image_gallery" "this" {
  name                = module.naming.shared_image_gallery.name_unique
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

module "dev_center" {
  source = "../../"
  # source             = "Azure/avm-res-devcenter-devcenter/azurerm"
  # ...
  enable_telemetry    = var.enable_telemetry # see variables.tf
  name                = module.naming.dev_test_lab.name_unique
  resource_group_name = azurerm_resource_group.this.name

  galleries = {
    my-dev-center-gallery = {
      shared_gallery_id = azurerm_shared_image_gallery.this.id
    }
  }
}
