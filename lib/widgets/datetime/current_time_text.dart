import 'dart:async';

import 'package:flutter/material.dart';

class CurrentTimeText extends StatefulWidget {
  final double fontsize;

  const CurrentTimeText({Key key, this.fontsize}) : super(key: key);

  @override
  _CurrentTimeTextState createState() => _CurrentTimeTextState();
}

class _CurrentTimeTextState extends State<CurrentTimeText> {
  String currentTime;
  Timer timer;

  @override
  void initState() {
    super.initState();
    currentTime = timeToString(DateTime.now());
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final time = DateTime.now();

        setState(() => currentTime = timeToString(time));
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String timeToString(DateTime time) {
    final seconds = time.second.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    final hours = time.hour.toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      currentTime,
      maxLines: 1,
      style: theme.textTheme.title.copyWith(
        fontSize: widget.fontsize ?? 110,
        shadows: [],
      ),
    );
  }
}
