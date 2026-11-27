# DayMark Authentication — Boundary Conditions Specification

**Status:** Signed off for requirements and implementation planning  
**Scope:** Register, login, forgot-password, and password-reset edge cases  
**Backend:** Supabase Auth

## 1. Purpose

Define expected behavior for invalid inputs, unusual states, and failures in the Authentication feature.

## 2. Registration boundaries

| Condition                                | Expected behavior                                                                                                 |
| ---------------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| Email empty or whitespace-only           | Reject locally and show field validation.                                                                         |
| Email malformed                          | Reject locally; do not submit.                                                                                    |
| Email has surrounding whitespace         | Trim before validation and submission.                                                                            |
| Password empty                           | Reject locally.                                                                                                   |
| Password shorter than 8 characters       | Reject locally.                                                                                                   |
| Password has leading/trailing spaces     | Preserve exactly; do not trim.                                                                                    |
| Email already registered                 | Map to `AppUserAlreadyExistsException` when provider response supports this conclusion.                           |
| Password rejected as weak                | Map to `AppWeakPasswordException`.                                                                                |
| Network unavailable                      | Show recoverable error; do not report success.                                                                    |
| Email verification required              | Show verification-pending state; do not grant Home access until verification and a valid session are established. |
| Confirm Password empty                   | Reject locally and show field validation.                                                                         |
| Confirm Password does not match Password | Reject locally and show field-level feedback.                                                                     |

## 3. Login boundaries

| Condition                                   | Expected behavior                                                                                         |
| ------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| Email or password empty                     | Reject locally.                                                                                           |
| Email malformed                             | Reject locally.                                                                                           |
| Email has surrounding whitespace            | Trim email before submission.                                                                             |
| Password has leading/trailing spaces        | Preserve exactly.                                                                                         |
| Credentials incorrect                       | Map to `AppInvalidCredentialsException`; do not authenticate.                                             |
| Email unverified and provider rejects login | Map to `AppEmailNotVerifiedException`; do not treat user as authenticated.                                |
| Network unavailable                         | Show recoverable error and preserve any still-valid current auth state.                                   |
| Session expired and cannot be renewed       | Transition to unauthenticated and route to a public auth screen.                                          |
| Refresh token rejected/revoked              | Map to `AppRefreshTokenRevokedException` when confirmed; clear invalid local session and require sign-in. |

## 4. Forgot-password boundaries

| Condition                                     | Expected behavior                                                          |
| --------------------------------------------- | -------------------------------------------------------------------------- |
| Email empty or whitespace-only                | Reject locally.                                                            |
| Email malformed                               | Reject locally.                                                            |
| Email has surrounding whitespace              | Trim before submission.                                                    |
| Reset-email request succeeds                  | Show neutral confirmation; do not disclose whether an account exists.      |
| Network unavailable                           | Show recoverable error and allow retry.                                    |
| Provider rate-limits requests                 | Show safe wait-and-retry guidance; do not repeatedly submit automatically. |
| Request fails while another auth state exists | Do not unnecessarily overwrite the global authentication state.            |

## 5. Password-reset deep-link boundaries

| Condition                                       | Expected behavior                                                                                             |
| ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| Valid reset deep link opens app                 | Open password-reset flow and validate recovery link/session before accepting a new password.                  |
| Link is malformed, expired, or already used     | Reject reset; show safe message and offer a new reset-email request.                                          |
| App receives link while unauthenticated         | Callback route remains reachable, but link/session validation is mandatory.                                   |
| New password empty or shorter than 8 characters | Reject locally.                                                                                               |
| Confirmation does not exactly match             | Reject locally with field-level feedback.                                                                     |
| Password update fails                           | Show recoverable failure; do not show success.                                                                |
| Reset succeeds                                  | Show confirmation and follow the agreed post-reset navigation; do not assume automatic login unless verified. |
| App cannot open the configured link             | Use only the configured fallback behavior; verify deployment configuration.                                   |

## 6. Session and navigation boundaries

- Protected Home routes require a valid authenticated state.
- Password-reset callback routes are reachable unauthenticated, but this does not bypass recovery-link validation.
- An email-verification-pending user cannot access Home.
- An operation failure must not erase a still-valid authenticated session.
- Forgot-password success/failure must not force an unrelated global auth-state transition.
- Local sign-out clears the current device's local session.
- Do not promise immediate cross-device logout; verify Supabase global sign-out and refresh-token revocation semantics.
- Handle access-token expiration, refresh-token rejection, and explicit sign-out as distinct cases.

## 7. Security and privacy boundaries

- Never log or display passwords, access tokens, or refresh tokens.
- Password-reset responses must not reveal whether an email exists.
- Use HTTPS in production.
- Never place the Supabase service-role key in the Flutter client.
- Enforce data authorization with backend policies such as PostgreSQL Row Level Security; UI route guards are not a security boundary.
- Select and verify secure session storage before implementation; do not assume default persistence is encrypted.

## 8. Acceptance criteria

- [ ] Empty/malformed inputs are rejected before network submission.
- [ ] Email is trimmed; passwords are never trimmed.
- [ ] Invalid credentials and duplicate registration have distinct mapped outcomes where provider responses allow.
- [ ] Unverified login does not create authenticated state.
- [ ] Forgot-password flow does not disclose account existence.
- [ ] Rate limits and network failures are handled without false success.
- [ ] Invalid, expired, and reused reset links are rejected safely.
- [ ] Callback route is reachable unauthenticated but validates the recovery link/session.
- [ ] Verification-pending and unauthenticated users cannot access Home.
- [ ] Auth operation failures do not destroy a valid existing session.
- [ ] Credentials and tokens are never logged or exposed.
- [ ] Secure storage and provider-specific session behavior are verified before release.

## 9. Sign-off

The application behavior for these boundary conditions is signed off. Exact provider error codes, redirect behavior, rate limits, and token-revocation semantics must be verified against the configured Supabase project and SDK before implementation.

## Specification Sign-off

| Field         | Details             |
| ------------- | ------------------- |
| Specification | Input Specification |
| Project       | DayMark             |
| Version       | 1.0                 |
| Status        | APPROVED            |
| Reviewed By   | Project Owner       |
| Approval Date | 2026-11-13          |

### Approval Checklist

- [] All input fields are defined.
- [] Dart types are specified.
- [] Validation rules are defined.
- [] Required and optional inputs are identified.
- [] Acceptance criteria are satisfied.

**Approval Decision:** APPROVED

**Note:** Approved for implementation planning.
