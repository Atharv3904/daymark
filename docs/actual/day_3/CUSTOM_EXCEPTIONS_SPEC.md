# DayMark Authentication — Custom Exceptions Specification

**Status:** Signed off for requirements and implementation planning
**Scope:** Application-owned authentication exception naming and behavior
**Backend:** Supabase Auth

## 1. Purpose

Define application-level exceptions without colliding with Supabase's own exception types.

## 2. Naming convention

- Use `AppAuthException` as the application-owned base exception.
- Do **not** create an application exception named `AuthException`; Supabase already uses that name.
- Use the `App` prefix for concrete application exceptions.
- Catch and map Supabase exceptions at the data-source/repository boundary. Do not expose Supabase exception types to the presentation layer.

## 3. Exception contracts

| Application exception                  | Meaning / trigger                                                                           |
| -------------------------------------- | ------------------------------------------------------------------------------------------- |
| `AppAuthException`                     | Base type for application-owned authentication failures.                                    |
| `AppInvalidCredentialsException`       | Login credentials are invalid.                                                              |
| `AppUserAlreadyExistsException`        | Registration is rejected because the email is already registered.                           |
| `AppWeakPasswordException`             | Provider rejects the password as too weak.                                                  |
| `AppEmailNotVerifiedException`         | Login is rejected because email is unverified; no authenticated app session is established. |
| `AppEmailVerificationPendingException` | Registration is accepted but verification remains pending.                                  |
| `AppNetworkException`                  | Network/connectivity failure during an auth operation.                                      |
| `AppSessionExpiredException`           | Session is no longer valid and cannot be renewed.                                           |
| `AppRefreshTokenRevokedException`      | Refresh token is revoked or no longer accepted, when confirmed by provider response.        |
| `AppUnknownAuthException`              | An auth failure cannot safely be mapped to a known application exception.                   |

## 4. Handling rules

1. Every concrete exception extends `AppAuthException`.
2. Map provider-specific errors in the data layer.
3. The data source throws application-owned exceptions; the repository catches and converts them into user-defined `AuthFailure` types.
4. The repository returns failures to the upper layers instead of exposing exceptions to the presentation layer.
5. Do not expose raw Supabase messages, internal codes, passwords, or tokens to users.
6. Preserve diagnostic causes only where safe; never log passwords, access tokens, or refresh tokens.
7. Verify actual Supabase error responses and SDK behavior before finalizing mappings. Unknown cases map to `AppUnknownAuthException` and then to an appropriate failure.

## 5. Exception-to-Failure conversion

- Define application-owned `AuthFailure` types separately from exceptions.
- Each known `AppAuthException` should map to its corresponding `AuthFailure`.
- The repository returns the mapped failure rather than allowing the exception to reach the presentation layer.
- Success and failure should be represented through a typed result, such as `Either<AuthFailure, T>`.
- Unexpected programming errors should not be silently treated as normal authentication failures.

## 6. Acceptance criteria

- [ ] No app-defined class is named `AuthException`.
- [ ] All concrete app exceptions extend `AppAuthException`.
- [ ] Supabase errors are translated at the data boundary.
- [ ] The repository converts application exceptions into user-defined failures.
- [ ] Presentation code has no dependency on Supabase exception classes.
- [ ] Raw provider messages and sensitive values are not shown or logged.
- [ ] Unmapped failures become `AppUnknownAuthException` before being mapped to a failure.

## 7. Sign-off

The application exception naming convention and contracts are signed off. Exact provider-to-app mappings must be validated against the Supabase SDK/project configuration used by DayMark.

## Specification Sign-off

| Field         | Details                         |
| ------------- | ------------------------------- |
| Specification | Custom Exceptions Specification |
| Project       | DayMark                         |
| Version       | 1.0                             |
| Status        | APPROVED                        |
| Reviewed By   | Project Owner                   |
| Approval Date | 2026-11-13                      |

### Approval Checklist

- [ ] Application exception naming convention is defined.
- [ ] Base and concrete exception types are specified.
- [ ] Exception handling rules are defined.
- [ ] Exception-to-Failure conversion responsibility is identified.
- [ ] Acceptance criteria are defined.

**Approval Decision:** APPROVED

**Note:** Approved for implementation planning. Exact Supabase provider-to-application exception mappings still require validation.
