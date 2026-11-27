---
name: flutter-ui-validation
description: Enforces Flutter UI input validation within the Presentation layer using appropriate form validators and user-friendly inline error messages.
---

# Flutter UI Validation

- UI input validation must remain in the Presentation layer.
- Use Flutter Form, GlobalKey<FormState>, and TextFormField.validator where appropriate.
- Display validation errors beside the corresponding input field.
- Validate required fields, formats, lengths, ranges, and input constraints.
- Trigger validation at appropriate UX moments, such as form submission.
- Provide clear, actionable, user-friendly error messages.
- Reuse existing validation utilities and validators where appropriate.
- Avoid duplicating validation logic unnecessarily.
- Do not place UI-specific input validation in Domain or Data layers.
- Domain validation should only handle genuine business rules.
- Keep validation consistent across the application.
- Follow existing project architecture, UI conventions, and design system.

**Rule:** Input validation and its UI feedback belong to the Presentation layer, close to the form and input components.
