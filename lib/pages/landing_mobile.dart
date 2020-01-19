import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_timer/state_models/current_session_model.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

import 'package:focus_timer/state_models/session_model.dart';
import 'package:focus_timer/widgets/datetime/current_datetime_container.dart';
import 'package:focus_timer/widgets/pageview_page.dart';
import 'package:focus_timer/widgets/sessions/session_countdown.dart';
import 'package:focus_timer/widgets/sessions/sessions_list_container.dart';
import 'package:focus_timer/widgets/soft/soft_appbar.dart';
import 'package:focus_timer/widgets/soft/soft_button.dart';
import 'package:focus_timer/widgets/soft/soft_container.dart';
import 'package:focus_timer/widgets/tasks/tasks_list_container.dart';

class MobileLanding extends StatefulWidget {
  @override
  _MobileLandingState createState() => _MobileLandingState();
}

class _MobileLandingState extends State<MobileLanding> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.bottom,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final currentSessionModel = Injector.get<CurrentSessionModel>();

    final containerSize = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      body: PageView.custom(
        scrollDirection: Axis.vertical,
        pageSnapping: true,
        childrenDelegate: SliverChildListDelegate(
          <Widget>[
            Page(
              child: Column(
                children: <Widget>[
                  SoftAppBar(
                    height: kToolbarHeight + 20,
                    titleStyle: theme.textTheme.title,
                  ),
                  Expanded(
                    flex: 7,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SoftContainer(
                          width: containerSize,
                          height: containerSize,
                          radius: containerSize / 1.8,
                          child: SessionCountdown(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        height: kToolbarHeight,
                        child: Center(
                          child: StateBuilder(
                            models: [currentSessionModel],
                            builder: (context, _) {
                              if (currentSessionModel.isBreak) {
                                return Container();
                              } else {
                                return SoftButton(
                                  radius: 15,
                                  onTap: () {
                                    if (currentSessionModel.isRunning) {
                                      currentSessionModel.stopTimer();
                                    } else {
                                      currentSessionModel.restartTimer();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Icon(
                                      currentSessionModel.isRunning
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      size: 36,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Page(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 8),
                      child: CurrentDateTimeContainer(),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SessionsListContainer(),
                    ),
                  ),
                ],
              ),
            ),
            Page(
              // useComplemtaryTheme: true,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 8),
                      child: CurrentDateTimeContainer(),
                    ),
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
            const Page(
                // useComplemtaryTheme: true,
                ),
          ],
          addAutomaticKeepAlives: true,
        ),
      ),
    );
  }
}
