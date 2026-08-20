import type { RequestHandler } from "express";
import request from "supertest";
import { beforeEach, describe, expect, it } from "vitest";

import { createApp } from "../src/app.js";
import type { BackendConfig } from "../src/config.js";
import { BackendService } from "../src/services/backend_service.js";
import {
  TokenEncryptionService,
  type KeyWrapper,
} from "../src/services/token_encryption.js";
import {
  FakeGoogle,
  FakeIdentityVerifier,
  FakeMessaging,
  MemoryStore,
} from "./fakes.js";

const config: BackendConfig = {
  GOOGLE_CLOUD_PROJECT: "test-project",
  PUBLIC_BASE_URL: "https://backend.example",
  GOOGLE_OAUTH_CLIENT_ID: "client-id",
  GOOGLE_OAUTH_CLIENT_SECRET: "client-secret",
  GOOGLE_OAUTH_REDIRECT_URI: "https://backend.example/v1/oauth/callback",
  KMS_KEY_NAME: "projects/p/locations/l/keyRings/r/cryptoKeys/k",
  GMAIL_PUBSUB_TOPIC: "projects/test-project/topics/gmail",
  INTERNAL_OIDC_AUDIENCE: "https://backend.example",
  INTERNAL_CALLER_EMAIL: "events@test-project.iam.gserviceaccount.com",
  PORT: 8080,
};

class TestKeyWrapper implements KeyWrapper {
  async wrap(value: Uint8Array) {
    return Uint8Array.from(value, (byte) => byte ^ 0x5c);
  }

  async unwrap(value: Uint8Array) {
    return Uint8Array.from(value, (byte) => byte ^ 0x5c);
  }
}

describe("backend API", () => {
  let store: MemoryStore;
  let messaging: FakeMessaging;
  let app: ReturnType<typeof createApp>;

  beforeEach(() => {
    store = new MemoryStore();
    messaging = new FakeMessaging();
    const service = new BackendService(
      store,
      new FakeGoogle(),
      new TokenEncryptionService(new TestKeyWrapper()),
      messaging,
      () => new Date("2026-08-20T12:00:00.000Z"),
    );
    const allowInternal: RequestHandler = (_request, _response, next) => next();
    app = createApp({
      config,
      service,
      identityVerifier: new FakeIdentityVerifier(),
      internalAuth: allowInternal,
    });
  });

  it("exposes a content-free health check", async () => {
    const response = await request(app).get("/healthz").expect(200);
    expect(response.body).toEqual({ ok: true });
  });

  it("requires a verified app identity", async () => {
    await request(app).get("/v1/accounts").expect(401);
    await request(app)
      .get("/v1/accounts")
      .set("authorization", "Bearer invalid")
      .expect(401);
  });

  it("connects Gmail while storing only an encrypted refresh token", async () => {
    const start = await request(app)
      .get("/v1/oauth/start?accountHint=parent@example.com")
      .set("authorization", "Bearer valid")
      .expect(200);
    const state = new URL(start.body.authorizationUrl as string).searchParams.get(
      "state",
    );
    expect(state).toBeTruthy();

    const callback = await request(app)
      .get("/v1/oauth/callback")
      .query({ state, code: "authorization-code" })
      .expect(200);
    expect(callback.text).toContain("parent@example.com");
    expect(callback.text).not.toContain("refresh-token-secret");
    expect(JSON.stringify([...store.accounts.values()])).not.toContain(
      "refresh-token-secret",
    );

    const token = await request(app)
      .post("/v1/accounts/account_1/access-token")
      .set("authorization", "Bearer valid")
      .expect(200);
    expect(token.headers["cache-control"]).toBe("no-store");
    expect(token.body.token).toBe("short-lived-access-token");
    expect(JSON.stringify(token.body)).not.toContain("refresh-token-secret");
  });

  it("deduplicates Gmail pushes and sends no mail content through FCM", async () => {
    await connectAccount(app);
    await request(app)
      .put("/v1/devices/phone_1")
      .set("authorization", "Bearer valid")
      .send({ fcmToken: "fcm-token-that-is-long-enough" })
      .expect(204);
    const envelope = {
      message: {
        messageId: "pubsub-1",
        data: Buffer.from(
          JSON.stringify({
            emailAddress: "parent@example.com",
            historyId: "999",
          }),
        ).toString("base64"),
      },
    };

    await request(app).post("/internal/pubsub/gmail").send(envelope).expect(200);
    const duplicate = await request(app)
      .post("/internal/pubsub/gmail")
      .send(envelope)
      .expect(200);

    expect(duplicate.body.result).toBe("duplicate");
    expect(messaging.messages).toHaveLength(1);
    expect(JSON.stringify(messaging.messages[0])).not.toContain(
      "parent@example.com",
    );

    const retryable = {
      ...envelope,
      message: { ...envelope.message, messageId: "pubsub-2" },
    };
    messaging.fail = true;
    await request(app)
      .post("/internal/pubsub/gmail")
      .send(retryable)
      .expect(400);
    messaging.fail = false;
    await request(app)
      .post("/internal/pubsub/gmail")
      .send(retryable)
      .expect(200);
    expect(messaging.messages).toHaveLength(2);
  });
});

async function connectAccount(app: ReturnType<typeof createApp>) {
  const start = await request(app)
    .get("/v1/oauth/start")
    .set("authorization", "Bearer valid");
  const state = new URL(start.body.authorizationUrl as string).searchParams.get(
    "state",
  );
  await request(app)
    .get("/v1/oauth/callback")
    .query({ state, code: "authorization-code" })
    .expect(200);
}
