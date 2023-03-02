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

class TabletLanding extends StatelessWidget {
  const TabletLanding({Key? key}) : super(key: key);

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
            const _TimerSection(),
            Divider(
              indent: 8,
              endIndent: 24,
              color: Theme.of(context).dividerColor,
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TasksListContainer(),
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
    return Consumer<CurrentSessionModel>(
      builder: (context, model, child) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            const SettingsButton(
              flyoutPlacement: FlyoutPlacement.topLeft,
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      32,
                    ),
                  ),
                  child: const SizedBox(
                    height: 60,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      child: SessionCountdown(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const StartBreakButton(
                  withAnimation: false,
                  extended: false,
                ),
              ],
            ),
            // Expanded(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.stretch,
            //     children: <Widget>[
            //       if (model.isBreak) ...[
            //         const SizedBox(height: 72),
            //         Flexible(
            //           flex: 2,
            //           child: Padding(
            //             padding: const EdgeInsets.only(left: 24),
            //             child: Text.rich(
            //               TextSpan(
            //                 children: <InlineSpan>[
            //                   TextSpan(
            //                     text:
            //                         'Hier sind ein paar Tips für die Pause:\n\n',
            //                     style: theme.textTheme.headlineSmall?.copyWith(
            //                       fontWeight: FontWeight.w600,
            //                     ),
            //                   ),
            //                   TextSpan(
            //                     children: [
            //                       if (model.isLongBreak) ...const [
            //                         TextSpan(
            //                           text: '* kurze Meditation\n',
            //                         ),
            //                         TextSpan(
            //                           text:
            //                               '* Reflektieren der bisherigen Aufgaben',
            //                         ),
            //                       ] else ...const [
            //                         TextSpan(
            //                           text: '* Trink etwas\n',
            //                         ),
            //                         TextSpan(
            //                           text: '* Mache eine kurze Atemübung',
            //                         ),
            //                       ],
            //                     ],
            //                     style: theme.textTheme.titleLarge,
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
