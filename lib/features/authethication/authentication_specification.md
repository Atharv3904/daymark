# DayMark Authentication Specification [SUPERSEDED]

> [!IMPORTANT]
> **NOTICE: THIS LOCAL FILE IS SUPERSEDED.**
> The official, authoritative, and active specification for DayMark Authentication is located at:
> [`docs/specifications/authethications/spec.md`](file:///Users/atharvkulkarni/Documents/daymark/daymark/daymark_tracking/docs/specifications/authethications/spec.md)
>
> All AI agents, contributors, and implementations must refer exclusively to `docs/specifications/authethications/spec.md` as the single source of truth.

---

### Official Architecture Summary

- **Backend:** Python FastAPI REST API
- **Database:** PostgreSQL (SQL)
- **Client Architecture:** Feature-first Clean Architecture (Presentation → Domain → Data)
- **State Management:** Bloc/Cubit
- **Navigation:** GoRouter

### Key Architectural Boundaries

1. **REST Communication:** Flutter communicates with authentication services exclusively through the FastAPI REST API; it must never connect directly to PostgreSQL.
2. **Authority:** FastAPI owns authentication validation, authorization, session/token management, and account/profile persistence orchestration.
3. **No Direct DB Access:** Database credentials, signing secrets, and privileged backend credentials remain strictly server-side.
4. **Error Mapping:** Remote Data Sources map HTTP and backend errors to application-owned domain failures (`AppFailure`).
5. **No Invented Contracts:** Agents must not invent endpoints, token formats, or authentication mechanisms without an approved backend specification.

For all functional requirements, input contracts, screen flows, error hierarchies, and acceptance criteria, please consult:
[`docs/specifications/authethications/spec.md`](file:///Users/atharvkulkarni/Documents/daymark/daymark/daymark_tracking/docs/specifications/authethications/spec.md).
