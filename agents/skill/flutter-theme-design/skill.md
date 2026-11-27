---
name: flutter-theme-design
description: Implement and maintain Flutter themes, design tokens, typography, colors, component styles, accessibility, and light/dark modes using DayMark's established design system.
---

# Flutter Theme Design Skill

## Purpose

Inspect existing `ThemeData`, `ColorScheme`, typography, component themes, and design tokens before making changes.

- Use centralized semantic tokens for colors, styles, spacing, radii, and component states.
- Avoid hard-coded styles scattered across widgets or duplicate theme systems.
- Preserve configured light, dark, and system theme behavior.
- Ensure contrast and distinguish focus, disabled, error, and interactive states.
- Update central tokens when appropriate and apply changes only to the requested scope.
- Reuse existing component themes and design conventions.
- Verify relevant themes, components, and UI states.
- Do not redesign the brand or introduce theme packages without approval.

## Agent Workflow

1. Read the relevant DayMark specification and project instructions.
2. Inspect existing implementation and neighboring patterns before editing.
3. Identify relevant theme tokens, components, and affected states.
4. Make the smallest scoped change consistent with the repository.
5. Run relevant analysis, formatting, and tests.
6. Report changed files, verification performed, and unresolved decisions.

## Guardrails

Do not invent requirements, duplicate existing abstractions, change unrelated code, or claim verification that was not performed.
