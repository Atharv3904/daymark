DayMark Authentication — Unified Specification
Status: Consolidated approved requirements
Backend: Python FastAPI REST API | Database: PostgreSQL (SQL) | State: Bloc/Cubit | Navigation: GoRouter | Architecture: Clean Architecture

Backend and Database Boundaries

- Flutter communicates with authentication services through the FastAPI REST API; it must never connect directly to PostgreSQL.
- FastAPI owns authentication validation, authorization, session/token policy, and account/profile persistence orchestration.
- PostgreSQL stores backend-managed identity/profile records as required by the approved data model. Use parameterized SQL, appropriate constraints, foreign keys, indexes, and versioned migrations.
- Database credentials, signing secrets, and privileged backend credentials must remain server-side.
- Authentication and profile initialization are not assumed to be atomic across API/database operations; follow the approved consistency and recovery strategy.
- Do not assume a particular ORM, authentication library, token format, or migration tool unless it is established by the project.

1. Authority and Scope
   This is the single source of truth for registration, login, forgot-password, password reset, email verification, session restoration/expiry, and sign-out.
   Precedence: system/safety → global DayMark rules → this SPEC → relevant skills → current task prompt. Lower levels may clarify but cannot weaken higher levels. Surface conflicts; never silently alter approved requirements.

Authentication owns account identity, credentials, authentication state, and session lifecycle. Profile owns profile data, initialization, viewing, and management. Registration must trigger the Profile lifecycle without implementing profile management itself. 2. Functional Requirements
ID Requirement
AUTH-FR-01 Support registration, login, forgot-password, password reset, email verification, and sign-out through the approved FastAPI authentication REST API.
AUTH-FR-02 Registration requires email and password only; no name field.
AUTH-FR-03 Validate locally before submitting.
AUTH-FR-04 Map backend/API errors to application-owned exceptions.
AUTH-FR-05 Manage auth state with Bloc/Cubit and approved secure session persistence.
AUTH-FR-06 GoRouter protects authenticated routes; unauthenticated users route to Welcome.
AUTH-FR-07 Reset and verification callbacks are reachable while unauthenticated and validated.
AUTH-FR-08 Distinguish local/global sign-out, token expiry, refresh rejection, and revocation.
AUTH-FR-09 After successful account creation, trigger the Profile initialization lifecycle defined by profile/spec.md; do not duplicate profile-management logic. 3. Screens and Routing
Screen Required behavior
Splash/session check Restore/check session; Home only for valid authenticated state, otherwise Welcome.
Welcome Entry to Login or Sign-up.
Login Email/password; success to Home; safe failure feedback.
Sign-up Email/password only; pending verification notice when needed; Home only with valid authenticated state.
Forgot Password Request reset email; neutral confirmation.
Password Reset Public recovery callback; validate recovery session/link; accept new password and confirmation.
Email Verification Validate callback; route Home only when authenticated, otherwise Login.
Verification Pending No protected access until verification and valid session requirements are met.
Home Protected; requires authenticated state.
Settings/Sign-out Sign out through shared auth flow; route to Welcome after confirmed session clearing.
Route Rules

- Home and feature routes require valid authenticated state.
- Unauthenticated protected-route access redirects to Welcome.
- Forgot-password, reset, and verification callback routes remain public for callback handling; public access does not bypass validation.
- Pending-verification users cannot access protected content.
- Verify actual route names, deep-link scheme/host, redirect URL, callback handling, and fallback against project/backend configuration. Do not invent values or create redirect loops.
  Flow: Splash checks session → authenticated Home or Welcome. Welcome opens Login/Sign-up. Login success → Home. Sign-up → Home only when verification and valid session conditions are met; otherwise pending notice. Forgot-password shows neutral confirmation. Valid recovery callback opens Reset Password; success follows verified backend/API behavior. Verification callback → Home only if a valid session exists, otherwise Login. Confirmed sign-out → Welcome.

4. Input Contracts and Validation
   Flow Input Rule
   Register/Login/Forgot Email Required; trim surrounding whitespace; validate format.
   Register/Login Password Required; preserve exactly; minimum 8 characters.
   Reset New password Required; preserve exactly; minimum 8 characters.
   Reset Confirmation Required; exact match.
   Rules:

- Reject empty/whitespace-only or malformed email locally.
- Trim email before validation/submission.
- Never trim, normalize, or alter passwords; spaces are significant.
- Reject passwords shorter than 8 characters.
- Confirmation must match exactly.
- Client validation provides feedback; the FastAPI backend remains authoritative.
- Do not submit invalid input; prevent duplicate submission while pending.
- Add no further password rules unless verified backend/API policy or approved requirement demands them.
  Messages: “Email required”, “Enter a valid email”, “Password must be at least 8 characters”, “Passwords do not match”.

5. Operation-Specific Boundaries
   Registration
   - Existing-account error is mapped only when backend/API response evidence supports it.
   - Provider-rejected weak password maps to the weak-password application exception.
   - Network failure is recoverable and never reports success.
   - Verification-required state remains protected until valid session conditions are met.
   - After account creation, trigger Profile initialization using the approved Profile contract. Profile initialization failure must be handled using the approved recovery/consistency strategy; do not falsely report the complete registration lifecycle as successful.
     Login
   - Empty/malformed inputs rejected locally.
   - Email trimmed; password preserved.
   - Invalid credentials remain unauthenticated.
   - Provider-rejected unverified email does not authenticate.
   - Network failure is recoverable and must not unnecessarily destroy a valid session.
   - Failed renewal transitions to unauthenticated.
   - Confirmed rejected/revoked refresh token clears invalid session and requires sign-in.
     Forgot Password
   - Validate and trim email.
   - Success uses neutral confirmation that does not reveal whether an account exists.
   - Network failure allows retry.
   - Rate-limit response gives safe wait guidance; no automatic retry loop.
   - Failure must not unnecessarily change global auth state or invalidate a valid session.
     Password Reset and Verification Callbacks
   - Callbacks remain reachable unauthenticated.
   - Validate recovery link/session and verification callback.
   - Expired, malformed, or used reset link is rejected safely and offers another reset request.
   - Update failure is recoverable; never show success prematurely.
   - After reset, follow configured behavior; do not assume auto-login.
   - Verification-pending users remain blocked from Home until required verification/session state is confirmed.
   - Deep-link configuration and fallback must be verified.
6. Application Exceptions and Error Flow
   All auth-specific exceptions extend AppAuthException. Do not use backend/client-library exception types as the application base exception.
   Required Exception Types
   - AppInvalidCredentialsException
   - AppUserAlreadyExistsException
   - AppWeakPasswordException
   - AppEmailNotVerifiedException
   - AppEmailVerificationPendingException
   - AppNetworkException
   - AppSessionExpiredException
   - AppRefreshTokenRevokedException
   - AppUnknownAuthException
     Layer Responsibilities
7. DataSource: Catch backend/API/client exceptions and map them to application-owned auth exceptions.
8. Repository: Convert application exceptions into project Failure/Result; return Failure to Presentation rather than leaking backend/API/client exceptions.
9. Bloc/Cubit: Consume repository results and emit states.
10. UI: Display safe messages; never inspect backend/API/client exceptions.
    Error path: backend/API error → DataSource mapping → app exception → Repository Failure → Bloc/Cubit state → UI message.
    Verify mappings against the actual FastAPI API contract and backend error responses. Use friendly known-error messages and a safe generic unknown-error message. Never expose raw backend/API messages or sensitive data. 7. Session and Sign-Out Behavior

- Restore/check session during Splash.
- Represent session-checking, unauthenticated, authenticated, verification-pending, loading, and recoverable failure states as needed.
- Distinguish access-token expiry, refresh attempts/rejection, local sign-out, global sign-out, and revocation.
- If renewal fails, transition to unauthenticated.
- Confirmed invalid/revoked refresh token clears the invalid local session.
- Unrelated failed operations must not erase a valid session.
- Forgot-password must not trigger unrelated auth transitions.
- Local sign-out clears the current device session.
- Do not promise immediate cross-device logout; verify backend/API semantics.
- Global revocation/sign-out clears local session and transitions to unauthenticated.
- Report sign-out success only after local session clearing succeeds.

8. Profile Lifecycle Boundary
   - Registration creates the authentication account through the FastAPI authentication API.
   - The backend coordinates any required PostgreSQL profile record using the approved schema, parameterized SQL, constraints, and transaction/consistency strategy.
   - Once the account identity is available, Authentication triggers or coordinates profile initialization through the approved Profile feature contract.
   - Authentication must not own profile fields, profile forms, profile editing, profile retrieval, or profile persistence implementation.
   - Profile initialization must be duplicate-safe/idempotent according to the approved Profile design.
   - Account creation and profile initialization must not be assumed to be atomic.
   - If profile initialization fails, follow the Profile-approved recovery strategy. Surface the appropriate state and do not silently claim all registration steps completed.
   - Profile lifecycle requirements and field definitions belong in profile/spec.md.
9. Security and Privacy
   - Never log, print, display, or expose passwords, access/refresh tokens, recovery secrets, or sensitive auth payloads.
   - Use approved secure session persistence; plain SharedPreferences is prohibited for sensitive authentication tokens unless explicitly allowed by higher-priority approved rules. Follow the backend authentication/session contract.
   - Reset responses must not reveal account existence.
   - Validate deep-link callbacks and recovery sessions.
   - Handle rate limits without retry loops.
   - Pending verification cannot bypass route protection.
   - Do not unnecessarily invalidate valid sessions.
   - Follow global security, privacy, dependency, logging, and release rules.
10. Verify Before Implementation
    Verify against the implemented FastAPI authentication API, API contract, and configured backend:
    - API error codes and response shapes, including duplicate-account, weak-password, and unverified-email behavior.
    - FastAPI authentication endpoints, request/response schemas, validation, authorization, and database persistence boundaries.
    - PostgreSQL profile/account schema, foreign keys, constraints, transaction behavior, migration status, and ownership enforcement where relevant.
    - Recovery and verification callback/session validation.
    - Deep-link scheme, host, redirect, and fallback.
    - Rate-limit responses.
    - Session restoration, expiry, refresh, and revocation semantics.
    - Local/global sign-out behavior.
    - Password-reset auto-authentication behavior.
    - Profile initialization contract and failure/retry behavior.
      Never guess API contracts, authentication behavior, or deployment configuration.
11. Acceptance Criteria
    - [ ] Signup uses email/password only.
    - [ ] Email is trimmed; passwords are preserved exactly.
    - [ ] Local validation and 8-character minimum work.
    - [ ] Confirmation matches exactly.
    - [ ] Login success requires valid authenticated state.
    - [ ] Verification-pending users cannot access protected routes.
    - [ ] Reset confirmation prevents account enumeration.
    - [ ] Public callbacks are reachable and validated.
    - [ ] Invalid/expired/used reset links are handled safely.
    - [ ] Provider errors are mapped in DataSource.
    - [ ] Repository returns Failure, not backend/API/client exceptions.
    - [ ] Bloc/Cubit drives UI feedback.
    - [ ] Protected routes require authentication.
    - [ ] Expiry, refresh rejection, and sign-out are distinguished.
    - [ ] Recoverable failure preserves valid session.
    - [ ] Sensitive auth data is not logged/exposed.
    - [ ] Registration triggers Profile initialization through the Profile boundary.
    - [ ] Profile-management logic is not duplicated in Authentication.
    - [ ] Profile initialization failure/recovery is handled.
    - [ ] Provider behavior/configuration is verified, not guessed.
12. Consolidation
    This SPEC replaces separate Authentication, Boundary Conditions, Custom Exceptions, and Input specifications. Maintain one current copy; mark old files superseded or archive them.
    Profile management remains defined in profile/spec.md.
