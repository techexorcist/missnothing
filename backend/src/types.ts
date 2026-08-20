export interface UserIdentity {
  uid: string;
  email?: string;
}

export interface EncryptedSecret {
  version: 1;
  wrappedKey: string;
  iv: string;
  authenticationTag: string;
  ciphertext: string;
}

export interface ConnectedAccount {
  id: string;
  userId: string;
  email: string;
  encryptedRefreshToken: EncryptedSecret;
  watchHistoryId?: string;
  watchExpiresAt?: string;
  createdAt: string;
  updatedAt: string;
}

export interface OAuthState {
  stateHash: string;
  userId: string;
  expiresAt: string;
  accountHint?: string;
}

export interface DeviceRegistration {
  userId: string;
  deviceId: string;
  fcmToken: string;
  platform: "android";
  updatedAt: string;
}

export interface WatchResult {
  historyId: string;
  expiration: string;
}

export interface PushEnvelope {
  message?: {
    messageId?: string;
    data?: string;
  };
  subscription?: string;
}

export interface GmailPush {
  emailAddress: string;
  historyId: string;
}
