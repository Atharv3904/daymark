# DayMark --- Product & Engineering Requirements

**Document type:** Master project requirements / product brief\
**Project:** DayMark --- Advanced Todo & Daily Productivity Tracker\
**Status:** Draft for stakeholder and AI-agent review\
**Primary client:** Flutter mobile application\
**Backend:** Supabase + PostgreSQL\
**Language:** Dart\
**Purpose:** Establish one shared understanding of what DayMark is, what
it must do, and the engineering constraints that guide future
specifications and implementation.

> **Important working rule:** This is the master requirements document.
> It is not a substitute for the small, feature-specific `SPEC.md` files
> required by the AI-First Engineering curriculum. Before implementing
> any feature, clarify its open questions, create and approve its
> compact specification, and only then write code.

---

# 1. Product vision

DayMark is a production-oriented mobile application for task management,
daily planning, habit-like recurring activities, calendar-based day
tracking, and personal productivity insights.

It must be substantially more capable than a basic Todo CRUD
application. Users should be able to plan tasks, organize them, complete
them over time, review their history, understand their productivity, and
focus on individual tasks.

The product should be maintainable, testable, secure, extensible, and
suitable for a polished portfolio project.

## 1.1 Product objectives

- Help users plan and manage daily work.
- Make task completion and daily progress visible.
- Let users review past days and task history.
- Support recurring tasks and reminders.
- Calculate productivity and streaks using explicit, testable rules.
- Provide analytics that help users understand their habits.
- Support focused work through a configurable Pomodoro timer.
- Protect each user's data through backend-enforced authorization.

## 1.2 Primary users

The initial product is intended for an individual user managing personal
tasks and productivity. Multi-user collaboration, teams, sharing, and
social features are not part of the stated initial scope.

## 1.3 Product principles

- Clear, predictable task lifecycle.
- Reliable date, time-zone, recurrence, and history behavior.
- Secure user-specific data access.
- Business logic separated from UI and infrastructure.
- Testable rules and traceable requirements.
- Incremental implementation; no whole-application generation in one
  step.

---

# 2. Technology stack

---

Area Selected technology

---

Mobile frontend Flutter

Programming language Dart

Architecture Clean Architecture, feature-first
organization

State management Bloc / Cubit

Backend platform Supabase

Database PostgreSQL

Authentication Supabase Auth

Push notifications Firebase Cloud Messaging

Local notifications Flutter Local Notifications

Local preferences SharedPreferences

Dependency injection GetIt

Navigation GoRouter

Charts A suitable Flutter charting
package, to be selected when needed

---

## 2.1 Technology boundaries

- Flutter communicates with Supabase through supported client/API
  interfaces.
- Flutter must never connect directly to PostgreSQL using database
  credentials.
- PostgreSQL access must be protected by Row Level Security (RLS).
- Supabase service-role keys must never be shipped in the Flutter
  application.
- SharedPreferences is for non-sensitive local preferences, not
  authentication secrets.
- Authentication/session handling must follow the Supabase SDK's
  supported secure behavior.
- Firebase Cloud Messaging and local notifications have separate
  responsibilities; their exact division and scheduling design must be
  specified before implementation.
- Packages must not be added without a concrete requirement and
  review.

---

# 3. Application navigation

The primary bottom navigation contains five destinations:

1.  Home/dashboard
2.  Calendar
3.  Tasks
4.  Insights
5.  Profile

Navigation must support clear back behavior. Authentication routes and
modal/detail flows must be designed consistently with GoRouter.

---

# 4. Functional requirements

## 4.1 Authentication and profile

The application must support:

- User registration.
- Login.
- Logout.
- Forgot-password flow.
- Password reset.
- Session management.
- User profile management.

Profile information and user settings must be associated with the
authenticated user. Exact profile fields and password-reset flow details
remain to be specified.

## 4.2 Dashboard

The personalized dashboard must display:

- Current date and greeting.
- Total tasks for the selected/current day.
- Completed tasks.
- Pending tasks.
- Overdue tasks.
- Daily completion percentage.
- Weekly productivity summary.
- Current streak.
- Quick Add Task action.
- Upcoming tasks.

Dashboard values must be derived from authoritative task and
productivity data. Their exact inclusion rules must be defined in
feature specifications.

## 4.3 Task management

A task must support the following information:

Field Requirement

---

Title Required task title
Description Optional description
Start date Task start date
Due date Task deadline/date
Start time Optional start time
End time Optional end time
Priority Low, Medium, High, Urgent
Category Associated category
Status Pending, In Progress, Completed, Cancelled
Subtasks Optional child tasks
Attachments Future enhancement
Reminders Optional reminder settings
Recurrence Optional recurring configuration
Completion timestamp Record when completed

Required operations:

- Create task.
- Read/list task.
- Update task.
- Delete/archive task.
- Change task status.
- Complete and reopen a task, subject to approved lifecycle rules.
- Filter, sort, and group tasks.
- View tasks by date.

Task validation must define title limits, valid date/time combinations,
status transitions, and behavior for invalid input before
implementation.

## 4.4 Calendar and day tracking

The calendar must provide:

- Monthly view.
- Weekly view.
- Daily task view.
- Completed-day markers.
- Partially completed-day markers.
- Missed-day markers.
- Highlighted current day.
- Historical productivity tracking.
- Date-wise task history.

Users must be able to select a date and see tasks associated with that
date.

The product must distinguish a day with no scheduled tasks from a day
where scheduled tasks were missed. Exact marker semantics require an
approved productivity specification.

## 4.5 Productivity and streaks

The application must support:

- Current daily streak.
- Longest streak.
- Total productive days.
- Daily completion percentage.
- Weekly productivity score.
- Monthly productivity score.
- Calendar heatmap similar to GitHub contributions.

The following rules must be explicitly specified and tested before
implementation:

- What makes a day productive?
- What happens when a day has no eligible tasks?
- Do cancelled tasks count?
- How are overdue tasks treated?
- Does reopening a completed task affect historical productivity?
- Which time zone defines the user's day?
- How are daylight-saving transitions handled for users in applicable
  time zones?
- How are streaks recalculated when historical task data changes?

No streak formula or productivity policy is considered approved by this
master document.

## 4.6 Categories and priorities

Default categories:

- Work
- Study
- Personal
- Health
- Fitness
- Shopping
- Finance
- Other

Users must be able to create, edit, and delete custom categories.

Priorities:

- Low
- Medium
- High
- Urgent

Category ownership, duplicate naming, default-category protection, and
behavior when deleting a category that has tasks must be specified.

## 4.7 Recurring tasks

The application must support:

- Daily recurrence.
- Weekly recurrence.
- Monthly recurrence.
- Custom recurring schedules.
- Selected weekdays.
- Recurring task completion history.

The implementation must avoid duplicate task generation.

A recurring schedule and each generated task occurrence must be modeled
distinctly unless an approved design establishes another approach. The
exact recurrence rules, end conditions, missed occurrences, edits to
future occurrences, and time-zone behavior must be specified before
implementation.

## 4.8 Notifications and reminders

The application must support:

- Task reminders.
- Upcoming-task notifications.
- Daily planning reminders.
- Overdue-task notifications.
- Custom reminder times.

The system must respect notification permissions and user preferences.

Notification delivery, local scheduling, push delivery, rescheduling
after edits, cancellation after deletion/completion, device time-zone
changes, and platform limitations require feature-level specifications.

## 4.9 Analytics and insights

The application must provide:

- Daily productivity chart.
- Weekly completion chart.
- Monthly productivity chart.
- Category-wise task distribution.
- Priority-wise task distribution.
- Completed-versus-pending task comparison.
- Most productive weekday.
- Productivity trends.

Every metric must have a documented calculation and a defined date
range. Analytics must use consistent rules with the dashboard and
calendar.

## 4.10 Focus mode

The application must include a Pomodoro timer with:

- Default 25-minute focus session.
- Default 5-minute short break.
- Default 15-minute long break.
- Session history.
- Focus-time statistics.
- Ability to associate a focus session with a task.
- Customizable session durations.

Timer lifecycle, pause/resume, app backgrounding, interruptions,
completion, and persistence behavior must be specified and tested.

---

# 5. Database requirements

Use a normalized PostgreSQL schema with UUID primary keys, foreign keys,
suitable constraints, indexes, timestamps, and RLS.

The requested initial tables are:

1.  `profiles`
2.  `tasks`
3.  `subtasks`
4.  `categories`
5.  `task_reminders`
6.  `recurring_rules`
7.  `daily_productivity`
8.  `focus_sessions`
9.  `user_settings`

Database requirements:

- Use UUID primary keys.
- Maintain `created_at` and `updated_at` timestamps where applicable.
- Add foreign-key constraints.
- Create appropriate indexes.
- Add Row Level Security policies.
- Ensure users can access only their own records.
- Apply database constraints for valid data.
- Avoid unnecessary duplication.
- Preserve historical completion records.
- Provide versioned database migrations.
- Explain table relationships and deletion behavior.

Supabase Auth owns the authentication identity records. The application
should reference the authenticated user ID rather than creating a
separate password/user-authentication system.

Additional tables may be proposed when a concrete requirement needs
them, but each addition must be justified and reviewed. Historical
status events, recurrence occurrence identity, and notification delivery
state are examples that may require explicit modeling.

## 5.1 Data integrity and ownership

- User-owned records must be scoped to the authenticated user.
- Child records must not be accessible by manipulating a parent ID.
- RLS must protect reads and writes, not just the Flutter UI.
- Unique constraints must prevent duplicate logical records where
  required.
- Deletion behavior must preserve required history.
- Derived statistics must not silently become the only source of
  truth.

---

# 6. Flutter architecture requirements

Use Clean Architecture with feature-first organization and separation
between:

- core
- feature
  Data
  Domain
  Presentation

Each feature should contain the relevant parts of:

### Data

- Data sources.
- Models
- Repository implementations.

### Domain

- Entities.
- Repository contracts.
- Use cases.

### Presentation

- Bloc/Cubit.
- Pages.
- Reusable widgets.

Architecture rules:

- Do not put business logic inside UI widgets.
- Domain logic must not depend on Flutter UI or Supabase SDK classes.
- Depend on abstractions rather than concrete implementations.
- Use constructor injection.
- Keep entities separate from data models.
- Keep JSON serialization in the data layer.
- Use explicit types and sound null safety.
- Avoid unsafe null assertions where a safe alternative exists.
- Use typed error handling.
- Close StreamControllers and manage subscriptions correctly.
- Keep classes and methods focused.
- Avoid unnecessary abstractions and packages.

---

# 7. UI/UX requirements

The product should feel like a polished commercial productivity
application. use a liquid glass.

Design requirements:

- Modern, premium, minimal visual style with liquid glass.
- Responsive mobile ,web , tablet , desktop UI.
- Light and dark themes.
- Consistent spacing and typography.
- Reusable components.
- Accessible color contrast.
- Subtle animations.
- Loading states.
- Empty states.
- Success states.
- Error states.
- Confirmation dialogs for destructive actions.
- Clear navigation and back navigation.
- splash page with authethication

The five main navigation destinations are Home, Calendar, Tasks,
Insights, and Profile.

Exact colors, typography, spacing scale, component specifications, and
screen layouts are not yet approved. They should be documented in a
separate design specification rather than invented in the business-logic
specifications.

---

# 8. Security requirements

- Never expose Supabase service-role keys in Flutter.
- Enforce authorization with PostgreSQL RLS.
- Secure user sessions.
- Validate input at appropriate boundaries.
- Handle authentication errors safely.
- Follow least-privilege principles.
- Protect user-specific database records.
- Never rely on client-side authorization alone.
- Do not log passwords, access tokens, or sensitive user data.
- Review local storage and notification payloads for sensitive
  information.

Security-sensitive implementation decisions require review before
release.

---

# 10. Non-functional requirements

The application should be:

- Maintainable: clear boundaries and understandable code.
- Testable: business rules independently testable.
- Secure: server-enforced user data isolation.
- Reliable: predictable handling of failures and retries.
- Consistent: the same business rules across dashboard, calendar, and
  analytics.
- Extensible: new features should not require rewriting unrelated
  modules.
- Accessible: usable contrast and clear interaction feedback.
- Observable: useful, privacy-conscious error diagnostics.
- Efficient: avoid unnecessary database requests and repeated
  calculations.

Specific performance targets, supported OS versions, accessibility
conformance level, and offline requirements are not yet defined.

---

# 11. Scope boundaries

## Initial stated scope

- Individual user accounts.
- Task CRUD and lifecycle.
- Subtasks.
- Categories and priorities.
- Calendar and historical day tracking.
- Productivity and streaks.
- Recurring tasks.
- Reminders and notifications.
- Analytics.
- Pomodoro focus mode.
- Profile and settings.
- Secure Supabase/PostgreSQL integration.
