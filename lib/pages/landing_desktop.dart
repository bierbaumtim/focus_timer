import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:provider/provider.dart';

import '../constants/tween_constants.dart';
import '../state_models/current_session_model.dart';
import '../widgets/datetime/current_datetime_container.dart';
import '../widgets/pageview_page.dart' as page;
import '../widgets/sessions/session_countdown.dart';
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
  FocusNode keyBoardNode;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    keyBoardNode = FocusNode();
  }

  @override
  void dispose() {
    pageController.dispose();
    keyBoardNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(keyBoardNode);
    final theme = Theme.of(context);
    final countdownHeight = MediaQuery.of(context).size.height / 3;

    return Scaffold(
      body: SafeArea(
        child: RawKeyboardListener(
          focusNode: keyBoardNode,
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
                  child: Column(
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
                      Expanded(
                        child: Consumer<CurrentSessionModel>(
                          builder: (context, model, child) {
                            if (model.isBreak) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(kToolbarHeight),
                                  child: PlayAnimation<double>(
                                    tween: fadeInTween,
                                    duration: const Duration(milliseconds: 750),
                                    delay: const Duration(milliseconds: 500),
                                    builder: (context, child, animation) =>
                                        Opacity(
                                      opacity: animation,
                                      child: child,
                                    ),
                                    child: SoftContainer(
                                      height: countdownHeight * 1.5,
                                      radius: (countdownHeight * 1.5) / 10,
                                      child: Center(
                                        child: SessionCountdown(),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(
                                  kToolbarHeight,
                                  kToolbarHeight + 20,
                                  kToolbarHeight,
                                  kToolbarHeight - 20,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    // Expanded(
                                    //   flex: 2,
                                    //   child: Stack(
                                    //     children: <Widget>[
                                    //       Center(
                                    //         child: PlayAnimation<double>(
                                    //           tween: fadeInTween,
                                    //           duration: const Duration(
                                    //               milliseconds: 1500),
                                    //           delay: const Duration(
                                    //               milliseconds: 500),
                                    //           builder:
                                    //               (context, child, animation) =>
                                    //                   AnimatedOpacity(
                                    //             duration: const Duration(
                                    //               milliseconds: 550,
                                    //             ),
                                    //             opacity: animation,
                                    //             child: child,
                                    //           ),
                                    //           child: SoftContainer(
                                    //             height: countdownHeight,
                                    //             radius: countdownHeight / 10,
                                    //             child: Center(
                                    //               child: SessionCountdown(),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       if (model.isSession)
                                    //         Positioned(
                                    //           left: 0,
                                    //           right: 0,
                                    //           bottom: 0,
                                    //           top: 2 * countdownHeight,
                                    //           child: Align(
                                    //             alignment: Alignment.center,
                                    //             child: StartBreakButton(),
                                    //           ),
                                    //         )
                                    //     ],
                                    //   ),
                                    // ),
                                    const SizedBox(width: 96),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: const TasksListContainer(),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
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
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(kToolbarHeight),
                          child: TasksListContainer(),
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
