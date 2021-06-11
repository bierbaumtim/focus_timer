import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

import '../../state_models/current_session_model.dart';
import '../../utils/time_utils.dart';

class CountdownTime extends StatelessWidget {
  final bool isSmall;
  final bool useDigitalClock;

  const CountdownTime({
    Key? key,
    this.isSmall = false,
    this.useDigitalClock = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentSessionModel>(
      builder: (context, value, child) => Center(
        child: SimpleTime(
          duration: value.timeRemaining,
          isSmall: isSmall,
        ),
      ),
    );
  }
}

// class _DigitalTime extends StatelessWidget {
//   final int duration;

//   const _DigitalTime({Key key, @required this.duration}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     final fontsize = getValueForScreenType<double>(
//       context: context,
//       mobile: theme.textTheme.headline6.fontSize,
//       tablet: 80,
//       desktop: 110,
//     );
//     final characterSize = _calculateCharacterSize(fontsize);

//     return SizedBox(
//       height: characterSize.height + 8,
//       child: FlipClock.countdown(
//         duration: Duration(seconds: duration),
//         digitColor: theme.textTheme.headline6.color,
//         backgroundColor: Colors.transparent,
//         height: characterSize.height,
//         width: characterSize.width,
//         digitSize: fontsize,
//       ),
//     );
//   }

//   Size _calculateCharacterSize(double fontsize) {
//     final style = TextStyle(
//       fontSize: fontsize,
//     );
//     final textPainter = TextPainter(
//       text: TextSpan(text: 'T', style: style),
//       maxLines: 1,
//       textDirection: TextDirection.ltr,
//     )..layout(minWidth: 0, maxWidth: double.infinity);

//     return textPainter.size;
//   }
// }

class SimpleTime extends StatelessWidget {
  final int duration;
  final bool isSmall;

  const SimpleTime({
    Key? key,
    required this.duration,
    this.isSmall = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      timeToString(duration),
      maxLines: 1,
      style: Theme.of(context).textTheme.headline6!.copyWith(
            fontSize: 130,
          ),
      maxFontSize: isSmall ? 20 : double.infinity,
    );
  }
}
