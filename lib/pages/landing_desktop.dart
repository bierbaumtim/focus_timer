import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../constants/tween_constants.dart';
import '../state_models/current_session_model.dart';
import '../widgets/datetime/current_datetime_container.dart';
import '../widgets/pageview_page.dart' as page;
import '../widgets/sessions/session_countdown.dart';
import '../widgets/sessions/sessions_list_container.dart';
import '../widgets/settings/settings_container.dart';
import '../widgets/soft/soft_appbar.dart';
import '../widgets/soft/soft_container.dart';
import '../widgets/start_break_button.dart';
import '../widgets/tasks/tasks_list_container.dart';
import '../widgets/time/mobile_top_time_bar.dart';

class DesktopLanding extends StatefulWidget {
  @override
  _DesktopLandingState createState() => _DesktopLandingState();
}

class _DesktopLandingState extends State<DesktopLanding> {
  PageController pageController;
  FocusNode _keyBoardNode;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    _keyBoardNode = FocusNode();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_keyBoardNode);
    final theme = Theme.of(context);
    final countdownHeight = MediaQuery.of(context).size.height / 3;

    final currentSessionModel = Injector.get<CurrentSessionModel>();

    return Scaffold(
      body: SafeArea(
        child: RawKeyboardListener(
          focusNode: _keyBoardNode,
          onKey: (event) async {
            if (event.logicalKey.keyId == LogicalKeyboardKey.arrowDown.keyId) {
              await pageController.nextPage(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
              );
            } else if (event.logicalKey.keyId ==
                LogicalKeyboardKey.arrowUp.keyId) {
              await pageController.previousPage(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
              );
            }
          },
          child: PageView.custom(
            controller: pageController,
            scrollDirection: Axis.vertical,
            pageSnapping: true,
            childrenDelegate: SliverChildListDelegate(
              <Widget>[
                page.Page(
                  child: Stack(
                    children: <Widget>[
                      SoftAppBar(
                        height: kToolbarHeight + 14,
                        titleStyle:
                            theme.textTheme.headline6.copyWith(fontSize: 35),
                        centerWidget: const Align(
                          alignment: Alignment.topCenter,
                          child: CurrentDateTimeContainer(),
                        ),
                      ),
                      StateBuilder<CurrentSessionModel>(
                        models: [currentSessionModel],
                        watch: (_) => currentSessionModel.isBreak,
                        builder: (context, _) {
                          if (currentSessionModel.isBreak) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(kToolbarHeight),
                                child: PlayAnimation(
                                  tween: fadeInTween,
                                  duration: const Duration(milliseconds: 750),
                                  delay: const Duration(milliseconds: 500),
                                  builder: (context, animation) => Opacity(
                                    opacity: animation,
                                    child: SoftContainer(
                                      height: countdownHeight * 1.5,
                                      radius: (countdownHeight * 1.5) / 10,
                                      child: Center(
                                        child: SessionCountdown(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Positioned(
                              left: kToolbarHeight,
                              right: kToolbarHeight,
                              bottom: kToolbarHeight - 20,
                              top: kToolbarHeight + 20,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Stack(
                                      children: <Widget>[
                                        Center(
                                          child: PlayAnimation(
                                            tween: fadeInTween,
                                            duration: const Duration(
                                                milliseconds: 1500),
                                            delay: const Duration(
                                                milliseconds: 500),
                                            builder: (context, animation) =>
                                                AnimatedOpacity(
                                              duration: const Duration(
                                                milliseconds: 550,
                                              ),
                                              opacity: animation,
                                              child: SoftContainer(
                                                height: countdownHeight,
                                                radius: countdownHeight / 10,
                                                child: Center(
                                                  child: SessionCountdown(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        StateBuilder<CurrentSessionModel>(
                                          models: [currentSessionModel],
                                          watch: (_) =>
                                              currentSessionModel.isSession,
                                          builder: (context, _) {
                                            if (currentSessionModel.isSession) {
                                              return Positioned(
                                                left: 0,
                                                right: 0,
                                                bottom: 0,
                                                top: 2 * countdownHeight,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: StartBreakButton(),
                                                ),
                                              );
                                            } else {
                                              return Container();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 96),
                                  Expanded(
                                    child: StateBuilder<CurrentSessionModel>(
                                      models: [currentSessionModel],
                                      watch: (_) =>
                                          currentSessionModel.isTimerRunning,
                                      builder: (context, _) =>
                                          AnimatedCrossFade(
                                        firstChild: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: const SessionsListContainer(),
                                        ),
                                        secondChild: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: const TasksListContainer(),
                                        ),
                                        crossFadeState:
                                            currentSessionModel.isTimerRunning
                                                ? CrossFadeState.showSecond
                                                : CrossFadeState.showFirst,
                                        duration:
                                            const Duration(milliseconds: 750),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                page.Page(
                  child: Column(
                    children: <Widget>[
                      SoftAppBar(
                        height: kToolbarHeight + 14,
                        titleStyle:
                            theme.textTheme.headline6.copyWith(fontSize: 35),
                        centerWidget: TopTimeBar(
                          contentPadding: const EdgeInsets.all(4),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(kToolbarHeight),
                                child: SessionsListContainer(),
                              ),
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(kToolbarHeight),
                                child: TasksListContainer(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                page.Page(
                  child: Column(
                    children: <Widget>[
                      SoftAppBar(
                        height: kToolbarHeight + 14,
                        titleStyle:
                            theme.textTheme.headline6.copyWith(fontSize: 35),
                        centerWidget: TopTimeBar(
                          contentPadding: const EdgeInsets.all(4),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: SettingsContainer(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
