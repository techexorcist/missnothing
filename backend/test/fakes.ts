import type { IdentityVerifier } from "../src/auth.js";
import type { BackendStore } from "../src/repositories/store.js";
import type {
  ConnectedAccount,
  DeviceRegistration,
  OAuthState,
  UserIdentity,
} from "../src/types.js";
import type {
  AccessToken,
  GoogleOperations,
  OAuthExchange,
} from "../src/services/google_gateway.js";
import type { WatchResult } from "../src/types.js";

export class MemoryStore implements BackendStore {
  readonly oauthStates = new Map<string, OAuthState>();
  readonly accounts = new Map<string, ConnectedAccount>();
  readonly devices = new Map<string, DeviceRegistration>();
  readonly pushes = new Set<string>();

  async saveOAuthState(state: OAuthState) {
    this.oauthStates.set(state.stateHash, state);
  }

  async consumeOAuthState(stateHash: string, now: Date) {
    const state = this.oauthStates.get(stateHash) ?? null;
    this.oauthStates.delete(stateHash);
    return state && Date.parse(state.expiresAt) > now.getTime() ? state : null;
  }

  async saveAccount(account: ConnectedAccount) {
    this.accounts.set(account.id, account);
  }

  async findAccount(userId: string, accountId: string) {
    const account = this.accounts.get(accountId) ?? null;
    return account?.userId === userId ? account : null;
  }

  async findAccountByEmail(email: string) {
    return (
      [...this.accounts.values()].find((account) => account.email === email) ??
      null
    );
  }

  async listAccounts(userId: string) {
    return [...this.accounts.values()].filter(
      (account) => account.userId === userId,
    );
  }

  async listAllAccounts() {
    return [...this.accounts.values()];
  }

  async deleteAccount(userId: string, accountId: string) {
    const account = await this.findAccount(userId, accountId);
    if (account) this.accounts.delete(accountId);
  }

  async saveDevice(device: DeviceRegistration) {
    this.devices.set(`${device.userId}:${device.deviceId}`, device);
  }

  async deleteDevice(userId: string, deviceId: string) {
    this.devices.delete(`${userId}:${deviceId}`);
  }

  async listDevices(userId: string) {
    return [...this.devices.values()].filter(
      (device) => device.userId === userId,
    );
  }

  async markPushProcessed(messageId: string) {
    if (this.pushes.has(messageId)) return false;
    this.pushes.add(messageId);
    return true;
  }

  async releasePush(messageId: string) {
    this.pushes.delete(messageId);
  }
}

export class FakeGoogle implements GoogleOperations {
  revoked: string[] = [];

  authorizationUrl(state: string, accountHint?: string): string {
    const url = new URL("https://accounts.example/authorize");
    url.searchParams.set("state", state);
    if (accountHint) url.searchParams.set("login_hint", accountHint);
    return url.toString();
  }

  async exchangeCode(_code: string): Promise<OAuthExchange> {
    return {
      email: "parent@example.com",
      refreshToken: "refresh-token-secret",
    };
  }

  async accessToken(_refreshToken: string): Promise<AccessToken> {
    return {
      token: "short-lived-access-token",
      expiresAt: "2026-08-20T13:00:00.000Z",
    };
  }

  async watch(_refreshToken: string): Promise<WatchResult> {
    return {
      historyId: "12345",
      expiration: String(Date.parse("2026-08-27T12:00:00.000Z")),
    };
  }

  async revoke(refreshToken: string) {
    this.revoked.push(refreshToken);
  }

  accountId(_userId: string, _email: string): string {
    return "account_1";
  }
}

export class FakeIdentityVerifier implements IdentityVerifier {
  async verify(token: string): Promise<UserIdentity> {
    if (token !== "valid") throw new Error("invalid");
    return { uid: "user_1", email: "owner@example.com" };
  }
}

export class FakeMessaging {
  readonly messages: unknown[] = [];
  fail = false;

  async sendEachForMulticast(message: unknown) {
    if (this.fail) throw new Error("FCM unavailable");
    this.messages.push(message);
    return { responses: [], successCount: 1, failureCount: 0 };
  }
}
