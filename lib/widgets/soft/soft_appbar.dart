import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:focus_timer/blocs/settings/settings_bloc.dart';
import 'package:focus_timer/blocs/settings/settings_event.dart';
import 'package:focus_timer/widgets/soft/soft_button.dart';

class SoftAppBar extends StatelessWidget {
  const SoftAppBar({
    Key key,
    this.titleStyle,
    this.height = kToolbarHeight,
  }) : super(key: key);

  final TextStyle titleStyle;
  final double height;

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
              SoftButton(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(Icons.wb_sunny),
                ),
                radius: 15,
                onTap: () =>
                    BlocProvider.of<SettingsBloc>(context).add(ChangeTheme()),
              ),
              // IconButton(
              //   icon: Icon(Icons.wb_sunny),
              //   onPressed: () =>
              //       BlocProvider.of<SettingsBloc>(context).add(ChangeTheme()),
              //   hoverColor: Colors.transparent,
              //   splashColor: Colors.transparent,
              //   highlightColor: Colors.transparent,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
