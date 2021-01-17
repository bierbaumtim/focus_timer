import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:provider/provider.dart';

import '../constants/tween_constants.dart';
import '../state_models/current_session_model.dart';
import '../widgets/datetime/current_datetime_container.dart';
import '../widgets/sessions/session_countdown.dart';
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
    final countdownHeight = MediaQuery.of(context).size.height / 3;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SoftAppBar(
              height: kToolbarHeight + 14,
              titleStyle: theme.textTheme.headline6!.copyWith(fontSize: 35),
              centerWidget: const Center(
                child: CurrentDateTimeContainer(),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 2,
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
                                builder: (context, child, animation) => Opacity(
                                  opacity: animation,
                                  child: child,
                                ),
                                child: SoftContainer(
                                  height: countdownHeight * 1.5,
                                  radius: (countdownHeight * 1.5) / 10,
                                  child: const Center(
                                    child: SessionCountdown(),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Stack(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(kToolbarHeight),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: SoftContainer(
                                        height: countdownHeight,
                                        radius: countdownHeight / 10,
                                        child: const Center(
                                          child: SessionCountdown(),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: kToolbarHeight,
                                      child: Center(
                                        child: StartBreakButton(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Positioned(
                                left: 16,
                                bottom: 20,
                                child: SoftButton(
                                  radius: 15,
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
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  const VerticalDivider(
                    indent: 8,
                    endIndent: 24,
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
        // child: PageView.custom(
        //   controller: pageController,
        //   scrollDirection: Axis.vertical,
        //   childrenDelegate: SliverChildListDelegate(
        //     <Widget>[
        //       page.Page(
        //         child: Column(
        //           children: <Widget>[
        //             SoftAppBar(
        //               height: kToolbarHeight + 14,
        //               titleStyle:
        //                   theme.textTheme.headline6.copyWith(fontSize: 35),
        //               centerWidget: const TopTimeBar(
        //                 contentPadding: EdgeInsets.all(4),
        //               ),
        //             ),
        //             const Expanded(
        //               child: Center(
        //                 child: Padding(
        //                   padding: EdgeInsets.all(24),
        //                   child: SettingsContainer(),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
