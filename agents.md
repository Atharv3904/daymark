DayMark — Global AI Agent Instructions

1. Authority and Instruction Priority
   Follow instructions in this order:
1. System and safety requirements.
1. This AGENTS.md / agent.md global project instruction file.
1. Approved product and feature specifications.
1. Relevant implementation skills and procedures.
1. The current task prompt.
   Lower-priority instructions may clarify but must not override or weaken higher-priority rules. If instructions conflict, identify the conflict, follow the highest-priority rule, and explain the resolution. If a material conflict or missing decision prevents safe/correct work, stop and ask. Never silently violate architecture, security, or approved requirements.
1. Project Context

- Project: DayMark — advanced todo and daily productivity tracker.
- Client: Flutter mobile app; language: Dart.
- Architecture: feature-first Clean Architecture.
- State management: existing Bloc/Cubit.
- Dependency injection: GetIt.
- Navigation: GoRouter via MaterialApp.router.
- Backend/database: Supabase with PostgreSQL; authentication via Supabase Auth.
- Repository results: Either (Left/Right), using existing Failure abstractions.
- Notifications: Firebase Cloud Messaging and Flutter Local Notifications.
- Local preferences: SharedPreferences for non-sensitive preferences only.
- Version control: Git.
  DayMark initially targets individual users. Collaboration/social features are out of scope unless approved.

3. Product Scope
   Core features: authentication/profile, dashboard, tasks/subtasks, categories/priorities, calendar and daily tracking, productivity/streaks, recurring tasks, reminders/notifications, analytics/insights, focus mode, and settings.
   Five main destinations: Home/Dashboard, Calendar, Tasks, Insights, Profile.
   Future enhancement: task attachments. Do not add unapproved features such as collaboration, social feeds/leaderboards, AI recommendations, calendar-provider sync, subscriptions, web/desktop clients, full offline-first sync, or admin dashboard.
   Detailed behavior belongs in approved feature specifications. Do not duplicate or invent feature rules in this global file.
4. Inspect Before Acting

- Inspect the relevant files, contracts, dependencies, tests, and existing patterns before changing code.
- Read only context relevant to the current task; load the governing specification and skill when applicable.
- Confirm the actual file paths, APIs, route definitions, package versions, and existing behavior—never assume.
- Reuse existing implementations and conventions; diagnose root causes before rewriting.
- Establish task scope and affected files before implementation.
- Do not create unnecessary files, abstractions, packages, duplicate code, or parallel implementations.

5. Architecture and Dependency Boundaries
   Maintain Clean Architecture:

- Presentation: pages, widgets, Bloc/Cubit, UI states/events. UI renders state and gathers input; keep business logic out of widgets.
- Domain: entities, repository contracts, use cases, business rules. Domain must not depend on Flutter UI, Supabase SDK, or concrete Data implementations.
- Data: models/serialization, DataSources, repository implementations, external-service integration.
- Core: reusable application-wide infrastructure, utilities, failures, routing, DI, and shared components.
  Dependency direction: Presentation → Domain abstractions; Data implements Domain contracts. Use constructor injection and abstractions. Keep classes and methods focused; follow SOLID without overengineering.
  Typical flow:
  UI → Bloc/Cubit → Use Case (where established) → Repository Contract → Repository Implementation → DataSource → External service/database.
  Follow the existing feature structure. Keep feature components inside their feature module. Reuse shared feature-level data sources, repositories, use cases, and state-management components where practical. Do not create one file/abstraction per operation automatically; split only when responsibility, complexity, or maintainability warrants it. Preserve established naming, contracts, and functionality.

6. State Management

- Use the existing Bloc/Cubit pattern; do not introduce another state-management framework.
- Follow established Event/State/Bloc/Cubit conventions.
- Bloc/Cubit invokes Use Cases where the project uses them; do not directly access DataSources.
- Handle Either using .fold() and represent outcomes through established states.
- Avoid duplicate state sources and keep UI logic out of state-management classes.
- Manage streams, subscriptions, and lifecycle correctly.

7. Dependency Injection

- Use the existing GetIt service locator.
- Central configuration: lib/core/get_it/injection.dart.
- Prefer constructor injection.
- Register implementations against abstractions and respect registration order.
- Ensure dependencies are registered before use; avoid duplicate registrations or manual instantiation where DI is established.

8. Repository, Errors, and Validation

- Domain repositories are abstract contracts; concrete implementations live in Data.
- Use the project's existing Either/Failure/result abstractions; do not introduce duplicates.
- Convert external/provider exceptions into typed application failures at the appropriate Data boundary.
- Never expose raw technical exceptions to UI.
- Validate at the appropriate boundary and follow feature specifications; avoid duplicating validation across layers without a reason.
- Preserve method signatures/contracts unless the task requires and approves a change.

9. Security and Data Integrity

- Never ship Supabase service-role keys, private credentials, or secrets in the Flutter client.
- Flutter must not connect directly to PostgreSQL; use the approved Supabase/backend access architecture.
- Enforce authorization and ownership at the database/backend level, including PostgreSQL RLS; client checks are not sufficient.
- Use least privilege and protect user-owned records.
- Secure sensitive session/token storage; SharedPreferences is for non-sensitive preferences, not secrets.
- Never log passwords, access/refresh tokens, recovery secrets, private credentials, or sensitive user data.
- Validate inputs, protect sensitive notification payloads/local storage, and never bypass security controls for convenience.

10. Routing and Navigation

- Use GoRouter and centralized routing at lib/core/routes/app_router.dart (verify the actual project configuration before editing).
- Integrate through MaterialApp.router.
- Inspect existing routes and navigation behavior first.
- Follow named-route, argument, parameter, nested-route, and back-navigation conventions.
- Register feature routes centrally when required.
- Avoid duplicate routers or unnecessary navigation abstractions; preserve existing behavior.

11. UI and Design

- Follow existing design system, theme, reusable widgets, and design specifications.
- Target a premium, modern, minimal Liquid Glass style only where the approved design direction applies.
- Support light/dark themes and responsive supported layouts.
- Maintain accessible contrast, consistent spacing/typography, focused components, and appropriate loading/empty/success/error states.
- Validate before invoking operations; use Flutter Form/FormField where appropriate.
- Avoid unrelated UI changes.

12. Packages and Configuration

- Inspect current packages before adding dependencies.
- Add only justified, compatible dependencies; avoid duplicates.
- Update pubspec.yaml when needed and run flutter pub get.
- Verify imports and dependency resolution.
- Do not remove packages without a valid task-related reason.
- Do not change secrets or environment configuration casually; never invent configuration values.

13. Specifications and Decisions

- Approved feature specifications are the source of detailed functional behavior, validation, boundaries, exceptions, and acceptance criteria.
- Authentication details belong in the unified Authentication specification; do not restate them here.
- Routing specifics are governed by the routing documentation and existing router configuration.
- If a specification is missing, outdated, contradictory, or marked draft/pending approval, identify that status. Do not treat unapproved assumptions as confirmed requirements.
- Product decisions such as streak calculation, recurrence/time-zone behavior, deletion policy, offline behavior, reminder semantics, and focus-timer lifecycle must be defined in their feature specs before inventing implementation behavior.

14. Scope and Change Discipline

- Implement only the requested scope.
- Preserve working functionality and existing contracts.
- Avoid unrelated refactoring, feature additions, formatting churn, or file moves.
- Make changes incrementally and review the diff.
- Do not hide issues with ignore comments, forced casts, placeholder implementations, or destructive shortcuts.
- When a requirement is ambiguous, ask only if it materially blocks safe implementation; otherwise document a conservative, specification-consistent assumption.

15. Verification
    Run checks relevant to the change and risk:

- Format modified Dart files: dart format <modified_files>
- Static analysis: flutter analyze
- Tests: flutter test (prefer targeted tests first when appropriate)
- Dependency resolution: flutter pub get after dependency changes
  Include relevant unit, repository, Bloc/Cubit, widget, integration, database/RLS, date/time, recurrence, and lifecycle tests as applicable.
  Resolve relevant failures, fix root causes, and rerun checks after corrections. Distinguish unrelated/environment-specific failures. Never claim a command or test passed unless it was actually executed successfully.

16. Definition of Done
    A feature/task is done when:

- Requirements and applicable specifications are understood and followed.
- Architecture, contracts, security, ownership, and validation are respected.
- Implementation is reviewed and relevant tests/static analysis/verification are completed.
- Remaining issues and limitations are documented.
  Release-level work additionally requires migration verification, security review, platform testing, and release documentation.

17. Final Response
    Report concisely:
1. Implemented changes.
1. Exact files created/modified.
1. Important architecture/security decisions.
1. Dependencies changed.
1. Verification commands actually run and results.
1. Tests and remaining issues/limitations.
1. Anything intentionally out of scope.
   Clearly separate verified facts from unverified assumptions or checks that could not be run.
1. Operating Principle
   Inspect first. Load only relevant context. Follow the hierarchy and approved specifications. Reuse existing patterns. Implement only the requested scope. Verify before declaring completion.

1. Global Branding & Logo Rules

- DayMark must use one consistent global application logo across the entire application.
- The logo must not be independently redesigned, recreated, or replaced by individual features.
- Use the approved DayMark logo asset from the centralized assets directory.
- Maintain consistent logo proportions, colors, padding, alignment, and sizing.
- Authentication screens must display the DayMark logo and brand name consistently.
- The logo must be used consistently across Splash, Welcome, Login, Register, Forgot Password, Reset Password, Dashboard, and other applicable screens.
- Use the icon-only version when space is limited and the full logo when the layout supports it.
- Do not use text-only substitutes, emoji logos, or locally recreated logo variations.
- If the approved logo asset is missing, ask for clarification before creating a replacement.

Asset location: "assets/images/logo/"

Suggested assets:

- "daymark_logo.png" — icon + brand name
- "daymark_icon.png" — icon only
- "daymark_logo.svg" — vector version, if supported by the project
