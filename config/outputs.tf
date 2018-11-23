output "lb-ip" {
  value = "${module.gce-lb-http.external_ip}"
}
