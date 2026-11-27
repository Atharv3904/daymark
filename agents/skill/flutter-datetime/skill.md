---
name: flutter-datetime
description: Handle date-only values, local date-times, absolute instants, formatting, timezone conversions, date boundaries, recurrence, and reminders without inventing timezone rules.
---

# Flutter Datetime Skill

## Purpose

Handle dates and times correctly across DayMark. Determine whether values represent date-only values, local date-times, or absolute instants. Inspect API formats and the project's timezone policy before implementation.

- Don't assume UTC, local time, or a fixed timezone.
- Reuse shared date/time utilities.
- Keep parsing, formatting, date-range calculations, and timezone logic out of build methods.
- Use locale-aware formatting for display and stable machine formats for APIs/storage.
- Consider DST, timezone boundaries, recurrence, and reminder scheduling where relevant.
- Handle null, invalid, and missing values safely.
- Avoid string comparisons unless the format guarantees chronological ordering.
- Test midnight, leap days, date boundaries, timezone conversions, and relevant edge cases.
- Flag unspecified timezone behavior instead of inventing rules.

## Agent Workflow

1. Read the relevant DayMark specification and project instructions.
2. Inspect existing datetime utilities and neighboring implementations.
3. Identify the value type, timezone assumptions, and required conversions.
4. Make the smallest scoped change consistent with the repository.
5. Run relevant analysis, formatting, and tests.
6. Report changed files, verification performed, and unresolved decisions.

## Guardrails

Do not invent timezone rules, duplicate existing abstractions, change unrelated code, or claim verification that was not performed.
