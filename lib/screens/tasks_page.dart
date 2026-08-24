import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../models/task.dart';
import '../services/task_repository.dart';
import '../widgets/common.dart';
import '../widgets/task_card.dart';

enum _Filter { all, pending, done, overdue }

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => TasksPageState();
}

class TasksPageState extends State<TasksPage>
    with AutomaticKeepAliveClientMixin {
  List<Task> _tasks = [];
  bool _loading = true;
  _Filter _filter = _Filter.all;
  String _query = '';

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    reload();
  }

  Future<void> reload() async {
    final tasks = await TaskRepository.fetchAll();
    if (!mounted) return;
    setState(() {
      _tasks = tasks;
      _loading = false;
    });
  }

  List<Task> get _filtered {
    Iterable<Task> result = _tasks;
    switch (_filter) {
      case _Filter.pending:
        result = result.where((t) => !t.done);
        break;
      case _Filter.done:
        result = result.where((t) => t.done);
        break;
      case _Filter.overdue:
        result = result.where((t) => t.isOverdue);
        break;
      case _Filter.all:
        break;
    }
    final q = _query.trim().toLowerCase();
    if (q.isNotEmpty) {
      result = result.where(
          (t) => t.title.toLowerCase().contains(q) ||
              t.description.toLowerCase().contains(q));
    }
    return result.toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final tasks = _filtered;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).padding.top + 12, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('My tasks',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 14),
              TextField(
                onChanged: (v) => setState(() => _query = v),
                style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: 'Search tasks…',
                  prefixIcon: const Icon(Icons.search_rounded,
                      color: AppColors.textTertiary, size: 20),
                  isDense: true,
                ),
              ),
              const SizedBox(height: 12),
              // Filter chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _filterChip(_Filter.all, 'All'),
                  _filterChip(_Filter.pending, 'Pending'),
                  _filterChip(_Filter.done, 'Done'),
                  _filterChip(_Filter.overdue, 'Overdue'),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: _loading
              ? const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primary))
              : RefreshIndicator(
                  color: AppColors.primary,
                  backgroundColor: AppColors.surfaceHigh,
                  onRefresh: reload,
                  child: tasks.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: EmptyState(
                                icon: _query.isEmpty
                                    ? Icons.folder_open_outlined
                                    : Icons.search_off_rounded,
                                title: _query.isEmpty
                                    ? 'No tasks here'
                                    : 'No results',
                                message: _query.isEmpty
                                    ? 'Create a task with the + button below.'
                                    : 'Try a different search term or filter.',
                              ),
                            ),
                          ],
                        )
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(20, 16, 20, 96),
                          itemCount: tasks.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 10),
                          itemBuilder: (_, i) => Dismissible(
                            key: ValueKey('all-${tasks[i].id}'),
                            direction: DismissDirection.endToStart,
                            background: const SwipeDeleteBackground(),
                            onDismissed: (_) => TaskRepository.deleteWithUndo(
                                context, tasks[i], reload),
                            child: TaskCard(
                              task: tasks[i],
                              onToggleDone: (v) async {
                                await TaskRepository.setDone(tasks[i], v);
                                reload();
                              },
                            ),
                          ),
                        ),
                ),
        ),
      ],
    );
  }

  Widget _filterChip(_Filter value, String label) {
    final selected = _filter == value;
    return GestureDetector(
      onTap: () => setState(() => _filter = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.16)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
