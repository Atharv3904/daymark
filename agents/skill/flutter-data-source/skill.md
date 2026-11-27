---
name: flutter-data-source
description: Implement remote and local data sources that isolate infrastructure access, reuse shared clients and configurations, follow established serialization and error conventions, and handle required operations.
---

# Flutter Data Source Skill

## Purpose

Data sources isolate remote/local infrastructure access in the data layer. Inspect existing naming, interfaces, implementations, shared HTTP/storage clients, serialization, and error conventions.

- Remote sources encapsulate API calls; local sources encapsulate storage.
- Keep UI state, business rules, and repository orchestration out of data sources.
- Reuse configured clients, interceptors, authentication, and shared infrastructure.
- Never instantiate clients per request or bypass shared configuration.
- Return project-standard models/values and propagate errors through established patterns.
- Implement only required operations and test parsing, success, failures, and edge cases.
- Do not add caching or persistence unless specified.
- Create separate source interface and implementation files when required by the established architecture.

## Agent Workflow

1. Read the relevant DayMark specification and project instructions.
2. Inspect existing implementations and neighboring patterns before editing.
3. Make the smallest scoped change consistent with the repository.
4. Run relevant analysis, formatting, and tests.
5. Report changed files, verification performed, and unresolved decisions.

## Guardrails

Do not invent requirements, duplicate abstractions, change unrelated code, or claim verification that was not performed.
