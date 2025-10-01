data "vkcs_networking_network" "extnet" {
   name     = "internet"
   sdn      = "sprut"
   external = true
}

resource "vkcs_networking_network" "devops_net" {
   name       = "devops-terraform-net"
   sdn        = "sprut"
}

resource "vkcs_networking_subnet" "devops_subnet" {
   name       = "devops-terraform-subnet"
   network_id = vkcs_networking_network.devops_net.id
}

resource "vkcs_networking_router" "devops_router" {
   name                 = "devops-terraform-router"
   sdn                  = "sprut"
   external_network_id  = data.vkcs_networking_network.extnet.id
}

resource "vkcs_networking_router_interface" "router_interface" {
   router_id  = vkcs_networking_router.devops_router.id
   subnet_id  = vkcs_networking_subnet.devops_subnet.id
}
