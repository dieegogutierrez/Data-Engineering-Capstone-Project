variable "credentials" {
  description = "My Credentials"
  default     = "/root/service_account.json"
}

variable "project" {
  description = "Project"
}

variable "region" {
  description = "Region"
}

variable "location" {
  description = "Project Location"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}