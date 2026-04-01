import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late int _currentYear;
  late int _currentMonth;
  late int _selectedDay;

  // Sample task data keyed as 'year-month-day'
  final Map<String, List<_CalTask>> _taskData = {
    '2026-3-5': [
      _CalTask('Team meeting', '10:00 AM', const Color(0xFF4D96FF)),
      _CalTask('Code review', '2:00 PM', const Color(0xFFA855F7)),
    ],
    '2026-3-12': [
      _CalTask('Doctor appointment', '9:00 AM', const Color(0xFFFF6B6B)),
    ],
    '2026-3-18': [
      _CalTask('Project deadline', '6:00 PM', const Color(0xFFFF6B6B)),
      _CalTask('Client call', '3:00 PM', const Color(0xFFFFD93D)),
      _CalTask('Report submit', '11:00 AM', const Color(0xFF6BCB77)),
    ],
    '2026-3-22': [
      _CalTask('UI design review', '1:00 PM', const Color(0xFFFFD93D)),
    ],
    '2026-3-29': [
      _CalTask('Django API design', '5:00 PM', const Color(0xFF4D96FF)),
      _CalTask('Flutter mockup', '7:00 PM', const Color(0xFFFFD93D)),
      _CalTask('Client meeting prep', 'All day', const Color(0xFFFF6B6B)),
    ],
    '2026-3-31': [
      _CalTask('Monthly review', '10:00 AM', const Color(0xFF6BCB77)),
    ],
  };

  static const List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  static const List<String> _shortMonths = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _currentYear = now.year;
    _currentMonth = now.month - 1; // 0-indexed
    _selectedDay = now.day;
  }

  String _taskKey(int year, int month, int day) => '$year-${month + 1}-$day';

  List<_CalTask> _tasksForDay(int day) =>
      _taskData[_taskKey(_currentYear, _currentMonth, day)] ?? [];

  void _changeMonth(int dir) {
    setState(() {
      _currentMonth += dir;
      if (_currentMonth > 11) {
        _currentMonth = 0;
        _currentYear++;
      } else if (_currentMonth < 0) {
        _currentMonth = 11;
        _currentYear--;
      }
      _selectedDay = 1;
    });
  }

  int get _daysInMonth => DateTime(_currentYear, _currentMonth + 2, 0).day;

  int get _firstWeekday =>
      DateTime(_currentYear, _currentMonth + 1, 1).weekday % 7; // Sun=0

  int get _daysInPrevMonth => DateTime(_currentYear, _currentMonth + 1, 0).day;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final tasks = _tasksForDay(_selectedDay);

    return Scaffold(
      backgroundColor: const Color(0xFF0F0E17),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A2E),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF2A2840)),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Calendar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Month navigation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _navBtn(Icons.chevron_left, () => _changeMonth(-1)),
                        Text(
                          '${_monthNames[_currentMonth]} $_currentYear',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        _navBtn(Icons.chevron_right, () => _changeMonth(1)),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Weekday headers
                    Row(
                      children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                          .map(
                            (d) => Expanded(
                              child: Center(
                                child: Text(
                                  d,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF444466),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),

                    const SizedBox(height: 8),

                    // Calendar grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            mainAxisSpacing: 3,
                            crossAxisSpacing: 3,
                            childAspectRatio: 1,
                          ),
                      itemCount: _firstWeekday + _daysInMonth,
                      itemBuilder: (_, index) {
                        if (index < _firstWeekday) {
                          // Previous month days
                          final d =
                              _daysInPrevMonth - _firstWeekday + index + 1;
                          return _calDay(d, isOtherMonth: true);
                        }
                        final day = index - _firstWeekday + 1;
                        final isToday =
                            today.year == _currentYear &&
                            today.month == _currentMonth + 1 &&
                            today.day == day;
                        final isSelected = day == _selectedDay;
                        final dayTasks = _tasksForDay(day);
                        return _calDay(
                          day,
                          isToday: isToday,
                          isSelected: isSelected,
                          taskCount: dayTasks.length,
                          onTap: () => setState(() => _selectedDay = day),
                        );
                      },
                    ),

                    const SizedBox(height: 16),
                    Container(height: 1, color: const Color(0xFF1E1E2E)),
                    const SizedBox(height: 12),

                    // Selected day header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_shortMonths[_currentMonth]} $_selectedDay',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xff4d96ff22),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${tasks.length} ${tasks.length == 1 ? "task" : "tasks"}',
                            style: const TextStyle(
                              color: Color(0xFF4D96FF),
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Task list for selected day
                    if (tasks.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text(
                            'এই দিনে কোনো task নেই ✨',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.3),
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )
                    else
                      ...tasks.map((t) => _buildTaskItem(t)),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF2A2840)),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _calDay(
    int day, {
    bool isOtherMonth = false,
    bool isToday = false,
    bool isSelected = false,
    int taskCount = 0,
    VoidCallback? onTap,
  }) {
    Color textColor = const Color(0xFF666680);
    BoxDecoration decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    );

    if (isSelected) {
      decoration = BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4D96FF), Color(0xFFA855F7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      );
      textColor = Colors.white;
    } else if (isToday) {
      decoration = BoxDecoration(
        color: const Color(0xff4d96ff22),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xff4d96ff44), width: 1.5),
      );
      textColor = const Color(0xFF4D96FF);
    }

    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isOtherMonth ? 0.25 : 1.0,
        child: Container(
          decoration: decoration,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                '$day',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
              if (taskCount > 0)
                Positioned(
                  bottom: 4,
                  child: Container(
                    width: taskCount > 1 ? 6 : 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white
                          : (taskCount > 1
                                ? const Color(0xFFFF6B6B)
                                : const Color(0xFF4D96FF)),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskItem(_CalTask task) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(14),
          border: Border(left: BorderSide(color: task.color, width: 3)),
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: task.color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    task.time,
                    style: const TextStyle(
                      color: Color(0xFF666680),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.white.withOpacity(0.2),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class _CalTask {
  final String name;
  final String time;
  final Color color;
  const _CalTask(this.name, this.time, this.color);
}
