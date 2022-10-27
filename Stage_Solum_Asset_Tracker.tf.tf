# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create Resource Group
resource "azurerm_resource_group" "stage00assetrg" {
  name     = "stage00-slm-asset-tracker-00"
  location = "Korea Central"
}

# Create AKS Cluster
resource "azurerm_kubernetes_cluster" "stage00assetaks" {
  name                = "stage00-slm-asset-tracker-aks-00"
  location            = azurerm_resource_group.stage00assetrg.location
  resource_group_name = azurerm_resource_group.stage00assetrg.name
  dns_prefix          = "stage00assetaksdns"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2_v2"
  }
identity {
    type = "SystemAssigned"
  }
}
# Create Azure Storage Account
resource "azurerm_storage_account" "stage00assetstorageaccount" {
  name                     = "stage00slmassettracker"
  resource_group_name      = azurerm_resource_group.stage00assetrg.name
  location                 = azurerm_resource_group.stage00assetrg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# create Azure Storage Container
resource "azurerm_storage_container" "stage00assetstoragecontainer1" {
  name                  = "stage00-slm-asset-tracker-checkpoint-lms"
  storage_account_name  = azurerm_storage_account.stage00assetstorageaccount.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "stage00stage00assetstoragecontainer2" {
  name                  = "stage00-slm-asset-tracker-checkpoint-ams"
  storage_account_name  = azurerm_storage_account.stage00assetstorageaccount.name
  container_access_type = "private"
}
resource "azurerm_storage_container" "stage00assetstoragecontainer3" {
  name                  = "stage00-slm-asset-tracker-checkpoint-db-outbound"
  storage_account_name  = azurerm_storage_account.stage00assetstorageaccount.name
  container_access_type = "private"
}

# Create Azure EventHub Namespace
resource "azurerm_eventhub_namespace" "stage00asseteventhubnamespace" {
  name                = "stage00-slm-asset-tracker-eventhub-00"
  location            = azurerm_resource_group.stage00assetrg.location
  resource_group_name = azurerm_resource_group.stage00assetrg.name
  sku                 = "Standard"
  capacity            = 1
}

# Create EventHub
resource "azurerm_eventhub" "stage00asseteventhub" {
  name                = "stage00-asset-tracker-dataserver"
  namespace_name      = azurerm_eventhub_namespace.stage00asseteventhubnamespace.name
  resource_group_name = azurerm_resource_group.stage00assetrg.name
  partition_count     = 5
  message_retention   = 7
}

# Create EventHub Consumer Group
resource "azurerm_eventhub_consumer_group" "stage00assetecg1" {
  name                = "stage00-lms"
  namespace_name      = azurerm_eventhub_namespace.stage00asseteventhubnamespace.name
  eventhub_name       = azurerm_eventhub.stage00asseteventhub.name
  resource_group_name = azurerm_resource_group.stage00assetrg.name
}

resource "azurerm_eventhub_consumer_group" "stage00assetecg2" {
  name                = "stage00-ams"
  namespace_name      = azurerm_eventhub_namespace.stage00asseteventhubnamespace.name
  eventhub_name       = azurerm_eventhub.stage00asseteventhub.name
  resource_group_name = azurerm_resource_group.stage00assetrg.name
}

resource "azurerm_eventhub_consumer_group" "stage00assetecg3" {
  name                = "stage00-db-outbound"
  namespace_name      = azurerm_eventhub_namespace.stage00asseteventhubnamespace.name
  eventhub_name       = azurerm_eventhub.stage00asseteventhub.name
  resource_group_name = azurerm_resource_group.stage00assetrg.name
}

