import '../helpers/database_helper.dart';
import '../models/memory.dart';
import 'auth_service.dart';
import 'task_changes.dart';

/// All memory access goes through here so every query is scoped to the
/// signed-in user. Mutations notify [TaskChanges] so live tabs reload.
class MemoryRepository {
  static int get _uid => AuthService.instance.userId;

  static Future<List<Memory>> fetchAll() =>
      DatabaseHelper.instance.getMemoriesForUser(_uid);

  static Future<void> add(Memory memory) async {
    await DatabaseHelper.instance.insertMemory(
      Memory(
        userId: _uid,
        title: memory.title,
        description: memory.description,
        date: memory.date,
      ),
    );
    TaskChanges.instance.notify();
  }

  static Future<void> delete(int memoryId) async {
    await DatabaseHelper.instance.deleteMemory(_uid, memoryId);
    TaskChanges.instance.notify();
  }
}
