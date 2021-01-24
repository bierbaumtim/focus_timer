import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../routes/flyout_overlay_route.dart';
import '../state_models/current_session_model.dart';
import '../widgets/datetime/current_datetime_container.dart';
import '../widgets/sessions/session_countdown.dart';
import '../widgets/settings/settings_container.dart';
import '../widgets/soft/soft_appbar.dart';
import '../widgets/soft/soft_button.dart';
import '../widgets/soft/soft_container.dart';
import '../widgets/start_break_button.dart';
import '../widgets/tasks/tasks_list_container.dart';

class DesktopLanding extends StatefulWidget {
  @override
  _DesktopLandingState createState() => _DesktopLandingState();
}

class _DesktopLandingState extends State<DesktopLanding> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SoftAppBar(
              height: kToolbarHeight + 14,
              titleStyle: theme.textTheme.headline6.copyWith(fontSize: 35),
              centerWidget: const Center(
                child: CurrentDateTimeContainer(),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: <Widget>[
                        _TimerSection(),
                        Positioned(
                          left: 16,
                          bottom: 20,
                          child: Builder(
                            builder: (context) => SoftButton(
                              radius: 15,
                              onTap: () {
                                final renderBox =
                                    context.findRenderObject() as RenderBox;
                                final offset = renderBox.localToGlobal(
                                  Offset.zero,
                                );

                                Navigator.of(context).push(
                                  FlyoutOverlayRoute(
                                    builder: (context) => SettingsContainer(
                                      width: 400,
                                      height: 626,
                                      shrinkWrap: true,
                                    ),
                                    bottomPosition: Offset(
                                      offset.dx,
                                      offset.dy + renderBox.size.height,
                                    ),
                                  ),
                                );
                              },
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(Icons.settings),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    indent: 8,
                    endIndent: 24,
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TasksListContainer(),
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

class _TimerSection extends StatelessWidget {
  const _TimerSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final countdownHeight = MediaQuery.of(context).size.height / 3;

    return Consumer<CurrentSessionModel>(
      builder: (context, model, child) => Padding(
        padding: const EdgeInsets.all(kToolbarHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    flex: model.isBreak ? 4 : 1,
                    child: Center(
                      child: SoftContainer(
                        height: countdownHeight,
                        radius: countdownHeight / 10,
                        child: const SessionCountdown(),
                      ),
                    ),
                  ),
                  if (model.isBreak) ...[
                    const SizedBox(height: 72),
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Text.rich(
                          TextSpan(
                            children: <InlineSpan>[
                              TextSpan(
                                text:
                                    'Hier sind ein paar Tips für die Pause:\n\n',
                                style: theme.textTheme.headline5.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                children: [
                                  if (model.isLongBreak) ...[
                                    TextSpan(
                                      text: '* kurze Meditation\n',
                                    ),
                                    TextSpan(
                                      text:
                                          '* Reflektieren der bisherigen Aufgaben',
                                    ),
                                  ] else ...[
                                    TextSpan(
                                      text: '* Mache ein paar Liegestütz\n',
                                    ),
                                    TextSpan(
                                      text: '* Trink etwas\n',
                                    ),
                                    TextSpan(
                                      text: '* Mache eine kurze Atemübung',
                                    ),
                                  ],
                                ],
                                style: theme.textTheme.headline6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: kToolbarHeight,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: StartBreakButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
