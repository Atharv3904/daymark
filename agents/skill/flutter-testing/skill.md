---
name: flutter-testing
description: Write, maintain, and execute deterministic Flutter tests covering logic, repositories, Bloc/Cubit, widgets, interactions, and critical user journeys using DayMark's established testing conventions.
---

# Flutter Testing Skill

## Purpose

Inspect the existing test structure, helpers, fixtures, packages, and conventions before writing or modifying tests.

- Test observable behavior rather than private implementation details.
- Unit-test logic, mappers, repositories, and Bloc/Cubit state transitions.
- Widget-test rendering, interactions, validation, and UI states.
- Use integration tests for critical user journeys when configured.
- Keep tests deterministic, isolated, and independent of real network/database calls.
- Reuse existing mocks, fakes, fixtures, and test helpers.
- Cover success, failure, boundaries, edge cases, and regressions.
- Don't weaken, remove, or modify existing tests merely to make code pass.
- Run targeted tests first, followed by relevant broader tests.
- Report exact commands and results; never claim success without command evidence.

## Agent Workflow

1. Read the relevant DayMark specification and project instructions.
2. Inspect existing implementation, tests, helpers, and neighboring patterns.
3. Identify expected behavior and relevant test scenarios.
4. Make the smallest scoped change consistent with the repository.
5. Run relevant analysis, formatting, and tests.
6. Report changed files, commands executed, results, and unresolved decisions.

## Guardrails

Do not invent requirements, duplicate existing abstractions, change unrelated code, weaken tests, or claim verification that was not performed.
