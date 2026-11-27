---
name: flutter-rest-api
description: Standards, conventions, and error-handling patterns for interacting with the FastAPI REST API backend from Flutter Clean Architecture Remote Data Sources.
---

# Flutter REST API Skill

This skill defines the standards and best practices for implementing REST API communication between the Flutter client and the FastAPI backend in DayMark.

## 1. Architectural Boundaries

- **Layer Placement:** REST API interactions occur strictly within **Remote Data Sources** (`data/datasource/`).
- **Dependencies Point Inward:** Domain repositories must never know about HTTP methods, status codes, headers, or client libraries.
- **Data Source Responsibilities:**
  - Execute HTTP requests using the project's approved HTTP client.
  - Serialize request bodies and deserialize JSON responses into DTOs/Data Models.
  - Catch low-level network and client exceptions and throw typed `AppException`s.
- **Repository Responsibilities:**
  - Catch `AppException` from data sources and map them to domain `AppFailure` instances.

```text
RemoteDataSource (HTTP / JSON / FastAPI)
    ↓ throws AppException
RepositoryImpl (Data Layer)
    ↓ maps to Left(AppFailure)
UseCase (Domain Layer)
    ↓ Either<AppFailure, Entity>
Bloc / Cubit (Presentation Layer)
```

## 2. HTTP Methods and Conventions

Follow RESTful conventions aligned with FastAPI route definitions:

| Action | HTTP Method | Expected Status Code | Description |
|---|---|---|---|
| Fetch Collection / Item | `GET` | `200 OK` | Safe, idempotent read operations. |
| Create Resource | `POST` | `201 Created` / `200 OK` | Submit resource creation payload. |
| Replace Resource | `PUT` | `200 OK` | Complete replacement of resource fields. |
| Partial Update | `PATCH` | `200 OK` | Update specified resource fields. |
| Delete Resource | `DELETE` | `204 No Content` / `200 OK` | Remove resource. |

## 3. Headers and Authentication

- **Content Negotiation:** Include standard headers on all JSON requests:
  - `Content-Type: application/json`
  - `Accept: application/json`
- **Authorization:** Authenticated requests must pass the bearer token:
  - `Authorization: Bearer <access_token>`
- Token attachment must be handled centrally via an HTTP client interceptor or authorized client wrapper rather than manually attached in every individual data source call.
- Never log raw authorization tokens, passwords, or credentials.

## 4. Error Handling and FastAPI Status Codes

FastAPI returns structured JSON error responses. Data sources must inspect HTTP response status codes and throw corresponding `AppException` types:

| Status Code | FastAPI / HTTP Meaning | Application Exception (`Data`) | Domain Failure (`Domain`) |
|---|---|---|---|
| `400` | Bad Request / Malformed Syntax | `ValidationException` | `ValidationFailure` |
| `401` | Unauthorized / Expired Token | `UnauthorizedException` | `AuthFailure.unauthorized()` |
| `403` | Forbidden / Insufficient Permission | `ForbiddenException` | `AuthFailure.forbidden()` |
| `404` | Not Found | `NotFoundException` | `NotFoundFailure` |
| `422` | Unprocessable Entity (FastAPI Pydantic validation error) | `ValidationException` | `ValidationFailure` |
| `500+` | Internal Server Error | `ServerException` | `ServerFailure` |
| N/A | Timeout / No Connection (`SocketException`) | `NetworkException` | `NetworkFailure` |

### FastAPI 422 Unprocessable Entity Handling
FastAPI provides detailed field validation errors in the response body under `detail`:
```json
{
  "detail": [
    {
      "loc": ["body", "email"],
      "msg": "value is not a valid email address",
      "type": "value_error.email"
    }
  ]
}
```
Remote Data Sources must extract and parse `msg` or return a safe aggregated user message rather than crashing or leaking raw stack traces.

## 5. Timeouts and Resilience

- Always configure explicit timeouts on the project's approved HTTP client:
  - **Connect Timeout:** 10–15 seconds.
  - **Receive / Send Timeout:** 15–30 seconds.
- Avoid infinite waiting or unhandled socket hangs.
- When a timeout occurs, translate it into `NetworkException('Connection timed out')`.

## 6. Implementation Workflow for Remote Data Sources

1. **Verify Contract:** Inspect the approved feature specification (`docs/specifications/<feature>/spec.md`) and API documentation before creating methods. Do not invent endpoints.
2. **Inject Client:** Inject the approved HTTP client via constructor into the Remote Data Source implementation.
3. **Serialize / Deserialize:** Use typed models (`fromJson` / `toJson`). Validate nullability explicitly.
4. **Wrap in Try-Catch:** Catch client-specific network exceptions and rethrow typed `AppException`.
5. **Map to Failure in Repository:** Ensure the repository implementation catches `AppException` and returns `Left(AppFailure)`.
6. **Format & Test:** Run `flutter test` for data source unit tests using mocked HTTP responses.
