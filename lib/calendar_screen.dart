import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../core/date_utils.dart' as du;
import '../models/task.dart';
import '../services/task_repository.dart';
import '../widgets/common.dart';
import '../widgets/task_card.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage>
    with AutomaticKeepAliveClientMixin {
  late DateTime _visibleMonth; // first day of month
  DateTime _selectedDay = du.stripTime(DateTime.now());
  Map<DateTime, List<Task>> _byDay = {};
  bool _loading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _visibleMonth = DateTime(now.year, now.month, 1);
    reload();
  }

  Future<void> reload() async {
    final tasks = await TaskRepository.fetchAll();
    if (!mounted) return;
    final map = <DateTime, List<Task>>{};
    for (final t in tasks) {
      final key = du.stripTime(t.dueDateTime);
      map.putIfAbsent(key, () => []).add(t);
    }
    setState(() {
      _byDay = map;
      _loading = false;
    });
  }

  List<Task> get _selectedTasks =>
      (_byDay[du.stripTime(_selectedDay)] ?? [])
          ..sort((a, b) => a.isDone == b.isDone
              ? a.dueDateTime.compareTo(b.dueDateTime)
              : a.isDone == 1
                  ? 1
                  : -1);

  void _changeMonth(int dir) {
    setState(() => _visibleMonth = DateTime(
        _visibleMonth.year, _visibleMonth.month + dir, 1));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final now = DateTime.now();
    final today = du.stripTime(now);
    final daysInMonth =
        DateTime(_visibleMonth.year, _visibleMonth.month + 1, 0).day;
    // Monday-first week (weekday: Mon=1..Sun=7)
    final leadingBlanks = DateTime(_visibleMonth.year, _visibleMonth.month, 1)
            .weekday -
        1;

    final monthTasksCount = _byDay.entries
        .where((e) =>
            e.key.year == _visibleMonth.year &&
            e.key.month == _visibleMonth.month)
        .fold<int>(0, (sum, e) => sum + e.value.length);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).padding.top + 12, 20, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Calendar',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800)),
                        const SizedBox(height: 2),
                        Text(
                          '$monthTasksCount ${monthTasksCount == 1 ? 'task' : 'tasks'} this month',
                          style: const TextStyle(
                              fontSize: 13, color: AppColors.textTertiary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Month navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => _changeMonth(-1),
                    icon: const Icon(Icons.chevron_left_rounded,
                        color: AppColors.textSecondary),
                    splashRadius: 20,
                  ),
                  Text(
                    _monthTitle(_visibleMonth),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary),
                  ),
                  IconButton(
                    onPressed: () => _changeMonth(1),
                    icon: const Icon(Icons.chevron_right_rounded,
                        color: AppColors.textSecondary),
                    splashRadius: 20,
                  ),
                ],
              ),
            ],
          ),
        ),

        // Weekday header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']
                .map((d) => Expanded(
                      child: Center(
                        child: Text(
                          d,
                          style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textTertiary),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 6),

        // Day grid
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: leadingBlanks + daysInMonth,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 0.92,
            ),
            itemBuilder: (_, index) {
              if (index < leadingBlanks) return const SizedBox.shrink();
              final day = index - leadingBlanks + 1;
              final date = DateTime(
                  _visibleMonth.year, _visibleMonth.month, day);
              final isToday = du.isSameDay(date, today);
              final isSelected = du.isSameDay(date, _selectedDay);
              final count = _byDay[date]?.length ?? 0;
              final hasOverduePending =
                  (_byDay[date] ?? []).any((t) => !t.done && date.isBefore(today));
              return _dayCell(
                date,
                isToday: isToday,
                isSelected: isSelected,
                taskCount: count,
                urgent: hasOverduePending,
                onTap: () => setState(() => _selectedDay = date),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        // Selected-day list
        Expanded(
          child: _loading
              ? const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primary))
              : RefreshIndicator(
                  color: AppColors.primary,
                  backgroundColor: AppColors.surfaceHigh,
                  onRefresh: reload,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 96),
                    children: [
                      Row(
                        children: [
                          Text(
                            du.fullDate(_selectedDay),
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary),
                          ),
                          const Spacer(),
                          Text(
                            '${_selectedTasks.length} ${_selectedTasks.length == 1 ? 'task' : 'tasks'}',
                            style: const TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textTertiary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (_selectedTasks.isEmpty)
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.28,
                          child: const EmptyState(
                            icon: Icons.event_available_outlined,
                            title: 'Nothing scheduled',
                            message: 'No tasks for this day.',
                          ),
                        )
                      else
                        ..._selectedTasks.map((task) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Dismissible(
                                key: ValueKey('cal-${task.id}'),
                                direction: DismissDirection.endToStart,
                                background:
                                    const SwipeDeleteBackground(),
                                onDismissed: (_) =>
                                    TaskRepository.deleteWithUndo(
                                        context, task, reload),
                                child: TaskCard(
                                  task: task,
                                  onToggleDone: (v) async {
                                    await TaskRepository.setDone(task, v);
                                    reload();
                                  },
                                ),
                              ),
                            )),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  String _monthTitle(DateTime m) {
    const names = [
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
      'December'
    ];
    return '${names[m.month - 1]} ${m.year}';
  }

  Widget _dayCell(
    DateTime date, {
    required bool isToday,
    required bool isSelected,
    required int taskCount,
    required bool urgent,
    required VoidCallback onTap,
  }) {
    Color bg = Colors.transparent;
    Border? border;

    if (isSelected) {
      bg = AppColors.primary;
    } else if (isToday) {
      bg = AppColors.primary.withValues(alpha: 0.12);
      border = Border.all(color: AppColors.primary.withValues(alpha: 0.55));
    } else if (taskCount > 0) {
      bg = AppColors.surfaceHigh;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          border: border,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${date.day}',
              style: TextStyle(
                fontSize: 13,
                fontWeight:
                    isSelected || isToday ? FontWeight.w800 : FontWeight.w600,
                color: isSelected
                    ? Colors.white
                    : isToday
                        ? AppColors.primary
                        : taskCount > 0
                            ? AppColors.textPrimary
                            : AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: 3),
            if (taskCount > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < taskCount.clamp(1, 3); i++)
                    Container(
                      width: 4,
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? Colors.white
                            : urgent
                                ? AppColors.red
                                : AppColors.primary,
                      ),
                    ),
                ],
              )
            else
              const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
