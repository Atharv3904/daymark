---
name: flutter-logging
description: Implement privacy-safe, structured logging and diagnostics using DayMark's established logging abstraction, log levels, error reporting, and debug/release policies.
---

# Flutter Logging Skill

## Purpose

Inspect logging abstraction, levels, debug/release policy, and error reporting.

- Use shared logging instead of scattered `print` or `debugPrint`.
- Log useful diagnostic context with low noise.
- Never log passwords, tokens, secrets, personal data, or sensitive request/response bodies.
- Avoid duplicate error reporting and excessive per-widget or per-frame logs.
- Include stack traces for unexpected failures using project conventions.
- Separate developer diagnostics from user-facing messages.
- Verify production logging and filtering policies.
- Don't add logging or telemetry packages/services without approval.

## Agent Workflow

1. Read the relevant DayMark specification and project instructions.
2. Inspect existing logging implementation and neighboring patterns before editing.
3. Identify logging requirements, privacy risks, error-reporting behavior, and environment policies.
4. Make the smallest scoped change consistent with the repository.
5. Run relevant analysis, formatting, and tests.
6. Report changed files, verification performed, and unresolved decisions.

## Guardrails

Do not invent requirements, duplicate existing abstractions, change unrelated code, or claim verification that was not performed.
