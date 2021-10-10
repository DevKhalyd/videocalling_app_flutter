import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../mini_widgets.dart';

const _size = 50.0;

class CircleProfileImage extends StatelessWidget {
  /// Returns an image if provider otherwise use a letter to show
  const CircleProfileImage({
    Key? key,
    this.url,
    this.firstLetter,
    this.size = _size,
    this.fontSize = 16,
  })  :
        // Avoid to use both parameters
        assert(url == null || firstLetter == null),
        super(key: key);

  final String? url, firstLetter;
  final double size;

  /// The size of the first letter
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Utils.genereateColor(),
          shape: BoxShape.circle,
          image: url != null
              ? DecorationImage(
                  image: NetworkImage(url!),
                  fit: BoxFit.cover,
                )
              : null),
      child: firstLetter != null
          ? Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextCustom(
                firstLetter!,
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
    );
  }
}
