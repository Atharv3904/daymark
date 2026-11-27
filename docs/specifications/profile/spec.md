DayMark Profile — Unified Specification
Status: Requirements consolidation; unresolved profile/settings rules require approval before implementation
Backend: FastAPI REST API | Database: PostgreSQL (SQL) | State: Bloc/Cubit | Architecture: Clean Architecture

1. Authority and Scope
   Define the user's profile lifecycle and profile management after an account has been registered, plus all reminder and notification preferences/settings.

Profile owns user profile information and user-level preferences. Authentication owns account identity, credentials, and session lifecycle. Shared Notification Service owns notification permission handling, scheduling, delivery, rescheduling, cancellation, and platform-specific behavior. Task Management owns task records and does not own reminders or notification settings.

Precedence: system/safety → global DayMark rules → this SPEC → relevant skills → current task prompt. Surface conflicts; never silently alter approved requirements. 2. Relevant Skills/Procedures
Load only relevant skills:

- Flutter Bloc/Cubit
- Dart Model
- Null-Safe Collections
- Dart Error Handling
- Interface-First Architecture
- Dependency Injection
- Security Review
- Testing

3. Implementation Task
   Before implementation:

- Inspect existing profile models, tables/schema, repositories, screens, auth-registration flow, DI, and state management.
- Confirm approved profile fields and settings.
- Identify profile initialization behavior and failure/retry handling.
- Inspect notification preference and reminder infrastructure.
- Reuse existing contracts and conventions.
  Do not duplicate authentication, account creation, password handling, session management, task reminder configuration, or notification scheduling/delivery logic.

4. Functional Requirements
   ID Requirement
   PROF-FR-01 Ensure each registered user has an associated profile.
   PROF-FR-02 Initialize a profile after successful account registration according to the approved strategy.
   PROF-FR-03 Retrieve the authenticated user's profile.
   PROF-FR-04 Display profile information.
   PROF-FR-05 Allow users to edit approved profile fields.
   PROF-FR-06 Validate profile inputs.
   PROF-FR-07 Persist profile changes.
   PROF-FR-08 Handle profile initialization, loading, empty/incomplete, and error states.
   PROF-FR-09 Restrict profile access and modifications to the profile owner.
   PROF-FR-10 Reflect successful profile updates in relevant UI.
   PROF-FR-11 Allow users to view and update reminder and notification preferences/settings.
   PROF-FR-12 Allow users to enable/disable approved reminders, including the daily planning reminder.
   PROF-FR-13 Allow users to configure approved reminder times/settings, including the daily planning reminder, subject to the approved settings contract.
   PROF-FR-14 Persist all reminder and notification preferences/settings and associate them with the authenticated user.
   PROF-FR-15 Communicate preference changes to the shared Notification Service so active schedules can be reconciled.

5. Profile Lifecycle
   5.1 Profile Initialization
   Profile initialization is triggered as part of the registration lifecycle defined by Authentication.

- Associate the profile with the authenticated user identity.
- Initialize only approved profile fields.
- Avoid duplicate profiles.
- Initialization must be idempotent or otherwise protected against duplicate execution.
- Define initialization failure and retry handling.
- Do not assume account creation and profile creation are automatically atomic.
  The exact strategy (backend operation, database mechanism, or application-coordinated operation) must be selected based on existing architecture and approved before implementation.
  5.2 View Profile
- Retrieve the authenticated user's profile.
- Display available profile fields.
- Handle incomplete profiles.
- Do not expose another user's profile through client-controlled identifiers.
  5.3 Edit Profile
- Allow editing only approved profile fields.
- Prepopulate edit form with current values.
- Validate inputs.
- Save changes through Profile repository boundary.
- Preserve fields not intentionally changed.
- Show success/failure feedback.
- Prevent duplicate submissions while saving.
  5.4 Profile Completion
  If required information is missing:
- Represent profile as incomplete.
- Provide approved completion flow.
- Missing optional information is not an error.
- Required fields and completion rules must be defined before implementation.

6. Profile Data Contract
   The authoritative profile field list must come from approved project requirements/schema.

Do not invent phone, bio, gender, birthday, address, or other fields unless approved.

For each approved field define:

- Name and type.
- Required/optional.
- Validation.
- Editable status.
- Persistence mapping.
  Profile identity must link to authenticated user ID and must not be independently user-editable.

7. Reminders and Notification Preferences
   Profile is the sole feature owner for all user-facing reminder and notification settings. Tasks must not contain reminder configuration or reminder-related requirements.
   7.1 Preference Scope
   The Profile settings may include approved reminder and notification options, such as:

- Global notifications enabled/disabled.
- Daily planning reminder enabled/disabled and time.
- Upcoming-task reminder preferences, if approved.
- Overdue reminder preferences, if approved.
- Other reminder types, frequencies, or timing preferences only when explicitly approved.
  The exact reminder types, options, and defaults must be approved; do not invent them.
  7.2 Reminder Configuration
- Users can view and update approved reminder settings from Profile.
- Users can enable or disable each supported reminder type.
- Users can configure reminder time/frequency where supported by the approved contract.
- Settings must be validated and persisted for the authenticated user.
- Settings must be reflected accurately when Profile is reopened.
- Changes must be communicated to the shared Notification Service for schedule reconciliation.
- If OS permission is denied or unavailable, show appropriate status and guidance without falsely claiming that a notification is scheduled or will be delivered.
- Defaults, timezone policy, recurrence/frequency options, and permission-denied behavior require approval.
  7.3 Daily Planning Reminder
- User can enable or disable the daily planning reminder.
- When enabled, user can configure its time if supported by the approved contract.
- Validate the selected time.
- Persist the setting for the authenticated user.
- Changes must be communicated to the shared Notification Service.
- Exact default enabled state, default time, timezone policy, and behavior when permission is denied require approval.
  7.4 Notification Preference UI States
  Support applicable:
- Loading preferences.
- Loaded preferences.
- Saving/updating.
- Success.
- Failure.
- Permission denied/unavailable state.
  Do not show a preference as successfully saved until persistence confirms it. Do not claim a notification will be delivered merely because a preference is enabled.

8. Ownership Boundaries
   Responsibility Owner
   Profile fields and profile CRUD Profile
   Profile initialization coordination Authentication lifecycle + Profile contract
   User-level notification preferences Profile
   Daily planning reminder enabled/time preference Profile
   All reminder and notification settings/preferences Profile
   Notification permission request Shared Notification Service
   Notification scheduling and delivery Shared Notification Service
   Rescheduling/cancellation Shared Notification Service
   Task lifecycle events that affect task reminders Tasks coordinates with Notification Service

Tasks must not implement reminder settings or reminder logic. Profile must not implement its own notification scheduling/delivery engine; that belongs to shared notification infrastructure. 9. Architecture

- Presentation: profile display/edit screens, settings UI, Bloc/Cubit states.
- Domain: profile entity, approved preference rules, use cases, repository contracts.
- Data: REST API/local persistence, mapping, data-source error handling.
- Repository: abstracts persistence and returns project-owned Result/Failure types.
- DataSource: maps API/platform failures to application-owned errors.
- Notification Service: shared interface/service invoked to reconcile preference changes; implementation belongs to notification infrastructure.
  Follow existing project conventions and inspect repository before creating/modifying files. Do not introduce a parallel architecture.
  Backend and Database Boundaries
- Flutter must communicate with the backend through REST APIs exposed by FastAPI.
- Flutter must not connect directly to PostgreSQL or contain database credentials.
- FastAPI owns backend request validation, authorization, orchestration, and database access.
- PostgreSQL must use appropriate constraints, foreign keys, indexes, and parameterized SQL.
- Database schema changes must follow the project's established migration process.
- Profile and user-level preferences must be associated with the authenticated user; the backend must not trust client-supplied owner IDs.
- Profile initialization and account registration must follow the approved Authentication lifecycle strategy; do not assume they are automatically atomic.
- Notification preferences must be persisted according to the approved storage strategy and coordinated with the shared Notification Service.
- Do not introduce or assume a specific ORM, migration tool, endpoint, API response format, authentication/token implementation, or database schema unless confirmed by the existing project or an approved specification.
- Local persistence may be used only where the approved architecture requires it; it must not be treated as a replacement for authoritative backend persistence without approval.

10. Security, Data Integrity, and Reliability

- Profile and preferences belong to the authenticated user.
- Backend authorization must prevent cross-user access/modification.
- Do not trust client-supplied owner IDs.
- Do not store sensitive secrets in ordinary preferences.
- Validate input at appropriate boundaries.
- Avoid logging sensitive profile values.
- Handle network/persistence failures without false success.
- Follow approved FastAPI authorization and PostgreSQL schema/constraint rules.
- Follow global privacy, security, dependency, and release requirements.

11. UI States
    Profile and settings components support applicable:

- Initial/loading.
- Loaded/content.
- Empty/incomplete.
- Saving.
- Success.
- Failure.
- Retry.
- Permission-related state for notifications.

12. Unresolved Decisions — Approval Required

- Approved profile fields and requiredness.
- Profile initialization strategy.
- Initialization failure/retry behavior.
- Profile completion requirements.
- Approved reminder and notification preference list and configuration options.
- Defaults for each supported reminder/notification setting.
- Timezone and DST behavior.
- Behavior when OS permission is denied.
- Whether reminder/notification preferences are stored remotely, locally, or both.
- Synchronization/reconciliation behavior between preference storage and notification scheduling.

13. Acceptance Criteria

- Each registered user has an associated profile according to approved initialization rules.
- Users can retrieve and edit approved profile fields.
- Profile access is restricted to its owner.
- User-level notification preferences can be viewed and updated.
- Daily planning reminder can be enabled/disabled and its time configured where approved.
- Preferences persist and are loaded correctly.
- Preference changes are communicated to shared Notification Service.
- Profile owns all reminder/notification settings, but does not implement scheduling/delivery itself.
- Loading, incomplete, success, failure, and permission-related states are handled.
- Tests cover profile lifecycle, validation, persistence, ownership, preferences, and service coordination.
- Unresolved rules are not implemented through agent assumptions.
