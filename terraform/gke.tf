resource "google_container_cluster" "primary" {
  name     = "task9-gke-cluster"
  location = var.region  # Use zonal cluster for faster provisioning
  
  # Minimal configuration
  initial_node_count = 1
  networking_mode = "VPC_NATIVE"
  network = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  # Disable unnecessary features
  enable_shielded_nodes = false
  enable_legacy_abac = false

  # Faster node pool configuration
  node_config {
    machine_type = "e2-medium"  # Cheaper and faster to provision
    disk_size_gb = 30
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  # Reduce timeout thresholds
  timeouts {
    create = "15m"
    update = "10m"
    delete = "10m"
  }
}