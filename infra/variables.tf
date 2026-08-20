variable "project_id" {
  description = "Google Cloud project that also owns the Gmail OAuth client."
  type        = string
}

variable "region" {
  description = "Region for Cloud Run, KMS and Artifact Registry."
  type        = string
  default     = "asia-south1"
}

variable "backend_image" {
  description = "Immutable container image digest for the backend."
  type        = string
}

variable "public_base_url" {
  description = "HTTPS Cloud Run or custom-domain base URL, without a trailing slash."
  type        = string
}

variable "firestore_location" {
  description = "Firestore database location."
  type        = string
  default     = "asia-south1"
}
