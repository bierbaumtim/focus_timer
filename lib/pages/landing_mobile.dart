import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../constants/tween_constants.dart';
import '../state_models/current_session_model.dart';
import '../widgets/pageview_page.dart';
import '../widgets/sessions/session_countdown.dart';
import '../widgets/sessions/sessions_list_container.dart';
import '../widgets/settings/settings_container.dart';
import '../widgets/soft/soft_appbar.dart';
import '../widgets/soft/soft_container.dart';
import '../widgets/start_break_button.dart';
import '../widgets/tasks/tasks_list_container.dart';
import '../widgets/time/mobile_top_time_bar.dart';

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
                        child: ControlledAnimation(
                          tween: fadeInTween,
                          duration: const Duration(milliseconds: 1500),
                          builder: (context, animation) => Opacity(
                            opacity: animation,
                            child: SoftContainer(
                              width: containerSize,
                              height: containerSize,
                              radius: containerSize / 1.8,
                              child: const SessionCountdown(),
                            ),
                          ),
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
                                return StartBreakButton();
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
                  TopTimeBar(),
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
              child: Column(
                children: <Widget>[
                  TopTimeBar(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: TasksListContainer(),
                    ),
                  ),
                ],
              ),
            ),
            Page(
              child: Column(
                children: const <Widget>[
                  TopTimeBar(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: SettingsContainer(),
                    ),
                  ),
                ],
              ),
            ),
          ],
          addAutomaticKeepAlives: true,
        ),
      ),
    );
  }
}
