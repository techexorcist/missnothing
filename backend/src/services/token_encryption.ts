import {
  createCipheriv,
  createDecipheriv,
  randomBytes,
} from "node:crypto";

import { KeyManagementServiceClient } from "@google-cloud/kms";

import type { EncryptedSecret } from "../types.js";

export interface KeyWrapper {
  wrap(plaintext: Uint8Array): Promise<Uint8Array>;
  unwrap(ciphertext: Uint8Array): Promise<Uint8Array>;
}

export class GoogleKmsKeyWrapper implements KeyWrapper {
  constructor(
    private readonly client: KeyManagementServiceClient,
    private readonly keyName: string,
  ) {}

  async wrap(plaintext: Uint8Array): Promise<Uint8Array> {
    const [result] = await this.client.encrypt({
      name: this.keyName,
      plaintext: Buffer.from(plaintext),
    });
    if (!result.ciphertext) {
      throw new Error("Cloud KMS returned no ciphertext.");
    }
    return bytes(result.ciphertext);
  }

  async unwrap(ciphertext: Uint8Array): Promise<Uint8Array> {
    const [result] = await this.client.decrypt({
      name: this.keyName,
      ciphertext: Buffer.from(ciphertext),
    });
    if (!result.plaintext) {
      throw new Error("Cloud KMS returned no plaintext.");
    }
    return bytes(result.plaintext);
  }
}

function bytes(value: string | Uint8Array): Uint8Array {
  return typeof value === "string"
    ? new Uint8Array(Buffer.from(value, "base64"))
    : new Uint8Array(value);
}

export class TokenEncryptionService {
  constructor(private readonly keys: KeyWrapper) {}

  async encrypt(refreshToken: string, context: string): Promise<EncryptedSecret> {
    const dataKey = randomBytes(32);
    const iv = randomBytes(12);
    const cipher = createCipheriv("aes-256-gcm", dataKey, iv);
    cipher.setAAD(Buffer.from(context, "utf8"));
    const ciphertext = Buffer.concat([
      cipher.update(refreshToken, "utf8"),
      cipher.final(),
    ]);
    const authenticationTag = cipher.getAuthTag();
    let wrappedKey: Uint8Array;
    try {
      wrappedKey = await this.keys.wrap(dataKey);
    } finally {
      dataKey.fill(0);
    }

    return {
      version: 1,
      wrappedKey: Buffer.from(wrappedKey).toString("base64"),
      iv: iv.toString("base64"),
      authenticationTag: authenticationTag.toString("base64"),
      ciphertext: ciphertext.toString("base64"),
    };
  }

  async decrypt(secret: EncryptedSecret, context: string): Promise<string> {
    if (secret.version !== 1) {
      throw new Error(`Unsupported encrypted secret version: ${secret.version}`);
    }
    const dataKey = Buffer.from(
      await this.keys.unwrap(Buffer.from(secret.wrappedKey, "base64")),
    );
    try {
      const decipher = createDecipheriv(
        "aes-256-gcm",
        dataKey,
        Buffer.from(secret.iv, "base64"),
      );
      decipher.setAAD(Buffer.from(context, "utf8"));
      decipher.setAuthTag(Buffer.from(secret.authenticationTag, "base64"));
      return Buffer.concat([
        decipher.update(Buffer.from(secret.ciphertext, "base64")),
        decipher.final(),
      ]).toString("utf8");
    } finally {
      dataKey.fill(0);
    }
  }
}
