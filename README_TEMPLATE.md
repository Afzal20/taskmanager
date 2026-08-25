# Taskly

<!-- INSTRUCTION: Write one punchy sentence here: what the app is, who it is for, and the single most impressive technical fact (local-first, per-user data isolation over SQLite). Keep it under 30 words. Example tone: "A local-first task manager for Android built with Flutter - multi-user accounts, live calendar, zero backend." -->

<p align="center">
  <img src="assets/logo.svg" alt="Taskly logo" width="120" />
</p>

<!-- INSTRUCTION: Add 3-5 shields below. Suggested badges:
![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.10-0175C2?logo=dart&logoColor=white)
![SQLite](https://img.shields.io/badge/SQLite-local%20first-003B57?logo=sqlite&logoColor=white)
![Tests](https://img.shields.io/badge/tests-passing-brightgreen)
Replace values with your real versions after checking pubspec.yaml. -->

---

## Screenshots

<!-- INSTRUCTION: Take screenshots on a device or emulator at the SAME resolution, portrait.
Suggested captures (8):
1. Login screen          -> docs/screenshots/login.png
2. Register screen       -> docs/screenshots/register.png
3. Home dashboard        -> docs/screenshots/home.png   (show stats + Today's focus populated)
4. Calendar month view   -> docs/screenshots/calendar.png (pick a month with several tasks so dots are visible)
5. All Tasks with filters-> docs/screenshots/tasks.png  (show search text + an active filter chip + an overdue badge)
6. Add/Edit task form    -> docs/screenshots/add_task.png
7. Profile page          -> docs/screenshots/profile.png
8. Swipe-delete UNDO     -> docs/screenshots/undo.png   (capture mid-snackbar if possible)

Put images in a docs/screenshots folder, then use a table like below. Tables render better than long image lists. -->

| Home | Calendar | Tasks | Add Task |
| --- | --- | --- | --- |
| ![Home](docs/screenshots/home.png) | ![Calendar](docs/screenshots/calendar.png) | ![Tasks](docs/screenshots/tasks.png) | ![Add Task](docs/screenshots/add_task.png) |

| Login | Register | Profile | Undo |
| --- | --- | --- | --- |
| ![Login](docs/screenshots/login.png) | ![Register](docs/screenshots/register.png) | ![Profile](docs/screenshots/profile.png) | ![Undo](docs/screenshots/undo.png) |

---

## About This Project

<!-- INSTRUCTION: Two short paragraphs maximum.
Paragraph 1: the problem (task apps need accounts and servers; you built a fully local alternative that still supports multiple users).
Paragraph 2: who should look at this code (anyone learning Flutter architecture, SQLite migrations, or auth design without a server). -->

## Features

<!-- INSTRUCTION: Verify each line against the final build and edit freely. Delete anything you removed during the completion pass; add what you added (e.g., hashed passwords). -->

- **Multi-user authentication** - register and sign in with email and password; credentials stored hashed locally.
- **Per-user data isolation** - every database query is scoped by user id; accounts cannot see each other's tasks.
- **Task management** - create, edit, complete, delete tasks with title, notes, priority (low/medium/high), color tag, and due date.
- **Home dashboard** - time-based greeting, daily progress card, stat tiles, and a "Today's focus" list including overdue items.
- **Live calendar** - hand-built month grid bound to real task data, day-count dots, per-day task list, Monday-first weeks.
- **Search and filters** - live search plus All / Pending / Done / Overdue chips on the tasks tab.
- **Profile management** - emoji avatars, name editing, password change with verification, sign out.
- **Thoughtful interactions** - swipe-to-delete with UNDO (restores the exact original row), pull-to-refresh, inline validation, overdue badges, friendly relative dates ("Today", "Tomorrow").

## Highlights for Developers

<!-- INSTRUCTION: This section is your differentiator for recruiters and clients. One bullet each, pointing at the file that proves it. Adjust paths if you moved files during the completion pass. -->

- Real schema migration path (v1 to v2) that preserves legacy rows without leaking them across accounts - see `lib/helpers/database_helper.dart`.
- Authorization enforced at the repository layer, not in UI code - see `lib/services/task_repository.dart`.
- UNDO restores the original primary key, not a re-inserted copy - see the delete flow in the tasks screen.
- Centralized design tokens and themed components - see `lib/core/app_theme.dart`.
- Unit tests covering model round-trip, overdue logic, and session restore - see `test/`.

## Tech Stack

| Piece | Choice |
| --- | --- |
| Framework | Flutter (Material 3) |
| Language | Dart 3.10 |
| Local database | sqflite (raw SQL, parameterized queries) |
| Session storage | shared_preferences |
| Fonts and icons | google_fonts (Inter), flutter_svg, custom vector logo |
| Testing | flutter_test (unit tests), flutter_lints |

<!-- INSTRUCTION: Update versions from pubspec.yaml before publishing. -->

## Architecture

```
lib/
  core/            theme tokens, date utilities
  helpers/         database_helper.dart (schema + migrations)
  models/          data classes
  services/        auth_service.dart, task_repository.dart
  screens/         auth, home, calendar, tasks, profile screens
  widgets/         shared UI components
test/              unit tests
```

<!-- INSTRUCTION: Optionally add 2-3 sentences here describing the data flow: UI calls repository -> repository scopes by session user id -> parameterized SQL via database_helper. Mention that state is component-level setState by design for this scope. Honesty about scope reads well in interviews. -->

## Getting Started

### Prerequisites

- Flutter SDK (check version with `flutter --version`)
- An Android device or emulator (a web build exists but Android is the primary target)

### Run

```bash
git clone https://github.com/Afzal20/taskly-flutter.git
cd taskly-flutter
flutter pub get
flutter run
```

### Test

```bash
flutter test
```

### Build release APK

<!-- INSTRUCTION: Include this only if release signing is configured. If signing reads from key.properties (gitignored), mention creating it from key.properties.example. If not configured yet, delete this block. -->

```bash
flutter build apk --release
```

## Security Notes

<!-- INSTRUCTION: Be honest and specific here. State clearly: credentials are hashed before storage; data never leaves the device; sessions persist locally. If any known limitation remains (single-device by design, no cloud sync), list it under Limitations instead of hiding it. -->

## Roadmap

<!-- INSTRUCTION: Pick 2-4 items max. Strong candidates given your stack:
- Optional Supabase sync behind a toggle (keeps local-first behavior)
- Recurring tasks
- Reminders/notifications
- JSON export/import -->
- [ ] Item one
- [ ] Item two

## License

<!-- INSTRUCTION: Choose one. MIT recommended for portfolio pieces. If MIT: add LICENSE file and write "MIT" here with a link. -->

## Author

**Md. Afzal Hossen**

- GitHub: [Afzal20](https://github.com/Afzal20)
- LinkedIn: [afzal-hossen](https://www.linkedin.com/in/afzal-hossen)

<!-- INSTRUCTION: Final checklist before publishing:
1. Every image link resolves (push screenshots first, then check on github.com rendered view).
2. Clone command matches the FINAL repo name.
3. Feature list matches the actual build.
4. No template comments remain (delete every block wrapped like this one).
-->
