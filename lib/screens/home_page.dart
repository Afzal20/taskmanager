import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../core/date_utils.dart' as du;
import '../models/task.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/task_repository.dart';
import '../widgets/common.dart';
import '../widgets/task_card.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onOpenProfile;
  final VoidCallback onOpenTasks;

  const HomePage({
    super.key,
    required this.onOpenProfile,
    required this.onOpenTasks,
  });

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  List<Task> _tasks = [];
  User? _user;
  bool _loading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    reload();
  }

  Future<void> reload() async {
    final tasks = await TaskRepository.fetchAll();
    final user = await AuthService.instance.currentUser();
    if (!mounted) return;
    setState(() {
      _tasks = tasks;
      _user = user;
      _loading = false;
    });
  }

  List<Task> get _todayTasks {
    final today = DateTime.now();
    return _tasks.where((t) {
      if (t.done) return false;
      final due = t.dueDateTime;
      // Today's open tasks plus anything overdue.
      return du.isSameDay(due, today) || due.isBefore(today);
    }).toList()
      ..sort((a, b) => a.dueDateTime.compareTo(b.dueDateTime));
  }

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final width = MediaQuery.of(context).size.width;
    final compact = width < 360;

    final total = _tasks.length;
    final done = _tasks.where((t) => t.done).length;
    final pending = total - done;
    final progress = total == 0 ? 0.0 : done / total;

    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.surfaceHigh,
      onRefresh: reload,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
            20, MediaQuery.of(context).padding.top + 8, 20, 96),
        children: [
          // Header: greeting + avatar
          Row(
            children: [
              GestureDetector(
                onTap: widget.onOpenProfile,
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceHigh,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child:
                      Center(child: Text(_user?.avatar ?? '🙂', style: const TextStyle(fontSize: 22))),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$_greeting,',
                      style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textTertiary,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      _user?.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Progress card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        progress == 1 && total > 0
                            ? 'All caught up! 🎉'
                            : "You're making progress",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                    Text(
                      '$done/$total',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 7,
                    backgroundColor: Colors.white.withValues(alpha: 0.25),
                    valueColor:
                        const AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '$done of $total tasks completed',
                  style: const TextStyle(
                      fontSize: 12.5, color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Stat tiles
          Row(
            children: [
              Expanded(
                  child: _StatTile(
                      label: 'Total',
                      value: total,
                      icon: Icons.checklist_rounded,
                      color: AppColors.primary,
                      compact: compact)),
              const SizedBox(width: 10),
              Expanded(
                  child: _StatTile(
                      label: 'Pending',
                      value: pending,
                      icon: Icons.pending_outlined,
                      color: AppColors.amber,
                      compact: compact)),
              const SizedBox(width: 10),
              Expanded(
                  child: _StatTile(
                      label: 'Done',
                      value: done,
                      icon: Icons.task_alt_rounded,
                      color: AppColors.green,
                      compact: compact)),
            ],
          ),

          const SizedBox(height: 26),

          // Today's section
          Row(
            children: [
              const Text(
                "Today's focus",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary),
              ),
              const Spacer(),
              Text(
                '${_todayTasks.length} ${_todayTasks.length == 1 ? 'task' : 'tasks'}',
                style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textTertiary),
              ),
            ],
          ),
          const SizedBox(height: 12),

          if (_loading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 60),
              child: Center(
                  child: CircularProgressIndicator(color: AppColors.primary)),
            )
          else if (_todayTasks.isEmpty)
            EmptyState(
              icon: Icons.emoji_events_outlined,
              title: total == 0 ? 'No tasks yet' : 'Nothing left for today',
              message: total == 0
                  ? 'Tap the + button below to create your first task.'
                  : 'Enjoy your day, or plan ahead from the Tasks tab.',
            )
          else
            ..._todayTasks.map((task) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Dismissible(
                    key: ValueKey('home-${task.id}'),
                    direction: DismissDirection.endToStart,
                    background: const SwipeDeleteBackground(),
                    onDismissed: (_) => TaskRepository.deleteWithUndo(
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
          if (_tasks.any((t) => !t.done) && _todayTasks.isNotEmpty) ...[
            const SizedBox(height: 4),
            TextButton.icon(
              onPressed: widget.onOpenTasks,
              style: TextButton.styleFrom(foregroundColor: AppColors.primary),
              icon: const Icon(Icons.arrow_forward_rounded, size: 16),
              label: const Text('See all tasks'),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;
  final Color color;
  final bool compact;

  const _StatTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: compact ? 12 : 14, horizontal: compact ? 8 : 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, size: compact ? 18 : 21, color: color),
          const SizedBox(height: 7),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '$value',
              style: TextStyle(
                fontSize: compact ? 19 : 22,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            style: TextStyle(
              fontSize: compact ? 11 : 12,
              color: AppColors.textTertiary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
