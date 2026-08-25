import 'package:flutter_test/flutter_test.dart';
import 'package:taskly/services/password_hasher.dart';

/// Regression tests for the background-isolate PBKDF2 migration: hash() and
/// verify() became async (compute-based) — this locks in round-trip behavior
/// so the stored format stays stable across refactors.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PasswordHasher', () {
    test('hash produces a self-describing hashed string', () async {
      final stored = await PasswordHasher.hash('correct horse');
      expect(PasswordHasher.isHashed(stored), isTrue);
      final parts = stored.split('\$');
      expect(parts, hasLength(4));
      expect(parts[0], 'pbkdf2');
      expect(int.tryParse(parts[1]), 120000);
      expect(parts[2], hasLength(24)); // 16 bytes -> base64url with padding
    });

    test('hash uses a fresh salt each call', () async {
      final a = await PasswordHasher.hash('same-password');
      final b = await PasswordHasher.hash('same-password');
      expect(a, isNot(b));
    });

    test('verify accepts the right password and rejects a wrong one',
        () async {
      final stored = await PasswordHasher.hash('s3cret!');
      expect(await PasswordHasher.verify('s3cret!', stored), isTrue);
      expect(await PasswordHasher.verify('wrong', stored), isFalse);
    });

    test('verify rejects legacy plaintext values', () async {
      expect(await PasswordHasher.verify('anything', 'plaintext'), isFalse);
    });
  });
}
