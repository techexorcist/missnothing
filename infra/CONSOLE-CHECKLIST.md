# Console checklist — MissNothing token broker

Written from `backend/README.md`, `infra/README.md` and `infra/main.tf`. No second
architecture. Nothing here was applied: this session has no network egress to
`googleapis.com` and no authenticated `gcloud`, so every step below needs your
login. Resource names are taken verbatim from the Terraform.

## 0 · Blockers before anything is applied

**B1 — Artifact Registry repository is missing.** `main.tf` enables
`artifactregistry.googleapis.com` but never declares a
`google_artifact_registry_repository`. There is nowhere to push
`var.backend_image`. Either add the resource or create the repo by hand.

**B2 — `public_base_url` is a chicken-and-egg.** It feeds five things: two Cloud
Run env vars, `GOOGLE_OAUTH_REDIRECT_URI`, the Pub/Sub push endpoint, the
Scheduler URI and `INTERNAL_OIDC_AUDIENCE`. But the Cloud Run URL does not exist
until the service does. Options:

- **Predict it.** Cloud Run's current URL format is
  `https://<service>-<project-number>.<region>.run.app`, so once you know the
  project number you can pass it up front and apply in one pass.
- **Two-pass.** Apply with a placeholder, read the `backend_url` output, re-apply
  with the real value. Safe, and the second apply only touches env vars, the
  subscription and the scheduler job.
- **Custom domain**, e.g. `api.missnothing.app`, mapped to Cloud Run. Stable
  forever, but adds domain mapping and certificate provisioning.

**B3 — Firestore location is permanent.** `var.firestore_location` defaults to
`asia-south1`. It cannot be changed after the database is created; changing it
later means a new project. Confirm before the first apply.

**B4 — The Flutter app is not wired to this backend.** `pubspec.yaml` has no
`firebase_core`, `firebase_auth` or `firebase_messaging`, and there is no
`android/app/google-services.json`. The app still talks to Gmail directly via
`google_sign_in` + `googleapis`. Deploying the broker changes nothing about app
behaviour until that work lands — worth knowing so a green deploy isn't mistaken
for a working pipeline.

## 1 · Project and billing — you, in the console

1. Pick or create the project that will **also own the OAuth web client** (the
   Terraform assumes one project owns both).
2. Attach a billing account. Cloud Run scales to zero, but KMS key versions,
   Firestore and Scheduler are billable at rest.
3. Record the **project ID** and **project number** (the number is needed for
   B2's predicted URL and appears in the Pub/Sub and Scheduler agent identities
   the Terraform references).

## 2 · Enable APIs

Terraform enables all ten via `google_project_service`, so this is optional —
but doing it first makes the first apply faster and surfaces org-policy blocks
early.

```sh
gcloud config set project PROJECT_ID
gcloud services enable \
  artifactregistry.googleapis.com cloudkms.googleapis.com \
  cloudscheduler.googleapis.com firestore.googleapis.com \
  firebase.googleapis.com fcm.googleapis.com gmail.googleapis.com \
  pubsub.googleapis.com run.googleapis.com secretmanager.googleapis.com
```

## 3 · OAuth clients — console only, no CLI

**Consent screen:** External, publishing status **Production**, app name
**MissNothing**, homepage `https://techexorcist.github.io/missnothing/`, privacy
`https://techexorcist.github.io/missnothing/privacy.html`. Scope
`https://www.googleapis.com/auth/gmail.readonly`.

> The privacy policy at that URL currently states the app has no server. That is
> no longer true. It must be rewritten before this consent screen is reviewed —
> see §8.

**Web client** (`APIs & Services → Credentials → Create → OAuth client → Web`):

- Authorised redirect URI: `<public_base_url>/v1/oauth/callback`
- Copy the **client ID** and **client secret**. The secret goes only to Secret
  Manager (§5). Neither goes in git.

**Android client** (`Create → OAuth client → Android`):

- Package name: `app.missnothing`
- Debug SHA-1: `4B:A4:07:EA:DC:FB:B8:BD:E2:06:D8:CA:7C:09:24:5C:F4:72:D1:4A`
- Add the release keystore SHA-1 later, as a second Android client or a second
  fingerprint on the same one.
- You never paste the Android client ID anywhere. It authorises the app by
  package + fingerprint; the app uses the **web** client ID.

## 4 · Artifact Registry and the image

Resolve B1 first. If creating by hand:

```sh
gcloud artifacts repositories create missnothing \
  --repository-format=docker --location=REGION
gcloud auth configure-docker REGION-docker.pkg.dev
```

Build, push, and capture the **digest** (Terraform wants an immutable
reference, not a tag):

```sh
cd backend
npm ci && npm test && npm run typecheck && npm run build
IMG=REGION-docker.pkg.dev/PROJECT_ID/missnothing/backend
docker build --platform linux/amd64 -t "$IMG:v1" .
docker push "$IMG:v1"
gcloud artifacts docker images describe "$IMG:v1" --format='value(image_summary.digest)'
# backend_image = REGION-docker.pkg.dev/PROJECT_ID/missnothing/backend@sha256:...
```

`--platform linux/amd64` matters: you are on arm64 and Cloud Run is amd64.

## 5 · Terraform

```sh
cd infra
cat > terraform.tfvars <<'EOF'
project_id      = "PROJECT_ID"
region          = "asia-south1"
firestore_location = "asia-south1"
backend_image   = "REGION-docker.pkg.dev/.../backend@sha256:..."
public_base_url = "https://missnothing-backend-PROJECT_NUMBER.asia-south1.run.app"
EOF

terraform init
# If the project already has a default Firestore database:
terraform import google_firestore_database.default \
  "projects/PROJECT_ID/databases/(default)"
terraform plan
terraform apply
```

Then the two secret versions, which Terraform deliberately leaves empty:

```sh
printf '%s' "$GOOGLE_OAUTH_CLIENT_ID" | \
  gcloud secrets versions add missnothing-oauth-client-id --data-file=-
printf '%s' "$GOOGLE_OAUTH_CLIENT_SECRET" | \
  gcloud secrets versions add missnothing-oauth-client-secret --data-file=-
```

Cloud Run reads both at `latest`, so add versions **before** first traffic or the
revision fails to start.

Expected resources: 10 API enablements, Firebase project, Firestore `(default)`,
2 service accounts (`missnothing-backend`, `missnothing-events`), KMS keyring
`missnothing` + key `oauth-tokens` (90-day rotation, `prevent_destroy`), 2 empty
secrets, Pub/Sub topic `missnothing-gmail` + push subscription
`missnothing-gmail-push`, Cloud Run `missnothing-backend`, Scheduler
`missnothing-renew-gmail-watches` at 03:17 UTC daily.

## 6 · Health smoke check only

```sh
curl -sS -i "$(terraform output -raw backend_url)/healthz"
```

Expect 200 and a content-free body. **Do not** call `/v1/oauth/start` with a real
family mailbox yet, and do not tee any response containing a token into a file or
a shell history.

## 7 · What you must add to the app

Once §3 and §5 are done:

`secrets.json` (gitignored, consumed by `--dart-define-from-file=secrets.json`):

```json
{
  "GOOGLE_SERVER_CLIENT_ID": "WEB_CLIENT_ID.apps.googleusercontent.com",
  "MISSNOTHING_API_BASE_URL": "https://missnothing-backend-PROJECT_NUMBER.asia-south1.run.app"
}
```

The second key does not exist in `secrets.json.example` yet and no Dart code
reads it — add both when the app is wired to the broker (B4).

**Callback URL to register on the web client:**
`<public_base_url>/v1/oauth/callback`

## 8 · Still manual, and still unresolved

| Item | Status |
|---|---|
| **Privacy policy rewrite** | **Required.** The live text says there is no server. A KMS-encrypted refresh token on Cloud Run makes that false, and it is the document Google reviews. |
| **CASA / restricted-scope verification** | The earlier "no server, so probably no assessment" argument is gone. `gmail.readonly` plus server-held refresh tokens is squarely inside Google's trigger. Family-only under 100 users still avoids verification; going public is now materially more expensive. `infra/README.md` already says this. |
| **8-day refresh-token canary** | Not automated. Record the timestamp of the first successful `/v1/oauth/callback` and re-check unattended sync on day 9. |
| **Firebase Authentication** | Enable the Google sign-in provider and register the Android app (package + both SHA-1s) by hand. Terraform creates the Firebase project but not the provider config. |
| **`google-services.json`** | Download from Firebase after registering the Android app. Gitignored already. |
| **Release keystore SHA-1** | Add to the Android OAuth client and Firebase when a release keystore exists. |
| **Gmail `users.watch`** | Called by the backend per account; the topic exists but no watch is registered until an account connects. |
| **`*.tfvars` not gitignored** | `infra/.gitignore` covers state but not tfvars. Add `*.tfvars` — it will hold your project id and URLs. |
