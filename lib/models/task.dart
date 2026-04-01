class Task {
  final int? id;
  final String title;
  final String description;
  final int colorValue;
  final int priority;
  final String createTime;
  final String dueDate;
  final int isDone;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.colorValue,
    required this.priority,
    required this.createTime,
    required this.dueDate,
    this.isDone = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
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
      id: map['id'],
      title: map['title'],
      description: map['description'],
      colorValue: map['colorValue'],
      priority: map['priority'],
      createTime: map['createTime'],
      dueDate: map['dueDate'],
      isDone: map['isDone'],
    );
  }
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
