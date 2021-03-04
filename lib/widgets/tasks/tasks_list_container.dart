import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../state_models/tasks_model.dart';
import '../soft/soft_button.dart';
import 'add_task_tile.dart';
import 'task_tile.dart';

class TasksListContainer extends StatefulWidget {
  const TasksListContainer({Key? key}) : super(key: key);

  @override
  _TasksListContainerState createState() => _TasksListContainerState();
}

class _TasksListContainerState extends State<TasksListContainer> {
  late ScrollController tasksScrollController;

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
    final theme = Theme.of(context);
    final hintTextStyle = getValueForScreenType<TextStyle>(
      context: context,
      mobile: theme.textTheme.bodyText1!,
      desktop: theme.textTheme.headline6,
    );
    final headerTextStyle = getValueForScreenType<TextStyle>(
      context: context,
      mobile: theme.textTheme.subtitle1!,
      desktop: theme.textTheme.headline5,
    );

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
              title: Text(
                'Tasks',
                style: headerTextStyle,
              ),
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
                  return Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        "You've done all your tasks",
                        style: hintTextStyle,
                      ),
                    ),
                  );
                } else if (model.filteredTasks.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: ReorderableListView(
                      onReorder: model.reorderTasks,
                      scrollController: tasksScrollController,
                      children: model.filteredTasks
                          .map<Widget>(
                            (e) => TaskTile(
                              key: ValueKey(e.uuid),
                              task: e,
                            ),
                          )
                          .toList(),
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        'Add tasks that you want to complete in future sessions',
                        textAlign: TextAlign.center,
                        style: hintTextStyle,
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
