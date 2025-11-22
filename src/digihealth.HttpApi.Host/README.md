# digihealth HTTP API Host

## Using Swagger OAuth locally

Use the Swagger **Authorize** dialog with the following values for local development:

- **Authorization URL:** `https://localhost:44322/connect/authorize`
- **Token URL:** `https://localhost:44322/connect/token`
- **Client ID:** `digihealth_Swagger`
- **Redirect URI:** `https://localhost:44322/swagger/oauth2-redirect.html`
- **Scopes:** `digihealth`

PKCE is enabled for the Swagger UI client, so no client secret is required when authorizing in the browser.

Sign in with an existing test/admin account when prompted to obtain tokens. Replace the hard-coded secret with a secure secret store for non-development environments.
