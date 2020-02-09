import 'package:flutter/material.dart';

class CurrentDateText extends StatelessWidget {
  const CurrentDateText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      dateToText,
      style: theme.textTheme.headline6.copyWith(
        fontSize: 20,
        shadows: [],
      ),
    );
  }

  String get dateToText {
    final date = DateTime.now();
    return '${date.day.toString().padLeft(2, '0')}'
        '.${date.month.toString().padLeft(2, '0')}'
        '.${date.year.toString()}';
  }
}
