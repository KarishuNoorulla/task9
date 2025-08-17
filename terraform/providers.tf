terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
  backend "gcs" {
    bucket = "YOUR_BUCKET_NAME"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
