---
name: flutter-security
description: Implement and maintain Flutter client security, secure storage, authentication lifecycle, input validation, platform hardening, privacy, and secure networking using DayMark's established security conventions.
---

# Flutter Security Skill

## Purpose

Treat the Flutter client as untrusted. Inspect existing security mechanisms and project policies before making changes.

- Never embed privileged secrets or server-side credentials.
- Use HTTPS and configured networking infrastructure.
- Store sensitive tokens using approved secure storage, not plain preferences unless explicitly classified as non-sensitive.
- Never log credentials, tokens, private content, or sensitive payloads.
- Validate deep links, external input, and untrusted data.
- Backend must enforce authentication, authorization, ownership, and validation.
- Follow approved token lifecycle, session handling, and logout cleanup.
- Review permissions, exported components, platform configuration, and dependencies when relevant.
- Flag security gaps rather than silently redesigning authentication.
- Avoid introducing security packages or mechanisms without requirements or approval.

## Agent Workflow

1. Read the relevant DayMark specification and project instructions.
2. Inspect existing implementation and neighboring patterns before editing.
3. Identify security requirements, risks, and existing protection mechanisms.
4. Make the smallest scoped change consistent with the repository.
5. Run relevant analysis, formatting, and tests.
6. Report changed files, verification performed, security concerns, and unresolved decisions.

## Guardrails

Do not invent requirements, duplicate existing abstractions, weaken security controls, change unrelated code, or claim verification that was not performed.
