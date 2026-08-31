/// A diary-style entry the user attaches to a past calendar day ("memories").
/// Unlike tasks, memories are allowed on previous days and have no done state.
class Memory {
  final int? id;
  final int userId;
  final String title;
  final String description;
  final String date; // ISO day prefix, e.g. "2026-08-24"

  Memory({
    this.id,
    required this.userId,
    required this.title,
    this.description = '',
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'date': date,
    };
  }

  factory Memory.fromMap(Map<String, dynamic> map) {
    return Memory(
      id: map['id'] as int?,
      userId: (map['userId'] as int?) ?? 0,
      title: map['title'] as String,
      description: (map['description'] as String?) ?? '',
      date: map['date'] as String,
    );
  }
}
