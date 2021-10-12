import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../extensions/context_ext.dart';
import '../utils/my_themes.dart';
import '../utils/utils.dart';

class TextCustom extends StatelessWidget {
  const TextCustom(this.data,
      {Key? key,
      this.fontSize = 14,
      this.fontWeight,
      this.color = Colors.white,
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
    this.useCenter = true,
  });

  final Color color;
  final double strokeWidth;
  final bool useCenter;

  @override
  Widget build(BuildContext context) {
    Widget child = CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(color),
      strokeWidth: strokeWidth,
    );

    if (useCenter) child = Center(child: child);

    return child;
  }
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
  const FormButton({
    Key? key,
    this.onPressed,
    this.label = 'TextLabel',
    this.isEnabled = true,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String label;
  final bool isEnabled;

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
            color: isEnabled ? Colors.white : Colors.grey,
          ),
          style: ElevatedButton.styleFrom(
              primary: Utils.acentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              )),
          onPressed: isEnabled
              ? onPressed ?? () => print('Button Form Pressed')
              : null,
        ),
      ),
    );
  }
}

class RichTextCustom extends StatefulWidget {
  const RichTextCustom({
    Key? key,
    this.firstText = 'First Text',
    this.secondText = 'Second Text',
    this.onPressed,
  }) : super(key: key);

  final String firstText, secondText;

  /// Receives an actions when the second word is tapped.
  final VoidCallback? onPressed;

  @override
  _RichTextCustomState createState() => _RichTextCustomState();
}

class _RichTextCustomState extends State<RichTextCustom> {
  late TapGestureRecognizer tapRecognizer;

  @override
  void initState() {
    super.initState();
    tapRecognizer = TapGestureRecognizer()..onTap = widget.onPressed;
  }

  @override
  void dispose() {
    tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: widget.firstText,
        style: TextStyle(
          color: Colors.white,
        ),
        children: <TextSpan>[
          TextSpan(
            text: ' ',
          ),
          TextSpan(
            text: widget.secondText,
            recognizer: tapRecognizer,
            style: TextStyle(
              color: Utils.acentColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Exposes a common scaffold to use in the forms
///
/// Contains a [SafeArea] to avoid paint over the status bar
///
/// Also contains a [SingleChildScrollView] to scroll over the children
class ScaffoldForm extends StatelessWidget {
  const ScaffoldForm({
    Key? key,
    this.useScroll = true,
    this.children = const [],
    this.backgroundColor,
    this.formKey,
    this.autovalidateMode,
  }) : super(key: key);

  final bool useScroll;
  final Color? backgroundColor;
  final List<Widget> children;
  final GlobalKey<FormState>? formKey;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    Widget child = Form(
      autovalidateMode: autovalidateMode,
      key: formKey,
      child: Column(children: children),
    );

    if (useScroll) child = SingleChildScrollView(child: child);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: child),
    );
  }
}

class StreamBuilderCustom<T> extends StatelessWidget {
  const StreamBuilderCustom({Key? key, this.stream, required this.onData})
      : super(key: key);

  final Stream<T>? stream;

  /// When the data is ready to be shown
  final Widget Function(BuildContext context, AsyncSnapshot<T> snapshot) onData;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError)
          return IconDescription(Icons.block, 'Something went wrong');

        if (snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressCustom();

        return onData(context, snapshot);
      },
    );
  }
}

class IconDescription extends StatelessWidget {
  final IconData icon;
  final String msg;

  const IconDescription(this.icon, this.msg);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 60,
            color: Colors.grey,
          ),
          Space(0.01),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextCustom(
              msg,
              textAlign: TextAlign.center,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
