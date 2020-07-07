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
      useDarkTheme: useDarkTheme,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const CurrentTimeText(),
            const SizedBox(width: 2.75),
            Container(
              width: 10,
              height: 1.25,
              color: Theme.of(context).textTheme.bodyText2.color,
            ),
            const SizedBox(width: 2.75),
            const CurrentDateText(),
          ],
        ),
      ),
    );
  }
}
