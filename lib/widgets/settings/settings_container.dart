import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../helper/enums.dart';
import '../../state_models/session_settings_model.dart';
import '../../state_models/settings_model.dart';
import '../../utils/time_utils.dart';
import '../soft/soft_container.dart';
import 'theme_switch.dart';

class SettingsContainer extends StatelessWidget {
  final double? height, width;
  final bool shrinkWrap;

  const SettingsContainer({
    Key? key,
    this.height,
    this.width,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SoftContainer(
      height: height,
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: shrinkWrap ? MainAxisSize.min : MainAxisSize.max,
          children: <Widget>[
            const ListTile(
              title: Text('Settings'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
              child: Container(
                height: 2,
                color: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.color
                    ?.withOpacity(0.75),
              ),
            ),
            Expanded(
              child: Consumer<SessionSettingsModel>(
                builder: (context, model, child) => ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    ListTile(
                      title: const Text('Darkmode'),
                      trailing: ThemeSwitch(),
                    ),
                    ListTile(
                      title: const Text('Themetype'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CupertinoSlidingSegmentedControl<ThemeType>(
                        children: {
                          ThemeType.flat: const Text('Flat'),
                          // ThemeType.material: const Text('Material'),
                          ThemeType.neomorphism: const Text('Neomorphism'),
                        },
                        groupValue: context.select<SettingsModel, ThemeType>(
                          (v) => v.themeType,
                        ),
                        onValueChanged: (value) => context
                            .read<SettingsModel>()
                            .changeThemeType(value!),
                      ),
                    ),
                    ListTile(
                      title: const Text('Sessions until break'),
                      subtitle: Text(
                        '${model.sessionUntilBreak} sessions',
                      ),
                    ),
                    ListTile(
                      title: Slider(
                        min: 1,
                        max: 10,
                        divisions: 10,
                        value: model.sessionUntilBreak.toDouble(),
                        onChanged: (sessions) =>
                            model.setSessionsUntilBreak(sessions.toInt()),
                      ),
                    ),
                    ListTile(
                      title: const Text('session duration'),
                      subtitle: Text(
                        timeToString(
                          model.sessionsDuration,
                          hoursDelimiter: ' hours ',
                          minutesDelimiter: ' minutes ',
                          secondsDelimiter: ' seconds',
                          hideZeroSeconds: true,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Slider(
                        min: 300,
                        max: 3600,
                        divisions: 55,
                        value: model.sessionsDuration,
                        onChanged: model.setSessionDuration,
                      ),
                    ),
                    ListTile(
                      title: const Text('short break duration'),
                      subtitle: Text(
                        timeToString(
                          model.shortBreakDuration,
                          hoursDelimiter: ' hours ',
                          minutesDelimiter: ' minutes ',
                          secondsDelimiter: ' seconds',
                          hideZeroSeconds: true,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Slider(
                        min: 60,
                        max: 900,
                        divisions: 24,
                        value: model.shortBreakDuration,
                        onChanged: model.setShortBreakDuration,
                      ),
                    ),
                    ListTile(
                      title: const Text('long break duration'),
                      subtitle: Text(
                        timeToString(
                          model.longBreakDuration,
                          hoursDelimiter: ' hours ',
                          minutesDelimiter: ' minutes ',
                          secondsDelimiter: ' seconds',
                          hideZeroSeconds: true,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Slider(
                        min: 300,
                        max: 5400,
                        divisions: 85,
                        value: model.longBreakDuration,
                        onChanged: model.setLongBreakDuration,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
