import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

import '../../state_models/session_settings_model.dart';
import '../../utils/time_utils.dart';
import '../soft/soft_container.dart';
import 'theme_switch.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sessionSettingsModel = Injector.get<SessionSettingsModel>();

    return SoftContainer(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              title: Text('Settings'),
            ),
            AnimatedPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              duration: Duration(milliseconds: 350),
              child: Container(
                height: 2,
                color:
                    Theme.of(context).textTheme.body1.color.withOpacity(0.75),
              ),
            ),
            ListTile(
              title: Text('Darkmode'),
              trailing: ThemeSwitch(),
            ),
            ListTile(
              title: Text('Sessionlänge'),
              subtitle: StateBuilder(
                models: [sessionSettingsModel],
                builder: (context, _) => Text(
                  timeToString(
                    sessionSettingsModel.sessionsDuration,
                    hoursDelimiter: ' hours ',
                    minutesDelimiter: ' minutes ',
                    secondsDelimiter: ' seconds',
                    hideZeroSeconds: true,
                  ),
                ),
              ),
            ),
            ListTile(
              title: StateBuilder(
                models: [sessionSettingsModel],
                builder: (context, _) => Slider(
                  min: 300,
                  max: 5400,
                  divisions: 85,
                  value: sessionSettingsModel.sessionsDuration,
                  onChanged: sessionSettingsModel.setSessionDuration,
                ),
              ),
            ),
            ListTile(
              title: Text('kurze Pausenlänge'),
              subtitle: StateBuilder(
                models: [sessionSettingsModel],
                builder: (context, _) => Text(
                  timeToString(
                    sessionSettingsModel.shortBreakDuration,
                    hoursDelimiter: ' hours ',
                    minutesDelimiter: ' minutes ',
                    secondsDelimiter: ' seconds',
                    hideZeroSeconds: true,
                  ),
                ),
              ),
            ),
            ListTile(
              title: StateBuilder(
                models: [sessionSettingsModel],
                builder: (context, _) => Slider(
                  min: 60,
                  max: 1800,
                  divisions: 28,
                  value: sessionSettingsModel.shortBreakDuration,
                  onChanged: sessionSettingsModel.setShortBreakDuration,
                ),
              ),
            ),
            ListTile(
              title: Text('lange Pauselänge'),
              subtitle: StateBuilder(
                models: [sessionSettingsModel],
                builder: (context, _) => Text(
                  timeToString(
                    sessionSettingsModel.longBreakDuration,
                    hoursDelimiter: ' hours ',
                    minutesDelimiter: ' minutes ',
                    secondsDelimiter: ' seconds',
                    hideZeroSeconds: true,
                  ),
                ),
              ),
            ),
            ListTile(
              title: StateBuilder(
                models: [sessionSettingsModel],
                builder: (context, _) => Slider(
                  min: 300,
                  max: 10800,
                  divisions: 175,
                  value: sessionSettingsModel.longBreakDuration,
                  onChanged: sessionSettingsModel.setLongBreakDuration,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
