terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 4.38.0"
    }
    dome9 = {
      source = "dome9/dome9"
      version = "1.28.5"
    }
  }
}

provider "google" {
  project     = var.gcp-project
  region      = var.gcp-region
  credentials = var.gcp-credentials
}
provider "dome9" {
  dome9_access_id   = var.cspm-key-id
  dome9_secret_key  = var.cspm-key-secret
  base_url = lookup(var.chkp-account-region-list, var.chkp-account-region)[0]
}