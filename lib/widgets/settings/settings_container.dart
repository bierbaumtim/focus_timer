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
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              title: Text('Settings'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
              child: Container(
                height: 2,
                color: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .color
                    .withOpacity(0.75),
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text('Darkmode'),
                    trailing: ThemeSwitch(),
                  ),
                  ListTile(
                    title: Text('Sessions until break'),
                    subtitle: StateBuilder(
                      models: [sessionSettingsModel],
                      builder: (context, _) => Text(
                        '${sessionSettingsModel.sessionUntilBreak} sessions',
                      ),
                    ),
                  ),
                  ListTile(
                    title: StateBuilder(
                      models: [sessionSettingsModel],
                      builder: (context, _) => Slider(
                        min: 1,
                        max: 10,
                        divisions: 10,
                        value:
                            sessionSettingsModel.sessionUntilBreak.toDouble(),
                        onChanged: (sessions) => sessionSettingsModel
                            .setSessionsUntilBreak(sessions.toInt()),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('session duration'),
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
                    title: Text('short break duration'),
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
                    title: Text('long break duration'),
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
          ],
        ),
      ),
    );
  }
}
