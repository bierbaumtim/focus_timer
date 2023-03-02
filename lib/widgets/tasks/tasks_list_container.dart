import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../state_models/tasks_model.dart';
import 'add_task_tile.dart';
import 'task_tile.dart';

class TasksListContainer extends StatelessWidget {
  const TasksListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final hintTextStyle = getValueForScreenType<TextStyle>(
      context: context,
      mobile: theme.textTheme.bodyLarge!,
      desktop: theme.textTheme.titleLarge,
    );

    final headerTextStyle = getValueForScreenType<TextStyle>(
      context: context,
      mobile: theme.textTheme.titleMedium!,
      desktop: theme.textTheme.headlineSmall,
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
              trailing: FilledButton.tonal(
                onPressed: () => context.read<TasksModel>().toggleFilter(),
                child: Icon(
                  context.select<TasksModel, bool>((value) => value.filterTasks)
                      ? Icons.filter_list
                      : Icons.format_list_bulleted,
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<TasksModel>(
              builder: (context, model, child) {
                if (model.allTasksCompleted) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
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
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      proxyDecorator: (child, index, animation) => child,
                      children: model.filteredTasks
                          .map<Widget>(
                            (e) => TaskTile(
                              key: ValueKey('${e.uuid}_reorder'),
                              task: e,
                            ),
                          )
                          .toList(),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(16),
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
