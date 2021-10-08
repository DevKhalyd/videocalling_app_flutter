import 'package:flutter/material.dart';
import 'package:videocalling_app/core/widgets/mini_widgets.dart';
import 'package:videocalling_app/features/home/presentation/widgets/home_bottom_navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Main',
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Test from here the new item
            HomeBottomNavigation()
          ],
        ),
      ),
    );
  }
}
