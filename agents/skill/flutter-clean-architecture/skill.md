---
name: flutter-clean-architecture
description: Maintain DayMark's feature-first Clean Architecture by separating presentation, domain, and data responsibilities, enforcing inward dependencies, and following established project patterns.
---

# Flutter Clean Architecture Skill

## Purpose

Maintain DayMark's feature-first Clean Architecture consistently. Inspect existing features and project conventions before editing.

Organize responsibilities across:

- **Presentation:** Pages, widgets, Bloc/Cubit, UI state, and user interaction.
- **Domain:** Entities, repository contracts, and business rules. Use cases only when required by existing architecture or justified by the feature.
- **Data:** Models/DTOs, data sources, repository implementations, and infrastructure mapping.

Dependencies must point inward. Domain must not depend on Flutter, UI, networking, database libraries, or concrete infrastructure implementations.

Keep business rules out of widgets, Bloc/Cubit, data sources, and API clients. Bloc/Cubit manages presentation state and coordinates user actions with the domain layer.

Reuse established project patterns. Do not introduce unnecessary layers, abstractions, use cases, files, or architectural changes.

## Agent Workflow

1. Read the relevant DayMark specification and project instructions.
2. Inspect the existing feature structure and neighboring implementations.
3. Identify affected layers, responsibilities, and dependencies.
4. Implement the smallest consistent change following established conventions.
5. Wire required dependencies using the existing DI mechanism.
6. Run relevant analysis, formatting, and tests.
7. Report changed files, verification performed, and unresolved decisions.

## Guardrails

- Do not invent requirements or architectural decisions.
- Do not duplicate existing abstractions or business logic.
- Do not modify unrelated files or refactor outside the requested scope.
- Do not introduce unnecessary architectural complexity.
- Do not claim verification that was not performed.
- If the specification conflicts with existing architecture, identify the conflict instead of silently deciding.
