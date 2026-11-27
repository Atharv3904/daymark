DayMark — Product & Engineering Requirements
Document type: Master product requirements
Status: Draft for feature-level specification
Client: Flutter (Dart)
Backend: Python FastAPI
Database: PostgreSQL (SQL)
Purpose: Define DayMark's product scope and shared engineering constraints. Feature-specific spec.md files define implementation detail.

1. Product Vision
   DayMark is a personal task-management and productivity application for planning tasks, organizing work, tracking completion across dates, reviewing history, understanding productivity, and supporting focused work.
   Objectives

- Plan and manage daily work.
- Make task completion and progress visible.
- Review past dates and task history.
- Support recurring tasks and reminders.
- Calculate productivity and streaks from explicit, testable rules.
- Provide useful analytics.
- Support focused work with a configurable Pomodoro timer.
- Protect user data with backend-enforced authentication and authorization.
  Users and Principles
- Initial target: individual users.
- Collaboration, teams, sharing, and social features are outside the initial scope.
- Predictable task lifecycle; reliable date/time/history behavior; secure ownership; separated business logic; testable rules; incremental implementation.

2. Technology and Boundaries
   Area Technology
   UI Flutter
   Language Dart
   Architecture Feature-first Clean Architecture
   State management Bloc/Cubit
   Backend Python FastAPI
   API communication REST / HTTP, JSON
   Database PostgreSQL, SQL
   Push notifications Firebase Cloud Messaging
   Local notifications Flutter Local Notifications
   Preferences SharedPreferences (non-sensitive only)
   Dependency injection GetIt
   Navigation GoRouter
   Charts Package selected when a concrete chart requirement exists

Rules

- Flutter communicates with the backend through documented API endpoints; it must never connect directly to PostgreSQL or contain database credentials.
- Backend authentication and authorization must be enforced server-side. Client-side authorization alone is insufficient.
- The backend must validate authenticated-user ownership for user-specific records on every relevant operation.
- Never expose database credentials, signing secrets, private API keys, or other server secrets in the Flutter client.
- Use parameterized SQL or the project's approved database-access approach; never build SQL queries by unsafe string concatenation with user input.
- Keep API contracts explicit, validated, and versioned when project conventions require it.
- FCM and local notifications have distinct responsibilities; decide their design in the relevant feature specification.
- Add packages or backend dependencies only for an approved concrete need.

3. Navigation
   The planned primary destinations are:
1. Home / Dashboard
1. Calendar
1. Tasks
1. Insights
1. Profile
   Authentication routes and modal/detail flows must have consistent back behavior and use GoRouter. Route details belong in the navigation specification.
1. Product Requirements
   4.1 Authentication and Profile

- Registration, login, logout, forgot-password, password reset, and session management.
- Profile management.
- User profile/settings data must belong to the authenticated user.
- Detailed authentication behavior is defined in the Authentication SPEC.
  4.2 Dashboard
  Planned content:
- Date and greeting.
- Selected/current-day total, completed, pending, overdue.
- Daily completion percentage.
- Weekly summary and current streak.
- Quick Add.
- Upcoming tasks.
  Dashboard values must be derived from shared authoritative task/productivity rules. Feature specs define exact calculations and inclusion rules.
  4.3 Tasks
  Task information:
- Title (required), description (optional).
- Start date, due date, optional start/end times.
- Priority: Low, Medium, High, Urgent.
- Category.
- Status: Pending, In Progress, Completed, Cancelled.
- Optional subtasks, reminders, recurrence.
- Completion timestamp.
- Attachments are a future enhancement.
  Operations:
- Create, read/list, update, delete/archive, status changes, complete/reopen, filtering, sorting, grouping, and date-based viewing.
- Feature specs must define validation, date/time constraints, and allowed lifecycle transitions.
  4.4 Calendar and Daily Tracking
  Planned capabilities:
- Monthly, weekly, and daily views.
- Select a date and view its tasks/history.
- Current-day highlighting.
- Completed, partial, pending, missed, and no-scheduled-task day distinctions.
- Manual day completion marking where approved.
- Automatic missed-day marking after the applicable deadline.
  Day states and productivity calculations must be defined in a dedicated specification before implementation.
  4.5 Productivity and Streaks
  Planned metrics:
- Current and longest streak.
- Total productive days.
- Daily completion percentage.
- Weekly/monthly productivity scores.
- Calendar heatmap.
  The productivity SPEC must define: productive-day criteria, empty days, cancelled/overdue tasks, reopened tasks, timezone/day boundaries, daylight-saving behavior, and recalculation after historical changes. This master document does not approve a formula.
  4.6 Categories and Priorities
  Default categories: Work, Study, Personal, Health, Fitness, Shopping, Finance, Other.
- Custom categories may be created, edited, and deleted.
- Priorities: Low, Medium, High, Urgent.
- Category ownership, duplicate names, default-category protection, and deletion behavior must be specified.
  4.7 Recurring Tasks
- Daily, weekly, monthly, and custom recurrence.
- Selected weekdays.
- Completion history.
- Prevent duplicate occurrence generation.
  Model recurrence rules separately from generated occurrences unless an approved design says otherwise. Define recurrence boundaries, end conditions, missed occurrences, future edits, and timezone behavior in the recurrence SPEC.
  4.8 Reminders and Notifications
- Task reminders, upcoming-task notifications, daily planning reminders, overdue notifications, and custom reminder times.
- Respect OS permission and user preferences.
  Feature SPEC must define delivery method, scheduling, rescheduling after edits, cancellation after deletion/completion, timezone changes, and platform limitations.
  4.9 Analytics and Insights
  Planned analytics:
- Daily, weekly, and monthly productivity/completion charts.
- Category and priority distribution.
- Completed vs pending.
- Most productive weekday.
- Trends.
  Every metric needs a documented calculation and date range. Shared rules must be reused by Dashboard and Calendar.
  4.10 Focus Mode
  Pomodoro defaults:
- Focus: 25 minutes.
- Short break: 5 minutes.
- Long break: 15 minutes.
  Capabilities:
- Session history and focus-time statistics.
- Associate a session with a task.
- Custom durations.
  The Focus SPEC must define pause/resume, lifecycle, app backgrounding, interruptions, completion, and persistence.

5. Database Requirements
   Use normalized PostgreSQL with UUID keys where appropriate, foreign keys, constraints, indexes, timestamps, and appropriate database-level integrity rules.
   Proposed Initial Entities/Tables

- profiles
- tasks
- subtasks
- categories
- task_reminders
- recurring_rules
- daily_productivity
- focus_sessions
- user_settings
  These are a proposal, not a mandate to create every table immediately. Add a table only when an approved feature requires it.
  Shared Database Rules
- Use versioned database migrations.
- Use appropriate created/updated timestamps.
- Enforce data validity through suitable constraints, indexes, and foreign keys.
- Enforce user ownership and authorization through backend checks and appropriate database permissions; evaluate additional database-level policies when warranted by the approved architecture.
- Child records must be protected against parent-ID manipulation and unauthorized ownership changes.
- Use unique constraints for logical duplicates where needed.
- Define explicit deletion and history behavior.
- Authentication identities must be associated with application user records through the approved backend authentication design.
- Preserve required historical records; derived statistics must not become the only source of truth.
- Use parameterized SQL and transactions for operations requiring atomicity.
- Define the database access layer and transaction ownership according to the approved backend architecture; feature specs must not assume an unselected ORM or database library.

6. Architecture
   Feature-first Clean Architecture for the Flutter client. Each feature uses only the layers it needs:

- Data: data sources, API DTOs/models, repository implementations.
- Domain: entities, repository contracts, use cases where justified.
- Presentation: Bloc/Cubit, pages, reusable widgets.
  Flutter Rules
- UI contains no business logic or direct backend/database access.
- Domain does not depend on Flutter, HTTP clients, FastAPI, PostgreSQL, SQL, or backend implementation details.
- Depend on abstractions; use constructor injection.
- Keep entities distinct from data models; JSON mapping belongs in Data.
- Explicit types and sound null safety.
- Avoid unsafe null assertions when safe alternatives exist.
- Typed error handling.
- Manage subscriptions/controllers correctly.
- Keep classes focused and avoid unnecessary abstractions/packages.
  Backend Rules
- Backend is implemented with Python FastAPI and exposes API contracts consumed by Flutter.
- Keep request/response schemas, routing, business logic, database access, and persistence responsibilities organized according to the existing backend architecture.
- Validate request data at API boundaries.
- Enforce authentication, authorization, ownership, and business rules server-side.
- Keep database access out of route handlers when the established project architecture separates it into services/repositories or equivalent components.
- Use safe, parameterized SQL and transactions where appropriate.
- Return consistent, documented API responses and safe error details; never expose internal exceptions, secrets, or database details to clients.
- Do not introduce an ORM, repository framework, migration tool, or other backend dependency without approval or an existing project convention.

7. UI/UX and Design
   Product direction: premium, minimal, polished visual design with liquid-glass styling where appropriate.

Requirements:

- Responsive layout for supported form factors.
- Light and dark themes.
- Consistent spacing and typography.
- Reusable components and accessible contrast.
- Subtle motion.
- Loading, empty, success, and error states.
- Confirmation for destructive actions.
- Clear navigation/back behavior.
- Authentication-aware splash/session entry.
  Exact design tokens, screen layouts, and component specs belong in a separate design specification; do not invent them in feature business specs.

8. Security and Privacy

- Never expose database credentials, private keys, signing secrets, or backend secrets in Flutter.
- Backend authorization is required; client-side authorization alone is insufficient.
- Use secure session/token handling according to the approved authentication design.
- Enforce least privilege for backend and database credentials.
- Validate input at appropriate boundaries.
- Map authentication/backend errors safely.
- Protect user-specific records through server-side ownership and authorization checks.
- Never log passwords, tokens, recovery secrets, database credentials, or sensitive user data.
- Review local storage and notification payloads for sensitive content.
- Security-sensitive decisions require review before release.

9. Quality Attributes
   DayMark should be maintainable, testable, secure, reliable, consistent across features, extensible, accessible, privacy-conscious in diagnostics, and efficient.

Specific performance targets, supported OS versions, accessibility conformance, and offline behavior remain open decisions and must be documented when required. 10. Scope and Specification Workflow
Initial product scope includes accounts, task lifecycle, subtasks, categories/priorities, calendar/history, productivity/streaks, recurrence, reminders, analytics, focus mode, profile/settings, and secure backend integration.

This is the long-term scope, not a requirement to implement all features simultaneously.
Workflow

1. Inspect the project and relevant requirements.
2. Identify open questions/conflicts.
3. Create or update one feature spec.md.
4. Approve the specification before coding.
5. Implement only the approved task.
6. Verify and report actual results.
   Feature SPECs are authoritative for detailed implementation behavior. Avoid duplicating detailed feature rules in this master document.
