import 'package:flutter/material.dart';

import 'package:auto_animated/auto_animated.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../state_models/tasks_model.dart';
import '../soft/soft_container.dart';
import 'add_task_tile.dart';
import 'task_tile.dart';

class TasksListContainer extends StatefulWidget {
  const TasksListContainer({Key key}) : super(key: key);

  @override
  _TasksListContainerState createState() => _TasksListContainerState();
}

class _TasksListContainerState extends State<TasksListContainer> {
  ScrollController tasksScrollController;

  @override
  void initState() {
    super.initState();
    tasksScrollController = ScrollController();
  }

  @override
  void dispose() {
    tasksScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasksModel = Injector.get<TasksModel>();

    return SoftContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            StateBuilder<TasksModel>(
              models: [tasksModel],
              builder: (context, _) {
                if (tasksModel.allTasksCompleted) {
                  return const Positioned(
                    bottom: 0,
                    top: 0,
                    left: 12,
                    right: 12,
                    child: Center(
                      child: Text(
                        'You\'ve done all your tasks',
                      ),
                    ),
                  );
                } else if (tasksModel.tasks.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: kToolbarHeight,
                      bottom: kToolbarHeight + 8,
                    ),
                    child: AnimateIfVisibleWrapper(
                      child: ReorderableListView(
                        onReorder: tasksModel.reorderTasks,
                        // scrollController: tasksScrollController,
                        children: tasksModel.tasks
                            .map<Widget>(
                              (e) => AnimateIfVisible(
                                key: ValueKey(e.uuid),
                                builder: (context, animation) => FadeTransition(
                                  opacity: Tween<double>(
                                    begin: 0,
                                    end: 1,
                                  ).animate(animation),
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0.5, 0),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: TaskTile(
                                      task: e,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  );
                } else {
                  return const Positioned(
                    bottom: 0,
                    top: 0,
                    left: 12,
                    right: 12,
                    child: Center(
                      child: Text(
                        'Add tasks that you want to complete in future sessions',
                      ),
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
