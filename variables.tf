variable "gcp_credentials" {
  description = "GCP service account key JSON credentials"
  type        = string
  sensitive   = true
}

variable "project_id" {}
variable "region" {}
variable "cluster_name" {}
variable "node_count" {
  default     = 1
}

variable "docker_login" {
  type = string
  sensitive = true
}
variable "docker_token" {
  type = string
  sensitive = true
}