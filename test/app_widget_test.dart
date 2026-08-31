import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:taskly/calendar_screen.dart';
import 'package:taskly/core/app_theme.dart';
import 'package:taskly/core/date_utils.dart' as du;
import 'package:taskly/helpers/database_helper.dart';
import 'package:taskly/home_screen.dart';
import 'package:taskly/models/task.dart';
import 'package:taskly/models/user.dart';
import 'package:taskly/screens/add_task_screen.dart';
import 'package:taskly/screens/tasks_page.dart';
import 'package:taskly/services/auth_service.dart';

/// Widget tests for the calendar, the task filter chips, and swipe-to-delete
/// with UNDO, plus regressions for cross-tab behaviour of the app shell. They
/// run the real SQLite schema on the host via sqflite_common_ffi so task
/// screens operate against genuine, isolated data.
///
/// This is the only test file that touches taskly.db; `flutter test` runs
/// files concurrently, and two files deleting/opening the same database file
/// race each other (SQLite "readonly database" errors).
///
/// sqflite_ffi talks to a separate isolate, so every database call must be
/// driven through [WidgetTester.runAsync]; otherwise the future never completes
/// inside the widget test's fake-async zone.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  // Note: the pages under test are hosted by HomeScreen's Scaffold in the real
  // app, so pumpPage() supplies one here. A stock M3 dark theme is used instead
  // of AppTheme.dark because that pulls in google_fonts, which tries to fetch
  // Inter over HTTP during tests (no network in the test binding).

  setUp(() async {
    databaseFactory = databaseFactoryFfi;
    // Give any work still in flight from the previous test (e.g. a reload
    // triggered by UNDO) a real-async window to finish before the shared
    // ffi database is closed and its file replaced.
    await Future<void>.delayed(const Duration(milliseconds: 150));
    await DatabaseHelper.closeForTesting();
    final dbPath = await databaseFactory.getDatabasesPath();
    final file = File(p.join(dbPath, 'taskly.db'));
    if (await file.exists()) await file.delete();
    AuthService.instance.resetForTesting();
    SharedPreferences.setMockInitialValues({});
  });

  Future<int> seedUser() async {
    final db = await DatabaseHelper.instance.database;
    return db.insert('users', {
      'name': 'Test User',
      'email': 'widget.test@example.com',
      'password': 'hashed',
      'avatar': '🐼',
      'createdAt': DateTime.now().toIso8601String(),
    });
  }

  Future<int> insertTask({
    required int userId,
    required String title,
    int isDone = 0,
    DateTime? due,
  }) async {
    return DatabaseHelper.instance.insertTask(Task(
      userId: userId,
      title: title,
      description: '',
      colorValue: 0xFF6366F1,
      priority: 1,
      createTime: DateTime.now().toIso8601String(),
      dueDate: (due ?? DateTime.now()).toIso8601String(),
      isDone: isDone,
    ));
  }

  /// Sets the session, pumps the page on a phone-sized surface, then lets the
  /// page's own async DB load (initState -> reload) finish on the real event
  /// loop before settling.
  Future<void> pumpPage(WidgetTester tester, Widget child,
      {required int userId}) async {
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);
    AuthService.instance
        .setSessionForTesting(userId, 'widget.test@example.com');
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(body: child),
    ));
    await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 400)));
    // Pages now run a second query after their first (e.g. tasks + memories),
    // so allow one more real-async window for both round-trips to finish
    // before settling.
    await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 400)));
    await tester.pumpAndSettle();
  }

  /// Pumps real time until [condition] holds, giving async work on the
  /// sqflite_ffi isolate (and any setState it triggers) room to finish
  /// regardless of host speed. Fails the test after ~5 seconds.
  Future<void> waitFor(WidgetTester tester, bool Function() condition) async {
    for (var i = 0; i < 100; i++) {
      await tester.pumpAndSettle();
      if (condition()) return;
      await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 50)));
    }
    fail('Condition not met within timeout');
  }

  group('Calendar', () {
    testWidgets('renders weekday headers and reflects a day containing tasks',
        (tester) async {
      final uid = (await tester.runAsync(() => seedUser()))!;
      await tester.runAsync(() => insertTask(
          userId: uid, title: 'Launch meeting', due: DateTime.now()));

      await pumpPage(tester, const CalendarPage(), userId: uid);

      // Correct Monday-first weekday headers.
      for (final label in ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']) {
        expect(find.text(label), findsOneWidget);
      }

      // The selected (highlighted) day holds today's task and lists it, and the
      // "1 task" counter confirms a day containing tasks is shown.
      expect(find.text('Launch meeting'), findsOneWidget);
      expect(find.text('1 task'), findsOneWidget);
    });
  });

  group('Task list filters', () {
    testWidgets('switching Pending/Done chips changes the visible tasks',
        (tester) async {
      final uid = (await tester.runAsync(() => seedUser()))!;
      await tester.runAsync(
          () => insertTask(userId: uid, title: 'Pending task', isDone: 0));
      await tester.runAsync(() => insertTask(
          userId: uid,
          title: 'Done task',
          isDone: 1,
          due: DateTime.now().add(const Duration(days: 1))));

      await pumpPage(tester, const TasksPage(), userId: uid);

      // All: both visible.
      expect(find.text('Pending task'), findsOneWidget);
      expect(find.text('Done task'), findsOneWidget);

      // Done only.
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();
      expect(find.text('Done task'), findsOneWidget);
      expect(find.text('Pending task'), findsNothing);

      // Pending only.
      await tester.tap(find.text('Pending'));
      await tester.pumpAndSettle();
      expect(find.text('Pending task'), findsOneWidget);
      expect(find.text('Done task'), findsNothing);
    });
  });

  group('Swipe to delete', () {
    testWidgets('shows UNDO and restores the row including its original id',
        (tester) async {
      final uid = (await tester.runAsync(() => seedUser()))!;
      final taskId = (await tester
          .runAsync(() => insertTask(userId: uid, title: 'Swipe me')))!;

      await pumpPage(tester, const TasksPage(), userId: uid);
      expect(find.text('Swipe me'), findsOneWidget);

      // Swipe left to delete. pumpAndSettle first completes the dismiss +
      // resize animations, which is what fires onDismissed; only then does the
      // async delete run, so it needs its own real-async window (runAsync)
      // afterwards before the snackbar can appear.
      await tester.fling(find.text('Swipe me'), const Offset(-500, 0), 1200);
      await tester.pumpAndSettle(); // dismiss + resize -> fires onDismissed

      // The delete itself runs asynchronously on the sqflite_ffi isolate;
      // wait for its confirmation snackbar rather than a fixed delay.
      await waitFor(tester,
          () => find.textContaining('Deleted').evaluate().isNotEmpty);

      // Let the page's own post-delete reload finish and render, so the
      // dismissed Dismissible is fully removed from the tree before UNDO puts
      // the row (same ValueKey) back.
      await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 200)));
      await tester.pumpAndSettle();

      // Deleted row left the list and an UNDO snackbar is showing.
      expect(find.text('Swipe me'), findsNothing);
      expect(find.textContaining('Deleted'), findsOneWidget);
      expect(find.text('UNDO'), findsOneWidget);
      final deleted = (await tester
          .runAsync(() => DatabaseHelper.instance.getTasksForUser(uid)))!;
      expect(deleted.where((t) => t.id == taskId), isEmpty);

      // Tapping UNDO restores the exact row, id included. The restore spans an
      // insert plus a list reload on the sqflite isolate, so wait for the row
      // to actually reappear instead of betting on a fixed delay.
      await tester.tap(find.text('UNDO'));
      await waitFor(
          tester, () => find.text('Swipe me').evaluate().isNotEmpty);
      final tasks = (await tester
          .runAsync(() => DatabaseHelper.instance.getTasksForUser(uid)))!;
      final restored = tasks.where((t) => t.id == taskId).toList();
      expect(restored, hasLength(1));
      expect(restored.first.id, taskId);
      expect(restored.first.title, 'Swipe me');

      // Let the UNDO-triggered reload finish before the next test reuses the
      // shared ffi database; otherwise its queued operations leak into the
      // next test's fresh connection and lock it.
      await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 300)));
      await tester.pumpAndSettle();
    });
  });

  // ---- App-shell regressions (real HomeScreen with all tabs alive) ----

  /// Pumps the real HomeScreen (IndexedStack keeps every tab alive) on a
  /// phone-sized surface with [userId] signed in.
  Future<void> pumpShell(WidgetTester tester, int userId) async {
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues({
      'sessionId': userId,
      'sessionEmail': 'widget.test@example.com',
    });
    AuthService.instance
        .setSessionForTesting(userId, 'widget.test@example.com');
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: const HomeScreen(),
    ));
  }

  /// Like [waitFor] but pumps fixed steps instead of settling, so a page stuck
  /// on a loading spinner cannot blow the timeout before its data arrives.
  Future<void> waitForQuiescent(
      WidgetTester tester, bool Function() condition) async {
    for (var i = 0; i < 100; i++) {
      await tester.pump(const Duration(milliseconds: 100));
      if (condition()) return;
      await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 50)));
    }
    fail('Condition not met within timeout');
  }

  Future<void> tapTab(WidgetTester tester, String label) async {
    await tester.tap(find.descendant(
      of: find.byType(NavigationBar),
      matching: find.text(label),
    ));
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  group('Shell regressions', () {
    testWidgets(
        'task created while a calendar day is selected is saved on that day',
        (tester) async {
      final uid = (await tester.runAsync(() => seedUser()))!;
      await pumpShell(tester, uid);
      await waitForQuiescent(tester,
          () => find.textContaining('Good ').evaluate().isNotEmpty);

      // Pick a day three days out in the calendar grid...
      await tapTab(tester, 'Calendar');
      final target = du.stripTime(DateTime.now().add(const Duration(days: 3)));
      await tester.tap(find.text('${target.day}'));
      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }

      // ...then open the editor from + and only enter a title. The due date
      // must default to the selected day, not today (regression: it used to
      // always save as today).
      await tester.tap(find.byType(FloatingActionButton));
      await waitForQuiescent(
          tester, () => find.text('Create task').evaluate().isNotEmpty);
      await tester.enterText(find.byType(TextFormField).first, 'Future task');
      await tester.tap(find.text('Create task'));
      await waitForQuiescent(tester,
          () => find.textContaining('Task created').evaluate().isNotEmpty);

      final tasks = (await tester
          .runAsync(() => DatabaseHelper.instance.getTasksForUser(uid)))!;
      expect(tasks, hasLength(1));
      expect(tasks.first.title, 'Future task');
      expect(tasks.first.dueDate.startsWith(du.dayKey(target)), isTrue,
          reason: 'dueDate=${tasks.first.dueDate}, '
              'expected ${du.dayKey(target)}');

      // Flush the snackbar/sqflite timers so teardown has nothing pending.
      await tester.pump(const Duration(seconds: 12));
    });

    testWidgets('picking Tomorrow inside the editor still saves tomorrow',
        (tester) async {
      final uid = (await tester.runAsync(() => seedUser()))!;
      final tomorrow =
          du.stripTime(DateTime.now().add(const Duration(days: 1)));

      await pumpPage(tester, const AddTaskScreen(), userId: uid);
      await tester.enterText(find.byType(TextFormField).first, 'Chip task');
      await tester.tap(find.text('Tomorrow'));
      await tester.tap(find.text('Create task'));
      await tester.pumpAndSettle();

      final tasks = (await tester
          .runAsync(() => DatabaseHelper.instance.getTasksForUser(uid)))!;
      expect(tasks, hasLength(1));
      expect(tasks.first.dueDate.startsWith(du.dayKey(tomorrow)), isTrue,
          reason: 'dueDate=${tasks.first.dueDate}');
    });

    testWidgets(
        'deleting a task on one tab removes it from the other live tabs too',
        (tester) async {
      final uid = (await tester.runAsync(() => seedUser()))!;
      await tester.runAsync(
          () => insertTask(userId: uid, title: 'Alpha'));
      await tester.runAsync(
          () => insertTask(userId: uid, title: 'Beta'));
      await tester.runAsync(
          () => insertTask(userId: uid, title: 'Gamma'));

      await pumpShell(tester, uid);
      await waitForQuiescent(tester, () => find.text('Alpha').evaluate().isNotEmpty);

      // Delete Alpha from the Tasks tab.
      await tapTab(tester, 'Tasks');
      await waitForQuiescent(tester, () => find.text('Alpha').evaluate().isNotEmpty);
      await tester.fling(find.text('Alpha'), const Offset(-500, 0), 1200);
      await waitForQuiescent(tester,
          () => find.textContaining('Deleted').evaluate().isNotEmpty);
      await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 300)));
      await tester.pump(const Duration(milliseconds: 100));

      // The row is really gone from the database...
      final remaining = (await tester
          .runAsync(() => DatabaseHelper.instance.getTasksForUser(uid)))!;
      expect(remaining.map((t) => t.title), unorderedEquals(['Beta', 'Gamma']));

      // ...and no other tab may keep showing the deleted row (regression:
      // stale IndexedStack tabs resurrected deleted tasks).
      await tapTab(tester, 'Home');
      await waitForQuiescent(tester, () => find.text('Alpha').evaluate().isEmpty);
      expect(find.text('Beta'), findsOneWidget);
      expect(find.text('Gamma'), findsOneWidget);

      await tapTab(tester, 'Calendar');
      await waitForQuiescent(tester, () => find.text('Alpha').evaluate().isEmpty);
      expect(find.text('Beta'), findsOneWidget);
      expect(find.text('Gamma'), findsOneWidget);

      await tester.pump(const Duration(seconds: 12));
    });

    testWidgets('UNDO after a delete restores the row on every tab',
        (tester) async {
      final uid = (await tester.runAsync(() => seedUser()))!;
      await tester.runAsync(
          () => insertTask(userId: uid, title: 'Alpha'));
      await tester.runAsync(
          () => insertTask(userId: uid, title: 'Beta'));

      await pumpShell(tester, uid);
      await waitForQuiescent(tester, () => find.text('Alpha').evaluate().isNotEmpty);

      await tapTab(tester, 'Tasks');
      await tester.fling(find.text('Alpha'), const Offset(-500, 0), 1200);
      await waitForQuiescent(tester, () => find.text('UNDO').evaluate().isNotEmpty);
      await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 200)));
      await tester.pump(const Duration(milliseconds: 100));

      await tester.tap(find.text('UNDO'));
      await waitForQuiescent(tester,
          () => find.text('Alpha').evaluate().isNotEmpty);

      final rows = (await tester
          .runAsync(() => DatabaseHelper.instance.getTasksForUser(uid)))!;
      expect(rows.map((t) => t.title), containsAll(['Alpha', 'Beta']));

      await tester.pump(const Duration(seconds: 12));
    });
  });

  // ---- Stat-tile deep links (total/pending/missed/done) ----

  Finder visible(Finder f) => f.hitTestable();

  group('Home stat tiles', () {
    testWidgets('tiles open the Tasks tab pre-filtered', (tester) async {
      final uid = (await tester.runAsync(() => seedUser()))!;
      await tester.runAsync(
          () => insertTask(userId: uid, title: 'PendingToday'));
      await tester.runAsync(
          () => insertTask(userId: uid, title: 'DoneTomorrow', isDone: 1));
      await tester.runAsync(
          () => insertTask(userId: uid, title: 'OverdueOld',
              due: DateTime.now().subtract(const Duration(days: 2))));

      await pumpShell(tester, uid);
      await waitForQuiescent(tester,
          () => visible(find.text('Total')).evaluate().isNotEmpty);

      // Total -> every task is listed.
      await tester.tap(visible(find.text('Total')));
      await waitForQuiescent(tester,
          () => visible(find.text('OverdueOld')).evaluate().isNotEmpty);
      expect(visible(find.text('PendingToday')), findsOneWidget);
      expect(visible(find.text('DoneTomorrow')), findsOneWidget);

      // Missed -> only the overdue task.
      await tapTab(tester, 'Home');
      await tester.tap(visible(find.text('Missed')));
      await waitForQuiescent(tester,
          () => visible(find.text('OverdueOld')).evaluate().isNotEmpty);
      expect(visible(find.text('PendingToday')), findsNothing);
      expect(visible(find.text('DoneTomorrow')), findsNothing);

      // Done -> only the completed task.
      await tapTab(tester, 'Home');
      await tester.tap(visible(find.text('Done')));
      await waitForQuiescent(tester,
          () => visible(find.text('DoneTomorrow')).evaluate().isNotEmpty);
      expect(visible(find.text('PendingToday')), findsNothing);
      expect(visible(find.text('OverdueOld')), findsNothing);

      // Flush sqflite timers so teardown has nothing pending.
      await tester.pump(const Duration(seconds: 12));
    });
  });

  // ---- Memories on past days + colourful calendar + profile photo ----

  group('Memories and calendar colours', () {
    testWidgets('picking a past day and + creates a memory, not a task',
        (tester) async {
      final uid = (await tester.runAsync(() => seedUser()))!;
      await pumpShell(tester, uid);
      await waitForQuiescent(tester,
          () => find.textContaining('Good ').evaluate().isNotEmpty);

      await tapTab(tester, 'Calendar');
      // Pick yesterday; if it fell into the previous month, navigate back.
      var target = du.stripTime(DateTime.now()).subtract(const Duration(days: 1));
      if (target.month != DateTime.now().month) {
        await tester.tap(find.byIcon(Icons.chevron_left_rounded));
        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(milliseconds: 100));
        }
      }
      await tester.tap(find.text('${target.day}'));
      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }

      // + on a past day must open the memory editor.
      await tester.tap(find.byType(FloatingActionButton));
      await waitForQuiescent(tester,
          () => find.text('Save memory').evaluate().isNotEmpty);

      await tester.enterText(find.byType(TextFormField).first, 'Beach day');
      await tester.enterText(find.byType(TextFormField).at(1), 'With friends');
      await tester.tap(find.text('Save memory'));
      await waitForQuiescent(tester,
          () => find.text('Memory saved').evaluate().isNotEmpty);

      final memories = (await tester.runAsync(
          () => DatabaseHelper.instance.getMemoriesForUser(uid)))!;
      expect(memories, hasLength(1));
      expect(memories.first.title, 'Beach day');
      expect(memories.first.date, du.dayKey(target));

      // The memory shows up under the selected past day.
      await waitForQuiescent(tester,
          () => visible(find.text('Beach day')).evaluate().isNotEmpty);
      // And no task row was created.
      final tasks = (await tester
          .runAsync(() => DatabaseHelper.instance.getTasksForUser(uid)))!;
      expect(tasks, isEmpty);

      await tester.pump(const Duration(seconds: 12));
    });

    testWidgets('weekday header uses the per-day tints', (tester) async {
      final uid = (await tester.runAsync(() => seedUser()))!;
      await pumpPage(tester, const CalendarPage(), userId: uid);

      Color headerColor(String label) =>
          tester.widget<Text>(find.text(label)).style!.color!;

      expect(headerColor('Mo'), AppColors.textTertiary); // Mon: default
      expect(headerColor('Th'), AppColors.thursdayBlue);
      expect(headerColor('Fr'), AppColors.fridayRed);
      expect(headerColor('Sa'), AppColors.weekendGreen);
      expect(headerColor('Su'), AppColors.weekendGreen);
    });

    testWidgets('avatar path round-trips through the users table',
        (tester) async {
      final uid = (await tester.runAsync(() => seedUser()))!;
      final user = (await tester.runAsync(() =>
          DatabaseHelper.instance
              .findUserByEmail('widget.test@example.com')))!;
      expect(user.avatarPath, isEmpty);
      final updated = User(
        id: user.id,
        name: user.name,
        email: user.email,
        password: user.password,
        avatar: user.avatar,
        createdAt: user.createdAt,
        avatarPath: '/data/avatars/me.jpg',
      );
      await tester.runAsync(
          () => DatabaseHelper.instance.updateUser(updated));
      final reread = (await tester.runAsync(() =>
          DatabaseHelper.instance
              .findUserByEmail('widget.test@example.com')))!;
      expect(reread.avatarPath, '/data/avatars/me.jpg');
      expect(reread.id, uid);
    });
  });
}

