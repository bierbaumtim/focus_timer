import 'package:flutter/material.dart';

import 'package:auto_animated/auto_animated.dart';
import 'package:provider/provider.dart';

import '../../state_models/tasks_model.dart';
import '../soft/soft_button.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
            ),
            child: ListTile(
              title: Text('Tasks'),
              trailing: SoftButton(
                onTap: () => context.read<TasksModel>().toggleFilter(),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    context.select<TasksModel, bool>(
                            (value) => value.filterTasks)
                        ? Icons.filter_list
                        : Icons.format_list_bulleted,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<TasksModel>(
              builder: (context, model, child) {
                if (model.allTasksCompleted) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        'You\'ve done all your tasks',
                      ),
                    ),
                  );
                } else if (model.filteredTasks.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: AnimateIfVisibleWrapper(
                      child: ReorderableListView(
                        onReorder: model.reorderTasks,
                        scrollController: tasksScrollController,
                        children: model.filteredTasks
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
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        'Add tasks that you want to complete in future sessions',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          const AddTaskTile(),
        ],
      ),
    );
  }
}
