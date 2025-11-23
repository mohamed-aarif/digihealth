# digihealth HTTP API Host

## Using Swagger OAuth locally

Use the Swagger **Authorize** dialog with the following values for local development:

- **Authorization URL:** `https://localhost:44322/connect/authorize`
- **Token URL:** `https://localhost:44322/connect/token`
- **Client ID:** `digihealth_Swagger`
- **Redirect URI:** `https://localhost:44322/swagger/oauth2-redirect.html`
- **Scopes:** `digihealth`

Swagger now uses PKCE with a public client, so no client secret is required. Sign in with an existing test/admin account when prompted to obtain tokens.

If you previously created the Swagger client with a client secret, rerun the **digihealth.DbMigrator** after pulling these changes so the OpenIddict application row is updated (the migrator reruns the data seed and clears the stored secret/marks the client as public).
