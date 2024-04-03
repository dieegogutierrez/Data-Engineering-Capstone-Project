terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.6.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
}

# Change the name of your storage bucket
resource "google_storage_bucket" "gcs_bucket_name" {
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true


  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

# Change the name of your bigquery dataset
resource "google_bigquery_dataset" "bq_dataset_name" {
  dataset_id = var.bq_dataset_name
  location   = var.location
}