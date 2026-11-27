Calendar & Daily Tracking Specification

1. This Specification
   Define the Calendar and Daily Tracking feature, including calendar views, date selection, task history, daily states, and day-level tracking.

This feature provides a date-based view of the user's tasks and productivity. 2. Relevant Skills/Procedures
Load only the skills relevant to the current implementation task:

- Flutter Bloc/Cubit
- Dart Model
- Null-Safe Collections
- Dart Error Handling
- Interface-First Architecture
- Dependency Injection
- Testing

3. Current Task Prompt
   Implement or modify Calendar and Daily Tracking according to this specification.

Before implementation:

- Inspect the existing calendar and task-tracking implementation.
- Identify existing task data sources, date handling, productivity calculations, and state management.
- Reuse existing authoritative task and productivity rules.
- Identify unresolved day-state or calculation rules before implementation.
  Do not duplicate business logic or introduce assumptions that conflict with existing specifications.

4. Functional Requirements
   ID Requirement
   CAL-FR-01 Provide monthly calendar view.
   CAL-FR-02 Provide weekly calendar view.
   CAL-FR-03 Provide daily view.
   CAL-FR-04 Allow users to select a date.
   CAL-FR-05 Display tasks associated with the selected date.
   CAL-FR-06 Display task and productivity history for the selected date.
   CAL-FR-07 Highlight the current day.
   CAL-FR-08 Visually distinguish completed, partial, pending, missed, and no-scheduled-task days.
   CAL-FR-09 Support manual day-completion marking where approved.
   CAL-FR-10 Automatically identify missed days after the applicable deadline.
   CAL-FR-11 Reflect task changes in the corresponding calendar date and day state.
   CAL-FR-12 Handle loading, empty, and error states.

5. Calendar Views
   5.1 Monthly View

- Display dates in a monthly calendar layout.
- Provide navigation between months.
- Highlight the current date.
- Allow selecting a date.
- Display the applicable day-state indicator.
- Selecting a date opens or updates the daily view.
  5.2 Weekly View
- Display dates and relevant daily task/progress information for the selected week.
- Allow navigation between weeks.
- Highlight the current date.
- Allow selecting a date.
- Display the applicable day-state indicator.
  5.3 Daily View
- Display the selected date.
- Display tasks assigned to that date.
- Display the day's applicable productivity state.
- Allow relevant task actions through existing Task functionality.
- Display the day's history and progress according to authoritative rules.

6. Date Selection and Navigation

- The current date is selected by default when entering the feature unless an existing navigation context specifies another date.
- Users can select dates from monthly and weekly views.
- Selecting a date updates the daily view.
- The selected date must remain consistent across relevant calendar navigation and task actions.
- Current-day highlighting must be independent of the selected-date indicator.
- Date calculations must follow the project's authoritative timezone and date-handling rules.

7. Day States
   The calendar must support these day-state distinctions:
   State Description
   Completed The day qualifies as completed according to authoritative productivity rules.
   Partial The day contains progress but does not qualify as completed.
   Pending The day has scheduled tasks that remain incomplete and is still eligible for completion.
   Missed The day qualifies as missed after the applicable deadline and according to authoritative rules.
   No Scheduled Tasks No tasks are scheduled for the day.

State Rules

- Day-state calculations must be owned by the authoritative Productivity specification.
- Calendar must consume the calculated state rather than independently calculating it.
- State precedence and transition rules must be explicitly defined before implementation.
- No-scheduled-task days must not automatically be classified as completed or missed unless approved by the authoritative productivity rules.
- Manual day completion must not override task-derived calculations unless explicitly permitted by the approved rules.

8. Manual Day Completion
   Where approved:

- Users may manually mark a day as completed.
- The action must follow the authoritative manual-completion rules.
- Manual completion must not silently modify individual task completion states.
- Manual and automatic day states must remain distinguishable in the data model where required.
- Reversibility and restrictions must be defined before implementation.

9. Automatic Missed-Day Marking

- Missed-day marking occurs only after the applicable deadline.
- Deadline and timezone rules must be defined in the authoritative Productivity specification.
- Automatic marking must not occur while a day is still eligible for completion.
- Missed-day state must be derived or persisted according to the approved architecture.
- Calendar must display the authoritative missed state.
- Recalculation must handle changes to task data or approved manual state.

10. Data and Business Rules

- Calendar consumes task data from the Task feature.
- Calendar consumes daily productivity states and calculations from the Productivity feature.
- Calendar must not independently calculate completion, partial progress, missed-day eligibility, streaks, or productivity scores.
- Date selection and calendar presentation belong to Calendar.
- Task completion and task data mutations belong to Task Management.
- Day-state calculation and productivity rules belong to Productivity.
- Historical information must follow the authoritative data-retention and calculation rules.

11. Architecture

- Presentation: Calendar UI and Calendar Bloc/Cubit.
- Domain: Calendar-specific contracts and date-navigation behavior where required.
- Data: Reuse existing task and productivity repositories/contracts.
  Responsibilities:
- Calendar owns calendar presentation, view switching, date navigation, and selected-date state.
- Task Management owns task data and task state mutations.
- Productivity owns authoritative day-state and productivity calculations.
  Avoid duplicate repositories, calculations, or business rules.
  Backend and Database Boundaries
- Flutter must communicate with the backend through REST APIs exposed by FastAPI.
- Flutter must not connect directly to PostgreSQL or contain database credentials.
- Calendar must consume task and productivity data through the existing feature contracts/repositories and approved API contracts.
- FastAPI owns backend request validation, authorization, orchestration, and database access.
- PostgreSQL must use appropriate constraints, foreign keys, indexes, and parameterized SQL.
- Database schema changes must follow the project's established migration process.
- Do not introduce or assume a specific ORM, migration tool, API endpoint, response format, or backend implementation unless confirmed by the existing project or an approved specification.
- Calendar-specific API or database ownership must not duplicate Task Management or Productivity responsibilities.

12. UI States
    The feature must support:

- Loading
- Loaded
- Empty
- Error
  Additional behavior:
- A date with no tasks must display the appropriate no-scheduled-task state.
- An unavailable history result must not be treated as a task failure.
- Errors must provide appropriate feedback and retry behavior.
- Selected date and current date must be visually distinguishable.

13. Explicit Dependencies
    This specification depends on:

- Task Management specification for task data, date assignment, and task completion.
- Productivity specification for day states, completion rules, missed-day rules, streaks, and productivity calculations.
  The Productivity specification must define these rules before Calendar day-state implementation begins.

14. Out of Scope
    This specification does not independently define:

- Task CRUD.
- Task completion behavior.
- Productivity scoring.
- Streak calculation.
- Day completion qualification.
- Missed-day deadlines.
- Manual completion eligibility.
- Recurring-task generation.
- Reminder and notification behavior.
  These responsibilities belong to their respective authoritative feature specifications.

15. Acceptance Criteria

- [ ] Monthly view is available.
- [ ] Weekly view is available.
- [ ] Daily view is available.
- [ ] Users can navigate between calendar periods.
- [ ] Users can select a date.
- [ ] Selected-date tasks are displayed correctly.
- [ ] Current date is highlighted.
- [ ] Selected date is visually distinguishable.
- [ ] Completed, partial, pending, missed, and no-scheduled-task states are displayed.
- [ ] Day states use authoritative Productivity rules.
- [ ] Manual completion works where approved.
- [ ] Automatic missed-day marking follows approved deadline rules.
- [ ] Calendar reflects task changes.
- [ ] Loading, empty, and error states are handled.
- [ ] No duplicate productivity calculations are introduced.
- [ ] Relevant tests are executed and actual results are reported.
