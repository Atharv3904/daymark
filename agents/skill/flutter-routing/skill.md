---
name: flutter-routing
description: Implement and maintain Flutter navigation, route definitions, route names, redirects, deep links, navigation stacks, and route parameters using DayMark's established routing architecture.
---

# Flutter Routing Skill

## Purpose

Use the established router (GoRouter only if confirmed). Inspect the route tree, redirects, shell routes, deep links, and navigation conventions before editing.

Maintain these three routing files with distinct responsibilities:

- **`routes_name.dart`** — Contains centralized route names and path constants. Avoid scattered route strings and duplicated route definitions.
- **`routes.dart`** — Defines route configurations, route paths, page mappings, nested routes, shell routes, route parameters, and route-specific configuration.
- **`router.dart`** — Creates and configures the router, including initial location, global redirects, authentication routing, navigation guards, and router-level settings.

- Validate route parameters and `extra` data.
- Keep navigation out of domain logic.
- Use established session state for authentication redirects and prevent redirect loops.
- Choose `push`, `go`, `replace`, and `pop` according to intended stack behavior.
- Handle back navigation and invalid or missing route data safely.
- Make minimal changes and verify authenticated/unauthenticated paths, deep links, and back behavior.
- Do not change access rules or add routes outside the requested scope.

## Agent Workflow

1. Read the relevant DayMark specification and project instructions.
2. Inspect existing routing files and neighboring patterns before editing.
3. Maintain clear separation between route names, route definitions, and router configuration.
4. Make the smallest scoped change consistent with the repository.
5. Run relevant analysis, formatting, and tests.
6. Report changed files, verification performed, and unresolved decisions.

## Guardrails

Do not invent requirements, duplicate existing abstractions, mix responsibilities between routing files, change unrelated code, or claim verification that was not performed.
