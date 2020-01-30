
# Cria uma VM no Google Cloud
resource "google_compute_instance" "helloworld" {
  name         = "helloworld"
  machine_type = var.tier1
  zone         = var.zone

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
  #Conexão SSH para validar Conectividade
  provisioner "remote-exec" {
    inline = ["echo 'Liberado para o Ansible'"]
    connection {
      type        = "ssh"
      user        = "jean.aps12"
     # private_key = file("../id_rsa")
      host        = google_compute_instance.helloworld.network_interface.0.access_config.0.nat_ip
      timeout     = "90s"
    }
  }

  # Cria o inventário do Ansible
  provisioner "local-exec" {
    command = "echo ${google_compute_instance.helloworld.network_interface.0.access_config.0.nat_ip} > ansible/inventory"
  }

  # Executa a playbook na máquina provisionada
  provisioner "local-exec" {
    command = "ansible-playbook -i ansible/inventory --private-key ../id_rsa ansible/playbook.yml"
  }
}
#----------------------------------------------
# Cria SQL Gerenciado com Engine MySQL 
resource "google_sql_database_instance" "wordpressdb" {
  name             = "database-1"
  database_version = var.db-version
  region           = var.region
  settings {
    tier = "db-${var.tier1}"
  }
}

resource "google_sql_user" "userwp" {
  name     = "wordpress"
  instance = google_sql_database_instance.wordpressdb.name
  host     = "wordpress"
  password = "wordpress"
}

