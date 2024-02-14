resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  remove_default_node_pool = true
  initial_node_count = 1
  deletion_protection = false

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true 
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  master_authorized_networks_config {

  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count

  node_config {
    preemptible  = false
    machine_type = "e2-medium"
  }
}