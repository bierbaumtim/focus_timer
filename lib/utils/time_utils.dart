String timeToString(int duration) {
  var timeString = '';
  final hours = (duration / 3600).truncate();
  if (hours > 0) {
    timeString += hours.toString().padLeft(2, '0');
    timeString += ':';
  }

  final minutes = ((duration % 3600) / 60).truncate();
  if (minutes > 0) {
    timeString += minutes.toString().padLeft(2, '0');
    timeString += ':';
  }

  final seconds = ((duration % 3600) % 60).truncate();
  return timeString += seconds.toString().padLeft(2, '0');
}
