# Google Cloud infrastructure

Terraform defines Cloud Run, Firestore, Cloud KMS, Secret Manager, Gmail
Pub/Sub delivery, daily watch renewal, Firebase/FCM enablement, and
least-privilege service accounts.

Terraform is not installed automatically and no cloud resources are created by
the repository tests.

## Bootstrap order

1. Select the Google Cloud project that owns the Gmail OAuth web client.
2. Initialize Terraform and create the APIs, KMS key, service accounts, topics,
   Firestore database, and the two empty Secret Manager secrets.
3. Add secret versions outside Terraform:

   ```sh
   printf '%s' "$GOOGLE_OAUTH_CLIENT_ID" |
     gcloud secrets versions add missnothing-oauth-client-id --data-file=-
   printf '%s' "$GOOGLE_OAUTH_CLIENT_SECRET" |
     gcloud secrets versions add missnothing-oauth-client-secret --data-file=-
   ```

4. Build and push the backend image, then apply with its immutable digest and
   the final HTTPS base URL.
5. Add `<base-url>/v1/oauth/callback` to the OAuth web client.
6. Enable Google sign-in in Firebase Authentication and register the Android
   package/signing fingerprints.

If the project already has a default Firestore database, import it before
applying:

```sh
terraform import google_firestore_database.default \
  "projects/PROJECT/databases/(default)"
```

## External release gate

`gmail.readonly` is a restricted scope. A backend capable of using server-held
refresh tokens can trigger Google OAuth verification and recurring security
assessment requirements. Keep the app family-only while validating the flow,
and run an eight-day refresh-token canary before declaring unattended sync
reliable.
