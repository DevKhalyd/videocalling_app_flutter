import 'dart:async';

main(List<String> args) {
  var stopwatch = Stopwatch()..start();
  Timer(Duration(seconds: 3), () {
    stopwatch.stop();
    print('Seconds elapsed: ${stopwatch.elapsed.inSeconds}');
  });
  print('Seconds elapsed before to enter: ${stopwatch.elapsed.inSeconds}');
}
