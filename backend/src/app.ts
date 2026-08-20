import express, {
  type NextFunction,
  type Request,
  type RequestHandler,
  type Response,
} from "express";
import { z } from "zod";

import {
  requireIdentity,
  requireInternalCaller,
  type IdentityVerifier,
} from "./auth.js";
import type { BackendConfig } from "./config.js";
import { BackendService } from "./services/backend_service.js";

export interface AppDependencies {
  config: BackendConfig;
  service: BackendService;
  identityVerifier: IdentityVerifier;
  internalAuth?: RequestHandler;
}

export function createApp(dependencies: AppDependencies) {
  const app = express();
  app.disable("x-powered-by");
  app.use(express.json({ limit: "64kb" }));

  const identity = requireIdentity(dependencies.identityVerifier);
  const internal =
    dependencies.internalAuth ??
    requireInternalCaller(
      dependencies.config.INTERNAL_OIDC_AUDIENCE,
      dependencies.config.INTERNAL_CALLER_EMAIL,
    );

  app.get("/healthz", (_request, response) => {
    response.json({ ok: true });
  });

  app.get("/v1/oauth/start", identity, async (request, response) => {
    const query = z
      .object({ accountHint: z.email().optional() })
      .parse(request.query);
    response.json({
      authorizationUrl: await dependencies.service.startOAuth(
        requiredIdentity(request),
        query.accountHint,
      ),
    });
  });

  app.get("/v1/oauth/callback", async (request, response) => {
    const query = z
      .object({ state: z.string().min(20), code: z.string().min(1) })
      .parse(request.query);
    const account = await dependencies.service.finishOAuth(
      query.state,
      query.code,
    );
    response
      .status(200)
      .type("html")
      .send(
        "<!doctype html><meta charset=utf-8>" +
          "<title>Gmail connected</title>" +
          "<main><h1>Gmail connected</h1>" +
          `<p>${escapeHtml(account.email)} is ready in MissNothing.</p>` +
          "<p>You can close this tab and return to the app.</p></main>",
      );
  });

  app.get("/v1/accounts", identity, async (request, response) => {
    response.json({
      accounts: await dependencies.service.listAccounts(
        requiredIdentity(request),
      ),
    });
  });

  app.post(
    "/v1/accounts/:accountId/access-token",
    identity,
    async (request, response) => {
      const accountId = idSchema.parse(request.params.accountId);
      response.set("cache-control", "no-store");
      response.json(
        await dependencies.service.accessToken(
          requiredIdentity(request),
          accountId,
        ),
      );
    },
  );

  app.delete(
    "/v1/accounts/:accountId",
    identity,
    async (request, response) => {
      await dependencies.service.disconnect(
        requiredIdentity(request),
        idSchema.parse(request.params.accountId),
      );
      response.status(204).send();
    },
  );

  app.put("/v1/devices/:deviceId", identity, async (request, response) => {
    const body = z.object({ fcmToken: z.string().min(20).max(4096) }).parse(
      request.body,
    );
    await dependencies.service.registerDevice(
      requiredIdentity(request),
      idSchema.parse(request.params.deviceId),
      body.fcmToken,
    );
    response.status(204).send();
  });

  app.delete("/v1/devices/:deviceId", identity, async (request, response) => {
    await dependencies.service.deleteDevice(
      requiredIdentity(request),
      idSchema.parse(request.params.deviceId),
    );
    response.status(204).send();
  });

  app.post("/internal/pubsub/gmail", internal, async (request, response) => {
    const result = await dependencies.service.handlePush(request.body);
    response.json({ result });
  });

  app.post("/internal/renew-watches", internal, async (_request, response) => {
    response.json(await dependencies.service.renewWatches());
  });

  app.use(
    (
      error: unknown,
      _request: Request,
      response: Response,
      _next: NextFunction,
    ) => {
      if (error instanceof z.ZodError) {
        response.status(400).json({
          error: "invalid_request",
          fields: error.issues.map((issue) => issue.path.join(".")),
        });
        return;
      }
      const message = error instanceof Error ? error.message : "Request failed.";
      const status = message === "Connected account not found." ? 404 : 400;
      response.status(status).json({
        error: status === 404 ? "not_found" : "request_failed",
      });
    },
  );

  return app;
}

const idSchema = z.string().regex(/^[A-Za-z0-9_-]{1,128}$/);

function requiredIdentity(request: Request) {
  if (!request.identity) throw new Error("Identity middleware was not applied.");
  return request.identity;
}

function escapeHtml(value: string): string {
  return value
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#39;");
}
