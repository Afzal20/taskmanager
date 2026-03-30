import 'package:flutter/material.dart';

enum TaskCategory {
  work('WORK', const Color(0xFF3B82F6)),
  design('DESIGN', const Color(0xFFEAB308)),
  personal('PERSONAL', const Color(0xFF10B981)),
  urgent('URGENT', const Color(0xFFEF4444));

  const TaskCategory(this.label, this.color);
  final String label;
  final Color color;
}

class Task {
  final String id;
  final String title;
  final String description;
  final TaskCategory category;
  final double progress;
  final String time;
  final bool hasAiBadge;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.progress,
    required this.time,
    this.hasAiBadge = false,
  });
}

class TaskStats {
  final int total;
  final int today;
  final int done;

  TaskStats({
    required this.total,
    required this.today,
    required this.done,
  });
}
