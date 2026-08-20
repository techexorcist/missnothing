# MissNothing backend

The backend is a credential and wake-up broker. It stores KMS-encrypted Gmail
refresh tokens and Gmail watch metadata. It must not fetch or persist message
bodies, attachments, proposals, events, or alarm content.

## Local verification

```sh
npm ci
npm test
npm run typecheck
npm run build
```

Copy `.env.example` to `.env` only for local development. Production values are
provided by Cloud Run and Secret Manager.

## HTTP surface

- `GET /healthz` — content-free health check.
- `GET /v1/oauth/start` — authenticated one-time offline OAuth start.
- `GET /v1/oauth/callback` — consumes the one-time state and connects Gmail.
- `GET /v1/accounts` — authenticated redacted account list.
- `POST /v1/accounts/:id/access-token` — short-lived token, `no-store`.
- `DELETE /v1/accounts/:id` — revokes and deletes the encrypted credential.
- `PUT|DELETE /v1/devices/:id` — FCM registration lifecycle.
- `POST /internal/pubsub/gmail` — OIDC-protected Gmail history wake-up.
- `POST /internal/renew-watches` — OIDC-protected daily watch renewal.

The Android app authenticates with a Firebase ID token. Internal routes accept
only the configured Pub/Sub/Scheduler service-account OIDC identity.

## Operational invariants

- Refresh tokens are AES-256-GCM encrypted with a random per-record data key.
- Data keys are wrapped by Cloud KMS; plaintext refresh tokens are never stored
  or logged.
- Pub/Sub events are deduplicated before FCM delivery.
- FCM carries only account ID and Gmail history ID, never mail content.
- Gmail watches are renewed daily because they expire within seven days.
