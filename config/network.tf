
resource "google_compute_network" "network" {
  name                    = "demo"
  description             = "Demo network for the Commit Conf"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "frontend-http" {
  name    = "demo-frontend-http"
  network = "${google_compute_network.network.name}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["frontend"]
  source_ranges = ["0.0.0.0/0"]
}
