data "vkcs_compute_flavor" "db" {
  name = var.psql-cluster-flavor
}

resource "vkcs_db_cluster" "psql-cluster" {
  name          = "psql-cluster"
  cluster_size  = 3
  flavor_id     = data.vkcs_compute_flavor.db.id
  volume_size   = 50
  volume_type   = "ceph-ssd"
  datastore {
    type        = "postgresql"
    version     = "17"
  }
  network {
    uuid        = vkcs_networking_network.devops_net.id
  }  
  depends_on    = [
    vkcs_networking_router_interface.router_interface
  ]
}

resource "vkcs_db_database" "db-database" {
  name              = var.pg_database
  dbms_id           = vkcs_db_cluster.psql-cluster.id
  charset           = "utf8"
  vendor_options {
    force_deletion  = true
  }
}

resource "vkcs_db_user" "db-user" {
  name      = var.pg_username
  password  = var.pg_password
  dbms_id   = vkcs_db_cluster.psql-cluster.id
  databases = [vkcs_db_database.db-database.name]
  vendor_options {
    skip_deletion  = true
  }
}