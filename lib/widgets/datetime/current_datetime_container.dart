import 'package:flutter/material.dart';

import '../soft/soft_container.dart';
import 'current_date_text.dart';
import 'current_time_text.dart';

class CurrentDateTimeContainer extends StatelessWidget {
  const CurrentDateTimeContainer({
    Key key,
    this.useDarkTheme,
  }) : super(key: key);

  final bool useDarkTheme;

  @override
  Widget build(BuildContext context) {
    return SoftContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            CurrentTimeText(fontsize: 20),
            SizedBox(width: 8),
            CurrentDateText(),
          ],
        ),
      ),
      useDarkTheme: useDarkTheme,
    );
  }
}
