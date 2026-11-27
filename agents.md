DayMark — Global Agent Instructions

Standards: ✓ SOLID · ✓ Null safety · ✓ Explicit types · ✓ Architecture · ✓ Verification · ✓ User Control

- Project: DayMark is a Flutter/Dart personal productivity tracker. Backend is Python FastAPI with a PostgreSQL database. Flutter communicates with the backend exclusively through REST APIs; never connect directly to PostgreSQL from Flutter, and never assume or introduce Supabase as DayMark's backend. Use the existing feature-first Clean Architecture, Bloc/Cubit, GetIt, GoRouter, and established project patterns.
- Authority: Follow system/safety instructions, this file, approved specifications, relevant skills, then the task. Specs are the source of truth; flag conflicts or missing decisions.
- Context: Inspect repository, relevant code, callers, and project structure. For feature requests, identify the feature from the user's prompt, locate its corresponding `spec.md` within `docs/specifications`, and read it before implementation. Load only relevant specifications and referenced documents. If no matching spec exists or requirements are ambiguous, report it and stop instead of inventing behavior. Never execute Git commands or perform Git operations.
- Architecture: Presentation → Domain → Data. Keep UI thin; business rules in Domain; repository contracts in Domain and implementations in Data. Use constructor injection and existing DI/state-management patterns.
- Code: Apply SOLID, null safety, explicit types, clear naming, small focused changes, and consistent conventions. Avoid duplication, unnecessary abstractions, unrelated refactors, and new dependencies without justification.
- State/errors: Bloc/Cubit must not access DataSources directly. Handle Either/Failures consistently; never leak raw exceptions to UI. Validate inputs and preserve lifecycle/subscription correctness.
- Security: Never expose secrets or service-role keys. Use authenticated server-side access, ownership checks, and RLS. Do not store sensitive data in SharedPreferences or logs.
- Scope: Implement only requested and approved behavior. Preserve existing functionality and user work. Do not perform destructive file operations without permission.
- Approval: Before modifying any file, present a file-by-file proposal stating the file path, planned changes, reason, and affected files/behavior. Request explicit permission for each file. Modify only individually approved files. If additional files become necessary, stop, explain, and request approval before modifying them. Never assume approval.
- Verify: Before delivery, format changed Dart files; run `flutter analyze`; resolve all errors, warnings, and actionable issues; rerun analysis until clean. Run relevant tests, fix failures, and report unresolved pre-existing issues honestly.
- Done: Review changed files, affected callers, tests, security, and edge cases. Report changes, verification results, and remaining risks concisely. Never claim unperformed verification.
