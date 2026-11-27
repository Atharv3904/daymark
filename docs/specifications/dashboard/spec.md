Dashboard Specification

1. This Specification
   Define the Dashboard feature, its content, data requirements, interactions, and acceptance criteria.

The Dashboard provides a consolidated overview of the user's productivity and task progress. All displayed values must be derived from shared authoritative task and productivity rules. 2. Relevant Skills/Procedures
Load only the skills relevant to the current implementation task:

- Flutter Bloc/Cubit
- Dart Model
- Null-Safe Collections
- Dart Error Handling
- Interface-First Architecture
- Dependency Injection
- Testing

3. Current Task Prompt
   Implement or modify the Dashboard according to this specification.

Before implementation:

- Inspect the existing Dashboard implementation.
- Identify the existing data sources, state management, reusable widgets, and shared calculations.
- Reuse existing authoritative task and productivity logic.
- Identify missing dependencies or unresolved requirements before making assumptions.
  Do not duplicate business logic, introduce unnecessary abstractions, or modify unrelated features.

4. Functional Requirements
   ID Requirement
   DASH-FR-01 Display the current date and an appropriate greeting.
   DASH-FR-02 Display total, completed, pending, and overdue task counts for the applicable day.
   DASH-FR-03 Display daily completion percentage.
   DASH-FR-04 Display a weekly productivity summary.
   DASH-FR-05 Display the user's current streak.
   DASH-FR-06 Provide Quick Add Task functionality.
   DASH-FR-07 Display upcoming tasks.
   DASH-FR-08 Allow navigation to the relevant detailed task or productivity screen.
   DASH-FR-09 Reflect task changes in Dashboard data.
   DASH-FR-10 Handle loading, empty, and error states.

5. Dashboard Content
   5.1 Daily Overview
   Display:

- Date
- Greeting
- Total tasks
- Completed tasks
- Pending tasks
- Overdue tasks
- Daily completion percentage
  Values must follow the authoritative task and productivity calculation rules.
  5.2 Weekly Summary
  Display a summary of the user's productivity for the applicable week.

The calculation period, task inclusion rules, and metrics must follow the authoritative productivity rules.
5.3 Current Streak
Display the user's current productivity streak.

Streak calculation and qualifying-day rules must be derived from the authoritative productivity rules.
5.4 Quick Add
Provide an entry point to create a task.

Quick Add must reuse the existing task-creation flow and must not introduce a separate task creation implementation.
5.5 Upcoming Tasks
Display relevant upcoming tasks.

Task eligibility, date range, ordering, and display limits must follow the authoritative task rules or approved feature requirements. 6. Data and Business Rules

- Dashboard must use authoritative task and productivity data.
- Dashboard must not independently implement task counts, overdue logic, completion percentage, weekly calculations, or streak calculations.
- Reuse existing feature contracts and calculation logic.
- Do not create duplicate calculations within Dashboard.
- Dashboard data must remain consistent with the corresponding Task, Calendar, and Productivity features.
- Date boundaries must follow the project's established date-handling rules.

7. Interactions

- Quick Add opens the shared task creation flow.
- Selecting a task opens its existing details or editing flow.
- Selecting a daily summary opens the relevant daily task view.
- Selecting weekly productivity or streak information opens the corresponding feature, if its navigation route exists.
- Dashboard data must refresh or reflect relevant task mutations.

8. Architecture

- Presentation: Dashboard UI and Dashboard Bloc/Cubit.
- Domain: Consume existing authoritative feature contracts.
- Data: Reuse existing repositories and data sources.
  Dashboard widgets must not directly access remote data sources/APIs or implement business calculations.

Avoid creating new repositories, use cases, or abstractions when existing feature contracts already provide the required functionality.
Backend and Database Boundaries

- Flutter must communicate with the backend through REST APIs exposed by FastAPI.
- Flutter must not connect directly to PostgreSQL or contain database credentials.
- Dashboard must consume task and productivity data through existing feature contracts/repositories and approved API contracts.
- FastAPI owns backend request validation, authorization, orchestration, and database access.
- PostgreSQL must use appropriate constraints, foreign keys, indexes, and parameterized SQL.
- Database schema changes must follow the project's established migration process.
- Do not introduce or assume a specific ORM, migration tool, API endpoint, response format, or backend implementation unless confirmed by the existing project or an approved specification.
- Dashboard must not duplicate Task Management or Productivity data ownership, repositories, or calculations.

9. UI States
   The Dashboard must support:

- Loading
- Loaded
- Empty
- Error
  Empty sections must be handled independently where appropriate.

A lack of tasks must not be treated as an error.

Errors must provide appropriate user feedback and retry behavior where applicable. 10. Acceptance Criteria

- [ ] Current date and greeting are displayed.
- [ ] Daily task metrics are correct.
- [ ] Daily completion percentage follows authoritative rules.
- [ ] Weekly summary follows authoritative productivity rules.
- [ ] Current streak follows authoritative productivity rules.
- [ ] Quick Add uses the shared task-creation flow.
- [ ] Upcoming tasks follow authoritative task eligibility and ordering rules.
- [ ] Dashboard reflects relevant task changes.
- [ ] Navigation actions work where corresponding routes exist.
- [ ] Loading, empty, and error states are handled.
- [ ] No duplicated business calculations are introduced.
- [ ] Relevant tests are executed and actual results are reported.

11. Out of Scope
    This specification does not independently define:

- Task CRUD or task validation.
- Completion and overdue calculation rules.
- Productivity scoring and streak calculation rules.
- Weekly period calculation rules.
- Upcoming-task eligibility and sorting rules.
- Task creation implementation.
- Analytics calculation logic.
  These belong to their respective authoritative feature specifications.
