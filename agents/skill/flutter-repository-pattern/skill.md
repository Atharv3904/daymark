---
name: flutter-repository-pattern
description: Implement domain repository contracts and data-layer implementations that coordinate data sources, map results to domain types, and follow DayMark's established error-handling and architecture conventions.
---

# Flutter Repository Pattern Skill

## Purpose

Repository contracts belong in the domain layer and implementations in data, following existing conventions. Repositories coordinate data sources, map infrastructure results to domain types, and expose task-oriented operations—not HTTP/JSON/database details.

- Reuse project result, failure, and exception patterns.
- Keep UI logic and business rules out of repositories.
- Do not invent caching, retries, offline fallback, or synchronization.
- Inspect neighboring repositories and define only required methods.
- Implement delegation, mapping, and error propagation.
- Register dependencies using established DI conventions.
- Test success, failure, mapping, and delegation.

## Agent Workflow

1. Read the relevant DayMark specification and project instructions.
2. Inspect existing implementation and neighboring patterns before editing.
3. Make the smallest scoped change consistent with the repository.
4. Run relevant analysis, formatting, and tests.
5. Report changed files, verification performed, and unresolved decisions.

## Guardrails

Do not invent requirements, duplicate existing abstractions, change unrelated code, or claim verification that was not performed.
