import 'package:flutter/material.dart';

import 'package:auto_animated/auto_animated.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SoftContainer(
        radius: 28,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(
                  left: 12,
                ),
                child: ListTile(
                  title: Text('Tasks'),
                ),
              ),
              Expanded(
                child: ViewModelBuilder<TasksModel>.reactive(
                  viewModelBuilder: () => context.read<TasksModel>(),
                  disposeViewModel: false,
                  builder: (context, model, child) {
                    if (model.allTasksCompleted) {
                      return const Positioned(
                        bottom: 16,
                        top: 16,
                        left: 16,
                        right: 16,
                        child: Center(
                          child: Text(
                            'You\'ve done all your tasks',
                          ),
                        ),
                      );
                    } else if (model.tasks.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 12,
                        ),
                        child: AnimateIfVisibleWrapper(
                          child: ReorderableListView(
                            onReorder: model.reorderTasks,
                            scrollController: tasksScrollController,
                            children: model.tasks
                                .map<Widget>(
                                  (e) => AnimateIfVisible(
                                    key: ValueKey(e.uuid),
                                    builder: (context, animation) =>
                                        FadeTransition(
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
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            'Add tasks that you want to complete in future sessions',
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: AddTaskTile(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
