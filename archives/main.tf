
terraform {
  backend "gcs" {
    bucket  = "YOUR_BUCKET_NAME"
 prefix  = "terraform/state"
  }
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.53.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region

  zone        = var.zone
}

module "instances" {

  source     = "./modules/instances"

}

module "storage" {
  source     = "./modules/storage"
}

module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 6.0.0"

    project_id   = "YOUR_PROJECT_ID"
    network_name = "YOUR_VPC_NAME"
    routing_mode = "GLOBAL"

    subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "us-east1"
        },
        {
            subnet_name           = "subnet-02"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = "us-east1"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "Please like share & subscribe"
        },
    ]
}



resource "google_compute_firewall" "tf-firewall"{
  name    = "tf-firewall"
 network = "projects/YOUR_PROJECT_ID/global/networks/YOUR_VPC_NAME"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_tags = ["web"]
  source_ranges = ["0.0.0.0/0"]
}

