resource "azurerm_resource_group" "rg" {

  name     = "${var.tfResourceGroup}"

  location = "${var.tfRgLocation}"

}


resource "azurerm_cosmosdb_account" "ac" {

  name                = "${var.tfCosmosAC}"

  location            = azurerm_resource_group.rg.location

  resource_group_name = azurerm_resource_group.rg.name

  offer_type          = "Standard"




  enable_automatic_failover = true


  consistency_policy {

    consistency_level       = "BoundedStaleness"

    max_interval_in_seconds = 300

    max_staleness_prefix    = 100000

  }


  geo_location {

    location          = "eastus"

    failover_priority = 1

  }


  geo_location {

    location          = "westus"

    failover_priority = 0

  }

}




resource "azurerm_cosmosdb_sql_database" "db" {

  name                = "${var.tfCosmosDb}"

  resource_group_name = azurerm_resource_group.rg.name

  account_name        = azurerm_cosmosdb_account.ac.name

  throughput          = 400

}
