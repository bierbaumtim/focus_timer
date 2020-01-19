import 'package:flutter/material.dart';
import 'package:focus_timer/widgets/datetime/current_datetime_container.dart';

import 'package:focus_timer/widgets/pageview_page.dart';
import 'package:focus_timer/widgets/sessions/session_countdown.dart';
import 'package:focus_timer/widgets/sessions/sessions_list_container.dart';
import 'package:focus_timer/widgets/soft/soft_appbar.dart';
import 'package:focus_timer/widgets/soft/soft_container.dart';
import 'package:focus_timer/widgets/tasks/tasks_list_container.dart';

class DesktopLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: CurrentDateTimeContainer(),
                    ),
                  ),
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
                          child: PageView(
                            scrollDirection: Axis.vertical,
                            pageSnapping: true,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SessionsListContainer(),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: TasksListContainer(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Page(
                  // useComplemtaryTheme: true,
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
