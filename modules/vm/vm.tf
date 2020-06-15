resource "google_compute_instance" "default" {
  project      = "enrichme-bbfde"
  name         =  var.vm_name
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["stack", "purpose"]

  lifecycle {
    create_before_destroy = true
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

    service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"
}