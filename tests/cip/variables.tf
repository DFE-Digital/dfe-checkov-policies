variable "environment" {
  type        = string
  description = "Top-level infrastructure environment aligned to the Azure subscription boundary (e.g. production subscription, non-production subscription)."
}

variable "context" {
  type        = string
  description = "Logical sub-environment within a subscription, such as staging or production workloads hosted in the same subscription."
}

variable "environment_id" {
  type        = string
  description = "Short instance identifier used in resource naming (e.g. d01, d02 for development instances; p01, p02 for production or staging instances)."
}