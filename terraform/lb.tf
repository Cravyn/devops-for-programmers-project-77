resource "vkcs_lb_loadbalancer" "devops_loadbalancer" {
  name              = "devops_loadbalancer"
  vip_subnet_id     = vkcs_networking_subnet.devops_subnet.id
  availability_zone = var.availability_zone_name
}

resource "vkcs_lb_listener" "devops_listener" {
  protocol                  = "TERMINATED_HTTPS"
  protocol_port             = 443
  loadbalancer_id           = vkcs_lb_loadbalancer.devops_loadbalancer.id
  default_tls_container_ref = data.vkcs_keymanager_container.lb-cert.container_ref
}

resource "vkcs_lb_pool" "devops_pool" {
  protocol                  = "HTTP"
  lb_method                 = "ROUND_ROBIN"
  listener_id               = vkcs_lb_listener.devops_listener.id
}

resource "vkcs_lb_monitor" "devops_monitor" {
  pool_id     = vkcs_lb_pool.devops_pool.id
  type        = "TCP"
  delay       = 5
  timeout     = 3
  max_retries = 3
}

resource "vkcs_lb_member" "devops_members" {
  count         = 2
  address       = element([vkcs_compute_instance.devops1.network[0].fixed_ip_v4, vkcs_compute_instance.devops2.network[0].fixed_ip_v4], count.index)
  protocol_port = var.redmine_port
  pool_id       = vkcs_lb_pool.devops_pool.id
  subnet_id     = vkcs_networking_subnet.devops_subnet.id
  weight        = 1
}