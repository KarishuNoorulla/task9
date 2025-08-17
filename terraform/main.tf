# Minimal VPC configuration
resource "google_compute_network" "vpc" {
  name                    = "task9-vpc"
  auto_create_subnetworks = false
  delete_default_routes_on_create = true
}

resource "google_compute_subnetwork" "subnet" {
  name          = "task9-subnet"
  ip_cidr_range = "10.10.0.0/24"
  region        = var.region
  network       = google_compute_network.vpc.id
}