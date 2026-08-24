# Taskly

A local-first task manager for Android built with Flutter.

## Features

- **Authentication** — register and sign in with email + password (stored locally, no encryption by design for now).
- **Authorization** — every task belongs to the signed-in user; all database queries are scoped by user id, so accounts cannot see each other's data.
- **Task management** — create, edit, complete, and delete tasks with title, notes, priority (low/medium/high), color tag, and due date.
- **Home dashboard** — greeting, daily progress bar, stats, and a "Today's focus" list that includes overdue items.
- **Calendar** — month view fed by real task data; days show task-count dots and a per-day task list.
- **All tasks** — search plus All / Pending / Done / Overdue filters.
- **Profile** — edit name/avatar, change password, sign out.

## UX details

- Swipe a task row to delete it, with an UNDO snackbar.
- Pull-to-refresh on all lists.
- Inline form validation, password visibility toggles, loading states.
- Overdue badges, friendly relative dates ("Today", "Tomorrow").
- Layouts adapt to small screens (compact stat tiles, wrapping chips, scroll-safe forms).

## Tech

| Piece | Where |
| --- | --- |
| Theme & design tokens | `lib/core/app_theme.dart` |
| Date helpers | `lib/core/date_utils.dart` |
| SQLite schema & migrations | `lib/helpers/database_helper.dart` |
| Auth/session service | `lib/services/auth_service.dart` |
| User-scoped task repository | `lib/services/task_repository.dart` |
| App shell (bottom nav + FAB) | `lib/home_screen.dart` |
| Tabs | `lib/screens/home_page.dart`, `lib/screens/tasks_page.dart`, `lib/calendar_screen.dart`, `lib/screens/profile_page.dart` |

## Run

```sh
flutter pub get
flutter run
```

## Test

```sh
flutter test
flutter analyze
```
