import 'package:flutter/material.dart';

import 'calendar_screen.dart';
import 'core/app_theme.dart';
import 'core/date_utils.dart' as du;
import 'screens/add_task_screen.dart';
import 'screens/home_page.dart';
import 'screens/memory_editor_screen.dart';
import 'screens/profile_page.dart';
import 'screens/tasks_page.dart';
import 'services/reminder_service.dart';

/// App shell: hosts the four tabs and the floating add button.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

  final _homeKey = GlobalKey<HomePageState>();
  final _calendarKey = GlobalKey<CalendarPageState>();
  final _tasksKey = GlobalKey<TasksPageState>();
  final _profileKey = GlobalKey<ProfilePageState>();

  @override
  void initState() {
    super.initState();
    // Ask once per app run (Android 13+) so reminders can be posted.
    ReminderService.requestPermission();
    // Pick up reminders for tasks that changed while the app was closed.
    ReminderService.syncSoon();
  }

  Future<void> _openAddTask() async {
    final today = du.stripTime(DateTime.now());
    // When adding from the calendar, respect the day the user picked. Past
    // days accept memories only — tasks must be for today or later.
    var initialDate = _tab == 1 ? _calendarKey.currentState?.selectedDay : null;
    initialDate ??= today;
    final isPastDay = initialDate.isBefore(today);

    final saved = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => isPastDay
            ? MemoryEditorScreen(date: initialDate!)
            : AddTaskScreen(initialDate: initialDate),
      ),
    );
    // Refresh whichever tabs show tasks (or memories).
    _homeKey.currentState?.reload();
    _calendarKey.currentState?.reload();
    _tasksKey.currentState?.reload();
    if (saved != true || !mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: AppColors.green, size: 18),
            const SizedBox(width: 8),
            Text(isPastDay ? 'Memory saved' : 'Task created'),
          ],
        ),
        backgroundColor: AppColors.surfaceHigh,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tab,
        children: [
          HomePage(
            key: _homeKey,
            onOpenProfile: () => setState(() => _tab = 3),
            onOpenTasks: () => setState(() => _tab = 2),
            onOpenTasksWithFilter: (filter) {
              _tasksKey.currentState?.setFilter(filter);
              setState(() => _tab = 2);
            },
          ),
          CalendarPage(key: _calendarKey),
          TasksPage(key: _tasksKey),
          ProfilePage(key: _profileKey),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTask,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
        child: const Icon(Icons.add_rounded, size: 28),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          height: 68,
          backgroundColor: AppColors.surface,
          indicatorColor: AppColors.primary.withValues(alpha: 0.16),
          surfaceTintColor: Colors.transparent,
          labelTextStyle: WidgetStateProperty.all(const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary)),
        ),
        child: NavigationBar(
          selectedIndex: _tab,
          onDestinationSelected: (i) => setState(() => _tab = i),
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon:
                  Icon(Icons.home_rounded, color: AppColors.primary),
              label: 'Home',
            ),
            const NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined),
              selectedIcon: Icon(Icons.calendar_month_rounded,
                  color: AppColors.primary),
              label: 'Calendar',
            ),
            const NavigationDestination(
              icon: Icon(Icons.checklist_outlined),
              selectedIcon:
                  Icon(Icons.checklist_rounded, color: AppColors.primary),
              label: 'Tasks',
            ),
            const NavigationDestination(
              icon: Icon(Icons.person_outline_rounded),
              selectedIcon:
                  Icon(Icons.person_rounded, color: AppColors.primary),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
