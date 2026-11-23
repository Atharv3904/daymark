DayMark Authentication — Unified Specification
Status: Consolidated approved requirements
Backend: Supabase Auth | State: Bloc/Cubit | Navigation: GoRouter | Architecture: Clean Architecture

1. Purpose and Authority
   This is the single source of truth for Authentication: registration, login, forgot-password, password-reset, email verification, session restoration/expiry, and sign-out.
   Instruction precedence:
1. System/safety requirements
1. Global DayMark rules
1. This specification
1. Relevant skills/procedures
1. Current task prompt
   Lower levels may clarify but must not override or weaken higher levels. Identify conflicts; resolve safely or ask if material. Never silently change approved requirements.
1. Functional Requirements
   ID Requirement
   FR-01 Provide registration, login, forgot-password, password-reset, email-verification, and sign-out through Supabase Auth.
   FR-02 Registration requires email and password only; no name field.
   FR-03 Validate locally before submitting, per Section 4.
   FR-04 Map provider errors to application-owned exceptions, per Section 9.
   FR-05 Manage auth state with Bloc/Cubit and persist sessions using approved secure handling.
   FR-06 GoRouter protects authenticated routes; unauthenticated users are redirected to Welcome.
   FR-07 Reset and verification callbacks must be reachable unauthenticated.
   FR-08 Distinguish local sign-out, global sign-out, token expiry, and refresh-token rejection/revocation.

1. Screens and Flows
   Screen/Flow Behavior
   Splash/Session Check Restore/check session; Home only if authenticated, otherwise Welcome.
   Welcome Entry to Login or Sign-up.
   Login Email/password; success to Home, failure shows safe message.
   Sign-up Email/password only; verification pending → notice; Home only after valid authenticated state.
   Forgot Password Request reset email; show neutral confirmation.
   Password Reset Public deep-link callback; validate recovery link/session; accept new password + confirmation; success follows verified post-reset behavior.
   Email Verification Validate callback; pending user returns to Login or Home only when authenticated.
   Verification Pending No protected Home access until verification and valid session are established.
   Home Protected; requires authenticated state.
   Settings/Sign-out Clear local session on successful sign-out; route to Welcome.

Route rules

- Home and feature routes require a valid authenticated state.
- Unauthenticated protected-route access redirects to Welcome.
- /reset-password, /forgot-password, and /verify-email (or actual configured equivalents) remain public for callback handling.
- Public callback access does not bypass validation.
- Verification-pending users cannot access protected content.
- Confirm actual route names and configured deep-link scheme, host, redirect URL, and fallback. Never invent configuration.
  Authentication flow in text: Splash checks/restores the session. A valid authenticated session routes to Home; otherwise, route to Welcome. Welcome opens Login or Sign-up. Successful Login routes to Home. Sign-up routes to Home only when verification and a valid authenticated session are established; otherwise, show the Email Verification Pending flow. Forgot Password requests a reset email and shows neutral confirmation. A valid reset callback opens Password Reset; successful reset routes to Login according to verified configuration. Email verification callback is validated; route to Home only if a valid authenticated session exists, otherwise route to Login. Sign-out clears the local session and routes to Welcome.

4. Input Contracts and Validation
   Flow Field Required Rule
   Register/Login/Forgot Email Yes Trim surrounding whitespace; validate format.
   Register/Login Password Yes Preserve exactly; minimum 8 characters.
   Reset New password Yes Preserve exactly; minimum 8 characters.
   Reset Confirmation Yes Exact match to new password.
   Rules:

- Reject empty/whitespace-only email and malformed email locally.
- Trim email before validation and submission.
- Never trim, normalize, or alter passwords; spaces are significant.
- Reject passwords shorter than 8 characters.
- Compare confirmation exactly.
- Client validation gives feedback; Supabase remains authoritative.
- Do not submit invalid inputs; prevent duplicate submissions during loading where supported.
- Do not add password rules unless required by verified provider policy or approved.
  Messages: Email required; Enter a valid email; Password must be at least 8 characters; Passwords do not match.

5. Registration Boundaries
   Condition Expected behavior
   Empty email Reject locally; “Email required”.
   Malformed email Reject locally; “Enter a valid email”; no request.
   Email whitespace Trim before validation/submission.
   Empty/short password Reject locally; minimum 8 characters.
   Password surrounding spaces Preserve exactly.
   Existing email Map to AppUserAlreadyExistsException only when provider evidence supports it.
   Weak password rejected by provider Map to AppWeakPasswordException.
   Network failure Recoverable error; never report success.
   Verification required Pending state; no Home until verified and valid session established.

6. Login Boundaries
   Condition Expected behavior
   Empty email/password Reject locally.
   Malformed email Reject locally.
   Email whitespace Trim.
   Password whitespace Preserve.
   Invalid credentials AppInvalidCredentialsException; remain unauthenticated.
   Unverified email rejected by provider AppEmailNotVerifiedException; do not authenticate.
   Network failure Recoverable; preserve any still-valid session.
   Expired session, renewal fails Unauthenticated; route to public auth screen.
   Refresh token confirmed rejected/revoked AppRefreshTokenRevokedException; clear invalid session and require sign-in.

7. Forgot-Password Boundaries

- Reject empty or malformed email locally; trim email.
- Success shows neutral confirmation; never disclose whether account exists.
- Network failure allows retry.
- Rate limits show safe wait-and-retry guidance; do not auto-repeat.
- Failure must not unnecessarily overwrite global auth state or invalidate an existing session.

8. Password Reset and Verification Callbacks

- Reset callback must be reachable while unauthenticated.
- Validate recovery link/session before accepting password.
- Malformed, expired, or used link: reject safely and offer another reset request.
- New password must be at least 8 characters; preserve exactly.
- Confirmation must match exactly.
- Update failure is recoverable; never show success.
- After success, follow configured behavior; do not assume automatic login unless verified.
- Verification callback must be validated. Pending users remain blocked from Home until verification and valid session requirements are met.
- Deep-link configuration/fallback must be verified; do not invent values.

9. Exceptions and Error Flow
   Exception names
   All extend AppAuthException:

- AppInvalidCredentialsException
- AppUserAlreadyExistsException
- AppWeakPasswordException
- AppEmailNotVerifiedException
- AppEmailVerificationPendingException
- AppNetworkException
- AppSessionExpiredException
- AppRefreshTokenRevokedException
- AppUnknownAuthException
  Do not name the base AuthException (Supabase uses that name).
  Layer responsibilities

1. DataSource: Catch Supabase/provider exceptions and map to application-owned exceptions.
2. Repository: Catch app exceptions and convert to project Failure/result; return Failure rather than throw to Presentation.
3. Bloc/Cubit: Consume repository results and emit states.
4. UI: Display safe state messages; never inspect provider exceptions.
   Supabase error → DataSource mapping → AppAuthException
   → Repository Failure → Bloc/Cubit state → UI message
   Rules: no raw provider messages in UI; specific friendly messages for known errors; generic safe failure for unknown errors; verify mappings against actual SDK responses; never log passwords/tokens.
5. Session and Sign-Out

- Restore/check session during Splash.
- Protected routes require valid authenticated state.
- Represent session checking, unauthenticated, authenticated, verification-pending, loading, and recoverable operation failure as needed by project conventions.
- Distinguish access-token expiry, refresh attempt/rejection, local sign-out, global sign-out, and revocation.
- If session cannot be renewed, transition to unauthenticated.
- Confirmed invalid/revoked refresh token clears invalid local session.
- Failed unrelated operations must not erase a valid session.
- Forgot-password must not cause unrelated auth transitions.
- Local sign-out clears the current device session.
- Do not promise immediate cross-device logout; verify Supabase global sign-out/revocation semantics.
- Global revocation/sign-out clears local session and transitions to Unauthenticated.
- Do not claim sign-out success before local session clearing succeeds.

11. Security and Privacy

- Never log, print, display, or expose passwords, access/refresh tokens, or recovery secrets.
- Use project-approved secure session persistence; plain SharedPreferences is prohibited for sensitive auth tokens unless a higher-priority approved rule explicitly permits it.
- Reset responses must not reveal account existence.
- Validate deep-link callbacks and recovery sessions.
- Handle rate limits without retry loops.
- Pending verification must not bypass route protection.
- Do not unnecessarily invalidate valid sessions.
- Verify provider/configuration behavior before relying on it.
- Follow global security, privacy, dependency, logging, and release requirements.

12. Verify Before Implementation
    Verify against installed Supabase SDK and configured project:

- Provider error codes/shapes; duplicate-email, weak-password, unverified-email behavior
- Reset and verification callback/session validation
- Deep-link scheme, host, redirect, fallback
- Rate-limit responses
- Session restoration, expiry, refresh and revocation semantics
- Local/global sign-out behavior
- Whether password reset auto-authenticates
  Never guess provider or deployment configuration.

13. Acceptance Criteria

- [ ] Registration has email/password only.
- [ ] Email is trimmed; passwords preserved exactly.
- [ ] Local validation and 8-character minimum work.
- [ ] Confirmation matches exactly.
- [ ] Login success requires valid authenticated session.
- [ ] Verification-pending users cannot access protected routes.
- [ ] Reset success response prevents account enumeration.
- [ ] Public callbacks are reachable and validated.
- [ ] Invalid/expired/used reset links handled safely.
- [ ] Provider errors mapped in DataSource.
- [ ] Repository returns Failure, not provider exceptions.
- [ ] Bloc/Cubit drives UI feedback.
- [ ] Protected routes require authentication.
- [ ] Expiry, refresh rejection, and sign-out are distinguished.
- [ ] Recoverable failure preserves valid session.
- [ ] No sensitive auth data is logged/exposed.
- [ ] Provider behavior/configuration verified, not guessed.

14. Consolidation
    This document supersedes the separate Authentication Specification, Boundary Conditions, Custom Exceptions, and Input Specification. Keep no divergent copies; archive old documents only if marked superseded by this file.
