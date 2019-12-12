
# Cria uma VM no Google Cloud
resource "google_compute_instance" "helloworld" {
  name         = "helloworld"
  machine_type = var.tier1
  zone         = var.lowa

  # Defini a Imagem da VM
  boot_disk {
    initialize_params {
      image = var.ubuntu18
    }
  }

  # Habilita rede para a VM com um IP público
  network_interface {
    network = "default"
    access_config {
    }
  }
}

# Cria SQL Gerenciado com Engine MySQL 
resource "google_sql_database_instance" "helloworld" {
  name             = "database2"
  database_version = var.db-version
  region           = var.lowa

  settings {
    tier = "db-${var.tier1}"    
  }
}
