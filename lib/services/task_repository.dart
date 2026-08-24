import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import 'auth_service.dart';
import '../helpers/database_helper.dart';
import '../models/task.dart';

/// All task access goes through here so every query is scoped to the
/// signed-in user (authorization boundary).
class TaskRepository {
  static int get _uid => AuthService.instance.userId;

  static Future<List<Task>> fetchAll() =>
      DatabaseHelper.instance.getTasksForUser(_uid);

  static Future<List<Task>> fetchForDay(DateTime day) async {
    final key =
        '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
    return DatabaseHelper.instance.getTasksForUser(_uid, dayPrefix: key);
  }

  static Future<void> add(Task task) async {
    await DatabaseHelper.instance.insertTask(
      Task(
        userId: _uid,
        title: task.title,
        description: task.description,
        colorValue: task.colorValue,
        priority: task.priority,
        createTime: task.createTime,
        dueDate: task.dueDate,
        isDone: task.isDone,
      ),
    );
  }

  static Future<void> update(Task task) =>
      DatabaseHelper.instance.updateTask(task);

  static Future<void> setDone(Task task, bool done) async {
    final updated = task.copyWith(isDone: done ? 1 : 0);
    await DatabaseHelper.instance.toggleTaskDone(_uid, task.id!, updated.isDone);
  }

  /// Deletes the task and offers an undo snackbar. The undo re-inserts the
  /// exact row (including its original id).
  static Future<void> deleteWithUndo(
    BuildContext context,
    Task task,
    VoidCallback onChanged,
  ) async {
    await DatabaseHelper.instance.deleteTask(_uid, task.id!);
    onChanged();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted "${task.title}"'),
        backgroundColor: AppColors.surfaceHigh,
        action: SnackBarAction(
          label: 'UNDO',
          textColor: AppColors.primary,
          onPressed: () async {
            // Re-insert preserving the original id.
            await DatabaseHelper.instance.insertTask(task);
            onChanged();
          },
        ),
      ),
    );
  }
}
