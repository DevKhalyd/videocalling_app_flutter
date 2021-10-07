import 'package:flutter/material.dart';

import '../../utils.dart';

/// A responsive text field
class TextFormFieldCustom extends StatefulWidget {
  const TextFormFieldCustom({
    Key? key,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.onSaved,
    this.validator,
    this.controller,
    this.suffixIcon,
    this.autovalidateMode,
    this.focusNode,
  }) : super(key: key);

  final String hintText;

  /// If true, this one show a text form field for passwords texts
  final bool isPassword;

  final FormFieldSetter<String>? onSaved;

  final FormFieldValidator<String>? validator;

  final TextInputType keyboardType;

  final TextEditingController? controller;

  final Widget? suffixIcon;

  final AutovalidateMode? autovalidateMode;

  final FocusNode? focusNode;

  @override
  _TextFormFieldCustomState createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  late FocusNode focusNode;

  bool hasFocus = false;
  bool isPassword = false;

  @override
  void initState() {
    super.initState();
    isPassword = widget.isPassword;
    if (widget.focusNode == null) {
      focusNode = FocusNode();
      focusNode.addListener(() {
        final focus = focusNode.hasFocus;
        if (focus != hasFocus) {
          // It's not necessary to use a state managment just for this changes
          setState(() => hasFocus = focus);
        }
      });
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    if (widget.focusNode == null)
      focusNode.dispose();
    else
      widget.focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: TextSelectionTheme(
        data: TextSelectionThemeData(
          cursorColor: Utils.acentColor,
          selectionColor: Utils.acentColor,
          selectionHandleColor: Utils.acentColor,
        ),
        child: TextFormField(
          autovalidateMode: widget.autovalidateMode,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          onSaved: widget.onSaved,
          focusNode: widget.focusNode ?? focusNode,
          obscureText: isPassword,
          validator: widget.validator,
          decoration: InputDecoration(
            hoverColor: Utils.acentColor,
            suffixStyle: TextStyle(color: Colors.red),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () => setState(() => isPassword = !isPassword),
                    icon: Icon(
                        isPassword ? Icons.visibility_off : Icons.visibility,
                        color: hasFocus ? Utils.acentColor : Colors.grey))
                : widget.suffixIcon,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Utils.textFormFIeldColor,
            contentPadding: EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 20.0,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Utils.acentColor,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
