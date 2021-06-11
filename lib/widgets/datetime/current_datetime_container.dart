import 'package:flutter/material.dart';

import 'current_date_time_text.dart';

class CurrentDateTimeContainer extends StatelessWidget {
  const CurrentDateTimeContainer({
    Key? key,
    this.useDarkTheme,
  }) : super(key: key);

  final bool? useDarkTheme;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 16,
      ),
      child: CurrentDateTimeText(),
    );
  }
}
