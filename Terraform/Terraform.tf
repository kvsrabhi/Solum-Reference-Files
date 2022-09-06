terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.21.1"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "satrg" {
  name     = "solum-asset-tracker"
  location = "Korea Central"
}

resource "azurerm_kubernetes_cluster" "satakscluster" {
  name                = "solum-asset-tracker-akscluster"
  location            = azurerm_resource_group.satrg.location
  resource_group_name = azurerm_resource_group.satrg.name
  dns_prefix          = "sataksdns"

  default_node_pool {
    name       = "satnodepool"
    node_count = 2
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "sat"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.satakscluster.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.satakscluster.kube_config_raw
  sensitive = true
}

resource "azurerm_storage_account" "satstorage" {
  name                     = "satstorageaccount12345"
  resource_group_name      = azurerm_resource_group.satrg.name
  location                 = azurerm_resource_group.satrg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "satstorage"
  }
}

resource "azurerm_storage_container" "satstoragecontainer" {
  name                  = "sat-storage-container12345"
  storage_account_name  = azurerm_storage_account.satstorage.name
  container_access_type = "private"
}

resource "azurerm_eventhub_namespace" "sateventhubnamespace" {
  name                = "sat-event-hub-namespace"
  location            = azurerm_resource_group.satrg.location
  resource_group_name = azurerm_resource_group.satrg.name
  sku                 = "Standard"
  capacity            = 1

  tags = {
    environment = "sateventhub"
  }
}

resource "azurerm_eventhub" "sateventhub" {
  name                = "sat-eventhub1"
  namespace_name      = azurerm_eventhub_namespace.sateventhubnamespace.name
  resource_group_name = azurerm_resource_group.satrg.name
  partition_count     = 10
  message_retention   = 2
}