---
name: flutter-core-foundation
description: Establish and maintain DayMark's shared Flutter infrastructure, including configuration, error handling, networking, dependency injection, routing, theme, shared UI, and authentication session integration.
---

# Flutter Core Foundation Skill

## Purpose

Establish shared infrastructure in `lib/core/` using DayMark's existing architecture, dependencies, specifications, and conventions.

- Inspect existing code before creating or modifying infrastructure.
- Keep Core limited to genuinely shared functionality; feature-specific logic belongs in its feature.
- Establish configuration, error handling, networking, DI, routing, theme, shared UI, and session integration only when required.
- Follow the dependency order: configuration → errors → networking → DI → routing → theme → shared UI → session integration.
- Reuse existing packages, abstractions, and implementations; avoid speculative files, empty folders, duplicate clients, and unnecessary dependencies.
- Keep initialization centralized and predictable.
- Follow relevant architecture, security, routing, theme, UI, and testing skills.
- Validate initialization, integration, analysis, and relevant tests.

## Agent Workflow

1. Read `agents.md`, relevant requirements/specifications, and skills.
2. Inspect `lib/core/`, dependencies, initialization, and existing implementations.
3. Identify required foundation components and dependencies.
4. Implement only the requested scope in logical stages.
5. Format, analyze, test, and review the diff.
6. Report changed files, verification, incomplete work, and unresolved decisions.

## Guardrails

Do not invent architecture, duplicate abstractions, create speculative infrastructure, modify unrelated features, or claim unperformed verification. Stop and report when requirements or architectural decisions are unclear.
