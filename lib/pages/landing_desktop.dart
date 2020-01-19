import 'package:flutter/material.dart';
import 'package:focus_timer/state_models/current_session_model.dart';
import 'package:focus_timer/widgets/datetime/current_datetime_container.dart';

import 'package:focus_timer/widgets/pageview_page.dart';
import 'package:focus_timer/widgets/sessions/session_countdown.dart';
import 'package:focus_timer/widgets/sessions/sessions_list_container.dart';
import 'package:focus_timer/widgets/soft/soft_appbar.dart';
import 'package:focus_timer/widgets/soft/soft_container.dart';
import 'package:focus_timer/widgets/tasks/tasks_list_container.dart';
import 'package:focus_timer/widgets/time/countdown_time.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class DesktopLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final currentSessionModel = Injector.get<CurrentSessionModel>();

    return Scaffold(
      body: SafeArea(
        child: PageView.custom(
          scrollDirection: Axis.vertical,
          pageSnapping: true,
          childrenDelegate: SliverChildListDelegate(
            <Widget>[
              Stack(
                children: <Widget>[
                  SoftAppBar(
                    height: kToolbarHeight + 14,
                    titleStyle: theme.textTheme.title.copyWith(fontSize: 35),
                    centerWidget: const Align(
                      alignment: Alignment.topCenter,
                      child: CurrentDateTimeContainer(),
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.topCenter,
                  //   child: const Padding(
                  //     padding: EdgeInsets.only(top: 16.0),
                  //     child: CurrentDateTimeContainer(),
                  //   ),
                  // ),
                  Positioned(
                    left: kToolbarHeight,
                    right: kToolbarHeight,
                    bottom: kToolbarHeight - 20,
                    top: kToolbarHeight + 20,
                    child: Row(
                      children: <Widget>[
                        const Expanded(
                          flex: 2,
                          child: SoftContainer(
                            height: 400,
                            radius: 40,
                            child: Center(
                              child: SessionCountdown(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 96),
                        Expanded(
                          child: StateBuilder(
                            models: [currentSessionModel],
                            builder: (context, _) =>
                                currentSessionModel.isRunning
                                    ? const TasksListContainer()
                                    : SessionsListContainer(),
                          ),
                        ),
                        // Expanded(
                        //   child: PageView(
                        //     scrollDirection: Axis.vertical,
                        //     pageSnapping: true,
                        //     children: <Widget>[
                        //       Padding(
                        //         padding: const EdgeInsets.all(12.0),
                        //         child: SessionsListContainer(),
                        //       ),
                        //       const Padding(
                        //         padding: EdgeInsets.all(12.0),
                        //         child: TasksListContainer(),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              Page(
                child: Column(
                  children: <Widget>[
                    SoftAppBar(
                      height: kToolbarHeight + 14,
                      titleStyle: theme.textTheme.title.copyWith(fontSize: 35),
                      centerWidget: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: StateBuilder(
                            models: [currentSessionModel],
                            builder: (context, _) => Row(
                              mainAxisAlignment: currentSessionModel.isBreak ||
                                      currentSessionModel.isRunning
                                  ? MainAxisAlignment.spaceBetween
                                  : MainAxisAlignment.center,
                              children: <Widget>[
                                const Expanded(
                                  child: Center(
                                    child: CurrentDateTimeContainer(),
                                  ),
                                ),
                                if (currentSessionModel.isBreak ||
                                    currentSessionModel.isRunning)
                                  const SoftContainer(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 4,
                                        horizontal: 8,
                                      ),
                                      child: CountdownTime(
                                        isSmall: true,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
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
              const Page(),
              const Page(
                  // useComplemtaryTheme: true,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
