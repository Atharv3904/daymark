---
name: flutter-form-validation
description: Implement Flutter form validation, input handling, field and form errors, submission states, accessibility, and backend validation alignment using DayMark's established patterns.
---

# Flutter Form Validation Skill

## Purpose

Follow existing form and validation patterns and the backend contract. Validate at the correct boundary; client validation is UX, not security.

- Reuse validators when genuinely shared.
- Give clear, actionable errors.
- Preserve entered values after recoverable failures.
- Handle field/form errors, loading, success, and duplicate submissions.
- Use correct keyboard types, autofill, labels, focus, and semantics.
- Normalize input only when specified; never silently alter passwords or user input.
- Test valid, invalid, empty, boundary, and server-error cases.
- Do not invent validation rules when specifications are silent; flag them.

## Agent Workflow

1. Read the relevant DayMark specification and project instructions.
2. Inspect existing implementation and neighboring patterns before editing.
3. Identify validation rules, input behavior, submission states, and backend requirements.
4. Make the smallest scoped change consistent with the repository.
5. Run relevant analysis, formatting, and tests.
6. Report changed files, verification performed, and unresolved decisions.

## Guardrails

Do not invent requirements, duplicate existing abstractions, change unrelated code, or claim verification that was not performed.
