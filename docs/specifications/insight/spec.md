Productivity & Insights Specification

1. This Specification
   Define the Productivity and Insights feature, including productivity metrics, streaks, historical performance, productivity scores, and visual summaries.

This feature is responsible for the authoritative productivity calculations consumed by Dashboard, Calendar, and other relevant features. 2. Relevant Skills/Procedures
Load only the skills relevant to the current implementation task:

- Flutter Bloc/Cubit
- Dart Model
- Null-Safe Collections
- Dart Error Handling
- Interface-First Architecture
- Dependency Injection
- Testing

3. Current Task Prompt
   Implement or modify Productivity and Insights according to this specification.

Before implementation:

- Inspect the existing productivity implementation and task data model.
- Identify existing calculations, historical data, date handling, and state management.
- Identify unresolved calculation rules.
- Resolve and document productivity rules before implementing calculations.
  Do not invent productivity formulas or duplicate calculations across features.

4. Functional Requirements
   ID Requirement
   INS-FR-01 Display current productivity streak.
   INS-FR-02 Display longest productivity streak.
   INS-FR-03 Display total productive days.
   INS-FR-04 Display daily completion percentage.
   INS-FR-05 Display weekly productivity score.
   INS-FR-06 Display monthly productivity score.
   INS-FR-07 Display historical productivity through a calendar heatmap.
   INS-FR-08 Support historical productivity data and recalculation when task history changes.
   INS-FR-09 Provide appropriate period selection for productivity summaries.
   INS-FR-10 Handle loading, empty, and error states.

5. Productivity Metrics
   5.1 Current Streak
   Display the current consecutive productive-day streak according to the approved productive-day criteria.
   5.2 Longest Streak
   Display the longest consecutive productive-day streak across the available history.
   5.3 Total Productive Days
   Display the number of days that qualify as productive according to authoritative productivity rules.
   5.4 Daily Completion Percentage
   Display the daily completion percentage using the approved calculation and task inclusion rules.
   5.5 Weekly Productivity Score
   Display productivity for the applicable week according to the approved scoring rules.
   5.6 Monthly Productivity Score
   Display productivity for the applicable month according to the approved scoring rules.
   5.7 Calendar Heatmap
   Provide a historical visual representation of productivity.

- Display productivity across dates.
- Use authoritative day-state or productivity values.
- Support historical date navigation.
- Avoid independently calculating productivity for visualization.

6. Authoritative Productivity Rules
   The following rules must be explicitly defined before productivity calculations are implemented:
   6.1 Productive-Day Criteria
   Define exactly what qualifies a day as productive.
   6.2 Empty Days
   Define how days with no scheduled tasks are treated.
   6.3 Cancelled Tasks
   Define whether and how cancelled tasks affect productivity calculations.
   6.4 Overdue Tasks
   Define how overdue and incomplete tasks affect daily and period calculations.
   6.5 Reopened Tasks
   Define how tasks that were completed and subsequently reopened affect historical productivity.
   6.6 Timezone and Day Boundaries
   Define how dates are determined and which timezone governs productivity calculations.
   6.7 Daylight-Saving Behavior
   Define date-boundary behavior when daylight-saving transitions apply.
   6.8 Historical Recalculation
   Define when productivity metrics must be recalculated after historical task changes, including:

- Task creation.
- Task deletion.
- Task date changes.
- Completion changes.
- Task reopening.
- Relevant task status changes.
  These rules must be approved and documented before calculation implementation.

7. Data and Business Rules

- Productivity calculations must have one authoritative implementation.
- Dashboard and Calendar must consume shared productivity results.
- Historical calculations must follow the approved historical recalculation rules.
- Metrics must remain consistent across Dashboard, Calendar, and Insights.
- Do not create separate formulas in presentation widgets.
- Persist calculated values only where justified by the approved architecture.
- Persisted metrics must remain consistent with their authoritative source data.

8. Architecture

- Presentation: Insights UI and Insights Bloc/Cubit.
- Domain: Authoritative productivity calculations and contracts.
- Data: Required task-history access and persistence.
  Responsibilities:
- Productivity owns day qualification, scores, streaks, and productivity calculations.
- Calendar owns calendar presentation and date navigation.
- Dashboard owns productivity summary presentation.
- Task Management owns task data and task state mutations.
  Reuse shared calculation contracts rather than duplicating business logic.
  Backend and Database Boundaries
- Flutter must communicate with the backend through REST APIs exposed by FastAPI.
- Flutter must not connect directly to PostgreSQL or contain database credentials.
- Productivity must use authoritative task-history data through approved feature contracts and API contracts.
- FastAPI owns backend request validation, authorization, orchestration, and database access.
- PostgreSQL must use appropriate constraints, foreign keys, indexes, and parameterized SQL.
- Database schema changes must follow the project's established migration process.
- Do not introduce or assume a specific ORM, migration tool, API endpoint, response format, or backend implementation unless confirmed by the existing project or an approved specification.
- Productivity owns authoritative calculation rules; database persistence or backend calculation placement must follow the approved architecture and must not create competing calculation implementations.

9. UI States
   The feature must support:

- Loading.
- Loaded.
- Empty history.
- Error.
  Historical data unavailable must not be treated as a calculation failure unless the underlying request failed.

10. Dependencies
    This specification depends on:

- Task Management for authoritative task data and task state.
- Calendar and Daily Tracking for date-based navigation and presentation integration.
- Dashboard for productivity summary integration.
  Calendar and Dashboard must consume productivity rules defined here rather than independently implementing them.

11. Explicit Exclusions
    This specification does not independently define:

- Task CRUD.
- Task completion implementation.
- Task cancellation implementation.
- Reminder or notification behavior.
- Calendar layout and navigation.
- Dashboard layout.
- AI productivity recommendations.
- Focus/Pomodoro functionality.

12. Acceptance Criteria

- [ ] Current streak is calculated correctly.
- [ ] Longest streak is calculated correctly.
- [ ] Total productive days is calculated correctly.
- [ ] Daily completion percentage is correct.
- [ ] Weekly productivity score follows approved rules.
- [ ] Monthly productivity score follows approved rules.
- [ ] Historical productivity heatmap is displayed.
- [ ] Empty-day rules are implemented.
- [ ] Cancelled-task rules are implemented.
- [ ] Overdue-task rules are implemented.
- [ ] Reopened-task rules are implemented.
- [ ] Timezone and day-boundary rules are implemented.
- [ ] Daylight-saving behavior is handled.
- [ ] Historical changes trigger correct recalculation.
- [ ] Dashboard and Calendar consume shared authoritative calculations.
- [ ] Loading, empty, and error states are handled.
- [ ] No duplicate productivity formulas are introduced.
- [ ] Relevant tests are executed and actual results are reported.
