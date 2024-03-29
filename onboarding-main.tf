
resource "google_service_account" "checkpoint-sa" {
  account_id   = "cloudguard-cnapp-sa"
  display_name = "CloudGuard CNAPP Service Account"
}
resource "google_service_account_key" "checkpoint-sa-key" {
  service_account_id = google_service_account.checkpoint-sa.name
}

data "google_organization" "google-org" {
  domain = var.gcp-org-name
}

resource "google_organization_iam_binding" "checkpoint-sa-org-permissions" {
  for_each = toset(var.gcp-org-permissions)
  org_id   = data.google_organization.google-org.org_id
  role     = each.key

  members  = [ "serviceAccount:${google_service_account.checkpoint-sa.email}" ]
}

data "google_projects" "google-org-projects" {
  filter = "lifecycleState:ACTIVE"
}

module "gcp-svc-mandatory" {
  for_each    = { for project in toset(data.google_projects.google-org-projects.projects) : project.name => project } 
  source    = "terraform-google-modules/project-factory/google//modules/project_services"

  project_id    = each.value.project_id
  activate_apis = var.gcp-svc-list-mandatory
  disable_dependent_services  = false
  disable_services_on_destroy = false
}

module "gcp-svc-optional" {
  for_each    = { for project in toset(data.google_projects.google-org-projects.projects) : project.name => project } 
  source    = "terraform-google-modules/project-factory/google//modules/project_services"

  project_id    = each.value.project_id
  activate_apis = var.gcp-svc-list-optional
  disable_dependent_services  = false
  disable_services_on_destroy = false
}

resource "local_sensitive_file" "checkpoint-sa-key-json" {
    content  = base64decode(google_service_account_key.checkpoint-sa-key.private_key)
    filename = "${path.module}/checkpoint-sa-key.json"
}

resource "dome9_cloudaccount_gcp" "connect-gcp-project" {
  for_each    = { for project in toset(data.google_projects.google-org-projects.projects) : project.name => project } 
  
  name                 = each.value.name 
  project_id           = each.value.project_id
  private_key_id       = jsondecode(base64decode(google_service_account_key.checkpoint-sa-key.private_key)).private_key_id
  private_key          = jsondecode(base64decode(google_service_account_key.checkpoint-sa-key.private_key)).private_key
  client_email         = jsondecode(base64decode(google_service_account_key.checkpoint-sa-key.private_key)).client_email
  client_id            = jsondecode(base64decode(google_service_account_key.checkpoint-sa-key.private_key)).client_id
  client_x509_cert_url = jsondecode(base64decode(google_service_account_key.checkpoint-sa-key.private_key)).client_x509_cert_url

  depends_on = [module.gcp-svc-mandatory, google_organization_iam_binding.checkpoint-sa-org-permissions]
}