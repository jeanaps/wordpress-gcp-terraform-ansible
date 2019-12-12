# Configura o Provider Google Cloud com o Projeto
provider "google" {
  credentials = file("/vagrant/long-state-260200-391bbf46e2b1.json")
  project     = var.project 
  region      = var.lowa
}
