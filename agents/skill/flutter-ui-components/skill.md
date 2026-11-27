---
name: flutter-ui-components
description: Build and maintain Flutter screens, widgets, reusable UI components, interactions, accessibility, and Liquid Glass UI using DayMark's established design and architectural conventions.
---

# Flutter UI Components Skill

## Purpose

Inspect DayMark screens, shared widgets, themes, design tokens, and conventions before creating or modifying UI.

- Follow DayMark's Liquid Glass design language and existing glass UI implementations.
- Use composition and focused widgets.
- Keep reusable widgets generic only when reuse is justified; feature-specific widgets remain local.
- Use theme tokens, semantic styles, and accessibility semantics.
- Ensure suitable touch targets and accessible interactions.
- Implement required loading, empty, error, disabled, and success states.
- Widgets render state and emit intent; business logic stays in Bloc/Cubit or designated layers.
- Avoid large build methods, excessive extraction, duplicated UI, and unnecessary packages.
- Avoid excessive glass effects, visual clutter, and reduced readability or contrast.
- Verify responsive behavior, visual consistency, interactions, and relevant widget tests.

## Agent Workflow

1. Read the relevant DayMark specification and project instructions.
2. Inspect existing implementation, Liquid Glass components, theme, and neighboring patterns.
3. Make the smallest scoped change consistent with the repository.
4. Run relevant analysis, formatting, and tests.
5. Report changed files, verification performed, and unresolved decisions.

## Guardrails

Do not invent requirements, duplicate existing abstractions, change unrelated code, introduce inconsistent UI styles, or claim verification that was not performed.
