import { createHash } from "node:crypto";

import { google } from "googleapis";

import type { WatchResult } from "../types.js";

const scopes = [
  "openid",
  "email",
  "https://www.googleapis.com/auth/gmail.readonly",
];
type OAuth2Client = InstanceType<typeof google.auth.OAuth2>;

export interface OAuthExchange {
  email: string;
  refreshToken: string;
}

export interface AccessToken {
  token: string;
  expiresAt: string;
}

export interface GoogleOperations {
  authorizationUrl(state: string, accountHint?: string): string;
  exchangeCode(code: string): Promise<OAuthExchange>;
  accessToken(refreshToken: string): Promise<AccessToken>;
  watch(refreshToken: string): Promise<WatchResult>;
  revoke(refreshToken: string): Promise<void>;
  accountId(userId: string, email: string): string;
}

export class GoogleGateway implements GoogleOperations {
  constructor(
    private readonly clientId: string,
    private readonly clientSecret: string,
    private readonly redirectUri: string,
    private readonly pubsubTopic: string,
  ) {}

  authorizationUrl(state: string, accountHint?: string): string {
    return this.client().generateAuthUrl({
      access_type: "offline",
      include_granted_scopes: true,
      prompt: "consent",
      scope: scopes,
      state,
      ...(accountHint ? { login_hint: accountHint } : {}),
    });
  }

  async exchangeCode(code: string): Promise<OAuthExchange> {
    const client = this.client();
    const { tokens } = await client.getToken(code);
    if (!tokens.refresh_token) {
      throw new Error(
        "Google returned no refresh token. Reconnect with consent enabled.",
      );
    }
    client.setCredentials(tokens);
    const profile = await google.oauth2({ version: "v2", auth: client }).userinfo.get();
    const email = profile.data.email?.trim().toLowerCase();
    if (!email) throw new Error("Google account email was not returned.");
    return { email, refreshToken: tokens.refresh_token };
  }

  async accessToken(refreshToken: string): Promise<AccessToken> {
    const client = this.clientWithRefreshToken(refreshToken);
    const response = await client.getAccessToken();
    if (!response.token) throw new Error("Google returned no access token.");
    return {
      token: response.token,
      expiresAt: new Date(
        client.credentials.expiry_date ?? Date.now() + 50 * 60 * 1000,
      ).toISOString(),
    };
  }

  async watch(refreshToken: string): Promise<WatchResult> {
    const gmail = google.gmail({
      version: "v1",
      auth: this.clientWithRefreshToken(refreshToken),
    });
    const response = await gmail.users.watch({
      userId: "me",
      requestBody: { topicName: this.pubsubTopic },
    });
    if (!response.data.historyId || !response.data.expiration) {
      throw new Error("Gmail watch returned incomplete metadata.");
    }
    return {
      historyId: response.data.historyId,
      expiration: response.data.expiration,
    };
  }

  async revoke(refreshToken: string): Promise<void> {
    await this.client().revokeToken(refreshToken);
  }

  accountId(userId: string, email: string): string {
    return createHash("sha256")
      .update(`${userId}\u0000${email.toLowerCase()}`)
      .digest("hex")
      .slice(0, 32);
  }

  private client(): OAuth2Client {
    return new google.auth.OAuth2(
      this.clientId,
      this.clientSecret,
      this.redirectUri,
    );
  }

  private clientWithRefreshToken(refreshToken: string): OAuth2Client {
    const client = this.client();
    client.setCredentials({ refresh_token: refreshToken });
    return client;
  }
}
