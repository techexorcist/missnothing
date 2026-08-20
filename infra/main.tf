locals {
  service_name = "missnothing-backend"
  required_apis = toset([
    "artifactregistry.googleapis.com",
    "cloudkms.googleapis.com",
    "cloudscheduler.googleapis.com",
    "firestore.googleapis.com",
    "firebase.googleapis.com",
    "fcm.googleapis.com",
    "gmail.googleapis.com",
    "pubsub.googleapis.com",
    "run.googleapis.com",
    "secretmanager.googleapis.com",
  ])
}

resource "google_project_service" "required" {
  for_each           = local.required_apis
  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}

resource "google_firebase_project" "default" {
  provider = google-beta
  project  = var.project_id

  depends_on = [google_project_service.required]
}

resource "google_firestore_database" "default" {
  project                     = var.project_id
  name                        = "(default)"
  location_id                 = var.firestore_location
  type                        = "FIRESTORE_NATIVE"
  delete_protection_state     = "DELETE_PROTECTION_ENABLED"
  deletion_policy             = "ABANDON"
  app_engine_integration_mode = "DISABLED"

  depends_on = [google_project_service.required]
}

resource "google_service_account" "runtime" {
  project      = var.project_id
  account_id   = "missnothing-backend"
  display_name = "MissNothing backend runtime"
}

resource "google_service_account" "events" {
  project      = var.project_id
  account_id   = "missnothing-events"
  display_name = "MissNothing Pub/Sub and Scheduler caller"
}

resource "google_kms_key_ring" "backend" {
  name     = "missnothing"
  location = var.region

  depends_on = [google_project_service.required]
}

resource "google_kms_crypto_key" "oauth_tokens" {
  name            = "oauth-tokens"
  key_ring        = google_kms_key_ring.backend.id
  rotation_period = "7776000s"

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_crypto_key_iam_member" "runtime" {
  crypto_key_id = google_kms_crypto_key.oauth_tokens.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${google_service_account.runtime.email}"
}

resource "google_secret_manager_secret" "oauth_client_id" {
  project   = var.project_id
  secret_id = "missnothing-oauth-client-id"
  replication {
    auto {}
  }
  depends_on = [google_project_service.required]
}

resource "google_secret_manager_secret" "oauth_client_secret" {
  project   = var.project_id
  secret_id = "missnothing-oauth-client-secret"
  replication {
    auto {}
  }
  depends_on = [google_project_service.required]
}

resource "google_secret_manager_secret_iam_member" "runtime" {
  for_each = {
    client_id     = google_secret_manager_secret.oauth_client_id.id
    client_secret = google_secret_manager_secret.oauth_client_secret.id
  }
  project   = var.project_id
  secret_id = each.value
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.runtime.email}"
}

resource "google_project_iam_member" "runtime_firestore" {
  project = var.project_id
  role    = "roles/datastore.user"
  member  = "serviceAccount:${google_service_account.runtime.email}"
}

resource "google_project_iam_member" "runtime_fcm" {
  project = var.project_id
  role    = "roles/firebasecloudmessaging.admin"
  member  = "serviceAccount:${google_service_account.runtime.email}"
}

resource "google_pubsub_topic" "gmail" {
  project = var.project_id
  name    = "missnothing-gmail"

  depends_on = [google_project_service.required]
}

resource "google_pubsub_topic_iam_member" "gmail_publisher" {
  project = var.project_id
  topic   = google_pubsub_topic.gmail.name
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:gmail-api-push@system.gserviceaccount.com"
}

resource "google_cloud_run_v2_service" "backend" {
  project             = var.project_id
  name                = local.service_name
  location            = var.region
  deletion_protection = true
  ingress             = "INGRESS_TRAFFIC_ALL"

  template {
    service_account = google_service_account.runtime.email
    timeout         = "60s"

    scaling {
      min_instance_count = 0
      max_instance_count = 3
    }

    containers {
      image = var.backend_image

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
        cpu_idle = true
      }

      env {
        name  = "GOOGLE_CLOUD_PROJECT"
        value = var.project_id
      }
      env {
        name  = "PUBLIC_BASE_URL"
        value = var.public_base_url
      }
      env {
        name  = "GOOGLE_OAUTH_REDIRECT_URI"
        value = "${var.public_base_url}/v1/oauth/callback"
      }
      env {
        name  = "KMS_KEY_NAME"
        value = google_kms_crypto_key.oauth_tokens.id
      }
      env {
        name  = "GMAIL_PUBSUB_TOPIC"
        value = google_pubsub_topic.gmail.id
      }
      env {
        name  = "INTERNAL_OIDC_AUDIENCE"
        value = var.public_base_url
      }
      env {
        name  = "INTERNAL_CALLER_EMAIL"
        value = google_service_account.events.email
      }
      env {
        name = "GOOGLE_OAUTH_CLIENT_ID"
        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.oauth_client_id.secret_id
            version = "latest"
          }
        }
      }
      env {
        name = "GOOGLE_OAUTH_CLIENT_SECRET"
        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.oauth_client_secret.secret_id
            version = "latest"
          }
        }
      }
    }
  }

  depends_on = [
    google_project_service.required,
    google_secret_manager_secret_iam_member.runtime,
  ]
}

resource "google_cloud_run_v2_service_iam_member" "public_api" {
  project  = var.project_id
  location = google_cloud_run_v2_service.backend.location
  name     = google_cloud_run_v2_service.backend.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_service_account_iam_member" "events_token_creator" {
  for_each = toset([
    "service-${data.google_project.current.number}@gcp-sa-pubsub.iam.gserviceaccount.com",
    "service-${data.google_project.current.number}@gcp-sa-cloudscheduler.iam.gserviceaccount.com",
  ])
  service_account_id = google_service_account.events.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${each.value}"
}

data "google_project" "current" {
  project_id = var.project_id
}

resource "google_pubsub_subscription" "gmail_push" {
  project = var.project_id
  name    = "missnothing-gmail-push"
  topic   = google_pubsub_topic.gmail.id

  ack_deadline_seconds       = 30
  message_retention_duration = "604800s"

  retry_policy {
    minimum_backoff = "10s"
    maximum_backoff = "600s"
  }

  push_config {
    push_endpoint = "${var.public_base_url}/internal/pubsub/gmail"
    oidc_token {
      service_account_email = google_service_account.events.email
      audience              = var.public_base_url
    }
  }

  depends_on = [google_service_account_iam_member.events_token_creator]
}

resource "google_cloud_scheduler_job" "renew_watches" {
  project     = var.project_id
  region      = var.region
  name        = "missnothing-renew-gmail-watches"
  description = "Renew all Gmail watches daily with a six-day safety margin."
  schedule    = "17 3 * * *"
  time_zone   = "Etc/UTC"

  retry_config {
    retry_count          = 3
    min_backoff_duration = "30s"
    max_backoff_duration = "300s"
  }

  http_target {
    http_method = "POST"
    uri         = "${var.public_base_url}/internal/renew-watches"
    oidc_token {
      service_account_email = google_service_account.events.email
      audience              = var.public_base_url
    }
  }

  depends_on = [google_project_service.required]
}
