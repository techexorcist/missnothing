import type { NextFunction, Request, RequestHandler, Response } from "express";
import type { Auth } from "firebase-admin/auth";
import { OAuth2Client } from "google-auth-library";

import type { UserIdentity } from "./types.js";

declare global {
  namespace Express {
    interface Request {
      identity?: UserIdentity;
    }
  }
}

export interface IdentityVerifier {
  verify(token: string): Promise<UserIdentity>;
}

export class FirebaseIdentityVerifier implements IdentityVerifier {
  constructor(private readonly auth: Auth) {}

  async verify(token: string): Promise<UserIdentity> {
    const decoded = await this.auth.verifyIdToken(token, true);
    return {
      uid: decoded.uid,
      ...(decoded.email ? { email: decoded.email } : {}),
    };
  }
}

export function requireIdentity(verifier: IdentityVerifier): RequestHandler {
  return async (request, response, next) => {
    const token = bearer(request);
    if (!token) {
      response.status(401).json({ error: "authentication_required" });
      return;
    }
    try {
      request.identity = await verifier.verify(token);
      next();
    } catch {
      response.status(401).json({ error: "invalid_identity_token" });
    }
  };
}

export function requireInternalCaller(
  audience: string,
  expectedEmail: string,
  oauth = new OAuth2Client(),
): RequestHandler {
  return async (request: Request, response: Response, next: NextFunction) => {
    const token = bearer(request);
    if (!token) {
      response.status(401).json({ error: "internal_authentication_required" });
      return;
    }
    try {
      const ticket = await oauth.verifyIdToken({ idToken: token, audience });
      const payload = ticket.getPayload();
      if (
        !payload?.email_verified ||
        payload.email?.toLowerCase() !== expectedEmail.toLowerCase()
      ) {
        throw new Error("Unexpected internal caller.");
      }
      next();
    } catch {
      response.status(401).json({ error: "invalid_internal_identity" });
    }
  };
}

function bearer(request: Request): string | null {
  const header = request.header("authorization");
  return header?.startsWith("Bearer ") ? header.slice(7) : null;
}
