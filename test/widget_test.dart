import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/core/date_utils.dart' as du;
import 'package:taskmanager/models/task.dart';
import 'package:taskmanager/services/auth_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Task model', () {
    test('round-trips through a map', () {
      final task = Task(
        id: 3,
        userId: 1,
        title: 'Buy milk',
        description: '2 liters',
        colorValue: 0xFF6366F1,
        priority: 1,
        createTime: '2026-01-01T10:00:00.000',
        dueDate: '2026-08-23T00:00:00.000',
        isDone: 0,
      );

      final map = task.toMap();
      expect(map['userId'], 1);
      expect(map['title'], 'Buy milk');

      final restored = Task.fromMap(map);
      expect(restored.id, 3);
      expect(restored.userId, 1);
      expect(restored.title, 'Buy milk');
      expect(restored.done, isFalse);
    });

    test('isOverdue only for open past-due tasks', () {
      final twoDaysAgo =
          DateTime.now().subtract(const Duration(days: 2)).toIso8601String();

      final overdue = Task(
        userId: 1,
        title: 'Old',
        description: '',
        colorValue: 1,
        priority: 1,
        createTime: '',
        dueDate: twoDaysAgo,
      );
      final donePast = overdue.copyWith(isDone: 1);

      expect(overdue.isOverdue, isTrue);
      expect(donePast.isOverdue, isFalse);
    });
  });

  group('Date utils', () {
    test('friendlyDate labels relative days', () {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      expect(du.friendlyDate(today), 'Today');
      expect(du.friendlyDate(today.add(const Duration(days: 1))), 'Tomorrow');
      expect(
          du.friendlyDate(today.subtract(const Duration(days: 1))), 'Yesterday');
    });

    test('dayKey pads month and day', () {
      expect(du.dayKey(DateTime(2026, 3, 5)), '2026-03-05');
    });
  });

  group('AuthService', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('starts with no session', () async {
      AuthService.instance.resetForTesting();
      expect(await AuthService.instance.restoreSession(), isFalse);
      expect(AuthService.instance.isLoggedIn, isFalse);
    });
  });
}
