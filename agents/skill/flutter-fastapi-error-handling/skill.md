---
name: flutter-fastapi-error-handling
description: Handle errors, exceptions, API errors, and failures across Flutter Clean Architecture and FastAPI. Automatically activate whenever tasks involve exceptions, error handling, failures, Dio, HTTP, validation, parsing, authentication, database errors, or error responses.
---

# Flutter + FastAPI Error Handling

- **Exceptions (Data/Backend):** Technical errors. DataSources throw typed `AppException` (NetworkException, ServerException, TimeoutException, UnauthorizedException, ParsingException, etc.). FastAPI handles backend exceptions centrally.
- **Failures (Domain):** Repositories catch Exceptions, map them to `AppFailure`, and return `Either<AppFailure, T>`. Failures are never thrown.
- **Flutter Flow:** DataSource → throws Exception → Repository → maps Failure → Either → UseCase → BLoC/Cubit → UI state.
- **FastAPI Flow:** Router → Service → Repository → Database. Use centralized exception handlers and consistent HTTP status codes/error schemas.
- **Dio:** Convert Dio/HTTP errors into typed AppExceptions inside DataSources. Never leak Dio exceptions to Domain or Presentation.
- **BLoC/Cubit:** Handle `Either` using `fold()`. Emit safe error states. Never handle technical exceptions directly.
- **Parsing:** Validate JSON types, nullable/missing fields, and malformed responses. Use safe parsing; avoid arbitrary defaults.
- **API Responses:** Consistent structure containing `success`, `message`, `error_code`, and optional `details`. Never expose stack traces, SQL errors, secrets, or internal details.
- **Security:** Never log passwords, tokens, OTPs, recovery secrets, or sensitive personal data.
- **Unknown errors:** Map to `UnknownFailure` / safe HTTP 500 responses; log diagnostic details securely.

## **Core rule:** Technical exceptions belong to implementation layers; Domain Failures belong to Domain; user-facing messages belong to Presentation; HTTP error handling belongs to FastAPI.
