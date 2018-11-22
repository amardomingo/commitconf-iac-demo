
resource "google_compute_network" "network" {
  name                    = "${var.network_name}"
  description             = "${var.network_description}"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "frontend-http" {
  name    = "${var.frontend_name}-http"
  network = "${google_compute_network.network.name}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["frontend"]
  source_ranges = ["0.0.0.0/0"]
}

