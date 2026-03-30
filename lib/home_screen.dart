import 'package:flutter/material.dart';
import 'models/task.dart';
import 'add_task_screen.dart';
import 'calendar_screen.dart';
import 'package:battery_plus/battery_plus.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeNav = 0;

  // Battery
  final Battery _battery = Battery();
  int _batteryLevel = 100;
  bool _isCharging = false;
  late StreamSubscription<BatteryState> _batterySubscription;

  @override
  void initState() {
    super.initState();
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

  @override
  void dispose() {
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
                  const Text(
                    '9:41',
                    style: TextStyle(
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
        const Text(
          'তোমার ৫টা task আজকে শেষ করতে হবে',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildTaskStatsCards() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('Total', '8', const Color(0xFFEF4444))),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard('Today', '3', const Color(0xFFEAB308))),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard('Done', '5', const Color(0xFF10B981))),
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
    final tasks = [
      Task(
        id: '1',
        title: 'Django project API design করা',
        description: 'Authentication endpoints + OTP flow',
        category: TaskCategory.work,
        progress: 0.7,
        time: 'আজ ৫:০০ PM',
        hasAiBadge: true,
      ),
      Task(
        id: '2',
        title: 'Figma design করা',
        description: 'Mobile app design for client',
        category: TaskCategory.design,
        progress: 0.3,
        time: 'আজ ৬:০০ PM',
      ),
      Task(
        id: '3',
        title: 'Gym যাওয়া',
        description: 'Chest + Triceps workout',
        category: TaskCategory.personal,
        progress: 0.0,
        time: 'আজ ৭:০০ PM',
      ),
      Task(
        id: '4',
        title: 'Client meeting',
        description: 'Project discussion and feedback',
        category: TaskCategory.urgent,
        progress: 0.5,
        time: 'আজ ৮:০০ PM',
      ),
    ];

    return Column(children: tasks.map((task) => _buildTaskCard(task)).toList());
  }

  Widget _buildTaskCard(Task task) {
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
                  color: task.category.color,
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
                    const SizedBox(height: 4),
                    Text(
                      task.description,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              if (task.hasAiBadge)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'AI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 12),

          // Progress Bar
          LinearProgressIndicator(
            value: task.progress,
            backgroundColor: const Color(0xFF1E1E2C),
            valueColor: AlwaysStoppedAnimation<Color>(task.category.color),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: task.category.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  task.category.label,
                  style: TextStyle(
                    color: task.category.color,
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
                    task.time,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: task.category.color,
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
              child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
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
                  .push(MaterialPageRoute(builder: (_) => const CalendarScreen()))
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
