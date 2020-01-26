import 'package:flutter/material.dart';

import '../settings/theme_switch.dart';

class SoftAppBar extends StatelessWidget {
  const SoftAppBar({
    Key key,
    this.centerWidget,
    this.titleStyle,
    this.height = kToolbarHeight,
  }) : super(key: key);

  final TextStyle titleStyle;
  final double height;
  final Widget centerWidget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        color: theme.canvasColor,
        height: height,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Focus Timer',
                style: titleStyle ?? theme.textTheme.title,
              ),
              if (centerWidget != null)
                Expanded(child: centerWidget),
              // SoftButton(
              //   radius: 15,
              //   onTap: () =>
              //       BlocProvider.of<SettingsBloc>(context).add(ChangeTheme()),
              //   child: Padding(
              //     padding: const EdgeInsets.all(8),
              //     child: Icon(FontAwesome.sun_o),
              //   ),
              // ),
              ThemeSwitch(),
            ],
          ),
        ),
      ),
    );
  }
}
