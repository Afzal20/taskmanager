import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/database_helper.dart';
import '../models/user.dart';

/// Result wrapper so screens can show precise error messages.
class AuthResult {
  final bool success;
  final String? error;

  const AuthResult._(this.success, this.error);

  const AuthResult.ok() : this._(true, null);
  const AuthResult.fail(String message) : this._(false, message);
}

class AuthService {
  AuthService._();
  static final instance = AuthService._();

  static const _sessionKey = 'sessionId';
  static const _avatars = ['🦊', '🐼', '🐯', '🐸', '🦄', '🐙'];

  int? _currentUserId;

  bool get isLoggedIn => _currentUserId != null;

  /// Id of the signed-in user; tasks are always scoped by this (authorization).
  int get userId {
    final id = _currentUserId;
    if (id == null) {
      throw StateError('No user is signed in.');
    }
    return id;
  }

  List<String> get avatarChoices => _avatars;

  /// Restores the session on app start. Returns true when a user is logged in.
  Future<bool> restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt(_sessionKey);
    if (id == null) return false;
    _currentUserId = id;
    return true;
  }

  Future<User?> currentUser() async {
    final id = _currentUserId;
    if (id == null) return null;
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('sessionEmail');
    if (email != null) {
      final user = await DatabaseHelper.instance.findUserByEmail(email);
      if (user != null && user.id == id) return user;
    }
    // Fallback: scan by id (should not normally happen).
    final all = await DatabaseHelper.instance.database;
    final maps =
        await all.query('users', where: 'id = ?', whereArgs: [id], limit: 1);
    if (maps.isEmpty) return null;
    return User.fromMap(maps.first);
  }

  Future<AuthResult> register({
    required String name,
    required String email,
    required String password,
    required String avatar,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    final existing = await DatabaseHelper.instance.findUserByEmail(normalizedEmail);
    if (existing != null) {
      return const AuthResult.fail(
          'An account with this email already exists.');
    }
    final user = User(
      name: name.trim(),
      email: normalizedEmail,
      password: password,
      avatar: avatar,
      createdAt: DateTime.now().toIso8601String(),
    );
    final id = await DatabaseHelper.instance.insertUser(user);
    await _startSession(id, normalizedEmail);
    return const AuthResult.ok();
  }

  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    final user = await DatabaseHelper.instance.findUserByEmail(normalizedEmail);
    if (user == null || user.password != password) {
      return const AuthResult.fail('Incorrect email or password.');
    }
    await _startSession(user.id!, user.email);
    return const AuthResult.ok();
  }

  Future<void> updateProfile(User updated) async {
    await DatabaseHelper.instance.updateUser(updated);
  }

  Future<AuthResult> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = await currentUser();
    if (user == null) return const AuthResult.fail('Not signed in.');
    if (user.password != currentPassword) {
      return const AuthResult.fail('Current password is incorrect.');
    }
    await DatabaseHelper.instance.updateUser(
      User(
        id: user.id,
        name: user.name,
        email: user.email,
        password: newPassword,
        avatar: user.avatar,
        createdAt: user.createdAt,
      ),
    );
    return const AuthResult.ok();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
    await prefs.remove('sessionEmail');
    _currentUserId = null;
  }

  Future<void> _startSession(int userId, String email) async {
    _currentUserId = userId;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_sessionKey, userId);
    await prefs.setString('sessionEmail', email);
  }

  /// Clears in-memory session state (used by tests).
  void resetForTesting() {
    _currentUserId = null;
  }
}
