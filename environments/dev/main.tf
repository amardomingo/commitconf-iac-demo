
provider "google" {
  project = "mm-cc-demo"
  region  = "europe-west1"
  
}

/*
 * Store the tfstate in google cloud
 */
terraform {
  backend "gcs" {
    bucket  = "mm-cc-tfstates"
    prefix  = "states/commitconf/dev"
    project = "mm-cc-demo"
    region  = "europe-west1"
  }
}

module "frontends" {
  source = "../../config"
  gcp_project_id     = "mm-cc-demo"

  frontend_name      = "dev-frontend"
  image_name         = "commitconf-frontend-1542911402"
  network_name       = "dev"
}

output "lb-ip" {
  value = "LB IP: ${module.frontends.lb-ip}"
}
