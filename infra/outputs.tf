output "backend_url" {
  value       = google_cloud_run_v2_service.backend.uri
  description = "Cloud Run generated service URL."
}

output "gmail_pubsub_topic" {
  value       = google_pubsub_topic.gmail.id
  description = "Topic passed to Gmail users.watch."
}

output "kms_key_name" {
  value       = google_kms_crypto_key.oauth_tokens.id
  description = "KMS key used for OAuth token envelope encryption."
}

output "internal_caller_email" {
  value       = google_service_account.events.email
  description = "OIDC identity accepted by internal HTTP routes."
}
