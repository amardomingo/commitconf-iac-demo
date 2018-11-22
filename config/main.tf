
provider "google" {
  project = "${var.gcp_project_id}"
  region  = "${var.region}"
  
}
/*
 * Store the tfstate in google cloud
 * Remember to load the config in terraform init
 * with --backend-config <config_file>
 */
terraform {
  backend "gcs" {}
}