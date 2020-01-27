import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../constants/tween_constants.dart';
import '../state_models/current_session_model.dart';
import '../widgets/datetime/current_datetime_container.dart';
import '../widgets/pageview_page.dart';
import '../widgets/sessions/session_countdown.dart';
import '../widgets/sessions/sessions_list_container.dart';
import '../widgets/soft/soft_appbar.dart';
import '../widgets/soft/soft_container.dart';
import '../widgets/start_break_button.dart';
import '../widgets/tasks/tasks_list_container.dart';
import '../widgets/time/countdown_time.dart';

class DesktopLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final countdownHeight = MediaQuery.of(context).size.height / 3;

    final currentSessionModel = Injector.get<CurrentSessionModel>();

    return Scaffold(
      body: SafeArea(
        child: PageView.custom(
          scrollDirection: Axis.vertical,
          pageSnapping: true,
          childrenDelegate: SliverChildListDelegate(
            <Widget>[
              Page(
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
                    StateBuilder(
                      models: [currentSessionModel],
                      builder: (context, _) {
                        if (currentSessionModel.isBreak) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(kToolbarHeight),
                              child: ControlledAnimation(
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
                                        child: ControlledAnimation(
                                          tween: fadeInTween,
                                          duration: const Duration(
                                              milliseconds: 1500),
                                          delay:
                                              const Duration(milliseconds: 500),
                                          builder: (context, animation) =>
                                              Opacity(
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
                                      StateBuilder(
                                        models: [currentSessionModel],
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
                                  child: StateBuilder(
                                    models: [currentSessionModel],
                                    builder: (context, _) => AnimatedCrossFade(
                                      firstChild: SessionsListContainer(),
                                      secondChild: const TasksListContainer(),
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
              Page(
                child: Column(
                  children: <Widget>[
                    SoftAppBar(
                      height: kToolbarHeight + 14,
                      titleStyle:
                          theme.textTheme.headline6.copyWith(fontSize: 35),
                      centerWidget: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ControlledAnimation(
                            tween: MultiTrackTween([
                              Track('opacity').add(
                                const Duration(milliseconds: 650),
                                fadeInTween,
                              ),
                              Track('translation').add(
                                const Duration(milliseconds: 450),
                                Tween<double>(
                                  begin: -50,
                                  end: 0,
                                ),
                                curve: Curves.easeInOut,
                              ),
                            ]),
                            duration: const Duration(milliseconds: 1500),
                            builder: (context, animation) => Opacity(
                              opacity: animation['opacity'],
                              child: Transform.translate(
                                offset: Offset(0, animation['translation']),
                                child: StateBuilder(
                                  models: [currentSessionModel],
                                  builder: (context, _) => Row(
                                    mainAxisAlignment: currentSessionModel
                                                .isBreak ||
                                            currentSessionModel.isTimerRunning
                                        ? MainAxisAlignment.spaceBetween
                                        : MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Expanded(
                                        child: Center(
                                          child: CurrentDateTimeContainer(),
                                        ),
                                      ),
                                      if (currentSessionModel.isBreak ||
                                          currentSessionModel.isTimerRunning)
                                        SoftContainer(
                                          child: const Padding(
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
            ],
          ),
        ),
      ),
    );
  }
}
