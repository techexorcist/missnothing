import { createHash, randomBytes } from "node:crypto";

import type { Messaging } from "firebase-admin/messaging";

import type { BackendStore } from "../repositories/store.js";
import type {
  ConnectedAccount,
  GmailPush,
  PushEnvelope,
  UserIdentity,
} from "../types.js";
import type { GoogleOperations } from "./google_gateway.js";
import { TokenEncryptionService } from "./token_encryption.js";

export interface AccountSummary {
  id: string;
  email: string;
  watchHistoryId?: string;
  watchExpiresAt?: string;
  updatedAt: string;
}

export class BackendService {
  constructor(
    private readonly store: BackendStore,
    private readonly google: GoogleOperations,
    private readonly encryption: TokenEncryptionService,
    private readonly messaging: Pick<Messaging, "sendEachForMulticast">,
    private readonly now: () => Date = () => new Date(),
  ) {}

  async startOAuth(
    identity: UserIdentity,
    accountHint?: string,
  ): Promise<string> {
    const state = randomBytes(32).toString("base64url");
    await this.store.saveOAuthState({
      stateHash: hash(state),
      userId: identity.uid,
      expiresAt: new Date(this.now().getTime() + 10 * 60 * 1000).toISOString(),
      ...(accountHint ? { accountHint } : {}),
    });
    return this.google.authorizationUrl(state, accountHint);
  }

  async finishOAuth(state: string, code: string): Promise<AccountSummary> {
    const saved = await this.store.consumeOAuthState(hash(state), this.now());
    if (!saved) throw new Error("OAuth state is invalid, expired, or already used.");

    const exchange = await this.google.exchangeCode(code);
    const accountId = this.google.accountId(saved.userId, exchange.email);
    const context = tokenContext(saved.userId, accountId);
    const encryptedRefreshToken = await this.encryption.encrypt(
      exchange.refreshToken,
      context,
    );
    const watch = await this.google.watch(exchange.refreshToken);
    const timestamp = this.now().toISOString();
    const existing = await this.store.findAccount(saved.userId, accountId);
    const account: ConnectedAccount = {
      id: accountId,
      userId: saved.userId,
      email: exchange.email,
      encryptedRefreshToken,
      watchHistoryId: watch.historyId,
      watchExpiresAt: new Date(Number(watch.expiration)).toISOString(),
      createdAt: existing?.createdAt ?? timestamp,
      updatedAt: timestamp,
    };
    await this.store.saveAccount(account);
    return summarize(account);
  }

  async listAccounts(identity: UserIdentity): Promise<AccountSummary[]> {
    return (await this.store.listAccounts(identity.uid)).map(summarize);
  }

  async accessToken(identity: UserIdentity, accountId: string) {
    const account = await this.requireAccount(identity.uid, accountId);
    const refreshToken = await this.decrypt(account);
    return this.google.accessToken(refreshToken);
  }

  async disconnect(identity: UserIdentity, accountId: string): Promise<void> {
    const account = await this.requireAccount(identity.uid, accountId);
    const refreshToken = await this.decrypt(account);
    await this.google.revoke(refreshToken);
    await this.store.deleteAccount(identity.uid, accountId);
  }

  async registerDevice(
    identity: UserIdentity,
    deviceId: string,
    fcmToken: string,
  ): Promise<void> {
    await this.store.saveDevice({
      userId: identity.uid,
      deviceId,
      fcmToken,
      platform: "android",
      updatedAt: this.now().toISOString(),
    });
  }

  deleteDevice(identity: UserIdentity, deviceId: string): Promise<void> {
    return this.store.deleteDevice(identity.uid, deviceId);
  }

  async renewWatches(): Promise<{ renewed: number; failed: number }> {
    return this.renewAccounts(await this.store.listAllAccounts());
  }

  async renewAccounts(
    accounts: ConnectedAccount[],
  ): Promise<{ renewed: number; failed: number }> {
    let renewed = 0;
    let failed = 0;
    for (const account of accounts) {
      try {
        const watch = await this.google.watch(await this.decrypt(account));
        await this.store.saveAccount({
          ...account,
          watchHistoryId: watch.historyId,
          watchExpiresAt: new Date(Number(watch.expiration)).toISOString(),
          updatedAt: this.now().toISOString(),
        });
        renewed += 1;
      } catch {
        failed += 1;
      }
    }
    return { renewed, failed };
  }

  async handlePush(
    envelope: PushEnvelope,
  ): Promise<"delivered" | "duplicate" | "unknown-account"> {
    const messageId = envelope.message?.messageId;
    const encoded = envelope.message?.data;
    if (!messageId || !encoded) throw new Error("Malformed Pub/Sub envelope.");

    const push = JSON.parse(
      Buffer.from(encoded, "base64").toString("utf8"),
    ) as GmailPush;
    if (!push.emailAddress || !push.historyId) {
      throw new Error("Malformed Gmail push payload.");
    }
    if (!(await this.store.markPushProcessed(messageId, this.now()))) {
      return "duplicate";
    }
    try {
      const account = await this.store.findAccountByEmail(
        push.emailAddress.toLowerCase(),
      );
      if (!account) return "unknown-account";
      const devices = await this.store.listDevices(account.userId);
      if (devices.length === 0) return "delivered";

      await this.messaging.sendEachForMulticast({
        tokens: devices.map((device) => device.fcmToken),
        data: {
          type: "gmail_history",
          accountId: account.id,
          historyId: push.historyId,
        },
        android: { priority: "high" },
      });
      return "delivered";
    } catch (error) {
      await this.store.releasePush(messageId);
      throw error;
    }
  }

  private async requireAccount(
    userId: string,
    accountId: string,
  ): Promise<ConnectedAccount> {
    const account = await this.store.findAccount(userId, accountId);
    if (!account) throw new Error("Connected account not found.");
    return account;
  }

  private decrypt(account: ConnectedAccount): Promise<string> {
    return this.encryption.decrypt(
      account.encryptedRefreshToken,
      tokenContext(account.userId, account.id),
    );
  }
}

function hash(value: string): string {
  return createHash("sha256").update(value).digest("hex");
}

function tokenContext(userId: string, accountId: string): string {
  return `missnothing:oauth:${userId}:${accountId}`;
}

function summarize(account: ConnectedAccount): AccountSummary {
  return {
    id: account.id,
    email: account.email,
    ...(account.watchHistoryId
      ? { watchHistoryId: account.watchHistoryId }
      : {}),
    ...(account.watchExpiresAt
      ? { watchExpiresAt: account.watchExpiresAt }
      : {}),
    updatedAt: account.updatedAt,
  };
}
