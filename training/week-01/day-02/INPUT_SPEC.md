# DayMark Authentication — Input Specification

**Status:** Signed off for requirements and implementation planning  
**Scope:** Register, login, and forgot-password input contracts  
**Backend:** Supabase Auth

## 1. Purpose

Define the exact inputs accepted by registration, login, and forgot-password flows.

## 2. Input contracts

| Flow            | Field            | Type   | Required | Rules                                                                                  |
| --------------- | ---------------- | ------ | -------- | -------------------------------------------------------------------------------------- |
| Register        | Email            | String | Yes      | Trim surrounding whitespace; validate email format.                                    |
| Register        | Password         | String | Yes      | Preserve exactly as entered; never trim. Minimum 8 characters.                         |
| Register        | Confirm Password | String | Yes      | Preserve exactly as entered; never trim. Must exactly match the registration Password. |
| Login           | Email            | String | Yes      | Trim surrounding whitespace; validate email format.                                    |
| Login           | Password         | String | Yes      | Preserve exactly as entered; never trim.                                               |
| Forgot password | Email            | String | Yes      | Trim surrounding whitespace; validate email format.                                    |
| Reset password  | New password     | String | Yes      | Preserve exactly; minimum 8 characters.                                                |
| Reset password  | Confirm password | String | Yes      | Must exactly match the new password.                                                   |

## 3. Password-reset email and deep link

- Forgot Password accepts an email and requests a password-reset email through Supabase Auth.
- The email contains a deep link that returns the user to the app's password-reset flow.
- The app must receive the reset callback while the user is unauthenticated.
- The recovery link/session must be validated before allowing a password change.
- The deep-link scheme, host, and redirect URL are configuration decisions. Confirm them against the Supabase project and app configuration before implementation; do not invent values.

## 4. Input handling rules

1. Reject empty or whitespace-only email values.
2. Trim email before validation and submission.
3. Never trim or normalize passwords. Leading and trailing spaces are significant.
4. Reject passwords shorter than 8 characters.
5. Confirm-password comparison is exact.
6. Client validation improves feedback; Supabase remains authoritative for server-side rules.

## 5. Acceptance criteria

- [ ] Register, login, and forgot-password require valid email input.
- [ ] Register and login require a password.
- [ ] Password reset requires a new password and matching confirmation.
- [ ] Email is trimmed consistently; passwords are preserved exactly.
- [ ] Passwords shorter than 8 characters are rejected locally.
- [ ] Reset email uses the configured deep link.
- [ ] Reset callback can be reached unauthenticated, while still validating the recovery link/session.
- [ ] Registration requires Confirm Password.
- [ ] Registration Confirm Password must exactly match Password.

## 6. Sign-off

Input requirements are signed off. The actual redirect URI and Supabase configuration must be verified before implementation.

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

- [x] All input fields are defined.
- [x] Dart types are specified.
- [x] Validation rules are defined.
- [x] Required and optional inputs are identified.
- [x] Acceptance criteria are satisfied.

**Approval Decision:** APPROVED

**Note:** Approved for implementation planning.
