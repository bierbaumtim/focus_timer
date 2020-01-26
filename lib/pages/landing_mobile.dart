import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../constants/tween_constants.dart';
import '../state_models/current_session_model.dart';
import '../widgets/pageview_page.dart';
import '../widgets/sessions/session_countdown.dart';
import '../widgets/sessions/sessions_list_container.dart';
import '../widgets/settings/theme_switch.dart';
import '../widgets/soft/soft_appbar.dart';
import '../widgets/soft/soft_button.dart';
import '../widgets/soft/soft_container.dart';
import '../widgets/tasks/tasks_list_container.dart';
import '../widgets/time/mobile_top_tim_bar.dart';

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
                                return ControlledAnimation(
                                  tween: MultiTrackTween([
                                    Track('opacity').add(
                                      const Duration(milliseconds: 650),
                                      fadeInTween,
                                    ),
                                    Track('translation').add(
                                      const Duration(milliseconds: 450),
                                      Tween<double>(
                                        begin: 130,
                                        end: 0,
                                      ),
                                      curve: Curves.easeInOut,
                                    ),
                                  ]),
                                  duration: const Duration(milliseconds: 1500),
                                  // delay: const Duration(milliseconds: 500),
                                  builder: (context, animation) => Opacity(
                                    opacity: animation['opacity'],
                                    child: Transform.translate(
                                      offset:
                                          Offset(0, animation['translation']),
                                      child: SoftButton(
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
                                      ),
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
                  MobileTopTimeBar(),
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
                  MobileTopTimeBar(),
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
                children: <Widget>[
                  MobileTopTimeBar(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SoftContainer(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              ListTile(
                                title: Text('Settings'),
                              ),
                              AnimatedPadding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                duration: Duration(milliseconds: 350),
                                child: Container(
                                  height: 2,
                                  color: Theme.of(context)
                                      .textTheme
                                      .body1
                                      .color
                                      .withOpacity(0.75),
                                ),
                              ),
                              ListTile(
                                title: Text('Darkmode'),
                                trailing: ThemeSwitch(),
                              ),
                            ],
                          ),
                        ),
                      ),
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
