---
name: flutter-global-snackbar
description: Enforces a reusable global Snackbar mechanism for displaying application-wide success, error, warning, and informational messages.
---

# Global Snackbar

- Create and maintain a reusable GlobalSnackbar mechanism.
- It must be accessible across features without duplicating Snackbar implementations.
- Support success, error, warning, and informational messages.
- Display user-friendly messages for API failures, successful operations, and relevant application events.
- Maintain consistent styling, icons, colors, duration, and positioning.
- Never expose stack traces, sensitive information, or raw technical errors.
- Avoid duplicate, unnecessary, or excessive notifications.
- Keep Snackbar UI and presentation logic within the Presentation layer.
- Do not place Snackbar implementation in Domain or Data layers.
- Reuse the global Snackbar instead of creating feature-specific implementations.
- Follow existing architecture and UI conventions.
- Create only necessary files; avoid unnecessary abstractions or refactoring.

**Rule:** All global application feedback messages must use the shared GlobalSnackbar mechanism.
