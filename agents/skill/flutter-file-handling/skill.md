---
name: flutter-file-handling
description: Handle file selection, validation, permissions, reading, storage, uploads, cleanup, and file lifecycle safely using DayMark's established abstractions and requirements.
---

# Flutter File Handling Skill

## Purpose

Confirm requirements for file types, size, destination, permissions, and retention. Reuse existing picker, image, upload, and storage abstractions.

- Treat names, MIME types, extensions, and contents as untrusted.
- Client validation improves UX; server validation remains authoritative.
- Avoid loading large files wholly into memory when streaming or bounded processing is possible.
- Protect sensitive files and manage temporary files and cleanup.
- Handle cancellation, permission denial, missing files, invalid types, size limits, upload failures, and retry UX.
- Don't invent file constraints or add file support outside scope.

## Agent Workflow

1. Read the relevant DayMark specification and project instructions.
2. Inspect existing implementation and neighboring patterns before editing.
3. Identify file requirements, storage destination, permissions, lifecycle, and failure scenarios.
4. Make the smallest scoped change consistent with the repository.
5. Run relevant analysis, formatting, and tests.
6. Report changed files, verification performed, and unresolved decisions.

## Guardrails

Do not invent requirements, duplicate existing abstractions, change unrelated code, or claim verification that was not performed.
