mixin VideoCallMixin {
  final maxDurationToWait = 10000;

  /// Given [seconds] return the minutes and seconds in the following format
  /// 00:00
  String getMinutesFromSeconds(int seconds) {
    int minutes = seconds ~/ 60;
    int secondsInt = seconds % 60;
    String secondsString = secondsInt.toString();
    if (secondsInt < 10) secondsString = '0$secondsInt';
    return '$minutes:$secondsString';
  }
}
