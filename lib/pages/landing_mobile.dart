import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_timer/blocs/tasks/bloc.dart';
import 'package:focus_timer/widgets/pageview_page.dart';
import 'package:focus_timer/widgets/sessions/session_countdown.dart';
import 'package:focus_timer/widgets/tasks/add_task_tile.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'package:focus_timer/constants/theme_constants.dart';
import 'package:focus_timer/state_models/session_model.dart';
import 'package:focus_timer/widgets/datetime/current_datetime_container.dart';
import 'package:focus_timer/widgets/soft/soft_appbar.dart';
import 'package:focus_timer/widgets/soft/soft_button.dart';
import 'package:focus_timer/widgets/soft/soft_container.dart';
import 'package:focus_timer/widgets/tasks/task_tile.dart';

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
              useComplemtaryTheme: true,
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
                      child: SoftContainer(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Stack(
                            children: <Widget>[
                              BlocBuilder<TasksBloc, TasksState>(
                                builder: (context, state) {
                                  if (state is TasksLoaded) {
                                    if (state.tasks.isNotEmpty) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          top: kToolbarHeight,
                                          bottom: kToolbarHeight + 8,
                                        ),
                                        child: CustomScrollView(
                                          physics: BouncingScrollPhysics(),
                                          slivers: <Widget>[
                                            SliverPadding(
                                              padding: const EdgeInsets.only(
                                                bottom: 14,
                                                top: 14,
                                              ),
                                              sliver: SliverList(
                                                delegate:
                                                    SliverChildBuilderDelegate(
                                                  (context, index) => TaskTile(
                                                    task: state.tasks
                                                        .elementAt(index),
                                                  ),
                                                  childCount:
                                                      state.tasks.length,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: Text(
                                          'You\'ve done all your tasks',
                                        ),
                                      );
                                    }
                                  } else if (state is TasksLoading) {
                                    return Center(
                                      child: SoftContainer(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: CircularProgressIndicator(),
                                        ),
                                        radius: 15,
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: Text(
                                        'Add tasks that you want to complete in future sessions',
                                      ),
                                    );
                                  }
                                },
                              ),
                              Positioned(
                                left: 12,
                                right: 12,
                                child: ListTile(
                                  title: Text('Tasks'),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 12,
                                right: 12,
                                child: AddTaskTile(),
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
            Page(),
            Page(
              useComplemtaryTheme: true,
            ),
          ],
          addAutomaticKeepAlives: true,
        ),
      ),
    );
  }
}
