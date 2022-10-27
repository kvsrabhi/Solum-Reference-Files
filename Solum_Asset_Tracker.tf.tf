# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create Resource Group
resource "azurerm_resource_group" "assetrg" {
  name     = "slm-asset-tracker-00"
  location = "Korea Central"
}

# Create AKS Cluster
resource "azurerm_kubernetes_cluster" "assetaks" {
  name                = "slm-asset-tracker-aks-00"
  location            = azurerm_resource_group.assetrg.location
  resource_group_name = azurerm_resource_group.assetrg.name
  dns_prefix          = "assetaksdns"

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
resource "azurerm_storage_account" "assetstorageaccount" {
  name                     = "slmassettrackerstorage00"
  resource_group_name      = azurerm_resource_group.assetrg.name
  location                 = azurerm_resource_group.assetrg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# create Azure Storage Container
resource "azurerm_storage_container" "assetstoragecontainer1" {
  name                  = "slm-asset-tracker-checkpoint-lms"
  storage_account_name  = azurerm_storage_account.assetstorageaccount.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "assetstoragecontainer2" {
  name                  = "slm-asset-tracker-checkpoint-ams"
  storage_account_name  = azurerm_storage_account.assetstorageaccount.name
  container_access_type = "private"
}
resource "azurerm_storage_container" "assetstoragecontainer3" {
  name                  = "slm-asset-tracker-checkpoint-db-outbound"
  storage_account_name  = azurerm_storage_account.assetstorageaccount.name
  container_access_type = "private"
}

# Create Azure EventHub Namespace
resource "azurerm_eventhub_namespace" "asseteventhubnamespace" {
  name                = "slm-asset-tracker-eventhub-00"
  location            = azurerm_resource_group.assetrg.location
  resource_group_name = azurerm_resource_group.assetrg.name
  sku                 = "Standard"
  capacity            = 1
}

# Create EventHub
resource "azurerm_eventhub" "asseteventhub" {
  name                = "asset-tracker-dataserver"
  namespace_name      = azurerm_eventhub_namespace.asseteventhubnamespace.name
  resource_group_name = azurerm_resource_group.assetrg.name
  partition_count     = 5
  message_retention   = 7
}

# Create EventHub Consumer Group
resource "azurerm_eventhub_consumer_group" "assetecg1" {
  name                = "lms"
  namespace_name      = azurerm_eventhub_namespace.asseteventhubnamespace.name
  eventhub_name       = azurerm_eventhub.asseteventhub.name
  resource_group_name = azurerm_resource_group.assetrg.name
}

resource "azurerm_eventhub_consumer_group" "assetecg2" {
  name                = "ams"
  namespace_name      = azurerm_eventhub_namespace.asseteventhubnamespace.name
  eventhub_name       = azurerm_eventhub.asseteventhub.name
  resource_group_name = azurerm_resource_group.assetrg.name
}

resource "azurerm_eventhub_consumer_group" "assetecg3" {
  name                = "db-outbound"
  namespace_name      = azurerm_eventhub_namespace.asseteventhubnamespace.name
  eventhub_name       = azurerm_eventhub.asseteventhub.name
  resource_group_name = azurerm_resource_group.assetrg.name
}

# Create Azure Container Registry
resource "azurerm_container_registry" "assetacr" {
  name                = "slmassettrackeracr00"
  resource_group_name = azurerm_resource_group.assetrg.name
  location            = azurerm_resource_group.assetrg.location
  sku                 = "Basic"
  admin_enabled       = false
}