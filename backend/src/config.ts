import { z } from "zod";

const configSchema = z.object({
  GOOGLE_CLOUD_PROJECT: z.string().min(1),
  PUBLIC_BASE_URL: z.url(),
  GOOGLE_OAUTH_CLIENT_ID: z.string().min(1),
  GOOGLE_OAUTH_CLIENT_SECRET: z.string().min(1),
  GOOGLE_OAUTH_REDIRECT_URI: z.url(),
  KMS_KEY_NAME: z.string().min(1),
  GMAIL_PUBSUB_TOPIC: z
    .string()
    .regex(/^projects\/[^/]+\/topics\/[^/]+$/),
  INTERNAL_OIDC_AUDIENCE: z.url(),
  INTERNAL_CALLER_EMAIL: z.email(),
  PORT: z.coerce.number().int().positive().default(8080),
});

export type BackendConfig = z.infer<typeof configSchema>;

export function loadConfig(
  environment: NodeJS.ProcessEnv = process.env,
): BackendConfig {
  return configSchema.parse(environment);
}
