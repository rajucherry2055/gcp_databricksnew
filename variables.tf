
variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "bucket_prefix" {
  description = "Globally unique lowercase bucket prefix"
  type        = string

  validation {
    condition = (
      length(var.bucket_prefix) >= 3 &&
      length(var.bucket_prefix) <= 40 &&
      can(regex("^[a-z0-9][a-z0-9-]*[a-z0-9]$", var.bucket_prefix))
    )
    error_message = "Use 3-40 lowercase letters, numbers, or hyphens; start and end with a letter or number."
  }
}

variable "service_account_key_file" {
  description = "Optional path to a Google Cloud service account JSON key file"
  type        = string
  default     = null
  sensitive   = true
}
