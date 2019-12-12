# Retorno de IP Publico da Instancia
output "IP_Publico_da_VM" {
  value = "${google_compute_instance.helloworld.network_interface.0.access_config.0.nat_ip}"
}

# Retorno de IP Privado da Instacia
output "IP_Privado_da_VM" {
  value = "${google_compute_instance.helloworld.network_interface.0.network_ip}"
}

# Retorno de IP Privado da Instacia
output "Teste_saida" {
  value = "${google_compute_instance.helloworld.instance_id}"
}

