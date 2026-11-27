---
name: flutter-performance
description: Optimize Flutter application performance by identifying bottlenecks, reducing unnecessary rebuilds, improving rendering and resource management, and validating improvements without speculative optimization.
---

# Flutter Performance Skill

## Purpose

Optimize only after identifying or measuring a bottleneck. Inspect/profile relevant code before making changes.

- Reduce unnecessary rebuilds using established state granularity and selectors.
- Use `const` where appropriate.
- Keep expensive work out of `build()`.
- Use lazy lists for large collections.
- Dispose resources correctly.
- Avoid excessive object creation, inefficient image handling, and costly nested scrolling.
- Optimize data and network operations at the appropriate layer.
- Don't introduce caching, pagination, isolates, or memoization speculatively.
- Preserve correctness and test changes.
- Report performance evidence or verified rationale; don't claim improvements without measurement.

## Agent Workflow

1. Read the relevant DayMark specification and project instructions.
2. Inspect existing implementation and neighboring patterns before editing.
3. Identify the bottleneck and affected rendering, state, resource, or data operations.
4. Make the smallest scoped change consistent with the repository.
5. Run relevant analysis, formatting, and tests; profile or measure when appropriate.
6. Report changed files, verification performed, performance evidence, and unresolved decisions.

## Guardrails

Do not invent requirements, duplicate existing abstractions, change unrelated code, or claim verification or performance improvements that were not demonstrated.
