# DayMark — Global Routing Specification

**Routing:** GoRouter  
**Scope:** Global route definitions, route names, and router configuration.

## 1. Purpose

Define a centralized routing structure using GoRouter to manage navigation, route names, route paths, redirects, and authentication-based route protection.

## 2. File Structure

```text
daymark_tracking/lib/core/routes
├── routes.dart
├── routes_name.dart
└── router.dart
```

### `routes_name.dart`

- Contains centralized route name constants.
- Use descriptive, consistent naming.
- Avoid hardcoded route names throughout the application.

### `routes.dart`

- Contains centralized route path constants.
- Each route path must have a corresponding route name.
- Avoid hardcoded route paths throughout the application.

### `router.dart`

- Contains the main GoRouter configuration.
- Defines route registrations and navigation behavior.
- Handles redirects and authentication-based route protection.
- Connects route names and paths to their corresponding pages.

## 3. Naming Convention

Use clear, class-specific naming conventions:

| File               | Naming       |
| ------------------ | ------------ |
| `routes_name.dart` | `RouteNames` |
| `routes.dart`      | `AppRoutes`  |
| `router.dart`      | `AppRouter`  |

Use descriptive route names and paths, for example:

```text
RouteNames.login
RouteNames.register

AppRoutes.login
AppRoutes.register
```

## 4. Routing Rules

- All routes must be centralized.
- Use named navigation wherever appropriate.
- Protected routes require an authenticated user.
- Unauthenticated users accessing protected routes must be redirected to the appropriate public route.
- Authentication callback routes must remain accessible when unauthenticated.
- Redirect logic must use the application's authentication state.
- Avoid duplicate route definitions.
- Navigation logic must not be scattered across UI widgets.

## 5. Responsibilities

- `routes_name.dart`: Route names.
- `routes.dart`: Route paths.
- `router.dart`: Route registration, GoRouter configuration, and redirects.

## 6. Implementation Rules

- Follow the existing project architecture and coding conventions.
- Use GoRouter consistently.
- Do not introduce another navigation package.
- Keep routing configuration centralized and maintainable.
- Verify route names, paths, redirects, and navigation flows.

---

**Artifact Metadata**

- UserFacing: true
- RequestFeedback: false
- Summary: Global GoRouter configuration and naming conventions for DayMark.
