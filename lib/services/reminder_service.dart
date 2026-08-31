import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../core/date_utils.dart' as du;
import '../helpers/database_helper.dart';
import 'auth_service.dart';
import 'task_changes.dart';

/// Local due-date reminders (no push server involved).
///
/// Every pending task gets a device-local notification at 09:00 on its due
/// date. The schedule is re-synced whenever tasks change and after reboot
/// (boot receiver declared in AndroidManifest.xml).
class ReminderService {
  ReminderService._();

  static final _plugin = FlutterLocalNotificationsPlugin();
  static StreamSubscription<void>? _changesSub;
  static Timer? _debounce;
  static tz.Location? _location;
  static bool _initialized = false;

  static const _channelId = 'task_reminders';
  static const _channelName = 'Task reminders';

  /// Hour of day (local) a task reminder fires on its due date.
  static const _reminderHour = 9;
  static const _reminderMinute = 0;

  static Future<void> init() async {
    if (_initialized || kIsWeb || !Platform.isAndroid) return;
    try {
      tzdata.initializeTimeZones();
      try {
        final info = await FlutterTimezone.getLocalTimezone();
        _location = tz.getLocation(info.identifier);
      } catch (_) {
        // Fall back to UTC rather than failing to notify at all.
        _location = tz.getLocation('UTC');
      }

      await _plugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        ),
      );

      // Re-sync the whole schedule whenever any task changes.
      _changesSub = TaskChanges.instance.listen(syncSoon);
      syncSoon();
      _initialized = true;
    } catch (_) {
      // Notifications are best-effort; never crash the app over them.
    }
  }

  /// Releases the change listener (used by tests).
  @visibleForTesting
  static void disposeForTesting() {
    _changesSub?.cancel();
    _changesSub = null;
    _debounce?.cancel();
    _initialized = false;
  }

  /// Runtime permission for posting notifications (required on Android 13+).
  static Future<void> requestPermission() async {
    if (!_initialized) return;
    try {
      final android = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      await android?.requestNotificationsPermission();
    } catch (_) {
      // Ignore — user simply won't see reminders until they grant it.
    }
  }

  /// Debounced so bursts of changes (create + undo + reload) reschedule once.
  static void syncSoon() {
    if (!_initialized) return;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () {
      unawaited(_sync());
    });
  }

  /// Cancels all pending reminders and re-schedules one per pending future
  /// task at 09:00 local time on its due date.
  static Future<void> _sync() async {
    try {
      int uid;
      try {
        uid = AuthService.instance.userId;
      } catch (_) {
        return; // Not signed in yet.
      }
      final tasks = await DatabaseHelper.instance.getTasksForUser(uid);
      await _plugin.cancelAll();
      final now = DateTime.now();
      for (final task in tasks) {
        if (task.done || task.id == null) continue;
        final dueDay = du.stripTime(task.dueDateTime);
        final fireAt = DateTime(dueDay.year, dueDay.month, dueDay.day,
            _reminderHour, _reminderMinute);
        if (!fireAt.isAfter(now.add(const Duration(minutes: 5)))) continue;
        await _plugin.zonedSchedule(
          task.id!,
          'Task due today: ${task.title}',
          du.friendlyDate(dueDay),
          tz.TZDateTime.from(fireAt, _location!),
          const NotificationDetails(
            android: AndroidNotificationDetails(
              _channelId,
              _channelName,
              channelDescription: 'Reminders on the morning a task is due',
              importance: Importance.high,
              priority: Priority.high,
              category: AndroidNotificationCategory.reminder,
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        );
      }
    } catch (_) {
      // Best-effort only.
    }
  }
}
