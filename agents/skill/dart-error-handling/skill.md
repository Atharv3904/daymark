---
name: dart-error-handling
description: Handle errors, exceptions, and failures across Clean Architecture using typed AppException, domain AppFailure, Either results, resilient parsing, and BLoC/Cubit state mapping.
---

# Dart Error Handling Skill

## Standards: ✓ Clean Architecture · ✓ Typed Failures · ✓ Either<Failure, T> · ✓ Safe UI

- **Exceptions vs Failures**:
  - `AppException` (Data): Thrown by DataSources on network, parsing, or FastAPI backend errors.
  - `AppFailure` (Domain): Returned by Repositories via `Left(Failure)`. Never thrown.
- **Layer Flow**:
  - `DataSource`: Catches HTTP/parsing errors; throws typed `AppException` (`ServerException`, `NetworkException`).
  - `Repository`: Catches `AppException`; maps to `AppFailure`; returns `Either<AppFailure, T>`.
  - `BLoC/Cubit`: Consumes `Either` via `.fold()`; emits error states with safe messages.
  - `UI`: Consumes state messages only; zero raw exceptions in Presentation.
- **Resilient Parsing**: Use `tryParse` with fallbacks: `int.tryParse(json['v']?.toString() ?? '') ?? 0`.
- **Security & Logging**: Never log passwords, tokens, or recovery secrets. Unmapped errors become `UnknownFailure`.

```dart
// Repository conversion
Future<Either<AppFailure, Item>> getItem(String id) async {
  try {
    return Right((await dataSource.getItem(id)).toEntity());
  } on ServerException catch (e) {
    return Left(ServerFailure(message: e.message));
  } catch (_) {
    return const Left(NetworkFailure());
  }
}
```
