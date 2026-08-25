import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/task.dart';
import '../models/user.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('taskly.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return openDatabase(
      path,
      version: 3,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  avatar TEXT NOT NULL,
  createdAt TEXT NOT NULL
)
''');
    await db.execute('''
CREATE TABLE tasks (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  userId INTEGER NOT NULL,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  colorValue INTEGER NOT NULL,
  priority INTEGER NOT NULL,
  createTime TEXT NOT NULL,
  dueDate TEXT NOT NULL,
  isDone INTEGER NOT NULL
)
''');
  }

  /// Migration from v1 (no auth) to v2: add users table and scope column.
  ///
  /// Migration v2 -> v3: passwords are now stored hashed (PBKDF2) instead of
  /// plaintext. The `password` column type is unchanged (TEXT), so there is no
  /// schema DDL here. Legacy plaintext rows are intentionally NOT converted
  /// silently — [AuthService.login] detects them via PasswordHasher.isHashed
  /// and forces a password-reset flow, which is the safest path for local data.
  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  avatar TEXT NOT NULL,
  createdAt TEXT NOT NULL
)
''');
      // Existing rows belong to no account; park them under userId -1 so they
      // never leak into another user's list.
      await db.execute(
        "ALTER TABLE tasks ADD COLUMN userId INTEGER NOT NULL DEFAULT -1",
      );
    }
    // oldVersion < 3: no DDL needed; hashing is enforced at the service layer.
  }

  /// Clears the cached database handle so a fresh one is opened (used by tests).
  @visibleForTesting
  static void resetForTesting() {
    _database = null;
  }

  /// Closes and clears the cached database handle (used by tests to release the
  /// file between cases).
  @visibleForTesting
  static Future<void> closeForTesting() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  // ---- Users ----

  Future<User?> findUserByEmail(String email) async {
    final db = await instance.database;
    final maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    return maps.isEmpty ? null : User.fromMap(maps.first);
  }

  Future<int> insertUser(User user) async {
    final db = await instance.database;
    return db.insert('users', user.toMap());
  }

  Future<int> updateUser(User user) async {
    final db = await instance.database;
    return db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // ---- Tasks (always scoped by userId — authorization boundary) ----

  Future<int> insertTask(Task task) async {
    final db = await instance.database;
    return db.insert('tasks', task.toMap());
  }

  Future<List<Task>> getTasksForUser(int userId, {String? dayPrefix}) async {
    final db = await instance.database;
    final maps = await db.query(
      'tasks',
      where: dayPrefix == null
          ? 'userId = ?'
          : 'userId = ? AND dueDate LIKE ?',
      whereArgs:
          dayPrefix == null ? [userId] : [userId, '$dayPrefix%'],
      orderBy: 'isDone ASC, dueDate ASC',
    );
    return maps.map(Task.fromMap).toList();
  }

  Future<int> updateTask(Task task) async {
    final db = await instance.database;
    return db.update(
      'tasks',
      task.toMap(),
      where: 'id = ? AND userId = ?',
      whereArgs: [task.id, task.userId],
    );
  }

  Future<int> toggleTaskDone(int userId, int taskId, int isDone) async {
    final db = await instance.database;
    return db.update(
      'tasks',
      {'isDone': isDone},
      where: 'id = ? AND userId = ?',
      whereArgs: [taskId, userId],
    );
  }

  Future<int> deleteTask(int userId, int taskId) async {
    final db = await instance.database;
    return db.delete(
      'tasks',
      where: 'id = ? AND userId = ?',
      whereArgs: [taskId, userId],
    );
  }
}
