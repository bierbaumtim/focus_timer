import 'package:flutter/material.dart';

import '../soft/soft_container.dart';
import 'current_date_time_text.dart';

class CurrentDateTimeContainer extends StatelessWidget {
  const CurrentDateTimeContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SoftContainer(
      child: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 16,
        ),
        child: CurrentDateTimeText(),
      ),
    );
  }
}
