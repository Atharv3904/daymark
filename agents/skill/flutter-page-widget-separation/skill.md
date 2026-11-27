---
name: flutter-page-widget-separation
description: Enforces separation of Flutter Page and Widget classes by maintaining one class per file and extracting additional UI components into dedicated widget files.
---

# Flutter Page & Widget Separation

- One Page class per Page file.
- One Widget class per Widget file.
- Never define additional Widget classes inside Page files.
- Extract additional UI components into the feature's `widgets/` directory.
- Pages compose widgets and manage screen-level responsibilities.
- Widgets handle focused UI responsibilities and presentation.
- Keep business logic in Bloc/Cubit.
- Reuse existing widgets whenever possible.
- Extract widgets when necessary for readability, complexity, reuse, or clear responsibility.
- Avoid unnecessary files, over-extraction, duplication, and abstractions.
- Follow existing project naming and folder conventions.

**Rule:** One class per Page/Widget file. Additional UI classes belong in separate widget files.
