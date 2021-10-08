import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

/// Docs: https://firebase.flutter.dev/docs/storage/usage#create-additional-storage-buckets

/// Contain the main methods to use across the application
abstract class CloudStorageRepository {
  final storage = FirebaseStorage.instance;

  // NOTE: Paths
  final pathProfileImgs = 'profileImages/';

  /// Use a `path` with the name of the file to store or download it.
  ///
  /// Example: $pathProfileImgs + 'nameFile.extension
  Reference getReference(String path) => storage.ref(path);

  /// Return the url of this object if is successful
  Future<String> uploadRawData(Uint8List data, String path) async {
    final ref = getReference(path);

    try {
      final task = await ref.putData(data);
      return await task.ref.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }
}
