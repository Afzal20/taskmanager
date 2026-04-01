import 'package:flutter/material.dart';
import 'models/task.dart';
import 'add_task_screen.dart';
import 'calendar_screen.dart';
import 'package:battery_plus/battery_plus.dart';
import 'dart:async';
import 'helpers/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeNav = 0;
  List<Task> _tasks = [];
  bool _isLoading = true;

  // Live clock
  late String _currentTime;
  late Timer _clockTimer;

  String _formatTime(DateTime t) {
    final hour = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final minute = t.minute.toString().padLeft(2, '0');
    final period = t.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  // Battery
  final Battery _battery = Battery();
  int _batteryLevel = 100;
  bool _isCharging = false;
  late StreamSubscription<BatteryState> _batterySubscription;

  @override
  void initState() {
    super.initState();
    _loadTasks();
    // Live clock — update every second
    _currentTime = _formatTime(DateTime.now());
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _currentTime = _formatTime(DateTime.now()));
    });
    // Get initial battery level
    _battery.batteryLevel.then((level) {
      if (mounted) setState(() => _batteryLevel = level);
    });
    // Listen for charging state changes
    _batterySubscription = _battery.onBatteryStateChanged.listen((state) {
      if (mounted) {
        setState(() => _isCharging = state == BatteryState.charging);
        // Refresh level whenever state changes
        _battery.batteryLevel.then((level) {
          if (mounted) setState(() => _batteryLevel = level);
        });
      }
    });
  }

  Future<void> _loadTasks() async {
    final tasks = await DatabaseHelper.instance.getTasks();
    if (mounted) {
      setState(() {
        _tasks = tasks;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    _batterySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _currentTime,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(Icons.more_horiz, color: Colors.white, size: 24),
                      SizedBox(width: 8),
                      Icon(Icons.more_horiz, color: Colors.white, size: 24),
                      SizedBox(width: 8),
                      Icon(Icons.more_horiz, color: Colors.white, size: 24),
                    ],
                  ),
                  Row(
                    children: [
                      if (_isCharging)
                        const Icon(
                          Icons.bolt,
                          color: Color(0xFFFFD93D),
                          size: 16,
                        ),
                      Text(
                        '$_batteryLevel%',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Greeting Section
                    _buildGreetingSection(),

                    const SizedBox(height: 24),

                    // Task Stats Cards
                    _buildTaskStatsCards(),

                    const SizedBox(height: 32),

                    // Today's Tasks Header
                    _buildTodayTasksHeader(),

                    const SizedBox(height: 16),

                    // Task List
                    _buildTaskList(),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildGreetingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            text: 'Good morning, ',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            children: [
              TextSpan(
                text: 'Afzal!',
                style: TextStyle(color: Color(0xFF3B82F6)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'তোমার ${_tasks.length}টা task আজকে শেষ করতে হবে',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildTaskStatsCards() {
    final total = _tasks.length;
    final done = _tasks.where((t) => t.isDone == 1).length;
    final todayStr = DateTime.now().toIso8601String().split('T')[0];
    final todayCount = _tasks.where((t) => t.dueDate.startsWith(todayStr)).length;

    return Row(
      children: [
        Expanded(child: _buildStatCard('Total', '$total', const Color(0xFFEF4444))),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard('Today', '$todayCount', const Color(0xFFEAB308))),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard('Done', '$done', const Color(0xFF10B981))),
      ],
    );
  }

  Widget _buildStatCard(String label, String count, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            count,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayTasksHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Today's tasks",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'See all ->',
            style: TextStyle(color: Color(0xFF3B82F6), fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_tasks.isEmpty) {
      return const Center(
        child: Text(
          'No tasks yet! Add one above.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
    return Column(children: _tasks.map((task) => _buildTaskCard(task)).toList());
  }

  Widget _buildTaskCard(Task task) {
    final taskColor = Color(task.colorValue);
    final priorityLabels = ['Low', 'Medium', 'High'];
    final priorityLabel = priorityLabels[task.priority];
    final dateStr = task.dueDate.split('T').first;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: taskColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    if (task.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        task.description,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: taskColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  priorityLabel,
                  style: TextStyle(
                    color: taskColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.grey, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    dateStr,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: taskColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Color(0xFF2A2A3E),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Home
          _buildNavItem(
            Icons.home_rounded,
            'Home',
            _activeNav == 0,
            () => setState(() => _activeNav = 0),
          ),
          // Add Task (centre)
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AddTaskScreen(
                    onTaskAdded: () {
                      _loadTasks();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Task added! 🎉'),
                          backgroundColor: const Color(0xFF6BCB77),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withOpacity(0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          // Calendar
          _buildNavItem(
            Icons.calendar_today_rounded,
            'Calendar',
            _activeNav == 2,
            () {
              setState(() => _activeNav = 2);
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(builder: (_) => const CalendarScreen()),
                  )
                  .then((_) => setState(() => _activeNav = 0));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isActive,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF3B82F6) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : Colors.grey,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
