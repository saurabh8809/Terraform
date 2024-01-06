terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.74.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-state"
    storage_account_name = "terraformstate321"
    container_name       = "tfstate"
    key                  = "test/terraform.tfstate"
  }
}

provider "azurerm" { 
  features {}
}

resource "azurerm_resource_group" "main-create-rg" {
  location = var.location
  name = var.rg-name
}

resource "azurerm_virtual_network" "this" {
  name = var.vnet-name
  resource_group_name = azurerm_resource_group.main-create-rg.name
  location = azurerm_resource_group.main-create-rg.location
  address_space = ["192.168.1.0/24"]
}

# resource "azurerm_subnet" "this" {
#   name = "subnet1"
#   resource_group_name = azurerm_resource_group.terraform-rg.name
#   virtual_network_name = azurerm_virtual_network.this.name
#   address_prefixes = ["192.168.1.0/25"]
  
# }

# resource "azurerm_subnet" "main" {
#   name = "subnet2"
#   resource_group_name = azurerm_resource_group.terraform-rg.name
#   virtual_network_name = azurerm_virtual_network.this.name
#   address_prefixes = ["192.168.1.128/25"]
  
# }

# resource "azurerm_public_ip" "this" {
#   name = "terraform-vm-public-ip"  
#   location = azurerm_resource_group.terraform-rg.location
#   allocation_method = "Static"
#   resource_group_name = azurerm_resource_group.terraform-rg.name
# }

# resource "azurerm_network_interface" "this" {
#   name = "terraform-nic"
#   resource_group_name = azurerm_resource_group.terraform-rg.name
#   location = azurerm_resource_group.terraform-rg.location
#   ip_configuration {
#     name = "terraform-ip_configuration"
#     subnet_id = azurerm_subnet.main.id
#     private_ip_address_allocation = "Dynamic"
#     # public_ip_address_id = azurerm_public_ip.this.ip_address

#   }
# }

# resource "azurerm_network_security_group" "this" {
#   name = "terrafrom-vm-nsg"
#   resource_group_name = azurerm_resource_group.terraform-rg.name
#   location = azurerm_resource_group.terraform-rg.location
# }

# resource "azurerm_network_security_rule" "this" {
#   resource_group_name = azurerm_resource_group.terraform-rg.name
#   network_security_group_name = azurerm_network_security_group.this.name
#   name                        = "allow-ssh"
#   priority                    = 100
#   direction                   = "Outbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "22"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
  
# }

# resource "azurerm_linux_virtual_machine" "this" {
#   name = "terraform-vm"
#   resource_group_name = azurerm_resource_group.terraform-rg.name
#   location = azurerm_resource_group.terraform-rg.location
#   size = "Standard_A1_v2"
#   admin_username = "deb"
#   admin_ssh_key {
#     username = "deb"
#     public_key = file("~/.ssh/id_rsa.pub")
#   }

#   network_interface_ids = [ azurerm_network_interface.this.id ]
#   # network_interface_ids = azurerm_network_interface.this.id
#   os_disk {
#     caching = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }
#   source_image_reference {
#     publisher = "Canonical"
#     offer = "0001-com-ubuntu-server-jammy"
#     sku = "22_04-lts"
#     version = "latest"
#   }

# }

# output "public_ip_address" {
#   value = azurerm_public_ip.this.ip_address
# }