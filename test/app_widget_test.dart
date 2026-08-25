import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:taskly/calendar_screen.dart';
import 'package:taskly/helpers/database_helper.dart';
import 'package:taskly/models/task.dart';
import 'package:taskly/screens/tasks_page.dart';
import 'package:taskly/services/auth_service.dart';

/// Widget tests for the calendar, the task filter chips, and swipe-to-delete
/// with UNDO. They run the real SQLite schema on the host via
/// sqflite_common_ffi so task screens operate against genuine, isolated data.
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
        () => Future<void>.delayed(const Duration(milliseconds: 300)));
    await tester.pumpAndSettle();
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

      // Swipe left to delete.
      await tester.fling(find.text('Swipe me'), const Offset(-500, 0), 1200);
      await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 150)));
      await tester.pumpAndSettle();

      // Deleted row left the list and an UNDO snackbar is showing.
      expect(find.text('Swipe me'), findsNothing);
      expect(find.textContaining('Deleted'), findsOneWidget);
      expect(find.text('UNDO'), findsOneWidget);
      final deleted = (await tester
          .runAsync(() => DatabaseHelper.instance.getTasksForUser(uid)))!;
      expect(deleted.where((t) => t.id == taskId), isEmpty);

      // Tapping UNDO restores the exact row, id included.
      await tester.tap(find.text('UNDO'));
      await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 150)));
      await tester.pumpAndSettle();
      expect(find.text('Swipe me'), findsOneWidget);
      final tasks = (await tester
          .runAsync(() => DatabaseHelper.instance.getTasksForUser(uid)))!;
      final restored = tasks.where((t) => t.id == taskId).toList();
      expect(restored, hasLength(1));
      expect(restored.first.id, taskId);
      expect(restored.first.title, 'Swipe me');
    });
  });
}

