---
name: flutter-dependency-injection
description: Manage dependency registrations and initialization using DayMark's established DI container, lifecycle conventions, dependency ordering, constructor injection, and startup flow.
---

# Flutter Dependency Injection Skill

## Purpose

Inspect the existing DI container and initialization flow before changing; use the repository's established mechanism (GetIt only if confirmed).

- Centralize registrations and avoid duplicates.
- Register abstractions to implementations where defined.
- Respect lifecycle conventions (singleton, lazy singleton, factory, and Bloc/Cubit conventions).
- Register dependencies in dependency order.
- Await asynchronous initialization and ensure startup calls setup once.
- Prefer constructor injection; avoid pervasive service-locator access.
- Prevent circular dependencies and unnecessary registrations.
- Inspect the dependency graph and add only missing registrations.
- Verify dependency resolution, startup, and relevant tests.

## Agent Workflow

1. Read the relevant DayMark specification and project instructions.
2. Inspect existing implementation and neighboring patterns before editing.
3. Make the smallest scoped change consistent with the repository.
4. Run relevant analysis, formatting, and tests.
5. Report changed files, verification performed, and unresolved decisions.

## Guardrails

Do not invent requirements, duplicate existing abstractions, change unrelated code, or claim verification that was not performed.
