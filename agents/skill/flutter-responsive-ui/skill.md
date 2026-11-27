---
name: flutter-responsive-ui
description: Build responsive Flutter interfaces that adapt to screen sizes, constraints, orientations, keyboard insets, and supported platforms while preserving usability and visual hierarchy.
---

# Flutter Responsive UI Skill

## Purpose

Confirm supported platforms and screen sizes; inspect existing responsive conventions before implementation.

- Use constraints such as `LayoutBuilder`, `MediaQuery`, flexible layouts, and established breakpoints instead of fixed screen assumptions.
- Prevent overflow, clipping, cramped controls, and unusable dialogs.
- Preserve layout hierarchy and usability rather than merely scaling UI.
- Use scrollable content, safe areas, and keyboard insets correctly.
- Avoid platform-specific layouts unless required.
- Verify narrow, standard, and wide layouts and relevant orientations.
- Test breakpoint transitions and avoid arbitrary breakpoint proliferation.
- Do not assume platform support without confirming project requirements.

## Agent Workflow

1. Read the relevant DayMark specification and project instructions.
2. Inspect existing implementation and neighboring patterns before editing.
3. Make the smallest scoped change consistent with the repository.
4. Run relevant analysis, formatting, and tests.
5. Report changed files, verification performed, and unresolved decisions.

## Guardrails

Do not invent requirements, duplicate existing abstractions, change unrelated code, or claim verification that was not performed.
