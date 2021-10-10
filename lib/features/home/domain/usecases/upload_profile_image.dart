import 'dart:typed_data';

import '../../../../core/utils/utils.dart';
import '../../data/api/home_c_s_repository.dart';

abstract class UploadProfileImage {
  /// Return the image url if everything goes fine
  static Future<String?> execute(Uint8List data) async {
    try {
      final repo = HomeCloudStorageRepository();
      return await repo.uploadImageProfile(data);
    } catch (e) {
      Utils.printACatch('UploadProfileImage', e);
    }
  }
}
