import 'package:flutter/material.dart';
import 'package:videocalling_app/core/utils/utils.dart';

/// React to the values passed to this widget
class ReactUsername extends StatelessWidget {
  const ReactUsername({
    Key? key,
    required this.username,
    required this.inputUser,
  }) : super(key: key);

  /// The username given by the database
  final String username;

  /// The data enter by the user
  final String inputUser;

  @override
  Widget build(BuildContext context) {
    final letters = username.split('');
    return RichText(
      text: TextSpan(
          text: letters[0],
          style: TextStyle(
            fontWeight: Utils.containsLetter(letters[0], inputUser)
                ? FontWeight.bold
                : null,
          ),
          children: [
            for (var s in letters.getRange(1, letters.length - 1))
              TextSpan(
                text: s,
                style: TextStyle(
                  fontWeight: Utils.containsLetter(s, inputUser)
                      ? FontWeight.bold
                      : null,
                ),
              )
          ]),
    );
  }
}
