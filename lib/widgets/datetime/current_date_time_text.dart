import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CurrentDateTimeText extends StatefulWidget {
  const CurrentDateTimeText({Key? key}) : super(key: key);

  @override
  State<CurrentDateTimeText> createState() => _CurrentDateTimeTextState();
}

class _CurrentDateTimeTextState extends State<CurrentDateTimeText> {
  late String currentTime;
  late Timer timer;

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

  String timeToString(DateTime time) {
    final seconds = time.second.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    final hours = time.hour.toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds'; // :$seconds
  }

  String get dateToText {
    final date = DateTime.now();
    return '${date.day.toString().padLeft(2, '0')}'
        '.${date.month.toString().padLeft(2, '0')}'
        '.${date.year.toString()}';
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final basicStyle = getValueForScreenType<TextStyle>(
      context: context,
      mobile: theme.textTheme.subtitle1!,
      tablet: theme.textTheme.headline6,
      desktop: theme.textTheme.headline6,
    );

    return Text(
      '$currentTime - $dateToText',
      maxLines: 1,
      style: basicStyle,
    );
  }
}
