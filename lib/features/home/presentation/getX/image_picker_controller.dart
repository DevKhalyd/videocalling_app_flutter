import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/messages.dart';
import '../../../../core/widgets/dialogs/info_dialog.dart';
import '../../domain/usecases/update_image_url.dart';
import '../../domain/usecases/upload_profile_image.dart';
import 'home_controller.dart';

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
    UploadProfileImage.execute(_bytes!).then((url) {
      if (url != null) {
        final ctrl = HomeController.to;
        final user = ctrl.user;
        final id = user?.id;
        if (id != null) UpdateImageUrl.execute(id: id, url: url);
        if (user != null) ctrl.updateUser(user.copyWith(imageUrl: url));
      }
    });
    // Return to home
    Get.back();
    // Show information in home
    Get.dialog(AlertInfo(
        content: 'You profile image has been successfully uploaded.'));
  }
}
