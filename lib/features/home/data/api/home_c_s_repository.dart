import 'dart:typed_data';

import '../../../../core/repositories/cloud_storage_repository.dart';
import '../../../../core/utils/utils.dart';

/// Handle the methods for the Home feature for Cloud Storage
class HomeCloudStorageRepository extends CloudStorageRepository {
  Future<String> uploadImageProfile(Uint8List data) async {
    try {
      final path = '$pathProfileImgs${Utils.generateId()}';
      return await uploadRawData(data, path);
    } catch (_) {
      rethrow;
    }
  }
}
