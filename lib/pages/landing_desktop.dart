import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:focus_timer/blocs/tasks/bloc.dart';
import 'package:focus_timer/constants/theme_constants.dart';
import 'package:focus_timer/widgets/datetime/current_datetime_container.dart';
import 'package:focus_timer/widgets/pageview_page.dart';
import 'package:focus_timer/widgets/sessions/session_countdown.dart';
import 'package:focus_timer/widgets/soft/soft_appbar.dart';
import 'package:focus_timer/widgets/soft/soft_container.dart';
import 'package:focus_timer/widgets/tasks/add_task_tile.dart';
import 'package:focus_timer/widgets/tasks/task_tile.dart';

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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: CurrentDateTimeContainer(),
                    ),
                  ),
                  Positioned(
                    left: kToolbarHeight,
                    right: kToolbarHeight,
                    bottom: kToolbarHeight,
                    top: kToolbarHeight + 20,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: SoftContainer(
                            height: 400,
                            radius: 40,
                            child: Center(
                              child: SessionCountdown(),
                            ),
                          ),
                        ),
                        SizedBox(width: 96),
                        Expanded(
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                    bottom: 14,
                                                    top: 14,
                                                  ),
                                                  sliver: SliverList(
                                                    delegate:
                                                        SliverChildBuilderDelegate(
                                                      (context, index) =>
                                                          TaskTile(
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
                                              child:
                                                  CircularProgressIndicator(),
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
                      ],
                    ),
                  ),
                ],
              ),
              Page(
                useComplemtaryTheme: true,
              ),
              Page(),
              Page(
                useComplemtaryTheme: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
