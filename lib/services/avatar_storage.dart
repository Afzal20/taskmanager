import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'auth_service.dart';

/// Picks a profile photo from the gallery/camera and copies it into the app's
/// private storage so the reference survives gallery cleanups.
class AvatarStorage {
  static final _picker = ImagePicker();

  static Future<String?> pickAndStore({required bool fromCamera}) async {
    final xfile = await _picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );
    if (xfile == null) return null;

    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docs.path, 'avatars'));
    if (!dir.existsSync()) dir.createSync(recursive: true);
    final ext = p.extension(xfile.path).isEmpty
        ? '.jpg'
        : p.extension(xfile.path);
    final dest = p.join(
        dir.path, 'u${AuthService.instance.userId}-'
        '${DateTime.now().millisecondsSinceEpoch}$ext');
    await File(xfile.path).copy(dest);
    return dest;
  }

  /// Best-effort removal of a replaced avatar image.
  static void deleteStored(String? path) {
    if (path == null || path.isEmpty) return;
    try {
      final f = File(path);
      if (f.existsSync()) f.deleteSync();
    } catch (_) {
      // Non-fatal; orphaned files are harmless.
    }
  }
}
