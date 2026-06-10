locals {
  project_id       = "s123"
  service_offering = "Service offering name"
  product          = "Producg name"
  source           = "terraform"
  location         = "westeurope"

  prefix = "${local.project_id}${var.environment_id}"

  common_tags = {
    "Environment"      = var.environment
    "Service Offering" = local.service_offering
    "Product"          = local.product
    "Source"           = local.source
    "Context"          = var.context
  }
}