terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  # Stan Terraforma w GCS (odpowiednik Azure Blob Storage)
  backend "gcs" {
    bucket = "tfstate-plated-analyzer-495108-v2"
    prefix = "gke/terraform.tfstate"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# GKE Cluster (odpowiednik AKS)
resource "google_container_cluster" "gke" {
  name     = var.cluster_name
  location = var.region

  # Wymagane przez GCP — usuwamy domyślny node pool i tworzymy własny
  remove_default_node_pool = true
  initial_node_count       = 1

  deletion_protection = false
}

resource "google_container_node_pool" "workers" {
  name       = "workers"
  location   = var.region
  cluster    = google_container_cluster.gke.name
  node_count = var.worker_count

  node_config {
    machine_type = var.worker_machine_type
    disk_size_gb = 30
    disk_type    = "pd-standard"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      environment = "learning"
    }
  }
}
