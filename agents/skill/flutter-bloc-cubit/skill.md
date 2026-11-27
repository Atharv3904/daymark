---
name: flutter-bloc-cubit
description: Implement and maintain Flutter BLoC and Cubit state management using consistent events, states, asynchronous handling, UI state transitions, lifecycle management, and DayMark's established conventions.
---

# Flutter BLoC/Cubit Skill

## Purpose

Follow DayMark's established BLoC/Cubit patterns for state management and UI orchestration.

- Inspect existing BLoC/Cubit implementations and project conventions before editing.
- Keep presentation state and UI orchestration inside BLoC/Cubit.
- Keep business rules and domain logic outside presentation state management.
- Use BLoC events and states or Cubit methods according to existing feature patterns.
- Maintain consistent loading, success, error, empty, and initial states where required.
- Avoid duplicate state classes, unnecessary events, and redundant state emissions.
- Handle asynchronous operations, errors, and concurrent requests safely.
- Keep state immutable and follow established equality conventions.
- Avoid UI logic, networking, database access, and direct infrastructure dependencies inside BLoC/Cubit.
- Dispose, close, and manage subscriptions according to lifecycle conventions.
- Test state transitions, success, failure, and relevant edge cases.

## File Organization

- **BLoC:** Each logical BLoC should use three files: `bloc.dart` for event handling and state emissions, `event.dart` for events, and `state.dart` for states.
- **Cubit:** Each logical Cubit should use two files: `cubit.dart` for methods and state emissions, and `state.dart` for states.
- Keep events and states consolidated into their respective files instead of creating separate files for individual events or states.
- Follow the existing feature folder structure and naming conventions.
- Use BLoC or Cubit according to the established feature pattern; do not introduce both unnecessarily.

## Agent Workflow

1. Read the relevant DayMark specification and project instructions.
2. Inspect existing BLoC/Cubit, event, state, and neighboring feature patterns.
3. Identify state transitions, dependencies, and asynchronous operations.
4. Make the smallest scoped change consistent with the repository.
5. Run relevant analysis, formatting, and tests.
6. Report changed files, verification performed, and unresolved decisions.

## Guardrails

Do not invent requirements, duplicate existing abstractions, mix business logic into presentation state management, change unrelated code, or claim verification that was not performed.
