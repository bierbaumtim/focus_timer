import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:focus_timer/widgets/pageview_page.dart';
import 'package:focus_timer/widgets/sessions/session_countdown.dart';
import 'package:focus_timer/widgets/sessions/sessions_list_container.dart';
import 'package:focus_timer/widgets/tasks/tasks_list_container.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'package:focus_timer/state_models/session_model.dart';
import 'package:focus_timer/widgets/datetime/current_datetime_container.dart';
import 'package:focus_timer/widgets/soft/soft_appbar.dart';
import 'package:focus_timer/widgets/soft/soft_button.dart';
import 'package:focus_timer/widgets/soft/soft_container.dart';

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

    final sessionsModel = Injector.get<SessionsModel>();

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
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.width * 0.8,
                          radius:
                              (MediaQuery.of(context).size.width * 0.8) / 1.8,
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
                            models: [sessionsModel],
                            builder: (context, _) => SoftButton(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Icon(
                                  sessionsModel.isBreak
                                      ? Icons.play_arrow
                                      : Icons.pause,
                                  size: 36,
                                ),
                              ),
                              radius: 15,
                            ),
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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                      child: CurrentDateTimeContainer(),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TasksListContainer(),
                    ),
                  ),
                ],
              ),
            ),
            Page(
                // useComplemtaryTheme: true,
                ),
          ],
          addAutomaticKeepAlives: true,
        ),
      ),
    );
  }
}
