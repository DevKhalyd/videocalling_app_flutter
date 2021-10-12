import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../mini_widgets.dart';

const _size = 40.0;

class CircleProfileImage extends StatelessWidget {
  /// Returns an image if provider otherwise use a letter to show
  const CircleProfileImage({
    Key? key,
    this.url,
    this.firstLetter,
    this.size = _size,
    this.fontSize = 16,
  })  : assert(url != null || firstLetter != null,
            'At least one must be provided'),
        super(key: key);

  /// Both can be used. But take priority the url over first letter.
  final String? url, firstLetter;
  final double size;

  /// The size of the first letter
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _size,
      width: _size,
      decoration: BoxDecoration(
          color: url != null ? null : Utils.genereateColor(),
          shape: BoxShape.circle,
          image: url != null
              ? DecorationImage(
                  image: NetworkImage(url!),
                  fit: BoxFit.cover,
                )
              : null),
      child: firstLetter != null && url == null
          ? Center(
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
