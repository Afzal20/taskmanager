import 'package:flutter/material.dart';

import 'calendar_screen.dart';
import 'core/app_theme.dart';
import 'screens/add_task_screen.dart';
import 'screens/home_page.dart';
import 'screens/profile_page.dart';
import 'screens/tasks_page.dart';

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

  Future<void> _openAddTask() async {
    final created = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const AddTaskScreen()),
    );
    // Refresh whichever tabs show tasks.
    _homeKey.currentState?.reload();
    _calendarKey.currentState?.reload();
    _tasksKey.currentState?.reload();
    if (created != true || !mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check_circle_rounded, color: AppColors.green, size: 18),
            SizedBox(width: 8),
            Text('Task created'),
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
