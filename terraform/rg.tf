resource "azurerm_resource_group" "rg" {
  name     = join("-", ["myTFResourceGroup", var.environment])
  location = "norwayeast"
}

