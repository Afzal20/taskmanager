class Task {
  final int? id;
  final int userId;
  final String title;
  final String description;
  final int colorValue;
  final int priority; // 0 = low, 1 = medium, 2 = high
  final String createTime;
  final String dueDate;
  final int isDone;

  Task({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.colorValue,
    required this.priority,
    required this.createTime,
    required this.dueDate,
    this.isDone = 0,
  });

  bool get done => isDone == 1;

  DateTime get dueDateTime =>
      DateTime.tryParse(dueDate) ?? DateTime.now();

  /// True when the task is not done and its due date has passed.
  bool get isOverdue {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return !done && dueDateTime.isBefore(today);
  }

  Task copyWith({int? isDone}) {
    return Task(
      id: id,
      userId: userId,
      title: title,
      description: description,
      colorValue: colorValue,
      priority: priority,
      createTime: createTime,
      dueDate: dueDate,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'colorValue': colorValue,
      'priority': priority,
      'createTime': createTime,
      'dueDate': dueDate,
      'isDone': isDone,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      userId: (map['userId'] as int?) ?? 0,
      title: map['title'] as String,
      description: map['description'] as String,
      colorValue: map['colorValue'] as int,
      priority: map['priority'] as int,
      createTime: map['createTime'] as String,
      dueDate: map['dueDate'] as String,
      isDone: map['isDone'] as int,
    );
  }
}
