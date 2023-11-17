import 'package:flutter/material.dart';

import 'current_date_time_text.dart';

class CurrentDateTimeContainer extends StatelessWidget {
  const CurrentDateTimeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 12,
        ),
        child: CurrentDateTimeText(),
      ),
    );
  }
}
