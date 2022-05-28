import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../state_models/current_session_model.dart';
import '../widgets/pageview_page.dart' as page;
import '../widgets/sessions/session_countdown.dart';
import '../widgets/settings/settings_container.dart';
import '../widgets/soft/custom_appbar.dart';
import '../widgets/soft/custom_container.dart';
import '../widgets/start_break_button.dart';
import '../widgets/tasks/tasks_list_container.dart';

class MobileLanding extends StatefulWidget {
  const MobileLanding({Key? key}) : super(key: key);

  @override
  State<MobileLanding> createState() => _MobileLandingState();
}

class _MobileLandingState extends State<MobileLanding>
    with WidgetsBindingObserver {
  DateTime? _userLeavedTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (!kIsWeb) {
      if (Platform.isIOS || Platform.isAndroid) {
        final currentSessionModel = context.read<CurrentSessionModel>();
        if (state == AppLifecycleState.paused) {
          _userLeavedTime = DateTime.now();
          currentSessionModel.pauseTimer();
        } else if (state == AppLifecycleState.resumed) {
          if (_userLeavedTime != null) {
            final elapsedMilliseconds = DateTime.now().millisecondsSinceEpoch -
                _userLeavedTime!.millisecondsSinceEpoch;
            final elapsedSeconds =
                Duration(milliseconds: elapsedMilliseconds).inSeconds;
            currentSessionModel.restartTimer();
            currentSessionModel.handleElapsedTimeInBackground(elapsedSeconds);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final containerSize = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      body: PageView.custom(
        scrollDirection: Axis.vertical,
        childrenDelegate: SliverChildListDelegate(
          <Widget>[
            page.Page(
              child: Column(
                children: <Widget>[
                  CustomAppBar(
                    height: kToolbarHeight + 20,
                    titleStyle: theme.textTheme.headline6,
                  ),
                  Expanded(
                    child: Consumer<CurrentSessionModel>(
                      builder: (context, value, child) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 7,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomContainer(
                                  width: containerSize,
                                  height: containerSize,
                                  radius: containerSize,
                                  child: const SessionCountdown(),
                                ),
                              ),
                            ),
                          ),
                          if (value.isBreak)
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 24,
                                ),
                                child: SingleChildScrollView(
                                  child: Text.rich(
                                    TextSpan(
                                      children: <InlineSpan>[
                                        const TextSpan(
                                          text:
                                              'Hier sind ein paar Tips für die Pause:\n\n',
                                        ),
                                        WidgetSpan(
                                          child: DefaultTextStyle(
                                            style: theme.textTheme.subtitle1!,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 16.0,
                                              ),
                                              child: Table(
                                                children: <TableRow>[
                                                  if (value
                                                      .isLongBreak) ...const [
                                                    TableRow(
                                                      children: <Widget>[
                                                        Text('* '),
                                                        Text(
                                                            'kurze Meditation'),
                                                      ],
                                                    ),
                                                    TableRow(
                                                      children: <Widget>[
                                                        Text('* '),
                                                        Text(
                                                          'Reflektieren der bisherigen Aufgaben',
                                                        ),
                                                      ],
                                                    ),
                                                  ] else ...const [
                                                    TableRow(
                                                      children: <Widget>[
                                                        Text('* '),
                                                        Text('Liegestütz'),
                                                      ],
                                                    ),
                                                    TableRow(
                                                      children: <Widget>[
                                                        Text('* '),
                                                        Text('Trinken'),
                                                      ],
                                                    ),
                                                    TableRow(
                                                      children: <Widget>[
                                                        Text('* '),
                                                        Text('Atemübung'),
                                                      ],
                                                    ),
                                                  ],
                                                ],
                                                columnWidths: const {
                                                  0: IntrinsicColumnWidth(),
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    style: theme.textTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          const Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 12),
                              child: SizedBox(
                                height: kToolbarHeight,
                                child: Center(
                                  child: StartBreakButton(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const page.Page(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: TasksListContainer(),
              ),
            ),
            const page.Page(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: SettingsContainer(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
