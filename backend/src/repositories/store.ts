import { Firestore } from "@google-cloud/firestore";

import type {
  ConnectedAccount,
  DeviceRegistration,
  OAuthState,
} from "../types.js";

export interface BackendStore {
  saveOAuthState(state: OAuthState): Promise<void>;
  consumeOAuthState(stateHash: string, now: Date): Promise<OAuthState | null>;
  saveAccount(account: ConnectedAccount): Promise<void>;
  findAccount(userId: string, accountId: string): Promise<ConnectedAccount | null>;
  findAccountByEmail(email: string): Promise<ConnectedAccount | null>;
  listAccounts(userId: string): Promise<ConnectedAccount[]>;
  listAllAccounts(): Promise<ConnectedAccount[]>;
  deleteAccount(userId: string, accountId: string): Promise<void>;
  saveDevice(device: DeviceRegistration): Promise<void>;
  deleteDevice(userId: string, deviceId: string): Promise<void>;
  listDevices(userId: string): Promise<DeviceRegistration[]>;
  markPushProcessed(messageId: string, now: Date): Promise<boolean>;
  releasePush(messageId: string): Promise<void>;
}

export class FirestoreBackendStore implements BackendStore {
  constructor(private readonly firestore: Firestore) {}

  async saveOAuthState(state: OAuthState): Promise<void> {
    await this.firestore.collection("oauthStates").doc(state.stateHash).set(state);
  }

  async consumeOAuthState(
    stateHash: string,
    now: Date,
  ): Promise<OAuthState | null> {
    const reference = this.firestore.collection("oauthStates").doc(stateHash);
    return this.firestore.runTransaction(async (transaction) => {
      const snapshot = await transaction.get(reference);
      if (!snapshot.exists) return null;
      const state = snapshot.data() as OAuthState;
      transaction.delete(reference);
      return Date.parse(state.expiresAt) > now.getTime() ? state : null;
    });
  }

  async saveAccount(account: ConnectedAccount): Promise<void> {
    await this.firestore.collection("accounts").doc(account.id).set(account);
  }

  async findAccount(
    userId: string,
    accountId: string,
  ): Promise<ConnectedAccount | null> {
    const snapshot = await this.firestore
      .collection("accounts")
      .doc(accountId)
      .get();
    if (!snapshot.exists) return null;
    const account = snapshot.data() as ConnectedAccount;
    return account.userId === userId ? account : null;
  }

  async findAccountByEmail(email: string): Promise<ConnectedAccount | null> {
    const snapshot = await this.firestore
      .collection("accounts")
      .where("email", "==", email.toLowerCase())
      .limit(1)
      .get();
    return snapshot.empty
      ? null
      : (snapshot.docs[0]?.data() as ConnectedAccount);
  }

  async listAccounts(userId: string): Promise<ConnectedAccount[]> {
    const snapshot = await this.firestore
      .collection("accounts")
      .where("userId", "==", userId)
      .get();
    return snapshot.docs.map((document) => document.data() as ConnectedAccount);
  }

  async listAllAccounts(): Promise<ConnectedAccount[]> {
    const snapshot = await this.firestore.collection("accounts").get();
    return snapshot.docs.map((document) => document.data() as ConnectedAccount);
  }

  async deleteAccount(userId: string, accountId: string): Promise<void> {
    const account = await this.findAccount(userId, accountId);
    if (account) {
      await this.firestore.collection("accounts").doc(accountId).delete();
    }
  }

  async saveDevice(device: DeviceRegistration): Promise<void> {
    await this.firestore
      .collection("devices")
      .doc(`${device.userId}_${device.deviceId}`)
      .set(device);
  }

  async deleteDevice(userId: string, deviceId: string): Promise<void> {
    await this.firestore
      .collection("devices")
      .doc(`${userId}_${deviceId}`)
      .delete();
  }

  async listDevices(userId: string): Promise<DeviceRegistration[]> {
    const snapshot = await this.firestore
      .collection("devices")
      .where("userId", "==", userId)
      .get();
    return snapshot.docs.map(
      (document) => document.data() as DeviceRegistration,
    );
  }

  async markPushProcessed(messageId: string, now: Date): Promise<boolean> {
    const reference = this.firestore.collection("pushEvents").doc(messageId);
    return this.firestore.runTransaction(async (transaction) => {
      if ((await transaction.get(reference)).exists) return false;
      transaction.create(reference, {
        processedAt: now.toISOString(),
      });
      return true;
    });
  }

  async releasePush(messageId: string): Promise<void> {
    await this.firestore.collection("pushEvents").doc(messageId).delete();
  }
}
