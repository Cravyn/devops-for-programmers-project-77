resource "vkcs_networking_floatingip" "lb_fip" {
  pool        = data.vkcs_networking_network.extnet.name
  sdn         = "sprut"

  depends_on  = [
    vkcs_networking_router_interface.router_interface
  ]
}

resource "vkcs_networking_floatingip" "fip1" {
  pool        = data.vkcs_networking_network.extnet.name
  sdn         = "sprut"

  depends_on  = [
    vkcs_networking_router_interface.router_interface
  ]
}

resource "vkcs_networking_floatingip" "fip2" {
  pool        = data.vkcs_networking_network.extnet.name
  sdn         = "sprut"

  depends_on  = [
    vkcs_networking_router_interface.router_interface
  ]
}

resource "vkcs_networking_floatingip_associate" "lb_fip_assoc" {
  floating_ip = vkcs_networking_floatingip.lb_fip.address
  port_id     = vkcs_lb_loadbalancer.devops_loadbalancer.vip_port_id
  
  depends_on  = [
    vkcs_networking_router_interface.router_interface
  ]
}

resource "vkcs_compute_floatingip_associate" "fip1_association" {
  floating_ip = vkcs_networking_floatingip.fip1.address
  instance_id = vkcs_compute_instance.devops1.id
  
  depends_on  = [
    vkcs_networking_router_interface.router_interface
  ]
}

resource "vkcs_compute_floatingip_associate" "fip2_association" {
  floating_ip = vkcs_networking_floatingip.fip2.address
  instance_id = vkcs_compute_instance.devops2.id

  depends_on  = [
    vkcs_networking_router_interface.router_interface
  ]
}
