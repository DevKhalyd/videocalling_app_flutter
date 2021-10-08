import 'dart:typed_data';

import 'package:videocalling_app/core/utils/logger.dart';
import 'package:videocalling_app/features/home/data/api/home_c_s_repository.dart';

abstract class UploadProfileImage {
  /// Return the image url if everything is fine
  static Future<String?> execute(Uint8List data) async {
    try {
      final repo = HomeCloudStorageRepository();
      return await repo.uploadImageProfile(data);
    } catch (e) {
      Log.console('UploadProfileImage', L.E, e);
    }
  }
}
