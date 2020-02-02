String timeToString(
  num duration, {
  String hoursDelimiter,
  String minutesDelimiter,
  String secondsDelimiter,
  bool hideZeroSeconds = false,
}) {
  var timeString = '';
  final hours = (duration / 3600).truncate();
  if (hours > 0) {
    timeString += hours.toString().padLeft(2, '0');
    timeString += hoursDelimiter ?? ':';
  }

  final minutes = ((duration % 3600) / 60).truncate();
  if (minutes > 0) {
    timeString += minutes.toString().padLeft(2, '0');
    timeString += minutesDelimiter ?? ':';
  }

  final seconds = ((duration % 3600) % 60).truncate();

  if (!hideZeroSeconds && seconds > 0) {
    timeString += seconds.toString().padLeft(2, '0');
    timeString += secondsDelimiter ?? '';
  }

  return timeString;
}
