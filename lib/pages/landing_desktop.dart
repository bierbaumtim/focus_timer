import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../routes/flyout_overlay_route.dart';
import '../state_models/current_session_model.dart';
import '../widgets/datetime/current_datetime_container.dart';
import '../widgets/sessions/session_countdown.dart';
import '../widgets/settings/settings_button.dart';
import '../widgets/soft/custom_appbar.dart';
import '../widgets/start_break_button.dart';
import '../widgets/tasks/tasks_list_container.dart';

class DesktopLanding extends StatelessWidget {
  const DesktopLanding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              height: kToolbarHeight + 14,
              titleStyle: theme.textTheme.titleLarge?.copyWith(fontSize: 35),
              centerWidget: const Center(
                child: CurrentDateTimeContainer(),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  const Expanded(
                    flex: 2,
                    child: Stack(
                      children: <Widget>[
                        _TimerSection(),
                        Positioned(
                          left: 16,
                          bottom: 20,
                          child: SettingsButton(
                            flyoutPlacement: FlyoutPlacement.bottomLeft,
                          ),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    indent: 8,
                    endIndent: 24,
                    color: Theme.of(context).dividerColor,
                  ),
                  const Flexible(
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
  const _TimerSection({Key? key}) : super(key: key);

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
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            countdownHeight / 10,
                          ),
                        ),
                        child: SizedBox(
                          height: countdownHeight,
                          child: const Padding(
                            padding: EdgeInsets.all(24),
                            child: SessionCountdown(),
                          ),
                        ),
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
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                children: [
                                  if (model.isLongBreak) ...const [
                                    TextSpan(
                                      text: '* kurze Meditation\n',
                                    ),
                                    TextSpan(
                                      text:
                                          '* Reflektieren der bisherigen Aufgaben',
                                    ),
                                  ] else ...const [
                                    TextSpan(
                                      text: '* Trink etwas\n',
                                    ),
                                    TextSpan(
                                      text: '* Mache eine kurze Atemübung',
                                    ),
                                  ],
                                ],
                                style: theme.textTheme.titleLarge,
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: kToolbarHeight),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: StartBreakButton(
                  withAnimation: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
