output "servers" {
  value = [
    {
      name  = vkcs_compute_instance.devops1.name,
      fip   = vkcs_networking_floatingip.fip1.address
    },
    {
      name  = vkcs_compute_instance.devops2.name,
      fip   = vkcs_networking_floatingip.fip2.address
    }
  ]
  sensitive = true
}

output "db_cluster" {
  value     = vkcs_db_cluster.psql-cluster
  sensitive = true
}

output "loadbalancer_floating_ip" {
  value = vkcs_networking_floatingip.lb_fip.address
  sensitive = true
}
