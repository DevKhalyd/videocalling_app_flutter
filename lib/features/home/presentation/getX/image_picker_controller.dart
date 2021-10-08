import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/messages.dart';
import '../../../../core/widgets/dialogs/info_dialog.dart';
import '../../domain/usecases/upload_profile_image.dart';

class ImagePickerController extends GetxController {
  final _picker = ImagePicker();
  Uint8List? _bytes;
  Uint8List? get bytes => _bytes;

  /// Open the gallery and allow to pick an image
  void onPickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    try {
      _bytes = await image.readAsBytes();
      update();
    } catch (e) {
      Get.dialog(AlertInfo(content: Messages.error));
    }
  }

  /// Upload the image selected by the user
  void onUpload() async {
    if (_bytes == null) {
      Get.dialog(AlertInfo(content: 'You have to choose an image to upload'));
      return;
    }
    UploadProfileImage.execute(_bytes!).then((value) {
      if (value != null) {
        // TODO: Update the UI of the Home Screen with the new URL image
      }
    });
    // Return to home
    Get.back();
    // Show information in home
    Get.dialog(AlertInfo(
        content: 'You profile image has been successfully uploaded.'));
  }
}
