import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../extensions/context_ext.dart';
import '../my_themes.dart';
import '../utils.dart';

class TextCustom extends StatelessWidget {
  const TextCustom(this.data,
      {Key? key,
      this.fontSize = 14,
      this.fontWeight,
      this.color = Colors.black,
      this.letterSpacing,
      this.decoration,
      this.textAlign,
      this.overflow,
      this.maxLines,
      this.foreground,
      this.fontFamily})
      : super(key: key);

  final String data;
  final String? fontFamily;
  final double? fontSize;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final FontWeight? fontWeight;
  final Color? color;

  // final String fontFamily;

  final TextDecoration? decoration;

  final TextOverflow? overflow;

  final int? maxLines;

  final Paint? foreground;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        decoration: decoration,
        foreground: foreground,
        fontFamily: fontFamily,
      ),
    );
  }
}

class CenterText extends StatelessWidget {
  const CenterText(
    this.data, {
    Key? key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.fontFamily,
  }) : super(key: key);

  final String data;
  final String? fontFamily;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextCustom(
      data,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: fontFamily,
    ));
  }
}

/// Show a `white space` inside of a Column or a Row
class SizedBoxCustom extends StatelessWidget {
  const SizedBoxCustom(this.space, {Key? key, this.isHorizontal = false})
      : super(key: key);

  final double space;
  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) return SizedBox(width: space);
    return SizedBox(height: space);
  }
}

/// Show a `white space` inside of a Column or a Row depending on the
/// screen size avaible. Consider that the [space] param must not be greater
/// than 0.99 because if the device is too big the design gets unshape
class Space extends StatelessWidget {
  const Space(this.space, {this.isHorizontal = false})
      : assert(space < 0.1,
            'The space cannot be greater than 0.1, because if the screen is too big the design can give us several problems');
  final double space;

  /// If [isHorizontal] is set to true the space is
  /// for a Row widget or similar widget
  final bool isHorizontal;

  @override
  Widget build(BuildContext context) => isHorizontal
      ? SizedBox(
          width: _getSpace(context) * space,
        )
      : SizedBox(
          height: _getSpace(context) * space,
        );

  double _getSpace(BuildContext context) =>
      isHorizontal ? context.width : context.height;
}

class AnnotatedRegionCustom extends StatelessWidget {
  const AnnotatedRegionCustom({
    Key? key,
    required this.child,
    this.value = MyThemes.lightTheme,
  }) : super(key: key);

  final Widget child;

  /// Use the `MyThemes` class to handle the theme.
  ///
  /// For example the dark theme
  final SystemUiOverlayStyle value;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: value,
      child: child,
    );
  }
}

class CircularProgressCustom extends StatelessWidget {
  const CircularProgressCustom({
    this.color = Colors.white,
    this.strokeWidth = 2.5,
  });

  final Color color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color),
          strokeWidth: strokeWidth,
        ),
      );
}

/// Use in the Sign In and Sign Up forms
class HeaderForms extends StatelessWidget {
  const HeaderForms({
    Key? key,
    this.title = 'Test Title',
    this.description = 'Test Description',
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final String title, description;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextCustom(
            title,
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          Space(0.02),
          TextCustom(
            description,
            color: Colors.grey,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}

class FormButton extends StatelessWidget {
  const FormButton({Key? key, this.onPressed, this.label = 'TextLabel'})
      : super(key: key);

  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: ElevatedButton(
          child: TextCustom(
            label,
            fontSize: 17.5,
            color: Colors.white,
          ),
          style: ElevatedButton.styleFrom(
              primary: Utils.acentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              )),
          onPressed: onPressed ?? () => print('Button Form Pressed'),
        ),
      ),
    );
  }
}

class RichTextCustom extends StatelessWidget {
  const RichTextCustom({
    Key? key,
    this.firstText = 'First Text',
    this.secondText = 'Second Text',
  }) : super(key: key);

  final String firstText, secondText;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstText,
        style: TextStyle(
          color: Colors.white,
        ),
        children: <TextSpan>[
          TextSpan(
            text: ' ',
          ),
          TextSpan(
            text: secondText,
            style: TextStyle(
              color: Utils.acentColor,
            ),
          ),
        ],
      ),
    );
  }
}
