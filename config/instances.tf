resource "google_compute_instance" "frontend" {
  name         = "demo-frontend-${count.index}"
  count        = "2"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-c"

  tags = ["commitconf", "frontend"]

  boot_disk {
    initialize_params {
      image = "commitconf-frontend-1542749301"
    }
  }

  network_interface {
    network = "${google_compute_network.network.name}"
  }

  metadata {
    role = "frontend"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

resource "google_compute_instance_group" "frontends" {
  name        = "demo-frontend-servers"
  description = "Commit Conf terraform demo"

  instances = ["${google_compute_instance.frontend.*.self_link}"]

  named_port {
    name = "http"
    port = "80"
  }

  zone = "europe-west1-c"
}

module "gce-lb-http" {
  source            = "GoogleCloudPlatform/lb-http/google"
  name              = "demo-frontend-http-lb"
  region            = "europe-west1"
  target_tags       = ["frontend"]
  backends          = {
    "0" = [
      { group = "${google_compute_instance_group.frontends.self_link}" }
    ],
  }
  backend_params    = [
    # health check path, port name, port number, timeout seconds.
    "/,http,80,10"
  ]
}

output "lb-ip" {
  value = "LB IP: ${module.gce-lb-http.external_ip}"
}
