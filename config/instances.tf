resource "google_compute_instance" "frontend" {
  name         = "${var.frontend_name}-${count.index}"
  count        = "${var.frontend_count}"
  machine_type = "${var.frontend_type}"
  zone         = "${var.zone}"

  tags = "${var.frontend_tags}"

  boot_disk {
    initialize_params {
      image = "${var.image_name}"
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
  name        = "${var.frontend_name}-servers"
  description = "Commit Conf terraform demo"

  instances = ["${google_compute_instance.frontend.*.self_link}"]

  named_port {
    name = "http"
    port = "80"
  }

  zone = "${var.zone}"
}

module "gce-lb-http" {
  source            = "GoogleCloudPlatform/lb-http/google"
  name              = "${var.frontend_name}-http-lb"
  region            = "${var.region}"
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

