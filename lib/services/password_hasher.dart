import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

/// Hashes passwords with PBKDF2-HMAC-SHA256 and stores them in a
/// self-describing format so the iteration count and salt travel with the hash.
///
/// Stored format: `pbkdf2$<iterations>$<saltB64>$<hashB64>`
///
/// This keeps plaintext passwords out of the database. Legacy accounts created
/// before hashing hold raw plaintext in the `password` column; those are
/// detected with [isHashed] and forced through a password-reset flow (see
/// AuthService) rather than being silently migrated.
///
/// The 120k-iteration derivation is CPU-bound (hundreds of ms on low-end
/// phones), so [hash] and [verify] run it on a background isolate via
/// [compute]. Calling them no longer blocks the UI thread, which previously
/// froze the app for seconds on every sign-in/register/password change.
class PasswordHasher {
  PasswordHasher._();

  static const int _iterations = 120000;
  static const int _saltLength = 16; // bytes
  static const int _keyLength = 32; // bytes
  static const String _prefix = 'pbkdf2';

  static final Random _rng = Random.secure();

  /// Hashes [password] with a fresh random salt. Runs on a background isolate.
  static Future<String> hash(String password) async {
    final saltBytes = List<int>.generate(_saltLength, (_) => _rng.nextInt(256));
    final saltB64 = base64UrlEncode(saltBytes);
    final hash =
        await compute(_deriveHashOnlyIsolate, (password, saltB64, _iterations));
    return '$_prefix\$$_iterations\$$saltB64\$$hash';
  }

  /// True when [stored] was produced by [hash] (as opposed to a legacy
  /// plaintext value stored before password hashing was introduced).
  static bool isHashed(String stored) => stored.startsWith('$_prefix\$');

  /// Recomputes the hash of [password] against [stored] and compares it in
  /// constant time. Runs on a background isolate.
  static Future<bool> verify(String password, String stored) async {
    if (!isHashed(stored)) return false;
    final parts = stored.split('\$');
    if (parts.length != 4) return false;
    final iterations = int.tryParse(parts[1]);
    if (iterations == null || iterations <= 0) return false;
    final saltB64 = parts[2];
    final expected = parts[3];

    final actualHash =
        await compute(_deriveHashOnlyIsolate, (password, saltB64, iterations));
    return _constantTimeEquals(
        base64Url.decode(actualHash), base64Url.decode(expected));
  }

  /// Isolate entry point for [compute]: derives the raw hash for one block of
  /// the key. Must stay a top-level/static function with serializable args.
  static String _deriveHashOnlyIsolate((String, String, int) args) {
    final (password, saltB64, iterations) = args;
    return _deriveHashOnly(password, saltB64, iterations);
  }

  /// PBKDF2-HMAC-SHA256 implemented directly on top of the `crypto` package's
  /// Hmac primitive (package:crypto exposes Hmac but not a stock PBKDF2).
  /// Pure CPU work with no Flutter dependencies, so it is isolate-safe.
  static String _deriveHashOnly(String password, String saltB64, int iterations) {
    final hmac = Hmac(sha256, utf8.encode(password));
    final salt = base64Url.decode(saltB64);
    const hLen = 32; // SHA-256 output length in bytes
    final blocks = (_keyLength + hLen - 1) ~/ hLen;
    final dk = List<int>.filled(_keyLength, 0);

    for (var blockIndex = 1; blockIndex <= blocks; blockIndex++) {
      // U1 = PRF(password, salt || INT_32_BE(blockIndex))
      final intBytes = <int>[
        (blockIndex >> 24) & 0xff,
        (blockIndex >> 16) & 0xff,
        (blockIndex >> 8) & 0xff,
        blockIndex & 0xff,
      ];
      var u = hmac.convert([...salt, ...intBytes]).bytes;
      var t = List<int>.from(u);
      for (var i = 1; i < iterations; i++) {
        u = hmac.convert(u).bytes;
        for (var j = 0; j < hLen; j++) {
          t[j] ^= u[j];
        }
      }
      final offset = (blockIndex - 1) * hLen;
      for (var j = 0; j < hLen; j++) {
        final pos = offset + j;
        if (pos < _keyLength) dk[pos] = t[j];
      }
    }
    return base64Url.encode(dk);
  }

  static bool _constantTimeEquals(List<int> a, List<int> b) {
    var diff = a.length ^ b.length;
    final length = a.length < b.length ? a.length : b.length;
    for (var i = 0; i < length; i++) {
      diff |= a[i] ^ b[i];
    }
    return diff == 0;
  }
}
