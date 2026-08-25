# Taskly

A local-first task manager for Android built with Flutter.

## Features

- **Authentication** — register and sign in with email + password. Passwords are never stored in plaintext: they are hashed with PBKDF2-HMAC-SHA256 (120,000 iterations, per-user random salt) via the `crypto` package.
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
| SQLite schema & migrations (v1→v3) | `lib/helpers/database_helper.dart` |
| PBKDF2 password hashing | `lib/services/password_hasher.dart` |
| Auth/session service | `lib/services/auth_service.dart` |
| User-scoped task repository | `lib/services/task_repository.dart` |
| App shell (bottom nav + FAB) | `lib/home_screen.dart` |
| Tabs | `lib/screens/home_page.dart`, `lib/screens/tasks_page.dart`, `lib/calendar_screen.dart`, `lib/screens/profile_page.dart` |

## Security

- **Password hashing** — passwords are stored as self-describing PBKDF2 hashes (`pbkdf2$<iterations>$<salt>$<hash>`), never in plaintext. Verification recomputes the hash and compares in constant time.
- **Legacy-account migration** — schema v1→v2 added per-user scoping (pre-auth rows are parked under userId `-1` so legacy data never leaks across accounts). Schema v2→v3 introduced hashing: existing plaintext rows are *not* silently converted. Instead, signing in with a legacy account routes through a password-reset screen (`lib/screens/auth/reset_password_screen.dart`) that stores the new password hashed. The reset path is only available while an account still holds an unhashed password, so secured accounts cannot be hijacked through it.

## Signing

Release builds are signed with a local keystore that is **not** committed:

1. Generate a keystore:
   ```sh
   keytool -genkey -v -keystore android/upload-keystore.jks \
     -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```
2. Copy `android/key.properties.example` to `android/key.properties` and fill in your real passwords/alias. Both `key.properties` and `*.jks` are gitignored.
3. Build:
   ```sh
   flutter build apk --release
   ```

If `android/key.properties` is absent, release builds fall back to the debug signing config so `flutter run --release` still works on a fresh clone.

## Run

```sh
flutter pub get
flutter run
```

## Test

```sh
flutter test        # unit + widget tests
flutter analyze
```

The widget tests (`test/app_widget_test.dart`) cover the calendar grid (weekday headers, live task data), the All/Pending/Done/Overdue filter chips, and swipe-to-delete with UNDO restoring the exact original row id. They run the real SQLite schema on the host through `sqflite_common_ffi`.
