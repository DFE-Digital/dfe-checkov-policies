locals {
  project_id          = "s123"
  project_short_code  = "dm"
  service_offering    = "Service offering name"
  product             = "Product name"
  source              = "terraform"
  location            = "uksouth"
  location_short_code = "uks"

  prefix         = "${local.project_id}${var.environment_id}"
  service_prefix = "${local.prefix}-${local.location_short_code}-${local.project_short_code}"

  common_tags = {
    "Environment"      = var.environment
    "Service Offering" = local.service_offering
    "Product"          = local.product
    "Source"           = local.source
    "Context"          = var.context
  }
}