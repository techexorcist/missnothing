import { describe, expect, it } from "vitest";

import {
  TokenEncryptionService,
  type KeyWrapper,
} from "../src/services/token_encryption.js";

class ReversibleTestKeyWrapper implements KeyWrapper {
  async wrap(plaintext: Uint8Array): Promise<Uint8Array> {
    return Uint8Array.from(plaintext, (byte) => byte ^ 0xa5);
  }

  async unwrap(ciphertext: Uint8Array): Promise<Uint8Array> {
    return Uint8Array.from(ciphertext, (byte) => byte ^ 0xa5);
  }
}

describe("TokenEncryptionService", () => {
  it("round-trips a token without storing plaintext", async () => {
    const service = new TokenEncryptionService(new ReversibleTestKeyWrapper());
    const encrypted = await service.encrypt(
      "refresh-token-secret",
      "user:account",
    );

    expect(JSON.stringify(encrypted)).not.toContain("refresh-token-secret");
    await expect(
      service.decrypt(encrypted, "user:account"),
    ).resolves.toBe("refresh-token-secret");
  });

  it("binds ciphertext to its account context", async () => {
    const service = new TokenEncryptionService(new ReversibleTestKeyWrapper());
    const encrypted = await service.encrypt("refresh-token", "user:account-a");

    await expect(
      service.decrypt(encrypted, "user:account-b"),
    ).rejects.toThrow();
  });
});
