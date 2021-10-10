import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/messages.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/mini_widgets.dart';
import '../getX/image_picker_controller.dart';

// TODO: Test this screen

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
          body: Column(
            children: [
              Space(0.05),
              Container(
                width: double.infinity,
                height: kToolbarHeight,
                child: Row(
                  children: [
                    BackButton(
                      color: Colors.white,
                    ),
                    Space(0.01, isHorizontal: true),
                    TextCustom(
                      'Profile Image',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ],
                ),
              ),
              Space(0.09),
              GestureDetector(
                onTap: c.onPickImage,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Utils.textFormFIeldColor,
                  backgroundImage: bytes != null ? MemoryImage(bytes) : null,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              Space(0.09),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextCustom(
                  Messages.selectImageExplanation,
                  textAlign: TextAlign.center,
                ),
              ),
              Space(0.07),
              Expanded(
                child: Center(
                  child: FormButton(
                    label: 'Upload',
                    onPressed: c.onUpload,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
