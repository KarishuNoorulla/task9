resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  
  # Minimal cluster configuration
  initial_node_count = 1
  networking_mode    = "VPC_NATIVE"
  network           = google_compute_network.vpc.name
  subnetwork        = google_compute_subnetwork.subnet.name

  # Cost-optimized node configuration
  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 30
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    labels = {
      environment = "prod"
    }
  }

  # Disable unnecessary features
  enable_shielded_nodes       = false
  enable_legacy_abac         = false
  remove_default_node_pool    = false
  default_max_pods_per_node  = 32

  timeouts {
    create = "30m"
    update = "20m"
    delete = "20m"
  }
}