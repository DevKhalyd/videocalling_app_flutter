import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/messages.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/mini_widgets.dart';
import '../getX/image_picker_controller.dart';

/// Select a image (if is desired) and then upload to the database.
///
/// This screen appears over the home screen.
class ImagePickerScreen extends StatelessWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImagePickerController>(
      init: ImagePickerController(),
      builder: (c) {
        final bytes = c.bytes;

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: TextCustom('Image Profile'),
          ),
          body: Column(
            children: [
              Space(0.02),
              GestureDetector(
                onTap: c.onPickImage,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Utils.textFormFIeldColor,
                  backgroundImage: bytes != null ? MemoryImage(bytes) : null,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                ),
              ),
              Space(0.01),
              TextCustom(Messages.selectImageExplanation),
              Space(0.07),
              FormButton(
                label: 'Upload',
                onPressed: c.onUpload,
              )
            ],
          ),
        );
      },
    );
  }
}
