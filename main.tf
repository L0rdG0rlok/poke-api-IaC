terraform {
  cloud {
    organization = "shart-demo-org"

    workspaces {
      name = "shart-demo-workspace"
    }
  }
}

provider "google" {
  credentials = var.gcp_credentials
  project     = var.project_id
  region      = var.region
}

data "google_client_config" "provider" {}

provider "kubernetes" {
  host                   = "https://${module.gke_cluster.cluster_endpoint}"
  token                  = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(module.gke_cluster.cluster_ca_certificate)
}

module "gke_cluster" {
  source  = "./modules/gke_cluster"
  cluster_name = var.cluster_name
  region = var.region
  project_id = var.project_id
}
