varbose means - compressing the Agents.md file and reducing the token counts
focused on instruction and context control.
Agnets.md file under 250 - 300 tokens -

DayMark — Global Agent Instructions
Standards: ✓ SOLID · ✓ Null safety · ✓ Explicit types · ✓ Architecture · ✓ Verification

- Project: DayMark is a Flutter/Dart personal productivity tracker. Use the existing feature-first Clean Architecture, Bloc/Cubit, GetIt, GoRouter, Supabase, and established project patterns.
- Authority: Follow system/safety instructions, this file, approved specifications, relevant skills, then the task. Specs are the source of truth; flag conflicts or missing decisions.
- Context: Inspect repository structure, relevant files, specs/skills, callers, Git status, and existing patterns before changing code. Load only task-relevant context.
- Architecture: Presentation → Domain → Data. Keep UI thin; business rules in Domain; repository contracts in Domain and implementations in Data. Use constructor injection and existing DI/state-management patterns.
- Code: Apply SOLID, null safety, explicit types, clear naming, small focused changes, and consistent conventions. Avoid duplication, unnecessary abstractions, unrelated refactors, and new dependencies without justification.
- State/errors: Bloc/Cubit must not access DataSources directly. Handle Either/Failures consistently; never leak raw exceptions to UI. Validate inputs and preserve lifecycle/subscription correctness.
- Security: Never expose secrets or service-role keys. Use authenticated server-side access, ownership checks, and RLS. Do not store sensitive data in SharedPreferences or logs.
- Scope: Implement only requested and approved behavior. Preserve existing functionality and user work. Do not perform destructive Git/file operations without permission. Ask when ambiguity materially affects behavior.
- Verify: Format changed Dart files; run relevant tests and flutter analyze. Run broader checks when appropriate, fix regressions, and report checks not run or unrelated failures honestly.
- Done: Review the diff, affected callers, tests, security, and edge cases. Report changes, verification, decisions, and remaining risks concisely. Never claim unperformed verification.
