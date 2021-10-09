import 'package:flutter/material.dart';

import '../features/home/presentation/widgets/home_bottom_navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Main',
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Test from here the new item
            HomeBottomNavigation()
          ],
        ),
      ),
    );
  }
}
