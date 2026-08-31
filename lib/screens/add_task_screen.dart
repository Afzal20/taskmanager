import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../models/task.dart';
import '../services/auth_service.dart';
import '../services/task_repository.dart';
import '../widgets/common.dart';
import '../core/date_utils.dart' as du;

class AddTaskScreen extends StatefulWidget {
  final Task? task;

  /// Day the form starts from when creating a new task (e.g. the day currently
  /// selected in the calendar). Ignored when editing an existing task.
  final DateTime? initialDate;

  const AddTaskScreen({super.key, this.task, this.initialDate});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descController;

  late int _selectedPriority; // 0 low, 1 medium, 2 high
  late int _selectedColor;
  DateTime _selectedDate = du.stripTime(DateTime.now());

  bool get _isEditing => widget.task != null;

  @override
  void initState() {
    super.initState();
    final t = widget.task;
    _titleController = TextEditingController(text: t?.title ?? '');
    _descController = TextEditingController(text: t?.description ?? '');
    _selectedPriority = t?.priority ?? 1;
    _selectedColor = t == null
        ? 0
        : AppColors.taskColors.indexWhere((c) => c.toARGB32() == t.colorValue);
    if (_selectedColor == -1) _selectedColor = 0;
    if (t != null) {
      _selectedDate = du.stripTime(t.dueDateTime);
    } else if (widget.initialDate != null) {
      _selectedDate = du.stripTime(widget.initialDate!);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = du.stripTime(DateTime.now());
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      // New tasks must be due today or later; editing an existing task keeps
      // its original (possibly past) date selectable.
      firstDate: _isEditing ? now.subtract(const Duration(days: 365)) : now,
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.dark(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => _selectedDate = du.stripTime(picked));
    }
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please give the task a title.'),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }

    final userId = AuthService.instance.userId;

    // Tasks can never be scheduled in the past — use memories for that.
    final today = du.stripTime(DateTime.now());
    if (!_isEditing && _selectedDate.isBefore(today)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tasks can\'t be added to past days. '
              'Use a memory instead.'),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }

    final task = Task(
      id: widget.task?.id,
      userId: userId,
      title: title,
      description: _descController.text.trim(),
      colorValue: AppColors.taskColors[_selectedColor].toARGB32(),
      priority: _selectedPriority,
      createTime:
          widget.task?.createTime ?? DateTime.now().toIso8601String(),
      dueDate: _selectedDate.toIso8601String(),
      isDone: widget.task?.isDone ?? 0,
    );

    if (_isEditing) {
      await TaskRepository.update(task);
    } else {
      await TaskRepository.add(task);
    }

    if (!mounted) return;
    Navigator.of(context).pop(_isEditing ? null : true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        title: Text(
          _isEditing ? 'Edit task' : 'New task',
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              AppTextField(
                controller: _titleController,
                label: 'Title',
                hint: 'What needs to be done?',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 18),
              AppTextField(
                controller: _descController,
                label: 'Notes (optional)',
                hint: 'Add more details…',
                maxLines: 4,
              ),
              const SizedBox(height: 20),

              // Priority
              const _FieldLabel('PRIORITY'),
              const SizedBox(height: 10),
              Row(
                children: List.generate(3, (i) {
                  final selected = _selectedPriority == i;
                  final color = AppColors.priorityColors[i];
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedPriority = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        margin:
                            EdgeInsets.only(right: i < 2 ? 8 : 0),
                        padding: const EdgeInsets.symmetric(vertical: 11),
                        decoration: BoxDecoration(
                          color: selected
                              ? color.withValues(alpha: 0.14)
                              : AppColors.surfaceHigh,
                          borderRadius: BorderRadius.circular(11),
                          border: Border.all(
                            color: selected ? color : AppColors.border,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 7,
                              height: 7,
                              decoration:
                                  BoxDecoration(color: color, shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              const ['Low', 'Medium', 'High'][i],
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: selected
                                    ? Colors.white
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              // Color
              const _FieldLabel('COLOR'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children:
                    List.generate(AppColors.taskColors.length, (i) {
                  final color = AppColors.taskColors[i];
                  final selected = _selectedColor == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedColor = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                          color: selected
                              ? Colors.white
                              : Colors.transparent,
                          width: 2.5,
                        ),
                      ),
                      child: selected
                          ? const Icon(Icons.check_rounded,
                              size: 16, color: Colors.white)
                          : null,
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              // Due date
              const _FieldLabel('DUE DATE'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      color: AppColors.surfaceHigh,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: _pickDate,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_month_outlined,
                                  size: 18, color: AppColors.primary),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  du.friendlyDate(_selectedDate),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Quick picks
              Wrap(
                spacing: 8,
                children: [
                  for (final offset in [0, 1, 2, 7])
                    _quickChip(offset),
                ],
              ),

              const SizedBox(height: 32),
              PrimaryButton(
                label: _isEditing ? 'Save changes' : 'Create task',
                icon: Icons.check_rounded,
                onPressed: _save,
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickChip(int offsetDays) {
    final date =
        du.stripTime(DateTime.now().add(Duration(days: offsetDays)));
    final selected = du.isSameDay(date, _selectedDate);
    final label = switch (offsetDays) {
      0 => 'Today',
      1 => 'Tomorrow',
      2 => 'In 2 days',
      7 => 'In 1 week',
      _ => '',
    };
    return GestureDetector(
      onTap: () => setState(() => _selectedDate = date),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.16)
              : AppColors.surfaceHigh,
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

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.1,
        color: AppColors.textTertiary,
      ),
    );
  }
}
