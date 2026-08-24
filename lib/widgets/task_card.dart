import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../core/date_utils.dart' as du;
import '../models/task.dart';
import '../screens/add_task_screen.dart';

/// Reusable task row. Wrap in a [Dismissible] for swipe actions.
class TaskCard extends StatelessWidget {
  final Task task;
  final ValueChanged<bool> onToggleDone;
  final VoidCallback? onDeleted;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggleDone,
    this.onDeleted,
  });

  void _openEditor(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AddTaskScreen(task: task)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(task.colorValue);
    final priority = ['Low', 'Medium', 'High'][task.priority.clamp(0, 2)];
    final priorityColor =
        AppColors.priorityColors[task.priority.clamp(0, 2)];

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () => _openEditor(context),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkbox
              GestureDetector(
                onTap: () => onToggleDone(!task.done),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 22,
                  height: 22,
                  margin: const EdgeInsets.only(top: 1),
                  decoration: BoxDecoration(
                    color: task.done ? color : Colors.transparent,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: color, width: 1.8),
                  ),
                  child: task.done
                      ? const Icon(Icons.check_rounded,
                          size: 15, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                        color: task.done
                            ? AppColors.textTertiary
                            : AppColors.textPrimary,
                        decoration:
                            task.done ? TextDecoration.lineThrough : null,
                        decorationColor: AppColors.textTertiary,
                      ),
                    ),
                    if (task.description.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        task.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.4,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                    const SizedBox(height: 9),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _chip(
                          label: priority,
                          color: priorityColor,
                        ),
                        _chip(
                          icon: Icons.event_outlined,
                          label: du.friendlyDate(task.dueDateTime),
                          color: task.isOverdue
                              ? AppColors.red
                              : AppColors.textTertiary,
                        ),
                        if (task.isOverdue)
                          _chip(
                            label: 'Overdue',
                            color: AppColors.red,
                            filled: true,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              // Edit affordance
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () => _openEditor(context),
                icon: const Icon(Icons.edit_outlined,
                    size: 17, color: AppColors.textTertiary),
                splashRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip({
    String? label,
    IconData? icon,
    required Color color,
    bool filled = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: filled ? color.withValues(alpha: 0.16) : color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 11.5, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label ?? '',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
