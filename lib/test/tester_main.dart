import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Main',
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('Material App Bar')),
        body: PathExample(),
      ),
    );
  }
}

// TODO: Use the method moveTo to start to draw

class PathExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: _PathPainter(),
        child: Container(
          width: double.infinity,
          height: 150,
        ),
      ),
    );
  }
}

class _PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..strokeWidth = 4;

    Path path = Path();

    path.lineTo(width * .2, 0);
    // First curve to down
    path.quadraticBezierTo(width * .3, 0, width * .35, 40);
    // A curve with shape U
    path.quadraticBezierTo(width * .5, height, width * .65, 40);
    // Second curve to up
    path.quadraticBezierTo(width * .7, 0, width * .85, 0);
    path.lineTo(width, 0);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    // path.relativeCubicTo(30, 5, 10, 50, width * .25, height * .1);
    // path.relativeCubicTo(30, -5, 10, -50, width * .25, height * .1 * -1);
    // path.lineTo(width, height * .5);
    /* path.cubicTo(
      width * .6,
      height * .55,
      width * .5,
      height * .7,
      width * .7,
      height * .5,
    );*/

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


/*

class PathExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PathPainter(),
      child: Container(
        height: 80,
        width: double.infinity,
      ),
    );
  }
}



class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    Path path = Path();

    path.lineTo(width * .4, 0);
    path.quadraticBezierTo(width * .5, height * .8, width * .6, 0);
    path.lineTo(width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}*/
