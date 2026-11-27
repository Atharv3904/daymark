---
name: flutter-single-usecase-per-file
description: Enforces creating a separate file for every UseCase, maintaining single-responsibility and clean architecture.
---

# Single UseCase Per File

- Every UseCase must have its own dedicated file.
- Never define multiple UseCases in a single file.
- Each file should contain only one UseCase class.
- Follow consistent naming conventions: `usecase_name.dart`.
- Keep each UseCase focused on one specific action or responsibility.
- Place UseCases in the appropriate feature's Domain layer.
- Reuse existing conventions and folder structures.
- Avoid unnecessary abstractions, duplication, or unrelated changes.

**Rule:** One UseCase = One file = One responsibility.
