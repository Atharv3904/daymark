---
name: flutter-params-separation
description: Enforces proper use of Params objects for user inputs and operation parameters across Flutter feature modules.
---

# Params Separation

- Use Params/Request objects for user input and operation parameters.
- Never use an Entity as a substitute for user-input parameters.
- Create Params objects when multiple inputs need to be passed through the architecture.
- Pass Params through the required layers instead of passing individual parameters unnecessarily.
- Maintain clear and consistent data flow between Presentation, Domain, and Data layers.
- Keep Params focused on the specific operation or use case.
- Follow existing feature architecture, naming conventions, and folder structures.
- Reuse existing Params when appropriate instead of creating duplicate classes.
- Avoid unnecessary classes, abstractions, duplication, and files.
- Do not introduce Params objects for trivial cases where they add unnecessary complexity.

## Rule

Use Params objects for user inputs and operation parameters when appropriate. Never pass Entities as substitutes for input parameters, and maintain clean, consistent data flow across architectural layers.
