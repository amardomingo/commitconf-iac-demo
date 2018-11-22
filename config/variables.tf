
variable gcp_project_id {
  type        = "string"
  description = "Google Cloud Project to use"
  default     = ""
}

variable region {
  type        = "string"
  description = "GCP region"
  default     = "europe-west1"
}
variable zone {
  type        = "string"
  description = "GCP default zone"
  default     = "europe-west1-c"
}

variable create_bucket {
  description = "Wether we should create the bucket for the tfstate" 
  default     = "true"
}

/**
 * Frontend configuration.
 */
variable frontend_name {
  type        = "string"
  description = "The base name for the frontend instances"
  default     = "frontend"
}

variable frontend_count {
  type        = "string"
  description = "The number of frontend instances to create"
  default     = "2"
}

variable frontend_type {
  type        = "string"
  description = "The frontend instance size" 
  default     = "n1-standard-1"
}

variable "image_name" {
  type        = "string"
  description = "The VM image to use for the frontend"
  default     = "commitconf-frontend-1542749301"  
}


variable frontend_tags {
  type        = "list"
  description = "The network tags for the frontend"
  default     = [
    "commitconf",
    "frontend"
  ]  
}

variable frontend_image {
  type        = "string"
  description = "The image for the frontend instance" 
  default     = "commitconf-frontend-1542749301"
}

/*
 * Network configuration
 */

variable network_name {
  type        = "string"
  description = "The name for the network"
  default     = "default"
}
variable network_description {
  type        = "string"
  description = "The description for the network"
  default     = "Default network for the project"
}
