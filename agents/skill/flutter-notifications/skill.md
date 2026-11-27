---
name: flutter-notifications
description: Implement Flutter push and local notifications, messaging, permissions, scheduling, delivery, lifecycle, notification interactions, and platform integration using DayMark's established architecture.
---

# Flutter Notifications Skill

## Purpose

Inspect existing Firebase Messaging/local notification setup, permissions, service, lifecycle, and platform configuration.

- Profile owns reminder and notification preferences; Tasks must not own reminder settings or reminder logic.
- Shared notification infrastructure owns permission requests, scheduling, rescheduling, cancellation, delivery, platform constraints, and token handling per architecture.
- Never schedule notifications from widgets or task code.
- Handle denied permissions, app restarts, timezone changes, duplicate schedules, idempotent updates/cancellation, and notification taps/deep links as required.
- Support notification-triggered actions and message handling across relevant app lifecycle states, including foreground, background, and terminated states, when required.
- Handle push messages and local notification interactions using established routing and service conventions.
- Don't log tokens or sensitive payloads.
- Do not invent notification types, defaults, times, or recurrence.

## Agent Workflow

1. Read the relevant DayMark specification and project instructions.
2. Inspect existing implementation and neighboring patterns before editing.
3. Identify notification types, lifecycle behavior, permissions, scheduling, interactions, and platform requirements.
4. Make the smallest scoped change consistent with the repository.
5. Run relevant analysis, formatting, and tests.
6. Report changed files, verification performed, and unresolved decisions.

## Guardrails

Do not invent requirements, duplicate existing abstractions, change unrelated code, or claim verification that was not performed.
