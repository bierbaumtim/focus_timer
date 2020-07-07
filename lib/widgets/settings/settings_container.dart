import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../state_models/session_settings_model.dart';
import '../../utils/time_utils.dart';
import '../soft/soft_container.dart';
import 'theme_switch.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: Consumer<SessionSettingsModel>(
                builder: (context, model, child) => ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    ListTile(
                      title: Text('Darkmode'),
                      trailing: ThemeSwitch(),
                    ),
                    ListTile(
                      title: Text('Sessions until break'),
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
                      title: Text('session duration'),
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
                        max: 5400,
                        divisions: 85,
                        value: model.sessionsDuration,
                        onChanged: model.setSessionDuration,
                      ),
                    ),
                    ListTile(
                      title: Text('short break duration'),
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
                        max: 1800,
                        divisions: 28,
                        value: model.shortBreakDuration,
                        onChanged: model.setShortBreakDuration,
                      ),
                    ),
                    ListTile(
                      title: Text('long break duration'),
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
                        max: 10800,
                        divisions: 175,
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
