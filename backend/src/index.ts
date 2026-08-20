import { Firestore } from "@google-cloud/firestore";
import { KeyManagementServiceClient } from "@google-cloud/kms";
import { applicationDefault, initializeApp } from "firebase-admin/app";
import { getAuth } from "firebase-admin/auth";
import { getMessaging } from "firebase-admin/messaging";

import { createApp } from "./app.js";
import { FirebaseIdentityVerifier } from "./auth.js";
import { loadConfig } from "./config.js";
import { FirestoreBackendStore } from "./repositories/store.js";
import { BackendService } from "./services/backend_service.js";
import { GoogleGateway } from "./services/google_gateway.js";
import {
  GoogleKmsKeyWrapper,
  TokenEncryptionService,
} from "./services/token_encryption.js";

const config = loadConfig();
const firebase = initializeApp({
  credential: applicationDefault(),
  projectId: config.GOOGLE_CLOUD_PROJECT,
});
const store = new FirestoreBackendStore(
  new Firestore({ projectId: config.GOOGLE_CLOUD_PROJECT }),
);
const encryption = new TokenEncryptionService(
  new GoogleKmsKeyWrapper(
    new KeyManagementServiceClient(),
    config.KMS_KEY_NAME,
  ),
);
const google = new GoogleGateway(
  config.GOOGLE_OAUTH_CLIENT_ID,
  config.GOOGLE_OAUTH_CLIENT_SECRET,
  config.GOOGLE_OAUTH_REDIRECT_URI,
  config.GMAIL_PUBSUB_TOPIC,
);
const service = new BackendService(
  store,
  google,
  encryption,
  getMessaging(firebase),
);
const app = createApp({
  config,
  service,
  identityVerifier: new FirebaseIdentityVerifier(getAuth(firebase)),
});
const server = app.listen(config.PORT, () => {
  console.info(
    JSON.stringify({ severity: "INFO", message: "backend_ready" }),
  );
});

process.on("SIGTERM", () => {
  server.close(() => process.exit(0));
});
