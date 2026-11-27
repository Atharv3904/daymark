# Skill: DayMark Authentication

## 1. Purpose

Use this skill when implementing, modifying, reviewing, testing, or debugging Authentication features, including Registration, Login, Password Recovery, Email Verification, Callbacks, Sessions, Sign-Out, Routes, and related Data/Domain/Presentation components.

**Source of truth:** `authentication_spec.md` defines requirements. This skill defines the implementation procedure.

## 2. Instruction Priority

1. System and safety requirements
2. Global DayMark rules (`AGENTS.md`)
3. `authentication_spec.md`
4. Relevant skills
5. Current task prompt

Lower-priority instructions cannot override higher-priority rules. Identify conflicts and ask if they cannot be safely resolved.

## 3. Preflight

Before editing:

- Read `AGENTS.md` and the complete `authentication_spec.md`.
- Inspect relevant Authentication files and existing project conventions.
- Verify Supabase, routing, DI, storage, Failure/result, and Bloc/Cubit patterns when relevant.
- Inspect related tests and current behavior.
- Confirm scope, dependencies, and affected files.

**Do not assume APIs, paths, routes, dependencies, or architecture. Verify them in the repository.**

## 4. Architecture Rules

Follow existing Clean Architecture.

### Presentation

- UI displays state and collects input.
- Bloc/Cubit manages UI state and orchestrates actions.
- No direct Supabase calls or provider-specific error handling.
- Display safe application messages.

### Domain

- Contains repository contracts, entities, and use cases where required.
- Uses existing result/Failure conventions.
- Must remain independent of Supabase and Presentation.

### Data

- DataSources handle Supabase interactions.
- Map provider errors to application-owned exceptions.
- Repositories convert exceptions into project Failure/results.
- No UI messaging or navigation.

**Dependency direction:** Presentation → Domain; Data implements Domain contracts. Reuse existing DI and abstractions.

## 5. Implementation Workflow

1. **Define scope:** Identify requested changes and exclusions.
2. **Trace flow:** UI → Bloc/Cubit → Use Case (if present) → Repository → DataSource → Supabase.
3. **Reuse:** Follow existing files, naming, state, DI, and result patterns.
4. **Validate inputs:** Trim email; preserve passwords exactly; enforce specification rules; prevent invalid or duplicate submissions.
5. **Verify provider behavior:** Use the installed SDK and configured client. Confirm API, error, callback, and session behavior instead of guessing.
6. **Handle errors:** Map only verified errors. Use safe recoverable handling for unknown errors.
7. **Manage state:** Emit consistent loading, success, and failure states. Preserve valid sessions during unrelated recoverable failures.
8. **Handle UI and routes:** Keep provider logic out of widgets. Verify GoRouter configuration, callback handling, and protected routes.
9. **Review security:** Check secrets, sensitive logging, storage, callback validation, account enumeration, and session handling.
10. **Verify:** Run relevant formatting, analysis, and tests. Report only checks actually performed.

## 6. Authentication Requirements Checklist

Apply only the checklist relevant to the task.

### Registration

- Email and password only; no name.
- Trim and validate email.
- Preserve password exactly; minimum 8 characters.
- Validate confirmation exactly when required.
- Reject invalid input locally.
- Map errors based on verified provider behavior.
- Handle network failures recoverably.
- Handle verification-pending state.
- Prevent access to protected routes without a valid verified session.

### Login

- Trim email; preserve password.
- Handle invalid credentials and unverified email.
- Success requires a valid session.
- Recoverable failures must not unnecessarily destroy a valid session.

### Forgot Password

- Validate and trim email.
- Use neutral responses to prevent account enumeration.
- Handle rate limits with guidance; no automatic retry loops.
- Do not change unrelated authentication state.

### Password Reset & Verification

- Callbacks must use public routes and be validated.
- Handle malformed, expired, and already-used links safely.
- Validate password and confirmation.
- Never show success when the operation failed.
- Verify post-reset and verification behavior.
- Pending verification must not access protected routes.

### Sessions & Sign-Out

- Verify session restoration.
- Use state-driven route guards.
- Distinguish expiry, refresh rejection, and sign-out semantics.
- Clear invalid sessions when required.
- Preserve valid sessions during unrelated recoverable failures.

## 7. Testing

Follow existing testing conventions. Test relevant behavior:

- Input validation and boundary conditions.
- Success and failure mapping.
- Recoverable/network failures.
- Authentication state transitions.
- Session preservation and clearing.
- Route guards and callbacks when affected.
- Password reset and verification flows when affected.

Use mocks/fakes. Never use real credentials or production accounts.

## 8. Change Discipline

- Keep changes focused on the task.
- Reuse existing architecture and conventions.
- Do not introduce dependencies without justification and required approval.
- Do not silently change specifications.
- Avoid unrelated refactoring.
- Report specification gaps separately.

## 9. Completion Report

Report:

1. **Implemented:** Summary
2. **Files changed:** Exact paths
3. **Requirements:** Covered requirements
4. **Decisions:** Important architecture/security decisions
5. **Verification:** Commands and actual results
6. **Issues:** Remaining unknowns or problems
7. **Out of scope:** Anything intentionally not changed

## 10. Non-Negotiable Rules

Never:

- Bypass instruction hierarchy or architecture silently.
- Expose provider exceptions to Presentation.
- Log credentials, tokens, or recovery secrets.
- Invent provider configuration or behavior.
- Trust unvalidated authentication callbacks.
- Claim verification or tests passed without evidence.

If a material conflict or unknown cannot be safely resolved, stop and ask.
