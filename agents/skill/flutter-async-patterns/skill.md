---
name: flutter-async-patterns
description: Handle asynchronous Flutter operations using Future, Stream, and Bloc/Cubit patterns while managing loading states, errors, concurrency, race conditions, cancellation, and lifecycle safely.
---

# Flutter Async Patterns Skill

## Purpose

Follow DayMark's established Future, Stream, Bloc/Cubit, and asynchronous operation patterns.

- Await operations when completion, results, or errors matter.
- Avoid untracked fire-and-forget operations.
- Never perform asynchronous work inside `build()`.
- Represent user-visible operations with appropriate loading, success, and error states.
- Prevent duplicate operations and stale responses when concurrent requests can race.
- Respect cancellation, disposal, and widget/state lifecycle.
- Avoid swallowed exceptions and broad catches; propagate or map errors using project conventions.
- Parallelize independent operations only when safe.
- Use isolates only when justified by profiling or computational requirements.
- Test success, failure, concurrency, race conditions, and lifecycle scenarios.
- Do not introduce retries, caching, or complex concurrency mechanisms without requirements.

## Agent Workflow

1. Read the relevant DayMark specification and project instructions.
2. Inspect existing implementation and neighboring patterns before editing.
3. Identify async operations, state transitions, concurrency, and lifecycle risks.
4. Make the smallest scoped change consistent with the repository.
5. Run relevant analysis, formatting, and tests.
6. Report changed files, verification performed, and unresolved decisions.

## Guardrails

Do not invent requirements, duplicate existing abstractions, change unrelated code, or claim verification that was not performed.
