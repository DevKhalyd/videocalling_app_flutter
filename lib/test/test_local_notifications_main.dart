import 'dart:developer';

import 'package:flutter/material.dart';

import '../core/repositories/awesome_notifications_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotificationsRepository.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 750), () {
      log('Requesting for permissions.');
      AwesomeNotificationsRepository.requestNotificationPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Local Example App',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Notification Local Example App Bar'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _TextButton(
                  text: 'One',
                  onPressed: () {
                    AwesomeNotificationsRepository.buttonNotification();
                  },
                )
              ],
            ),
          )),
    );
  }
}

class _TextButton extends StatelessWidget {
  const _TextButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        child: Text(text),
        onPressed: onPressed,
      ),
    );
  }
}
