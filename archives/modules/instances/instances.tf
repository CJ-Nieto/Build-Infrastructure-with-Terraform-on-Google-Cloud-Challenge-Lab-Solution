
resource "google_compute_instance" "tf-instance-1" {
  name         = "tf-instance-1"
  machine_type = "e2-standard-2"
  zone         = "YOUR_ZONE"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11" #Si no se encuentra disponible la imagen seleccionar otra
    }
  }

  network_interface {
    network = "YOUR_VPC_NAME"
     subnetwork = "subnet-01"
  }
  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
}

resource "google_compute_instance" "tf-instance-2" {
  name         = "tf-instance-2"
  machine_type = "e2-standard-2"
  zone         = "YOUR_ZONE"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11" #Si no se encuentra disponible la imagen seleccionar otra
    }
  }

  network_interface {
    network = "YOUR_VPC_NAME"
     subnetwork = "subnet-02"
  }
  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
}

resource "google_compute_instance" "YOUR_INSTANCE_NAME" {
  name         = "YOUR_INSTANCE_NAME"
  machine_type = "e2-standard-2"
  zone         = "YOUR_ZONE"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11" #Si no se encuentra disponible la imagen seleccionar otra
    }
  }

  network_interface {
    network = "YOUR_VPC_NAME"
     subnetwork = "subnet-02"
  }
  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
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
            subnet_region         = "YOUR_REGION"
        },
        {
            subnet_name           = "subnet-02"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = "YOUR_REGION"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "Please like share & subscribe"
        },
    ]
}

