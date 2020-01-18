import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

import 'package:focus_timer/state_models/tasks_model.dart';
import 'package:focus_timer/widgets/soft/soft_container.dart';
import 'add_task_tile.dart';
import 'task_tile.dart';

class TasksListContainer extends StatelessWidget {
  const TasksListContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksModel = Injector.get<TasksModel>();

    return SoftContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Stack(
          children: <Widget>[
            StateBuilder(
              models: [tasksModel],
              builder: (context, _) {
                if (tasksModel.allTasksCompleted) {
                  return const Center(
                    child: Text(
                      'You\'ve done all your tasks',
                    ),
                  );
                } else if (tasksModel.tasks.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: kToolbarHeight,
                      bottom: kToolbarHeight + 8,
                    ),
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: <Widget>[
                        SliverPadding(
                          padding: const EdgeInsets.only(
                            bottom: 14,
                            top: 14,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => TaskTile(
                                task: tasksModel.tasks.elementAt(index),
                              ),
                              childCount: tasksModel.tasks.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Add tasks that you want to complete in future sessions',
                    ),
                  );
                }
              },
            ),
            const Positioned(
              left: 12,
              right: 12,
              child: ListTile(
                title: Text('Tasks'),
              ),
            ),
            const Positioned(
              bottom: 0,
              left: 12,
              right: 12,
              child: AddTaskTile(),
            ),
          ],
        ),
      ),
    );
  }
}
