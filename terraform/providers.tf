terraform {
  required_version = ">= 1.5.7"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.80.0"  # Pinned stable version
    }
  }
  backend "gcs" {
    bucket = "task9-tf-state"  # Must exist beforehand
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = "${var.region}-a"
}