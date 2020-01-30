terraform {
  backend "gcs" {
    bucket = "long-state-260200-tfstate"
    credentials = "../long-state-260200-391bbf46e2b1.json"
  }
}
