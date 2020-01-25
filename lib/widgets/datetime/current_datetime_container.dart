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
            const CurrentTimeText(fontsize: 20),
            const SizedBox(width: 2.5),
            Container(
              width: 10,
              height: 2,
              color: Theme.of(context).textTheme.body1.color,
            ),
            const SizedBox(width: 2.5),
            const CurrentDateText(),
          ],
        ),
      ),
    );
  }
}
