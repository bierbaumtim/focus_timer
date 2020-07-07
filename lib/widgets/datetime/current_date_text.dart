import 'package:flutter/material.dart';

class CurrentDateText extends StatelessWidget {
  const CurrentDateText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 720;
    final isTablet = !isMobile && width < 960;
    final isDesktop = !isTablet;
    TextStyle basicStyle;
    if (isMobile) {
      basicStyle = theme.textTheme.subtitle1;
    } else if (isTablet) {
      basicStyle = theme.textTheme.headline6;
    } else if (isDesktop) {
      basicStyle = theme.textTheme.headline5;
    } else {
      basicStyle = theme.textTheme.bodyText1;
    }

    return Text(
      dateToText,
      style: basicStyle.copyWith(
        shadows: <Shadow>[],
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
