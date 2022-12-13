variable "gcp-project" {
  type = string
  sensitive = true
  description = "used to define the project name"
} # Value set via Variable-Set in Terraform Cloud

variable "gcp-region" {
  type = string
  sensitive = false
  description = "used to define the region"
} # Value set via Variable-Set in Terraform Cloud

variable "gcp-credentials" {
  type = string
  sensitive = true
  description = "used to define the json key content"
} # Value set via Variable-Set in Terraform Cloud

variable "gcp-org-name" {
  description ="The Google organization on onboard"
  type = string
  default = "gbrembati.it"
}

variable "gcp-org-permissions" {
  description ="The list of Role necessary for the Service Account"
  type = list(string)
  default = [
    "roles/viewer",
    "roles/cloudasset.viewer",
    "roles/iam.securityReviewer" ]
}

variable "gcp-svc-list-mandatory" {
  description ="The list of mandatory APIs for a project"
  type = list(string)
  default = [
    "compute.googleapis.com",
    "cloudresourcemanager.googleapis.com"
  ]
} 
variable "gcp-svc-list-optional" {
  description ="The list of optional APIs for a project"
  type = list(string)
  default = [
    "container.googleapis.com",
    "cloudkms.googleapis.com",
    "iam.googleapis.com",
    "bigtableadmin.googleapis.com",
    "appengine.googleapis.com",
    "bigquery.googleapis.com",
    "admin.googleapis.com",
    "cloudfunctions.googleapis.com",
    "sqladmin.googleapis.com",
    "pubsub.googleapis.com",
    "redis.googleapis.com",
    "serviceusage.googleapis.com",
    "file.googleapis.com",
    "apikeys.googleapis.com",
    "logging.googleapis.com",
    "dns.googleapis.com",
    "cloudasset.googleapis.com",
    "essentialcontacts.googleapis.com",
    "accessapproval.googleapis.com"
  ]
} 

// --- CloudGuard Provider ---
variable "cspm-key-id" {
  description = "Insert your API Key ID"
  type = string
}
variable "cspm-key-secret" {
  description = "Insert your API Key Secret"
  type = string
  sensitive = true
}
variable "chkp-account-region-list" {
  description = "List of CloudGuard Account ID and API Endpoint"
  default = {
    America   = ["https://api.dome9.com/v2/"],
    Europe    = ["https://api.eu1.dome9.com/v2/"],
    Singapore = ["https://api.ap1.dome9.com/v2/"],
    Australia = ["https://api.ap2.dome9.com/v2/"],
    India     = ["https://api.ap3.dome9.com/v2/"]
  }
}
locals {
  allowed_region_name = ["Europe","America","Singapore","Australia","India"]
  validate_region_name = index(local.allowed_region_name, var.chkp-account-region)
}
variable "chkp-account-region" {
  description = "Insert your Cloudguard Account residency location"
  type = string
}