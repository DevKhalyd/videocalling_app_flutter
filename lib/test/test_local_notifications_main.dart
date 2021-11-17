import 'package:flutter/material.dart';

import '../core/repositories/awesome_notifications_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotificationsRepository.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Local Example App',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Notification Local Example App Bar'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          )),
    );
  }
}
